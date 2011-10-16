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

#include "ViewPoint.h"
#include "base64.h"
#include "generic_library.h"
#include "xmlutils.h"

#include <wx/tokenzr.h>

static wxString className=wxT("ViewPoint");

static const int MAX_OVERLAYS=256;

ViewPoint::ViewPoint() {
    wxLogTrace(className, wxT("ViewPoint(): Entering"));
    Name=wxString(wxT(""));
    wxLogTrace(className, wxT("ViewPoint: clearing overlays"));
    VisibleOverlays.clear();
    ActiveOverlays.clear();
    for (int i=0; i<MAX_OVERLAYS; i++) {
        VisibleOverlays.insert(i);
        ActiveOverlays.insert(i);
    }
    canvas=NULL;
    QuickDraw=QuickDraw_None;
    OffScreenFullDetail=false;
    wxLogTrace(className, wxT("ViewPoint(): Exiting"));
}

ViewPoint::ViewPoint(arRealRect rect, int cw, int ch) {
    wxLogTrace(className, wxT("ViewPoint(arRealRect,int,int): Entering"));
	ClientWidth = cw;
	ClientHeight = ch;
	Area = rect;
	Name = wxString(wxT(""));
    wxLogTrace(className, wxT("ViewPoint: clearing overlays"));
	VisibleOverlays.clear();
	ActiveOverlays.clear();
	canvas = NULL;
	QuickDraw=QuickDraw_None;
    wxLogTrace(className, wxT("ViewPoint(arRealRect,int,int): Exiting"));
}

ViewPoint::ViewPoint(arRealRect rect, int cw, int ch, GridObject oldgrid) {
    wxLogTrace(className, wxT("ViewPoint(arRealRect,int,int,GridObject): Entering"));
	ClientWidth = cw;
	ClientHeight = ch;
	Area = rect;
	Name = wxString(wxT(""));
    wxLogTrace(className, wxT("ViewPoint: clearing overlays"));
	VisibleOverlays.clear();
	ActiveOverlays.clear();
	canvas = NULL;
	QuickDraw=QuickDraw_None;
	grid=oldgrid;
    wxLogTrace(className, wxT("ViewPoint(arRealRect,int,int,GridObject): Exiting"));
}

ViewPoint::ViewPoint(ViewPoint& view, bool useprinter) {
    wxLogTrace(className, wxT("ViewPoint(ViewPoint,bool): Entering"));
	Name = view.Name;

	if (useprinter) {
		///@todo handle use printer = true
     	//Area:=AdjustToPrinterPage(view.Area);
     	//ClientWidth:=Printer.PageWidth;
     	//ClientHeight:=Printer.PageHeight;
     	//Canvas := Printer.Canvas;
	} else {
		Area = view.Area;
		ClientWidth = view.ClientWidth;
		ClientHeight = view.ClientHeight;
		canvas = view.canvas;
	}

	VisibleOverlays = view.VisibleOverlays;
	ActiveOverlays = view.ActiveOverlays;
	SetCoordinateSize(ClientWidth, ClientHeight, false);
	grid = view.grid;
	QuickDraw = QuickDraw_None;
    wxLogTrace(className, wxT("ViewPoint(ViewPoint,bool): Exiting"));
}

void ViewPoint::CoordToScreen(coord cx, coord cy, coord& sx, coord& sy) {
    wxLogTrace(className, wxT("Entering CoordToScreen"));
    wxASSERT((Area.GetRight()-Area.GetLeft()) != 0);
    wxASSERT((Area.GetBottom()-Area.GetTop()) != 0);
	sx = ((cx - Area.GetLeft())/(Area.GetRight()-Area.GetLeft())) * ClientWidth;
	sy = ((cy - Area.GetTop()) /(Area.GetBottom()-Area.GetTop())) * ClientHeight;
    wxLogTrace(className, wxT("Exiting CoordToScreen"));
}

