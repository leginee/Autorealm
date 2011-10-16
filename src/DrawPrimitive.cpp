/*
 * Port of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
 * Used in rpgs and hobbyist GIS applications for mapmaking
 * Copyright (C) 2004 Michael J. Pedersen <m.pedersen@icelus.org>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
/**
 * @file 
 */

#include <stdexcept>
#include <cmath>

#include "DrawPrimitive.h"
#include "LinePrimitive.h"
#include "CurvePrimitive.h"
#include "PolyLinePrimitive.h"
#include "PolyCurvePrimitive.h"
#include "MapObject.h"
#include "LocalizedStrings.h"
#include "generic_library.h"
#include "SettingsDlg.h"
#include "matrixmath.h"
#include "geometry.h"

static wxString className=wxT("DrawPrimitive");

void StartNewHandleDraw() {
	extern coord LastHandleX;
	extern coord LastHandleY;
	LastHandleX = 9e99;
	LastHandleY = 9e99;
}

DrawPrimitive::DrawPrimitive() {
    wxLogTrace(className, wxT("Entering DrawPrimitive"));
	// By default, our map is the drawing map.  If this is actually going to go into
	// a different map (e.g. a symbol catalog), we don't have to worry about it here.
	// MapCollections always call SetMap whenever an object is added to their linked
	// lists.
	extern MapCollection* mapcollection;
	wxASSERT(mapcollection != NULL);
	MapC = mapcollection;

	// Start off by saying we are a base object, but don't add ourselves to the base
	// object list.  Routines like AddToBaseOrCopies(), DoRead(), or
	// ReadBaseFromDOMElement() will determine the truth and take appropriate steps.
	Base = NULL;
	extern wxFrame* glbMainWin;
	wxASSERT(glbMainWin != NULL);
	wxChoice* cbOverlay = static_cast<wxChoice*>(glbMainWin->FindWindowByName(wxT("cbOverlay")));
	wxASSERT(cbOverlay != NULL);
	int n = cbOverlay->GetSelection();
	if (n == wxNOT_FOUND) {
		n = 0;
	}
	fOverlay = n;
	fSelected = false;
	fExtent = MakeCoordRect(0, 0, 0, 0);
	extern wxColour CurrentColor;
	fColor = CurrentColor;
	Next = NULL;
	Alias.x = 0;
	Alias.y = 0;
    wxLogTrace(className, wxT("Exiting DrawPrimitive"));
}

DrawPrimitive::~DrawPrimitive() {
    wxLogTrace(className, wxT("Entering ~DrawPrimitive"));
    wxLogTrace(className, wxT("Exiting ~DrawPrimitive"));
}

// Since we now have this mechanism for base and alias objects, and since the
// base object list is contained in a MapCollection, each DrawPrimitive MUST know
// the MapCollection to which it belongs.  This is critical because there are
// actually several MapCollections active at any one time (symbol catalogs have
// their own distinct MapCollections).
void DrawPrimitive::SetMap(wxObject* M) {
    wxLogTrace(className, wxT("Entering SetMap"));
	MapC = M;
    wxLogTrace(className, wxT("Exiting SetMap"));
}

void DrawPrimitive::ClearChain() {
    wxLogTrace(className, wxT("Entering ClearChain"));
    wxLogTrace(className, wxT("Exiting ClearChain"));
}

// If we're not already in the base list, find the first free base slot to
// use, or make a new one if none are empty.  Base slots can become empty as
// objects are deleted.
void DrawPrimitive::InsertIntoBaseList() {
    wxLogTrace(className, wxT("Entering InsertIntoBaseList"));
	int i;
	bool b;
	MapCollection* map = static_cast<MapCollection*>(MapC);

	if (map->BasePrimitives.IndexOfObject(this) < 0) {
		i=0;
		b=false;
		while ((i < map->BasePrimitives.getCount()) and (not b)) {
			if (map->BasePrimitives.objects[i] == NULL) {
				b=true;
			} else {
				i++;
			}
		}
		if (b) {
			map->BasePrimitives.objects[i] = this;
		} else {
			map->BasePrimitives.AddObject(wxT(""), this);
		}
	}
    wxLogTrace(className, wxT("Exiting InsertIntoBaseList"));
}

// This routine checks a DrawPrimitive and finds out whether it is a unique
// object or is in fact a copy of something that already exists.  If the object
// is unique, it is added to the base object list, and if it is a copy then it
// is turned into an alias.  Generally this can be a time-consuming process,
// since it calls IsSimilarTo() for each object it finds in the base list, and
// should only be used at certain times (loading a binary map file, adding
// new objects, etc.).  Since XML files are designed to preserve base/alias
// information, this doesn't need to be called when they are loaded, which
// makes loading XML files very fast!  The main place where this routine is
// used is when binary maps are loaded and objects are made into base and alias
// objects.  It makes loading binary maps take longer but once they're converted
// to XML maps the pain is gone :)
void DrawPrimitive::AddToBaseOrCopies(bool DoChain) {
    wxLogTrace(className, wxT("Entering AddToBaseOrCopies"));
	int i, j;
	bool b;
	MapCollection* map=static_cast<MapCollection*>(MapC);
	DrawPrimitive* p;

	i=0;
	b=false;

	// We need to explicitly call SplitOff because we might be trying to add something
	// that is already an alias object (real-world example: group a series of objects,
	// copy the group, resize the new copy, and then group it again.).  The call to
	// ComputeExtent won't be accurate unless we first ensure that this object is
	// NOT an alias object.
	
	SplitOff();
	ComputeExtent();

	// Check all the base primitives, and see if we match any of them.
	// This is the most time-consuming part.
	
	while ((i < map->BasePrimitives.getCount()) and not b) {
		p = map->BasePrimitives.objects.at(i);
		if ((p != NULL) and (p != this)) {
			b = b or IsSimilarTo(*(static_cast<DrawPrimitive*>(p)));
		}
		if (not b) {
			i++;
		}
	}

	// Set the alias's position.  It doesn't hurt to set it for base objects as well.
	// (See DrawPrimitive.ReadBaseFromDOMElement() for important note)
	
	Alias.x = fExtent.GetLeft();
	Alias.y = fExtent.GetTop();

	// Is it unique or isn't it?
	
	if (not b) {
		// we don't match any existing object, so put into the base list
		InsertIntoBaseList();
	} else {
		// Get rid of any dynamically allocated pieces, since we will become an alias
		Clear();

		// It is possible that something that was a base is becoming another
		// primitive's alias.  This can happen when objects are decomposed into
		// their constituent parts and those parts are injected back into the
		// map (decomposing sometimes calls SplitOff()).  In that case, we need to
		// find this object's base slot and clear it.
		j = map->BasePrimitives.IndexOfObject(this);
		if (j >= 0) {
			map->BasePrimitives.objects.at(j) = NULL;
		}

		// Connect to our new base object and mirror the basic stuff that every
		// DrawPrimitive needs, then calculate our new extent
		Base = static_cast<DrawPrimitive*>(map->BasePrimitives.objects.at(i));
		Base->Copies.AddObject(wxT(""), this);
		CopyFromBase(true);
		ComputeExtent();
	}
	
    wxLogTrace(className, wxT("Exiting AddToBaseOrCopies"));
}

// ClearThis() is used to clear (and especially deallocate) anything specific
// to a particular DrawPrimitive type.  For instance, polylines and polycurves
// have to get rid of their point arrays, other objects have to get rid of
// fonts, bitmaps, etc.  Splitting the method off is important, since Clear() has
// to work differently depending on whether a DrawPrimitive is a base or an alias.
// Generally speaking, ClearThis() should never be called directly.  It is
// intended only for use by DrawPrimitive.Clear().
//
// Deallocate will cause ClearThis() to actually deallocate allocated memory if
// true.  Otherwise, only variables will be cleared to default values if necessary.
// This is mainly needed for dealing with group primitives.
void DrawPrimitive::ClearThis(bool deallocate) {
    wxLogTrace(className, wxT("Entering ClearThis"));
	// To be overridden in child classes
    wxLogTrace(className, wxT("Exiting ClearThis"));
}