void ViewPoint::CoordToScreen(coord cx, coord cy, int& sx, int& sy) {
    wxLogTrace(className, wxT("Entering CoordToScreen"));
	int tempx, tempy;
	coord fsx, fsy;
    CoordToScreen(cx, cy, fsx, fsy);

	tempx = (int)fsx;
	tempy = (int)fsy;

	if (tempx > 32767) {
		sx = 32767;
	} else if (tempx < -32768) {
		sx = -32768;
	} else { sx = tempx; }

	if (tempy > 32767) {
		sy = 32767;
	} else if (tempy < -32768) {
		sy = -32768;
	} else { sy = tempy; }
    wxLogTrace(className, wxT("Exiting CoordToScreen"));
}

void ViewPoint::ScreenToCoord(coord sx, coord sy, coord& cx, coord& cy) {
    wxLogTrace(className, wxT("Entering ScreenToCoord"));
    wxASSERT(ClientWidth != 0);
    wxASSERT(ClientHeight != 0);
    cx = Area.GetLeft() + (sx/ClientWidth)  * (Area.GetRight() - Area.GetLeft());
    cy = Area.GetTop()  + (sy/ClientHeight) * (Area.GetBottom() - Area.GetTop());
    wxLogTrace(className, wxT("Exiting ScreenToCoord"));
}

void ViewPoint::ScreenToCoord(int sx, int sy, coord& cx, coord& cy) {
    wxLogTrace(className, wxT("Entering ScreenToCoord"));
    ScreenToCoord((coord)sx, (coord)sy, cx, cy);
    wxLogTrace(className, wxT("Exiting ScreenToCoord"));
}

void ViewPoint::DeltaScreenToCoord(int dx, int dy, coord& cx, coord& cy) {
    wxLogTrace(className, wxT("Entering DeltaScreenToCoord"));
    wxASSERT(ClientWidth != 0);
    wxASSERT(ClientHeight != 0);
    cx = (dx/ClientWidth)*(Area.GetRight()-Area.GetLeft());
    cy = (dy/ClientHeight)*(Area.GetBottom()-Area.GetTop());
    wxLogTrace(className, wxT("Exiting DeltaScreenToCoord"));
}

void ViewPoint::DeltaScreenToCoord(coord dx, coord dy, coord& cx, coord& cy) {
    wxLogTrace(className, wxT("Entering DeltaScreenToCoord"));
    wxASSERT(ClientWidth != 0);
    wxASSERT(ClientHeight != 0);
    cx = (dx/ClientWidth)*(Area.GetRight()-Area.GetLeft());
    cy = (dy/ClientHeight)*(Area.GetBottom()-Area.GetTop());
    wxLogTrace(className, wxT("Exiting DeltaScreenToCoord"));
}

void ViewPoint::DeltaCoordToScreen(coord cx, coord cy, int& dx, int& dy) {
    wxLogTrace(className, wxT("Entering DeltaCoordToScreen"));
    wxASSERT((Area.GetRight()-Area.GetLeft()) != 0);
    wxASSERT((Area.GetBottom()-Area.GetTop()) != 0);
    dx = (int)((cx/(Area.GetRight()-Area.GetLeft()))*ClientWidth);
    dy = (int)((cy/(Area.GetBottom()-Area.GetTop()))*ClientHeight);
    wxLogTrace(className, wxT("Exiting DeltaCoordToScreen"));
}

void ViewPoint::DeltaCoordToScreen(coord cx, coord cy, coord& dx, coord& dy) {
    wxLogTrace(className, wxT("Entering DeltaCoordToScreen"));
    wxASSERT((Area.GetRight()-Area.GetLeft()) != 0);
    wxASSERT((Area.GetBottom()-Area.GetTop()) != 0);
    dx = (cx/(Area.GetRight()-Area.GetLeft()))*ClientWidth;
    dy = (cy/(Area.GetBottom()-Area.GetTop()))*ClientHeight;
    wxLogTrace(className, wxT("Exiting DeltaCoordToScreen"));
}