// Clear() is intended to completely empty a DrawPrimitive.  However, since a
// DrawPrimitive could be either a base or alias, this method has to handle the
// two cases intelligently.
//
// NB: One must be careful calling this routine.  Since it changes a DrawPrimitive,
// by rights the primitive should then either be made into a base object in its own
// right or become another object's alias.  Normally this would be done by calling
// AddToBaseOrCopies(), but since this routine is called BY AddToBaseOrCopies() that
// would be very bad :).  When calling Clear() from any normal routine, one should
// always call SplitOff() first to ensure that this object is unique.
void DrawPrimitive::Clear() {
    wxLogTrace(className, wxT("Entering Clear"));
	int i;
	DrawPrimitive* g;

	if (Base == NULL) {
		// This object is a base object.  Only fully clear and deallocate it if it has
		// no aliases.  If there are aliases, then the first alias has to become the new
		// base and this object can be cleared WITHOUT deallocating anything common to
		// all aliases.
		if (Copies.getCount() > 0) {
			g=static_cast<DrawPrimitive*>(Copies.objects.at(0));
			g->Base=NULL;
			g->Copies.Clear();
			for (i=1; i<Copies.getCount(); i++) {
				g->Copies.AddObject(wxT(""), Copies.objects.at(i));
				Copies.objects.at(i) = g;
			}
			static_cast<MapCollection*>(MapC)->BasePrimitives.objects.at(static_cast<MapCollection*>(MapC)->BasePrimitives.IndexOfObject(this)) = g;
			Copies.Clear();
			ClearThis(false);
		} else {
			ClearThis(true);
		}
	} else {
		// This object is an alias object.  Clear it and remove it from its base
		// object's alias list.
		//Base->Copies.Delete(Base->Copies.IndexOfObject(this));
		int index = Base->Copies.IndexOfObject(this);
		Base->Copies.Delete(index);
		Base = NULL;
		ClearThis(false);
	}


    wxLogTrace(className, wxT("Exiting Clear"));
}

// Makes an aliased copy from this object's Base object,
// without copying anything specific to this one (like
// its position).
void DrawPrimitive::CopyFromBase(bool AliasOnly) {
    wxLogTrace(className, wxT("Entering CopyFromBase"));
	if (Base != NULL) {
		fColor = Base->fColor;
		MapC = Base->MapC;
	}
    wxLogTrace(className, wxT("Exiting CopyFromBase"));
}

DrawPrimitive* DrawPrimitive::Copy() {
    wxLogTrace(className, wxT("Entering Copy"));
    wxLogTrace(className, wxT("Exiting Copy"));
	return(NULL);
}

void DrawPrimitive::SetExtent(const arRealRect& value) {
    wxLogTrace(className, wxT("Entering setExtent"));
	fExtent.SetLeft(std::min(value.GetLeft(), value.GetRight()));
	fExtent.SetRight(std::max(value.GetLeft(), value.GetRight()));
	fExtent.SetTop(std::min(value.GetTop(), value.GetBottom()));
	fExtent.SetBottom(std::max(value.GetTop(), value.GetBottom()));
    wxLogTrace(className, wxT("Exiting setExtent"));
}

void DrawPrimitive::MakeCopy(DrawPrimitive& from) {
	wxLogTrace(className, wxT("Entering MakeCopy"));
	if (from.Base != NULL) {
		Base = from.Base;
		from.Base->Copies.AddObject(wxT(""), this);
	} else {
		from.Copies.AddObject(wxT(""), this);
		Base = &from;
	}
	
	fExtent = from.fExtent;
	Alias.x = from.fExtent.GetLeft();
	Alias.y = from.fExtent.GetTop();
	MapC = from.MapC;
	fOverlay = from.fOverlay;
	fColor = from.fColor;
	wxLogTrace(className, wxT("Exiting MakeCopy"));
}

// This function should be called sparingly and with caution.  It reads a ViewPoint
// and allocates a new, SHIFTED ViewPoint that points to an object's base object.
// It's primary purpose is for when drawing a DrawPrimitive.  Is is generally better
// to call GetAdjustedX(), GetAdjustedY(), etc. rather than MakeAliasView(), except
// in cases where it is more efficient to simply shift the viewpoint (such as when
// drawing).
//
// NB: The routine that calls this is responsible for deallocating the ViewPoint it
// returns.  Note also that in the case where this object is actually a base object,
// a ViewPoint is NOT allocated and the original one is merely returned.  Routines
// that call this therefore have to make sure to only deallocate the ViewPoint if it
// is in fact different.
ViewPoint DrawPrimitive::MakeAliasView(ViewPoint view) {
	wxLogTrace(className, wxT("Entering MakeAliasView"));
	coord x, y;
	ViewPoint retval;

	if (Base != NULL) {
		ViewPoint v(view);
		x = Alias.x - Base->fExtent.GetLeft();
		y = Alias.y - Base->fExtent.GetTop();
		v.Area.SetLeft(v.Area.GetLeft()-x);
		v.Area.SetTop(v.Area.GetTop()-y);
		v.Area.SetRight(v.Area.GetRight()-x);
		v.Area.SetBottom(v.Area.GetBottom()-y);
		retval = v;
	} else {
		retval = view;
	}
	wxLogTrace(className, wxT("Exiting MakeAliasView"));
	return(retval);
}

// Alias objects, by definition, either contain or point to the same coordinates
// as their base objects.  Therefore, when we need to determine where a coordinate
// REALLY lies, we call routines like this to determine the truth.
coord DrawPrimitive::GetAdjustedX(coord x) {
	wxLogTrace(className, wxT("Entering GetAdjustedX"));
	coord retval;
	if (Base != NULL) {
		retval = x + (Alias.x - Base->fExtent.GetLeft());
	} else {
		retval = x;
	}
	wxLogTrace(className, wxT("Exiting GetAdjustedX"));
	return(retval);
}

// Alias objects, by definition, either contain or point to the same coordinates
// as their base objects.  Therefore, when we need to determine where a coordinate
// REALLY lies, we call routines like this to determine the truth.
coord DrawPrimitive::GetAdjustedY(coord y) {
	wxLogTrace(className, wxT("Entering GetAdjustedY"));
	coord retval;
	if (Base != NULL) {
		retval = y + (Alias.y - Base->fExtent.GetTop());
	} else {
		retval = y;
	}
	wxLogTrace(className, wxT("Exiting GetAdjustedY"));
	return(retval);
}

// Alias objects, by definition, either contain or point to the same coordinates
// as their base objects.  Therefore, when we need to determine where a coordinate
// REALLY lies, we call routines like this to determine the truth.
arRealPoint DrawPrimitive::GetAdjustedPoint(arRealPoint p) {
	wxLogTrace(className, wxT("Entering GetAdjustedPoint"));
	if (Base != NULL) {
		p.x = p.x + (Alias.x - Base->fExtent.GetLeft());
		p.y = p.y + (Alias.y - Base->fExtent.GetTop());
	}
	wxLogTrace(className, wxT("Exiting GetAdjustedPoint"));
	return(p);
}

void DrawPrimitive::RecalcAliasFromExtent() {
	wxLogTrace(className, wxT("Entering RecalcAliasFromExtent"));
	ComputeExtent();
	Alias.x = fExtent.GetLeft();
	Alias.y = fExtent.GetTop();
	wxLogTrace(className, wxT("Exiting RecalcAliasFromExtent"));
}

void DrawPrimitive::RefreshCopies() {
	wxLogTrace(className, wxT("Entering RefreshCopies"));
	wxLogTrace(className, wxT("Exiting RefreshCopies"));
}

void DrawPrimitive::ComputeExtent() {
    wxLogTrace(className, wxT("Entering ComputeExtent"));
	fExtent = MakeCoordRect(0, 0, 0, 0);
    wxLogTrace(className, wxT("Exiting ComputeExtent"));
}

bool DrawPrimitive::IsClosed() {
    wxLogTrace(className, wxT("Entering IsClosed"));
	return(false);
    wxLogTrace(className, wxT("Exiting IsClosed"));
}

void DrawPrimitive::SetSize(coord w, coord h) {
    wxLogTrace(className, wxT("Entering SetSize"));
	Matrix3 mat;
	coord xc, yc;
	double xf, yf;

	xc=width()/2;
	yc=height()/2;
	mat = Matrix3::offset(-(fExtent.GetLeft()+xc), -(fExtent.GetTop()+yc));
	if ((w != 0) and (width() != 0)) {
		xf = w/width();
		xc = w/2;
	} else {
		xf = 1.0;
	}

	if ((h != 0) and (height() != 0)) {
		yf = h/height();
		xc = h/2; ///@todo: This was double checked by me to be a correct port. But is the code correct?
	} else {
		yf = 1.0;
	}
	mat = (mat * Matrix3::scale(xf, yf)) * Matrix3::offset(fExtent.GetLeft()+xc, fExtent.GetTop()+yc);
	ApplyMatrix(mat);
	ComputeExtent();
    wxLogTrace(className, wxT("Exiting SetSize"));
}

coord DrawPrimitive::width() {
    wxLogTrace(className, wxT("Entering width"));
	return (fExtent.GetRight() - fExtent.GetLeft());
    wxLogTrace(className, wxT("Exiting width"));
}

coord DrawPrimitive::height() {
    wxLogTrace(className, wxT("Entering height"));
	return (fExtent.GetBottom() - fExtent.GetTop());
    wxLogTrace(className, wxT("Exiting height"));
}