wxPoint ViewPoint::CoordToScreenPt(arRealPoint p) {
    wxLogTrace(className, wxT("Entering CoordToScreenPt"));
    int x, y;
    CoordToScreen(p.x, p.y, x, y);
    wxLogTrace(className, wxT("Exiting CoordToScreenPt"));
    return(wxPoint(x, y));
}

void ViewPoint::ScreenToCoordPtArray(VPoints p, int count) {
    wxLogTrace(className, wxT("Entering ScreenToCoordPtArray"));
    coord x, y;
    for (int i=0; i<count; i++) {
        wxLogTrace(className, wxT("ScreenToCoorPtArray: Converting item %d: x=%f, y=%f"), i, p[i].x, p[i].y);
        ScreenToCoord(p[i].x, p[i].y, x, y);
        p[i].x = x;
        p[i].y = y;
        wxLogTrace(className, wxT("ScreenToCoorPtArray: Converted item %d: x=%f, y=%f"), i, p[i].x, p[i].y);
    }
    wxLogTrace(className, wxT("Exiting ScreenToCoordPtArray"));
}

void ViewPoint::Zoom(arRealPoint center, float factor, double px, double py) {
    wxLogTrace(className, wxT("Entering Zoom"));
    coord w, h;
    arRealRect ScreenCoord;

    GetCoordinateRect(ScreenCoord);
    wxLogTrace(className, wxT("Zoom: ScreenCoord: %d, %d, %d, %d"),
            ScreenCoord.GetLeft(), ScreenCoord.GetTop(),
            ScreenCoord.GetRight(), ScreenCoord.GetBottom());
    w = ScreenCoord.GetRight() - ScreenCoord.GetLeft();
    h = ScreenCoord.GetBottom() - ScreenCoord.GetTop();

    w *= factor;
    h *= factor;

    wxLogTrace(className, wxT("Zoom: center(%d, %d), w(%f), h(%f), factor(%f), px(%f), py(%f)"),
            center.x, center.y, w, h, factor, px, py);

    ScreenCoord.SetLeft(center.x - w*px);
    ScreenCoord.SetRight(center.x + w*(1-px));
    ScreenCoord.SetTop(center.y - h*py);
    ScreenCoord.SetBottom(center.y + h*(1-py));

    wxLogTrace(className, wxT("Zoom: ScreenCoord: %d, %d, %d, %d"),
            ScreenCoord.GetLeft(), ScreenCoord.GetTop(),
            ScreenCoord.GetRight(), ScreenCoord.GetBottom());

    SetCoordinateRect(ScreenCoord);
    wxLogTrace(className, wxT("Exiting Zoom"));
}

void ViewPoint::SetZoomPercent(double percent) {
    wxLogTrace(className, wxT("Entering SetZoomPercent"));
    arRealRect cr;
    arRealPoint center;
    int width, height;

    // A Zoom level of 100% has a one-to-one relationship between pixels
    // and coordinates. Center the zoom region on the current screen center.
    GetCoordinateRect(cr);
    wxLogTrace(className, wxT("SetZoomPercent: cr: %f, %f, %f, %f"),
            cr.GetLeft(), cr.GetTop(), cr.GetRight(), cr.GetBottom());
    center.x = (cr.GetRight() + cr.GetLeft()) / 2;
    center.y = (cr.GetBottom() + cr.GetTop()) / 2;
    GetCoordinateSize(width, height);

    // More useful to use a real scalar instead of percent.
    // The amount we scale is also reciprocal to the percentage (i.e.
    // bigger percents are larger zooms, which are correspondingly smaller
    // coordinate sizes).
    wxASSERT(percent != 0.0);
    percent = 1.0 / (percent * 0.01);

    wxLogTrace(className, wxT("SetZoomPercent: center(%f,%f), width(%d), height(%d), percent(%f)"),
            center.x, center.y, width, height, percent);
    cr.SetLeft(center.x - width*percent*0.5);
    cr.SetRight(center.x + width*percent*0.5);
    cr.SetTop(center.y - height*percent*0.5);
    cr.SetBottom(center.y + height*percent*0.5);

    wxLogTrace(className, wxT("SetZoomPercent: cr: %f, %f, %f, %f"),
            cr.GetLeft(), cr.GetTop(), cr.GetRight(), cr.GetBottom());
    SetCoordinateRect(cr);
    wxLogTrace(className, wxT("Exiting SetZoomPercent"));
}