bool DrawPrimitive::IsWithin(arRealRect rect) {
    wxLogTrace(className, wxT("Entering IsWithin"));
	bool retval =
		rect.Inside(fExtent.GetTopLeft()) and 
		rect.Inside(fExtent.GetBottomRight());
    wxLogTrace(className, wxT("Exiting IsWithin"));
	return(retval);
}

bool DrawPrimitive::IsTouching(arRealRect rect) {
    wxLogTrace(className, wxT("Entering IsTouching"));
	bool retval =
		rect.Inside(fExtent.GetTopLeft()) or 
		rect.Inside(fExtent.GetBottomRight()) or
		fExtent.Inside(rect.GetTopLeft()) or
		fExtent.Inside(rect.GetBottomRight());
    wxLogTrace(className, wxT("Exiting IsTouching"));
	return(retval);
}

bool DrawPrimitive::IsInOverlay(OverlaySet& overlay) {
    wxLogTrace(className, wxT("Entering IsInOverlay"));
	bool retval = (overlay.find(fOverlay) != overlay.end());
    wxLogTrace(className, wxT("Exiting IsInOverlay"));
	return(retval);
}

bool DrawPrimitive::IsSelected() {
    wxLogTrace(className, wxT("Entering IsSelected"));
    wxLogTrace(className, wxT("Exiting IsSelected"));
	return(fSelected);
}

void DrawPrimitive::Select(ViewPoint* View, bool b) {
    wxLogTrace(className, wxT("Entering Select"));
	if (b != fSelected) {
		fSelected = b;
		if ((View != NULL) and (View->canvas != NULL)) {
			Draw(View);
		}
	}
    wxLogTrace(className, wxT("Exiting Select"));
}

bool DrawPrimitive::SelectClick(const double within, arRealPoint p) {
    wxLogTrace(className, wxT("Entering SelectClick"));
	VPoints fracpoints;
	int i, polycount;
	bool retval = false;

	//GetLines() is smart enough to take Base/Alias into account and
	//return correct coordinates
	fracpoints = GetLines(NULL, polycount);
	if (polycount != 0) {
		if (IsClosed()) {
			retval = PointInPolygon(p, fExtent, fracpoints, polycount);
		} else {
			for (i=1; i<polycount; i++) {
				if (distanceToSegment(p, fracpoints[i-1], fracpoints[i]) < within) {
					retval = true;
					break;
				}
			}
		}
	}
    wxLogTrace(className, wxT("Exiting SelectClick"));
	return(retval);
}

bool DrawPrimitive::OnScreen(const arRealRect& rect) {
    wxLogTrace(className, wxT("Entering OnScreen"));
	bool retval =
			(fExtent.GetLeft()   < rect.GetRight()) and
			(fExtent.GetRight()  > rect.GetLeft()) and
			(fExtent.GetTop()    < rect.GetBottom()) and
			(fExtent.GetBottom() > rect.GetTop());
    wxLogTrace(className, wxT("Exiting OnScreen"));
	return(retval);
}

void DrawPrimitive::Invalidate(const wxObject& handle, const ViewPoint& view) {
    wxLogTrace(className, wxT("Entering Invalidate"));
    wxLogTrace(className, wxT("Exiting Invalidate"));
}

bool DrawPrimitive::Decompose(const ViewPoint& view, DrawPrimitive& NewChain, bool testinside) {
    wxLogTrace(className, wxT("Entering Decompose"));
    wxLogTrace(className, wxT("Exiting Decompose"));
	return(false);
}

void DrawPrimitive::InvalidateHandle(const wxObject& handle, const ViewPoint& view, coord x, coord y) {
    wxLogTrace(className, wxT("Entering InvalidateHandle"));
    wxLogTrace(className, wxT("Exiting InvalidateHandle"));
}

void DrawPrimitive::DrawHandle(const ViewPoint& view, coord x, coord y) {
    wxLogTrace(className, wxT("Entering DrawHandle"));
    wxLogTrace(className, wxT("Exiting DrawHandle"));
}

void DrawPrimitive::DrawOverlayHandle(ViewPoint view, coord x, coord y) {
    wxLogTrace(className, wxT("Entering DrawOverlayHandle"));
	int sx, sy;
	ViewPoint v;

	v = MakeAliasView(view);
	v.CoordToScreen(x, y, sx, sy);
	extern MainWin* glbMainWin;
	wxASSERT(glbMainWin != NULL);
	//wxCheckListBox* overlayList = static_cast<wxCheckListBox*>(glbMainWin->FindWindowByName(wxT("clOverlayList")));
	//wxASSERT(overlayList != NULL);
	glbMainWin->OverlayImages.Draw(fOverlay, *(v.canvas), sx, sy);
    wxLogTrace(className, wxT("Exiting DrawOverlayHandle"));
}

bool DrawPrimitive::TestHandle(ViewPoint& view, coord tx, coord ty, coord px, coord py) {
    wxLogTrace(className, wxT("Entering TestHandle"));
	int stx, sty, spx, spy;
	bool retval;

	view.CoordToScreen(tx, ty, stx, sty);
	view.CoordToScreen(px, py, spx, spy);
	wxRect rect(stx-2, sty-2, stx+3, sty+3);
	retval = rect.Inside(wxPoint(spx, spy));
    wxLogTrace(className, wxT("Exiting TestHandle"));
	return(retval);
}

int DrawPrimitive::PointClosestInArray(coord x, coord y, VPoints points, int count) {
    wxLogTrace(className, wxT("Entering PointClosestInArray"));
    wxLogTrace(className, wxT("Exiting PointClosestInArray"));
}

int DrawPrimitive::PointClosestInAdjustedArray(coord x, coord y, VPoints points, int count) {
    wxLogTrace(className, wxT("Entering PointClosestInAdjustedArray"));
    wxLogTrace(className, wxT("Exiting PointClosestInAdjustedArray"));
}

VPoints DrawPrimitive::GetLines(const ViewPoint* view, int& polycount) {
    wxLogTrace(className, wxT("Entering GetLines"));
	polycount = 0;
    wxLogTrace(className, wxT("Exiting GetLines"));
	VPoints empty;
	return(empty);
}

bool DrawPrimitive::FindHandle(ViewPoint& view, coord x, coord y) {
    wxLogTrace(className, wxT("Entering FindHandle"));
	bool retval = 
		(TestHandle(view, fExtent.GetLeft(),  fExtent.GetTop(),    x, y)) or 
		(TestHandle(view, fExtent.GetLeft(),  fExtent.GetBottom(), x, y)) or 
		(TestHandle(view, fExtent.GetRight(), fExtent.GetTop(),    x, y)) or 
		(TestHandle(view, fExtent.GetRight(), fExtent.GetBottom(), x, y));
    wxLogTrace(className, wxT("Exiting FindHandle"));
	return(retval);
}

bool DrawPrimitive::FindHyperLink(const ViewPoint& view, coord x, coord y, wxString& hypertext, HyperlinkFlags& hyperflags) {
    wxLogTrace(className, wxT("Entering FindHyperLink"));
    wxLogTrace(className, wxT("Exiting FindHyperLink"));
	return(false);
}

bool DrawPrimitive::FindEndPoint(const ViewPoint& view, coord x, coord y) {
    wxLogTrace(className, wxT("Entering FindEndPoint"));
    wxLogTrace(className, wxT("Exiting FindEndPoint"));
	return(false);
}

bool DrawPrimitive::FindPointOn(const ViewPoint& view, coord x, coord y, coord angle) {
    wxLogTrace(className, wxT("Entering FindPointOn"));
    wxLogTrace(className, wxT("Exiting FindPointOn"));
	return(false);
}

bool DrawPrimitive::MoveHandle(ViewPoint& view, HandleMode& mode, coord origx, coord origy, coord dx, coord dy) {
    wxLogTrace(className, wxT("Entering MoveHandle"));
	bool retval = false;
	if (FindHandle(view, origx, origy)) {
		fExtent.SetLeft(fExtent.GetLeft() + dx);
		fExtent.SetRight(fExtent.GetRight() + dx);
		fExtent.SetTop(fExtent.GetTop() + dy);
		fExtent.SetBottom(fExtent.GetBottom() + dy);
		retval = true;
	}
    wxLogTrace(className, wxT("Exiting MoveHandle"));
	return(retval);
}

void DrawPrimitive::Move(coord dx, coord dy) {
    wxLogTrace(className, wxT("Entering Move"));
	fExtent.SetLeft(fExtent.GetLeft() + dx);
	fExtent.SetRight(fExtent.GetRight() + dx);
	fExtent.SetTop(fExtent.GetTop() + dy);
	fExtent.SetBottom(fExtent.GetBottom() + dy);
	Alias.x = Alias.x + dx;
	Alias.y = Alias.y + dy;
	ComputeExtent();
    wxLogTrace(className, wxT("Exiting Move"));
}

void DrawPrimitive::Draw(ViewPoint* view) {
    wxLogTrace(className, wxT("Entering Draw"));
    wxLogTrace(className, wxT("Exiting Draw"));
}