int ViewPoint::GetZoomPercent() {
    wxLogTrace(className, wxT("Entering GetZoomPercent"));
    coord cx, cy;
    float zoom;
    int z;

    // Figure out our zoom by looking at how big a single pixel is
    DeltaScreenToCoord(1,1,cx,cy);

    wxASSERT(cx != 0.0);
    zoom = 100.0/cx;        // 100.0 * Reciprocal = percentage
    z = (int)round(zoom,0);   // Round off to not show fractional percentages

    wxLogTrace(className, wxT("GetZoomPercent: zoom(%f), z(%d)"), zoom, z);
    // Don't allow our displayed zoom to drop below 1% to 0%
    z = z<1 ? 1 : z;
    wxLogTrace(className, wxT("GetZoomPercent: zoom(%f), z(%d)"), zoom, z);
    wxLogTrace(className, wxT("Exiting GetZoomPercent"));
    return(z);
}

wxRect ViewPoint::CoordToScreenRect(arRealRect cr) {
    wxLogTrace(className, wxT("Entering CoordToScreenRect"));
    wxLogTrace(className, wxT("CoordToScreenRect: cr: %f, %f, %f, %f"),
            cr.GetLeft(), cr.GetTop(), cr.GetRight(), cr.GetBottom());
    int left, right, top, bottom;
    CoordToScreen(cr.GetLeft(), cr.GetTop(), left, top);
    CoordToScreen(cr.GetRight(), cr.GetBottom(), right, bottom);
    wxLogTrace(className, wxT("Exiting CoordToScreenRect"));
    return(wxRect(left, top, right-left, bottom-top));
}

arRealRect ViewPoint::ScreenToCoordRect(arRealRect cr) {
    wxLogTrace(className, wxT("Entering ScreenToCoordRect"));
    wxLogTrace(className, wxT("ScreenToCoordRect: cr: %f, %f, %f, %f"),
            cr.GetLeft(), cr.GetTop(), cr.GetRight(), cr.GetBottom());
    coord left, right, top, bottom;
    ScreenToCoord(cr.GetLeft(), cr.GetTop(), left, top);
    ScreenToCoord(cr.GetRight(), cr.GetBottom(), right, bottom);
    wxLogTrace(className, wxT("Exiting ScreenToCoordRect"));
    return(arRealRect(left, top, right-left, bottom-top));
}

arRealRect ViewPoint::ScreenToCoordRect(wxRect cr) {
    wxLogTrace(className, wxT("Entering ScreenToCoordRect"));
    wxLogTrace(className, wxT("ScreenToCoordRect: cr: %f, %f, %f, %f"),
            cr.GetLeft(), cr.GetTop(), cr.GetRight(), cr.GetBottom());
    coord left, right, top, bottom;
    ScreenToCoord(cr.GetLeft(), cr.GetTop(), left, top);
    ScreenToCoord(cr.GetRight(), cr.GetBottom(), right, bottom);
    wxLogTrace(className, wxT("Exiting ScreenToCoordRect"));
    return(arRealRect(left, top, right-left, bottom-top));
}

void ViewPoint::SetCoordinateSize(int width, int height, bool rescale) {
    wxLogTrace(className, wxT("Entering SetCoordinateSize"));
    arRealRect r;
    if ((ClientWidth != 0) && (ClientHeight != 0) && rescale) {
        wxASSERT(ClientHeight != 0);
        wxASSERT(ClientWidth != 0);
        Area.SetBottom(Area.GetBottom() * height / ClientHeight);
        Area.SetRight(Area.GetRight() * width / ClientWidth);
    }

    if ((width != ClientWidth) || (height != ClientHeight)) {
        ClientWidth = width;
        ClientHeight = height;

        ///@todo What the hell? This bit of code confuses/concerns me.
        ///Am I really just adding a line which fills an object, and
        ///then resets values to the exact same as they were before?
        GetCoordinateRect(r);
        SetCoordinateRect(r);
    }
    wxLogTrace(className, wxT("Exiting SetCoordinateSize"));
}