void DrawPrimitive::DrawHandles(const ViewPoint& view) {
    wxLogTrace(className, wxT("Entering DrawHandles"));
    wxLogTrace(className, wxT("Exiting DrawHandles"));
}

// Note the call to MakeAliasView() to create a shifted ViewPoint that points
// to the base object's coordinates.  If it was necessary to shift the
// viewpoint, it will be deallocated below.  This technique is used in Draw()
// methods as well and is especially useful for when dealing with
// GroupPrimitives.
void DrawPrimitive::DrawOverlayHandles(ViewPoint& view, coord x, coord y) {
    wxLogTrace(className, wxT("Entering DrawOverlayHandles"));
	DrawOverlayHandle(view, fExtent.GetLeft(), fExtent.GetTop());
    wxLogTrace(className, wxT("Exiting DrawOverlayHandles"));
}

void DrawPrimitive::PointClosestTo(coord x, coord y, coord& px, coord& py) {
    wxLogTrace(className, wxT("Entering PointClosestTo"));
    wxLogTrace(className, wxT("Exiting PointClosestTo"));
}

void DrawPrimitive::InvalidateHandles(const wxObject& handle, const ViewPoint& view) {
    wxLogTrace(className, wxT("Entering InvalidateHandles"));
    wxLogTrace(className, wxT("Exiting InvalidateHandles"));
}

bool DrawPrimitive::FindScalpelPoint(const ViewPoint& view, coord x, coord y, int& index) {
    wxLogTrace(className, wxT("Entering FindScalpelPoint"));
    wxLogTrace(className, wxT("Exiting FindScalpelPoint"));
	return(false);
}

bool DrawPrimitive::SeparateNode(const ViewPoint& view, int index, DrawPrimitive& NewObject) {
    wxLogTrace(className, wxT("Entering SeparateNode"));
    wxLogTrace(className, wxT("Exiting SeparateNode"));
	return(false);
}

void DrawPrimitive::DeleteNode(const ViewPoint& view, int index) {
    wxLogTrace(className, wxT("Entering DeleteNode"));
    wxLogTrace(className, wxT("Exiting DeleteNode"));
}

bool DrawPrimitive::SliceAlong(arRealPoint s1, arRealPoint s2, DrawPrimitive& np) {
    wxLogTrace(className, wxT("Entering SliceAlong"));
    wxLogTrace(className, wxT("Exiting SliceAlong"));
	return(false);
}

wxColour DrawPrimitive::DisplayColor(wxColour color) {
    wxLogTrace(className, wxT("Entering DisplayColor"));
	wxColour retval;
	extern wxColour* OverlayMainColor;
	extern SettingsDlg* settingsdlg;
	wxASSERT(settingsdlg != NULL);
	wxCheckBox* visual = static_cast<wxCheckBox*>(settingsdlg->FindWindowByName(wxT("checkVisualOverlayDisplay")));
	wxRadioButton* colorcoded = static_cast<wxRadioButton*>(settingsdlg->FindWindowByName(wxT("rdbColorCoded")));
	wxASSERT(visual != NULL);
	wxASSERT(colorcoded != NULL);
	if (visual->IsChecked() and colorcoded->GetValue()) {
		retval = OverlayMainColor[fOverlay % maxOverlayColors];
	} else {
		retval = color;
	}
    wxLogTrace(className, wxT("Exiting DisplayColor"));
	return(retval);
}

wxColour DrawPrimitive::DisplayFillColor(wxColour color) {
    wxLogTrace(className, wxT("Entering DisplayFillColor"));
	wxColour retval;
	extern wxColour* OverlayFillColor;
	extern SettingsDlg* settingsdlg;
	wxASSERT(settingsdlg != NULL);
	wxCheckBox* visual = static_cast<wxCheckBox*>(settingsdlg->FindWindowByName(wxT("checkVisualOverlayDisplay")));
	wxRadioButton* colorcoded = static_cast<wxRadioButton*>(settingsdlg->FindWindowByName(wxT("rdbColorCoded")));
	wxASSERT(visual != NULL);
	wxASSERT(colorcoded != NULL);
	if (visual->IsChecked() and colorcoded->GetValue()) {
		retval = OverlayFillColor[fOverlay % maxOverlayColors];
	} else {
		retval = color;
	}
    wxLogTrace(className, wxT("Exiting DisplayFillColor"));
	return (retval);
}

void DrawPrimitive::CopyCore(DrawPrimitive obj) {
    wxLogTrace(className, wxT("Entering CopyCore"));
	fOverlay  = obj.fOverlay;
	fSelected = obj.fSelected;
	fColor    = obj.fColor;
	MapC      = obj.MapC;
    wxLogTrace(className, wxT("Exiting CopyCore"));
}

bool DrawPrimitive::ApplyMatrix(Matrix3& mat) {
    wxLogTrace(className, wxT("Entering ApplyMatrix"));
    wxLogTrace(className, wxT("Exiting ApplyMatrix"));
	return(false);
}

bool DrawPrimitive::SetStyle(StyleAttrib style) {
    wxLogTrace(className, wxT("Entering SetStyle"));
    wxLogTrace(className, wxT("Exiting SetStyle"));
	return(false);
}

StyleAttrib DrawPrimitive::GetStyle() {
    wxLogTrace(className, wxT("Entering GetStyle"));
	StyleAttrib result;
	result.bits = 0xFFFFFFFF;
	result.FullStyle.Thickness = -1;
	result.FullStyle.SThickness = 0;
    wxLogTrace(className, wxT("Exiting GetStyle"));
	return(result);
}

bool DrawPrimitive::SetSeed(int seed) {
    wxLogTrace(className, wxT("Entering SetSeed"));
    wxLogTrace(className, wxT("Exiting SetSeed"));
	return(false);
}

int DrawPrimitive::GetSeed() {
    wxLogTrace(className, wxT("Entering GetSeed"));
    wxLogTrace(className, wxT("Exiting GetSeed"));
	return(-1);
}

bool DrawPrimitive::SetRoughness(int rough) {
    wxLogTrace(className, wxT("Entering SetRoughness"));
    wxLogTrace(className, wxT("Exiting SetRoughness"));
	return(false);
}

int DrawPrimitive::GetRoughness() {
    wxLogTrace(className, wxT("Entering GetRoughness"));
    wxLogTrace(className, wxT("Exiting GetRoughness"));
	return(-1);
}

bool DrawPrimitive::SetColor(wxColour color) {
    wxLogTrace(className, wxT("Entering SetColor"));
	SplitOff();
	fColor = color;
    wxLogTrace(className, wxT("Exiting SetColor"));
	return(true);
}

wxColour DrawPrimitive::GetColor() {
    wxLogTrace(className, wxT("Entering GetColor"));
    wxLogTrace(className, wxT("Exiting GetColor"));
	return(fColor);
}

bool DrawPrimitive::SetFillColor(wxColour color) {
    wxLogTrace(className, wxT("Entering SetFillColor"));
    wxLogTrace(className, wxT("Exiting SetFillColor"));
	return(false);
}

wxColour DrawPrimitive::GetFillColor() {
    wxLogTrace(className, wxT("Entering GetFillColor"));
    wxLogTrace(className, wxT("Exiting GetFillColor"));
	return(wxNullColour);
}

bool DrawPrimitive::SetOverlay(unsigned short overlay) {
    wxLogTrace(className, wxT("Entering SetOverlay"));
	SplitOff();
	fOverlay = overlay;
    wxLogTrace(className, wxT("Exiting SetOverlay"));
	return(true);
}

int DrawPrimitive::GetOverlay() {
    wxLogTrace(className, wxT("Entering GetOverlay"));
    wxLogTrace(className, wxT("Exiting GetOverlay"));
	return(fOverlay);
}

bool DrawPrimitive::SetTextAttrib(const ViewPoint& view, const TextAttrib& attrib) {
    wxLogTrace(className, wxT("Entering SetTextAttrib"));
    wxLogTrace(className, wxT("Exiting SetTextAttrib"));
	return(false);
}

TextAttrib DrawPrimitive::GetTextAttrib() {
    wxLogTrace(className, wxT("Entering GetTextAttrib"));
	TextAttrib attrib;
	attrib.Valid.clear();
    wxLogTrace(className, wxT("Exiting GetTextAttrib"));
	return(attrib);
}

void DrawPrimitive::CloseFigure() {
    wxLogTrace(className, wxT("Entering CloseFigure"));
    wxLogTrace(className, wxT("Exiting CloseFigure"));
}

void DrawPrimitive::Reverse() {
    wxLogTrace(className, wxT("Entering Reverse"));
    wxLogTrace(className, wxT("Exiting Reverse"));
}

bool DrawPrimitive::SetFractal(FractalState state) {
    wxLogTrace(className, wxT("Entering SetFractal"));
    wxLogTrace(className, wxT("Exiting SetFractal"));
	return(false);
}

bool DrawPrimitive::ChainApplyMatrix(Matrix3 mat, bool all) {
    wxLogTrace(className, wxT("Entering ChainApplyMatrix"));
	DrawPrimitive* p;
	bool retval = false;
	p = this;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			if (p->ApplyMatrix(mat)) {
				p->ComputeExtent();
				retval = true;
			}
		}
		p = p->Next;
	}
    wxLogTrace(className, wxT("Exiting ChainApplyMatrix"));
	return(retval);
}

arRealRect DrawPrimitive::ChainExtent(bool all) {
    wxLogTrace(className, wxT("Entering ChainExtent"));
	DrawPrimitive* p;
	arRealRect r;
	int c;

	r = MakeCoordRect(0, 0, 0, 0);
	p = this;
	c = 0;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			c++;
			if (c == 1) {
				r = p->fExtent;
			} else {
				r.x = std::min(r.x, p->fExtent.x);
				r.y = std::min(r.y, p->fExtent.y);
				r.width  = std::min(r.width,  p->fExtent.width);
				r.height = std::min(r.height, p->fExtent.height);
			}
		}
		p = p->Next;
	}
    wxLogTrace(className, wxT("Exiting ChainExtent"));
	return(r);
}

bool DrawPrimitive::ChainSetStyle(StyleAttrib style, bool all) {
    wxLogTrace(className, wxT("Entering ChainSetStyle"));
	DrawPrimitive* p=this;
	bool retval = false;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			if (p->SetStyle(style)) {
				retval = true;
			}
		}
		p = p->Next;
	}
    wxLogTrace(className, wxT("Exiting ChainSetStyle"));
	return(retval);
}

StyleAttrib DrawPrimitive::ChainGetStyle(bool all) {
    wxLogTrace(className, wxT("Entering ChainGetStyle"));
	DrawPrimitive* p=this;
	StyleAttrib t, style, retval;
	style.bits = 0xFFFFFFFF;
	style.FullStyle.Thickness = -1;
	style.FullStyle.SThickness = 0;
	retval.bits = 0;
	retval.FullStyle.Thickness = 0;
	retval.FullStyle.SThickness = 0;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			t = p->GetStyle();

			//.bytes.Line Style
			if (t.bytes.Line != 0xFF) {
				if (style.bytes.Line = 0xFF) {
					style.bytes.Line = t.bytes.Line;
				} else {
					if (style.bytes.Line != t.bytes.Line) {
						retval.bytes.Line = 0xFF;
					}
				}
			}

			//.bytes.Fill Style
			if (t.bytes.Fill != 0xFF) {
				if (style.bytes.Fill = 0xFF) {
					style.bytes.Fill = t.bytes.Fill;
				} else {
					if (style.bytes.Fill != t.bytes.Fill) {
						retval.bytes.Fill = 0xFF;
					}
				}
			}

			//.bytes.Line Start Style
			if (t.bytes.First != 0xFF) {
				if (style.bytes.First = 0xFF) {
					style.bytes.First = t.bytes.First;
				} else {
					if (style.bytes.First != t.bytes.First) {
						retval.bytes.First = 0xFF;
					}
				}
			}

			//.bytes.Line End Style
			if (t.bytes.Last != 0xFF) {
				if (style.bytes.Last = 0xFF) {
					style.bytes.Last = t.bytes.Last;
				} else {
					if (style.bytes.Last != t.bytes.Last) {
						retval.bytes.Last = 0xFF;
					}
				}
			}

			//.bytes.Line Thickness
			if (t.FullStyle.Thickness >= 0) {
				if (style.FullStyle.Thickness == -1) {
					style.FullStyle.Thickness  = t.FullStyle.Thickness;
					style.FullStyle.SThickness = t.FullStyle.SThickness;
				} else if (style.FullStyle.Thickness != t.FullStyle.Thickness) {
					retval.FullStyle.Thickness = -1;
				}
			}

		}
		p = p->Next;
	}

	if (retval.bytes.Line != 0xFF) {
		retval.bytes.Line = style.bytes.Line;
	}
	if (retval.bytes.Fill != 0xFF) {
		retval.bytes.Fill = style.bytes.Fill;
	}
	if (retval.bytes.First != 0xFF) {
		retval.bytes.First = style.bytes.First;
	}
	if (retval.bytes.Last != 0xFF) {
		retval.bytes.Last = style.bytes.Last;
	}
	if (retval.FullStyle.Thickness >= 0) {
		retval.FullStyle.Thickness  = style.FullStyle.Thickness;
		retval.FullStyle.SThickness = style.FullStyle.Thickness;
	}

    wxLogTrace(className, wxT("Exiting ChainGetStyle"));
	return(retval);
}

bool DrawPrimitive::ChainSetSeed(int seed, bool all) {
    wxLogTrace(className, wxT("Entering ChainSetSeed"));
	DrawPrimitive* p=this;
	bool retval = false;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			if (p->SetSeed(seed)) {
				retval = true;
			}
		}
		p = p->Next;
	}
    wxLogTrace(className, wxT("Exiting ChainSetSeed"));
	return(retval);
}

int DrawPrimitive::ChainGetSeed(bool all) {
    wxLogTrace(className, wxT("Entering ChainGetSeed"));
	DrawPrimitive* p = this;
	int t;
	int seed = -1;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			t = p->GetSeed();
			if (t != -1 ) {
				if (seed = -1) {
					seed = t;
				} else {
					if (seed != t) {
						seed = -1;
						break;
					}
				}
			}
		}
		p = p->Next;
	}
    wxLogTrace(className, wxT("Exiting ChainGetSeed"));
	return(seed);
}

bool DrawPrimitive::ChainSetRoughness(int rough, bool all) {
    wxLogTrace(className, wxT("Entering ChainSetRoughness"));
	DrawPrimitive* p=this;
	bool retval=false;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			if (p->SetRoughness(rough)) {
				retval = true;
			}
		}
		p = p->Next;
	}
    wxLogTrace(className, wxT("Exiting ChainSetRoughness"));
	return(retval);
}

int DrawPrimitive::ChainGetRoughness(bool all) {
    wxLogTrace(className, wxT("Entering ChainGetRoughness"));
	int t;
	int rough = -1;
	DrawPrimitive* p=this;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			t = p->GetRoughness();
			if (t != -1) {
				if (rough == -1) {
					rough = t;
				} else if (rough != t) {
					rough = -1;
					break;
				}
			}
		}
		p = p->Next;
	}
    wxLogTrace(className, wxT("Exiting ChainGetRoughness"));
	return(rough);
}

bool DrawPrimitive::ChainSetColor(wxColour color, bool all) {
    wxLogTrace(className, wxT("Entering ChainSetColor"));
	DrawPrimitive* p=this;
	bool retval = false;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			if (p->SetColor(color)) {
				retval = true;
			}
		}
		p = p->Next;
	}
    wxLogTrace(className, wxT("Exiting ChainSetColor"));
	return(retval);
}

wxColour DrawPrimitive::ChainGetColor(bool all) {
    wxLogTrace(className, wxT("Entering ChainGetColor"));
	wxColour t;
	wxColour color(wxNullColour);
	DrawPrimitive* p=this;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			t = p->GetColor();
			if (t != wxNullColour) {
				if (color == wxNullColour) {
					color = t;
				} else if (color != t) {
					color = wxNullColour;
					break;
				}
			}
		}
		p = p->Next;
	}
    wxLogTrace(className, wxT("Exiting ChainGetColor"));
	return (color);
}

bool DrawPrimitive::ChainSetFillColor(wxColour color, bool all) {
    wxLogTrace(className, wxT("Entering ChainSetFillColor"));
	DrawPrimitive* p=this;
	bool retval=false;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			if (p->SetFillColor(color)) {
				retval = true;
			}
		}
		p = p->Next;
	}
    wxLogTrace(className, wxT("Exiting ChainSetFillColor"));
	return(retval);
}

wxColour DrawPrimitive::ChainGetFillColor(bool all) {
    wxLogTrace(className, wxT("Entering ChainGetFillColor"));
	DrawPrimitive* p=this;
	wxColour color(wxNullColour);
	wxColour t;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			t = p->GetFillColor();
			if (t != wxNullColour) {
				if (color == wxNullColour) {
					color = t;
				} else if (color != t) {
					color = wxNullColour;
					break;
				}
			}
		}
		p = p->Next;
	}
	wxLogTrace(className, wxT("Exiting ChainGetFillColor"));
	return(color);
}

bool DrawPrimitive::ChainSetOverlay(unsigned short overlay, bool all) {
    wxLogTrace(className, wxT("Entering ChainSetOverlay"));
	DrawPrimitive* p=this;
	bool retval=false;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			if (p->SetOverlay(overlay)) {
				retval = true;
			}
		}
		p = p->Next;
	}
    wxLogTrace(className, wxT("Exiting ChainSetOverlay"));
	return(retval);
}