void ViewPoint::GetCoordinateSize(int &width, int& height) {
    wxLogTrace(className, wxT("Entering GetCoordinateSize"));
    width = ClientWidth;
    height = ClientHeight;
    wxLogTrace(className, wxT("Exiting GetCoordinateSize"));
}

void ViewPoint::SetCoordinateRect(arRealRect cr) {
    wxLogTrace(className, wxT("Entering SetCoordinateRect"));
    coord width, height, screen, pix, adjust;
    //If they zoom too close, refuse to do anything
    if ((abs((int)((cr.GetBottom() - cr.GetTop())*100)) <= 1) ||
            (abs((int)((cr.GetRight() - cr.GetLeft())*100)) <= 1)) {
        // If the existing area is "null", fix it up so we don't create
        // div by 0 errors.  Otherwise, leave the area alone if we got here
        // by repeated zoom-in commands.
        if ((Area.GetRight() - Area.GetLeft() == 0.00) ||
                (Area.GetBottom() - Area.GetTop() == 0.00)) {
            Area.SetLeft(0);
            Area.SetRight(1);   // Set a coordinate space of (0,0)-(1,1)
            Area.SetTop(0);     // Preventative measure for invalid
            Area.SetBottom(1);  // operations on zero width/height viewpoints.
        }
    } else {
        Area = cr;
        width = cr.GetRight() - cr.GetLeft();
        height = cr.GetBottom() - cr.GetTop();

        wxASSERT(height != 0);
        wxASSERT(ClientHeight != 0);
        screen = width/height;
        pix = ClientWidth/ClientHeight;
        if (round(screen,6) != round(pix,6)) {
            if (screen<pix) { //Coordinate Width < Screen Width
                adjust = 0.5*width*pix*screen;
                Area.SetLeft((cr.GetLeft()+cr.GetRight())/2 - adjust);
                Area.SetRight((cr.GetLeft()+cr.GetRight())/2 + adjust);
            } else { //Coordinate Height <= Screen Height
                adjust = 0.5*height*screen/pix;
                Area.SetTop((cr.GetTop()+cr.GetBottom())/2 - adjust);
                Area.SetBottom((cr.GetTop()+cr.GetBottom())/2 + adjust);
            }
        }
    }
    wxLogTrace(className, wxT("Exiting SetCoordinateRect"));
}

void ViewPoint::GetCoordinateRect(arRealRect& cr) {
    wxLogTrace(className, wxT("Entering GetCoordinateRect"));
    cr = Area;
    wxLogTrace(className, wxT("Exiting GetCoordinateRect"));
}

StyleAttrib ViewPoint::FixStyle(StyleAttrib st) {
    wxLogTrace(className, wxT("Entering FixStyle"));
    StyleAttrib result;

    result=st;
    ///@todo the following if statement requires that IsAComplexLine and
    ///GetLineThickness be defined, which they are not. Must wait until
    //they are before proceeding
    //if ((QuickDraw && QuickDraw_Lines) && ((GetLineThickness(st)>1) || IsAComplexLine(st))) {
        //result.Line = 1;
    //}
    wxLogTrace(className, wxT("Exiting FixStyle"));
    return(result);
}