int DrawPrimitive::ChainGetOverlay(bool all) {
    wxLogTrace(className, wxT("Entering ChainGetOverlay"));
	DrawPrimitive* p=this;
	int t;
	int overlay = -1;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			t = p->GetOverlay();
			if (t != -1) { 
				if (overlay == -1) {
					overlay = t;
				} else if (overlay != t) {
					overlay = -1;
					break;
				}
			}
		}
		p = p->Next;
	}
    wxLogTrace(className, wxT("Exiting ChainGetOverlay"));
	return(overlay);
}

bool DrawPrimitive::ChainSetTextAttrib(const ViewPoint& view, TextAttrib attrib, bool all) {
    wxLogTrace(className, wxT("Entering ChainSetTextAttrib"));
	bool retval = false;
	DrawPrimitive* p=this;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			if (p->SetTextAttrib(view, attrib)) {
				// Only allow the first text/hyperlink string to be changed so the others aren't
				// all wiped out by accident.
				attrib.Valid.erase(tatText);
				attrib.Valid.erase(tatHyperlinkText);
				retval = true;
			}
		}
		p = p->Next;
	}
	
    wxLogTrace(className, wxT("Exiting ChainSetTextAttrib"));
	return(retval);
}

TextAttrib DrawPrimitive::ChainGetTextAttrib(bool all) {
    wxLogTrace(className, wxT("Entering ChainGetTextAttrib"));
	DrawPrimitive* p=this;
	TextAttrib temp, attrib;
	TextAttribSet ignore;

	attrib.Valid.clear();
	ignore.clear();

	while (p != NULL) {
		if (all or p->IsSelected()) {
			temp = p->GetTextAttrib();

			//CheckText
			if ((temp.Valid.find(tatText) != temp.Valid.end()) and (ignore.find(tatText) == ignore.end())) {
				if (attrib.Valid.find(tatText) != attrib.Valid.end()) {
					// Text is a special case; don't merge multiple texts into one;
					// we only allow one text to pass.  More than one will be returned
					// as not the same to prevent us from changing millions of text strings
					// at once accidentally.
					ignore.insert(tatText);
					attrib.Valid.erase(tatText);
				} else {
					attrib.Text = temp.Text;
					attrib.Valid.insert(tatText);
				}
			}
			
			//CheckFontName
			if ((temp.Valid.find(tatFontName) != temp.Valid.end()) and (ignore.find(tatFontName) == ignore.end())) {
				if (attrib.Valid.find(tatFontName) != attrib.Valid.end()) {
					if (attrib.FontName != temp.FontName) {
						ignore.insert(tatFontName);
						attrib.Valid.erase(tatFontName);
					}
				} else {
					attrib.FontName = temp.FontName;
					attrib.Valid.insert(tatFontName);
				}
			}
			
			//CheckFontSize;
			if ((temp.Valid.find(tatFontSize) != temp.Valid.end()) and (ignore.find(tatFontSize) == ignore.end())) {
				if (attrib.Valid.find(tatFontSize) != attrib.Valid.end()) {
					if (attrib.FontSize != temp.FontSize) {
						ignore.insert(tatFontSize);
						attrib.Valid.erase(tatFontSize);
					}
				} else {
						attrib.FontSize = temp.FontSize;
						attrib.Valid.insert(tatFontSize);
				}
			}

			//CheckFontBold;
			if ((temp.Valid.find(tatFontBold) != temp.Valid.end()) and (ignore.find(tatFontBold) == ignore.end())) {
				if (attrib.Valid.find(tatFontBold) != attrib.Valid.end()) {
					if (attrib.FontBold != temp.FontBold) {
						ignore.insert(tatFontBold);
						attrib.Valid.erase(tatFontBold);
					}
				} else {
					attrib.FontBold = temp.FontBold;
					attrib.Valid.insert(tatFontBold);
				}
			}

			//CheckFontItalic;
			if ((temp.Valid.find(tatFontItalic) != temp.Valid.end()) and (ignore.find(tatFontItalic) == ignore.end())) {
				if (attrib.Valid.find(tatFontItalic) != attrib.Valid.end()) {
					if (attrib.FontItalic != temp.FontItalic) {
						ignore.insert(tatFontItalic);
						attrib.Valid.erase(tatFontItalic);
					}
				} else {
					attrib.FontItalic = temp.FontItalic;
					attrib.Valid.insert(tatFontItalic);
				}
			}

			//CheckFontUnderline;
			if ((temp.Valid.find(tatFontUnderline) != temp.Valid.end()) and (ignore.find(tatFontUnderline) == ignore.end())) {
				if (attrib.Valid.find(tatFontUnderline) != attrib.Valid.end()) {
					if (attrib.FontUnderline != temp.FontUnderline) {
						ignore.insert(tatFontUnderline);
						attrib.Valid.erase(tatFontUnderline);
					}
				} else {
					attrib.FontUnderline = temp.FontUnderline;
					attrib.Valid.insert(tatFontUnderline);
				}
			}

			//CheckAlignment;
			if ((temp.Valid.find(tatAlignment) != temp.Valid.end()) and (ignore.find(tatAlignment) == ignore.end())) {
				if (attrib.Valid.find(tatAlignment) != attrib.Valid.end()) {
					if (attrib.Alignment != temp.Alignment) {
						ignore.insert(tatAlignment);
						attrib.Valid.erase(tatAlignment);
					}
				} else {
					attrib.Alignment = temp.Alignment;
					attrib.Valid.insert(tatAlignment);
				}
			}

			//CheckIconSize;
			if ((temp.Valid.find(tatIconSize) != temp.Valid.end()) and (ignore.find(tatIconSize) == ignore.end())) {
				if (attrib.Valid.find(tatIconSize) != attrib.Valid.end()) {
					if (attrib.IconSize != temp.IconSize) {
						ignore.insert(tatIconSize);
						attrib.Valid.erase(tatIconSize);
					}
				} else {
					attrib.IconSize = temp.IconSize;
					attrib.Valid.insert(tatIconSize);
				}
			}

			//CheckFontOutline;
			if ((temp.Valid.find(tatOutlineColor) != temp.Valid.end()) and (ignore.find(tatOutlineColor) == ignore.end())) {
				if (attrib.Valid.find(tatOutlineColor) != attrib.Valid.end()) {
					if (attrib.FontOutlineColor != temp.FontOutlineColor) {
						ignore.insert(tatOutlineColor);
						attrib.Valid.erase(tatOutlineColor);
					}
				} else {
					attrib.FontOutlineColor = temp.FontOutlineColor;
					attrib.Valid.insert(tatOutlineColor);
				}
			}

			//CheckHyperlinkText;
			if ((temp.Valid.find(tatHyperlinkText) != temp.Valid.end()) and (ignore.find(tatHyperlinkText) == ignore.end())) {
				if (attrib.Valid.find(tatHyperlinkText) == attrib.Valid.end()) {
					// Treat Hyperlink text just like normal text
					ignore.insert(tatHyperlinkText);
					attrib.Valid.erase(tatHyperlinkText);
				} else {
					attrib.HyperlinkText = temp.HyperlinkText;
					attrib.Valid.insert(tatHyperlinkText);
				}
			}

			//CheckHyperlinkFlags;
			if ((temp.Valid.find(tatHyperlinkFlags) != temp.Valid.end()) and (ignore.find(tatHyperlinkFlags) == ignore.end())) {
				if (attrib.Valid.find(tatHyperlinkFlags) != attrib.Valid.end()) {
					if (attrib.LinkFlags != temp.LinkFlags) {
						ignore.insert(tatHyperlinkFlags);
						attrib.Valid.erase(tatHyperlinkFlags);
					}
				} else {
					attrib.LinkFlags = temp.LinkFlags;
					attrib.Valid.insert(tatHyperlinkFlags);
				}
			}
		}
		p = p->Next;
	}

    wxLogTrace(className, wxT("Exiting ChainGetTextAttrib"));
	return(attrib);
}

bool DrawPrimitive::ChainSetFractal(FractalState state, bool all) {
    wxLogTrace(className, wxT("Entering ChainSetFractal"));
	DrawPrimitive* p = this;
	bool retval = false;

	while (p != NULL) {
		if (all or p->IsSelected()) {
			if (p->SetFractal(state)) {
				retval = true;
			}
		}
		p = p->Next;
	}
	
    wxLogTrace(className, wxT("Exiting ChainSetFractal"));
	return(retval);
}

int DrawPrimitive::CountSiblings() {
    wxLogTrace(className, wxT("Entering CountSiblings"));
	int retval;
	DrawPrimitive* p=this;

	while (p != NULL) {
		retval++;
		p = p->Next;
	}

    wxLogTrace(className, wxT("Exiting CountSiblings"));
	return(retval);
}