void ViewPoint::LoadFromStream(wxFileInputStream& ins) {
    wxInt8 Active[32], Visible[32];
    float top, left, bottom, right;
    int i, j, k;

    Name = ReadStringFromBinaryStream(ins);
    ClientWidth = ReadIntFromBinaryStream(ins);
    ClientHeight = ReadIntFromBinaryStream(ins);
    Area.SetTop(ReadFloatFromBinaryStream(ins));
    Area.SetLeft(ReadFloatFromBinaryStream(ins));
    Area.SetBottom(ReadFloatFromBinaryStream(ins));
    Area.SetRight(ReadFloatFromBinaryStream(ins));
    ins.Read(Visible, 32); // 32 bytes is the size of a set under Delphi
    ins.Read(Active, 32);  // on Intel x86
    for (i=0; i<256; i++) {
        j = i / 8;
        k = 1 << (i % 8);
        if (Active[j] & k) {
            ActiveOverlays.insert(i);
        }
        if (Visible[j] & k) {
            VisibleOverlays.insert(i);
        }
    }
    grid.LoadFromStream(ins, 0);
}

void ViewPoint::LoadFromDOMElement(wxXmlNode E) {
    wxString s, st;
    long i;
    wxStringTokenizer tok;
    wxXmlNode* e1;

    Name = base64decode(getElContents(findNamedChild(wxT("NAME"), E)));
    ClientWidth = getElContenti(findNamedChild(wxT("CLIENTWIDTH"), E));
    ClientHeight = getElContenti(findNamedChild(wxT("CLIENTHEIGHT"), E));
    Area = getElContentr(findNamedChild(wxT("AREA"), E));
    s = getElContents(findNamedChild(wxT("VISIBLE_OVERLAYS"), E));
    VisibleOverlays.clear();
    tok.SetString(s, wxT(","));
    while (tok.HasMoreTokens()) {
        st = tok.GetNextToken();
        st.ToLong(&i);
        if ((i >= 0) && (i < MAX_OVERLAYS)) {
            VisibleOverlays.insert(i);
        }
    }
    s = getElContents(findNamedChild(wxT("ACTIVE_OVERLAYS"), E));
    ActiveOverlays.clear();
    tok.SetString(s, wxT(","));
    while (tok.HasMoreTokens()) {
        st = tok.GetNextToken();
        st.ToLong(&i);
        if ((i >= 0) && (i < MAX_OVERLAYS)) {
            ActiveOverlays.insert(i);
        }
    }

    e1 = findNamedChild(wxT("GRIDOBJECT"), E);
    if (e1 != NULL) {
        grid.LoadFromDOMElement(*e1);
    }
}

wxXmlNode ViewPoint::GetAsDOMElement(wxXmlDocument& D) {
    wxXmlNode E(wxXML_ELEMENT_NODE, wxT("VIEWPOINT"));
    wxXmlNode g;
    int i;
    wxString s,t,u;

    E.AddChild(newElWithChild(wxT("NAME"), base64encode(Name)));
    s.Printf(wxT("%d"), ClientWidth);
    E.AddChild(newElWithChild(wxT("CLIENTWIDTH"), s));
    s.Printf(wxT("%d"), ClientHeight);
    E.AddChild(newElWithChild(wxT("CLIENTHEIGHT"), s));
    s.Printf(wxT("%f,%f,%f,%f"), Area.GetLeft(), Area.GetTop(), Area.GetRight(), Area.GetBottom());
    E.AddChild(newElWithChild(wxT("AREA"), s));

    s = wxT("");
    t = wxT("");
    for (i=0; i<MAX_OVERLAYS; i++) {
        if (ActiveOverlays.find(i) != ActiveOverlays.end()) {
            u.Printf(wxT("%d"), i);
            if (t != wxT("")) {
                t += wxT(",");
            }
            t += u;
        }
        if (VisibleOverlays.find(i) != VisibleOverlays.end()) {
            u.Printf(wxT("%d"), i);
            if (s != wxT("")) {
                s += wxT(",");
            }
            s += u;
        }
    }
    E.AddChild(newElWithChild(wxT("VISIBLE_OVERLAYS"), s));
    E.AddChild(newElWithChild(wxT("ACTIVE_OVERLAYS"), t));
    g = grid.GetAsDOMElement(D);
    E.AddChild(&g);
    return(E);
}