DrawPrimitive DrawPrimitive::IdToObject(wxString id) {
    wxLogTrace(className, wxT("Entering IdToObject"));
    wxLogTrace(className, wxT("Exiting IdToObject"));
}

wxString DrawPrimitive::GetId() {
    wxLogTrace(className, wxT("Entering GetId"));
    wxLogTrace(className, wxT("Exiting GetId"));
}

// This is one of THE MOST IMPORTANT methods with regard to object base/aliasing.
// It takes a DrawPrimitive and makes it "unique", that is, it will become a base
// object with NO aliases.  The purpose of this routine is to prepare an object for
// some sort of modification that would make it fundamentally different from any
// of its duplicates (e.g. stretching, moving a node, changing a color, etc.).
// Only translating (moving) an object should do so without calling this first.
void DrawPrimitive::SplitOff() {
    wxLogTrace(className, wxT("Entering SplitOff"));
	int i;
	DrawPrimitive* g;
	arRealRect e;

	// If this object is already unique, we don't have to do anything
	if ((Base != NULL) or (Copies.getCount() > 0)) {
		// Is it already a base, or is it an alias?
		if (Base != NULL) {
			// This object is an alias.  First let's perform a FULL copy of its base
			// (which means also get anything dynamically allocated, e.g. CoordPoint
			// arrays, fonts, child objects, etc.)
			CopyFromBase(false); // AliasOnly is False, copy EVERYTHING

			// We will no longer be an alias
			Base->Copies.Delete(Base->Copies.IndexOfObject(this));

			// We are going to become a base in our own right
			Base = NULL;
		} else {
			// We are a base object.  The first of our aliases will become the new
			// base for the rest of our aliases.
			g = static_cast<DrawPrimitive*>(Copies.objects[0]);
			
			// All dynamically allocated information already exists, so simply copy the
			// static stuff into the first of our aliases and have it simply point to
			// the dynamic stuff (we'll make our own copy later).
			g->CopyFromBase(true);
			
			// Switch the base object slot to point to the alias and make it the new base
			static_cast<MapCollection*>(MapC)->BasePrimitives.objects[static_cast<MapCollection*>(MapC)->BasePrimitives.IndexOfObject(this)] = g;
			g->Base = NULL;
			
			// The rest of our aliases need to become aliases for the new base
			g->Copies.Clear();
			
			// Since the new base sits at a different location, it has to move.  However,
			// we also need to allocate a new dynamic copy for this object so we will
			// temporarily make the new base object our base so our dynamic copy will be at
			// the right position.
			Base    = g;
			e       = fExtent;
			Alias.x = e.GetLeft();
			Alias.y = e.GetTop();
			g->Move(g->Alias.x - e.GetLeft(),g->Alias.y - e.GetTop());
			CopyFromBase(false); // FULL copy
			
			// Relocate the other aliases to the new base
			for (i=1; i<Copies.getCount(); i++) {
				g->Copies.AddObject(wxT(""),Copies.objects[i]);
				static_cast<DrawPrimitive*>(Copies.objects[i])->Base = g;
			}
			
			// No more base or copies for us; we are to be unique
			Copies.Clear();
			Base = NULL;
			
			// Just for kicks
			g->Alias.x = g->fExtent.GetLeft();
			g->Alias.y = g->fExtent.GetTop();
		}
	}
	
    // It doesn't hurt to set these coordinates (and perhaps it might be useful
    // to make setting them standard in the future)
    // (See DrawPrimitive.ReadBaseFromDOMElement() for important note)
	
	Alias.x = fExtent.GetLeft();
	Alias.y = fExtent.GetTop();

    // Add the new unique object to the base object list
	
	InsertIntoBaseList();
    wxLogTrace(className, wxT("Exiting SplitOff"));
}

bool DrawPrimitive::IsSimilarTo(const DrawPrimitive& d) {
    wxLogTrace(className, wxT("Entering IsSimilarTo"));
    wxLogTrace(className, wxT("Exiting IsSimilarTo"));
	return(fColor == d.fColor);
}


DrawPrimitive DrawPrimitive::ReadChain(wxFileInputStream& ins, int version, bool selected, bool Full, bool UseAliasInfo, wxObject M) {
    wxLogTrace(className, wxT("Entering ReadChain"));
    wxLogTrace(className, wxT("Exiting ReadChain"));
}

void DrawPrimitive::DoRead(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo) {
    wxLogTrace(className, wxT("Entering DoRead"));
    wxLogTrace(className, wxT("Exiting DoRead"));
}

void DrawPrimitive::Read(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo) {
    wxLogTrace(className, wxT("Entering Read"));
    wxLogTrace(className, wxT("Exiting Read"));
}


DrawPrimitive DrawPrimitive::ReadChainFromDOMElement(wxXmlNode E, int version, bool selected, wxObject M) {
    wxLogTrace(className, wxT("Entering ReadChainFromDOMElement"));
    wxLogTrace(className, wxT("Exiting ReadChainFromDOMElement"));
}

wxXmlNode DrawPrimitive::GetChainAsDOMElement(wxXmlDocument D, bool all, bool undo) {
    wxLogTrace(className, wxT("Entering GetChainAsDOMElement"));
    wxLogTrace(className, wxT("Exiting GetChainAsDOMElement"));
}

bool DrawPrimitive::ReadBaseFromDOMElement(wxXmlNode E) {
    wxLogTrace(className, wxT("Entering ReadBaseFromDOMElement"));
    wxLogTrace(className, wxT("Exiting ReadBaseFromDOMElement"));
}

bool DrawPrimitive::GetAsAliasDOMElement(wxXmlDocument D, wxXmlNode E) {
    wxLogTrace(className, wxT("Entering GetAsAliasDOMElement"));
    wxLogTrace(className, wxT("Exiting GetAsAliasDOMElement"));
}

void DrawPrimitive::ReadFromDOMElement(wxXmlNode E, int version) {
    wxLogTrace(className, wxT("Entering ReadFromDOMElement"));
    wxLogTrace(className, wxT("Exiting ReadFromDOMElement"));
}

wxXmlNode DrawPrimitive::GetAsDOMElement(wxXmlDocument D, bool undo) {
    wxLogTrace(className, wxT("Entering GetAsDOMElement"));
    wxLogTrace(className, wxT("Exiting GetAsDOMElement"));
}

bool CombineObjects_Realloc_Match(int n1, int n2, VPoints newpoints, int& newcount, VPoints first, int s1, VPoints second, int s2, DrawPrimitive o1, DrawPrimitive o2) {
	int c1x, c1y, c2x, c2y;
	extern MapCollection* mapcollection;
	wxLogTrace(className, wxT("Entering CombineObjects_Realloc_Match"));
	mapcollection->CurrentView.CoordToScreen(first[n1].x, first[n1].y, c1x, c1y);
	mapcollection->CurrentView.CoordToScreen(first[n2].x, first[n2].y, c2x, c2y);
	return((abs(c1x-c2x) <= 1) and (abs(c1y-c2y) <= 1));
	wxLogTrace(className, wxT("Exiting CombineObjects_Realloc_Match"));
}

void CombineObjects_Realloc(VPoints& newpoints, int& newcount, VPoints first, int s1, VPoints second, int s2, DrawPrimitive o1, DrawPrimitive o2) {
	int i, n;
	bool upone, uptwo;
	wxLogTrace(className, wxT("Entering CombineObjects_Realloc"));
	newcount = s1+s2-1;
	newpoints.resize(newcount);
	// Based on the matching endpoints, copy stuff into the new array
	if (CombineObjects_Realloc_Match(0,0, newpoints, newcount, first, s1, second, s2, o1, o2)) {
		upone = true;
		uptwo = false;
	} else if (CombineObjects_Realloc_Match(0,s2-1, newpoints, newcount, first, s1, second, s2, o1, o2)) {
		upone = true;
		uptwo = true;
	} else if (CombineObjects_Realloc_Match(s1-1,0, newpoints, newcount, first, s1, second, s2, o1, o2)) {
		upone = false;
		uptwo = false;
	} else if (CombineObjects_Realloc_Match(s1-1,s2-1, newpoints, newcount, first, s1, second, s2, o1, o2)) {
		upone = false;
		uptwo = true;
	} else {
		throw std::runtime_error(wxToStd(res_primitives_combine1));
	}

	n=0;
	if (upone) {
		for (i=s1-1; i>=0; i--) {
			newpoints[n++] = first[i];
		}
	} else {
		for (i=0; i<s1-1; i++) {
			newpoints[n++] = first[i];
		}
	}

	if (uptwo) {
		for (i=s2-2; i>=0; i--) {
			newpoints[n++] = second[i];
		}
	} else {
		for (i=1; i<s2-1; i++) {
			newpoints[n++] = second[i];
		}
	}
	
	wxLogTrace(className, wxT("Exiting CombineObjects_Realloc"));
}

DrawPrimitive* CombineObjects(DrawPrimitive o1, DrawPrimitive o2) {
	wxLogTrace(className, wxT("Entering CombineObjects"));
	PolyLinePrimitive *PLP, *PLP1, *PLP2;
	PolyCurvePrimitive *PCP, *PCP1, *PCP2;
	DrawPrimitive* Result;

	wxASSERT(o1.GetId() == o2.GetId());
	Result = o1.Copy();
	wxASSERT(Result != NULL);
	Result->SplitOff();

	///@todo This section might be buggy. After all, we don't know what will happen with the ComputeExtent call, not really. Verify it works.
	if ((o1.GetId() == wxT("P")) or (o1.GetId() == wxT("p"))) {
		PLP = static_cast<PolyLinePrimitive*>(Result);
		PLP1 = static_cast<PolyLinePrimitive*>(&o1);
		PLP2 = static_cast<PolyLinePrimitive*>(&o1);
		CombineObjects_Realloc(PLP->points, PLP->count, PLP1->points, PLP1->count, PLP2->points, PLP2->count, o1, o2);
	} else if ((o1.GetId() == wxT("K")) or (o1.GetId() == wxT("k"))) {
		PCP = static_cast<PolyCurvePrimitive*>(Result);
		PCP1 = static_cast<PolyCurvePrimitive*>(&o1);
		PCP2 = static_cast<PolyCurvePrimitive*>(&o1);
		CombineObjects_Realloc(PCP->points, PCP->count, PCP1->points, PCP1->count, PCP2->points, PCP2->count, o1, o2);
	} else {
		throw std::runtime_error(wxToStd(res_primitives_combine2));
	}

	Result->ComputeExtent();
	wxLogTrace(className, wxT("Exiting CombineObjects"));
	return(Result);
}

DrawPrimitive* ConvertObject_DoubleDecompose(DrawPrimitive obj, wxString newtype) {
	wxLogTrace(className, wxT("Entering ConvertObject_DoubleDecompose"));
	DrawPrimitive *objchain, *nextobjchain, polyobj, *newpolyobj, newpolyobj2;
	DrawPrimitive Result, *retval;
	
	obj.Decompose(static_cast<MapCollection*>(obj.MapC)->CurrentView, *objchain);
	objchain->Decompose(static_cast<MapCollection*>(obj.MapC)->CurrentView, Result);
	nextobjchain = objchain->Next;
	delete objchain;
	objchain = nextobjchain;

	while (objchain != NULL) {
		objchain->Decompose(static_cast<MapCollection*>(obj.MapC)->CurrentView, polyobj);
		newpolyobj = CombineObjects(Result, polyobj);
		///@todo Result.Destroy;
		///@todo polyobj.Destroy;
		Result = *newpolyobj;

		nextobjchain = objchain->Next;
		delete objchain;
		objchain = nextobjchain;
	}
	retval = new DrawPrimitive();
	*retval = Result;
	return(retval);
	wxLogTrace(className, wxT("Exiting ConvertObject_DoubleDecompose"));
}

DrawPrimitive* ConvertObject(DrawPrimitive obj, wxString newtype) {
	VPoints pcoord;
	LinePrimitive *line, *frac;
	CurvePrimitive *curve, *fraccurve;
	PolyLinePrimitive *PolyLine;
	int i;
	DrawPrimitive *result = new DrawPrimitive;

	if (obj.GetId() == wxT("L")) { // Line Primitive
		line = static_cast<LinePrimitive*>(&obj);
		if (newtype == wxT("P")) {
			pcoord.resize(2);
			pcoord[0].x = line->x1;
			pcoord[0].y = line->y1;
			pcoord[1].x = line->x2;
			pcoord[1].y = line->y2;
			delete result;
			result = new PolyLinePrimitive(pcoord, 2, line->style);
			result->CopyCore(obj);
		} else if (newtype == wxT("K")) {
			pcoord.resize(4);
			pcoord[0].x = line->x1;
			pcoord[0].y = line->y1;
			pcoord[3].x = line->x2;
			pcoord[3].y = line->y2;
			pcoord[1] = pcoord[0];
			pcoord[2] = pcoord[3];
			delete result;
			result = new PolyCurvePrimitive(pcoord, 4, line->style);
			result->CopyCore(obj);
		} else {
			throw std::runtime_error(wxToStd(res_primitives_convert));
		}
	} else if (obj.GetId() == wxT("l")) { // Fractal Line Primitive
		frac = static_cast<LinePrimitive*>(&obj);
		if (newtype == wxT("P")) {
			frac->Decompose(static_cast<MapCollection*>(obj.MapC)->CurrentView, *result);
		} else if (newtype == wxT("p")) {
			pcoord.resize(2);
			pcoord[0].x = frac->x1;
			pcoord[0].y = frac->y1;
			pcoord[1].x = frac->x2;
			pcoord[1].y = frac->y2;
			delete result;
			result = new PolyLinePrimitive(pcoord, 2, frac->seed, frac->roughness, frac->style);
			result->CopyCore(obj);
		} else {
			throw std::runtime_error(wxToStd(res_primitives_convert));
		}
	} else if (obj.GetId() == wxT("P")) { // PolyLine Primitive
		PolyLine = static_cast<PolyLinePrimitive*>(&obj);
		if (newtype == wxT("P")) {
			delete result;
			result = new PolyLinePrimitive;
			result->CopyCore(obj);
		} else if (newtype == wxT("K")) {
			pcoord.resize((PolyLine->count) * 3 - 2);
			for (i=0; i<PolyLine->count-1; i++) {
				pcoord[i*3].x = PolyLine->points[i].x;
				pcoord[i*3].y = PolyLine->points[i].y;
				if (i>0) { pcoord[i*3-1] = pcoord[i*3]; }
				if (i<PolyLine->count-1) { pcoord[i*3+1] = pcoord[i*3]; }
			}
			delete result;
			result = new PolyCurvePrimitive(pcoord, PolyLine->count*3-2, PolyLine->style);
			result->CopyCore(obj);
		} else {
			throw std::runtime_error(wxToStd(res_primitives_convert));
		}
	} else if (obj.GetId() == wxT("p")) { // Fractal PolyLine Primitive
		if (newtype == wxT("P")) {
			result = ConvertObject_DoubleDecompose(obj, newtype);
		} else if (newtype == wxT("p")) {
			result = obj.Copy();
		} else {
			throw std::runtime_error(wxToStd(res_primitives_convert));
		}
	} else if (obj.GetId() == wxT("C")) { // Curve Primitive
		curve = static_cast<CurvePrimitive*>(&obj);
		if (newtype == wxT("P")) {
			curve->Decompose(static_cast<MapCollection*>(obj.MapC)->CurrentView, *result);
		} else if (newtype == wxT("K")) {
			pcoord.resize(4);
			pcoord[0] = curve->p1;
			pcoord[1] = curve->p2;
			pcoord[2] = curve->p3;
			pcoord[3] = curve->p4;
			delete result;
			result = new PolyCurvePrimitive(pcoord, 4, curve->style);
			result->CopyCore(obj);
		} else {
			throw std::runtime_error(wxToStd(res_primitives_convert));
		}
	} else if (obj.GetId() == wxT("c")) { // Fractal Curve Primitive
		fraccurve = static_cast<CurvePrimitive*>(&obj);
		if (newtype == wxT("P")) {
			fraccurve->Decompose(static_cast<MapCollection*>(obj.MapC)->CurrentView, *result);
		} else if (newtype == wxT("K")) {
			pcoord.resize(4);
			pcoord[0] = curve->p1;
			pcoord[1] = curve->p2;
			pcoord[2] = curve->p3;
			pcoord[3] = curve->p4;
			delete result;
			result = new PolyCurvePrimitive(pcoord, 4, fraccurve->seed, fraccurve->roughness, fraccurve->style);
			result->CopyCore(obj);
		} else {
			throw std::runtime_error(wxToStd(res_primitives_convert));
		}
	} else if (obj.GetId() == wxT("K")) { // PolyCurve Primitive
		if (newtype == wxT("P")) {
			result = ConvertObject_DoubleDecompose(obj, newtype);
		} else if (newtype == wxT("K")) {
			result = obj.Copy();
		} else {
			throw std::runtime_error(wxToStd(res_primitives_convert));
		}
	} else if (obj.GetId() == wxT("k")) { // Fractal PolyCurve Primitive
		if (newtype == wxT("P")) {
			result = ConvertObject_DoubleDecompose(obj, newtype);
		} else if (newtype == wxT("K")) {
			result = obj.Copy();
		} else {
			throw std::runtime_error(wxToStd(res_primitives_convert));
		}
	} else {
		throw std::runtime_error(wxToStd(res_primitives_convert));
	}
	return(result);
}
