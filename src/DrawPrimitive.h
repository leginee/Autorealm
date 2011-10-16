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

#ifndef DRAWPRIMITIVE_H
#define DRAWPRIMITIVE_H

#include <wx/arrstr.h>
#include "globals.h"
#include "Primitives.h"
#include "ViewPoint.h"
#include "matrixmath.h"
#include "arStringList.h"

class DrawPrimitive;

/**
 * This class is the parent class of all other primitives
 *
 * @todo Document this class
 */
class DrawPrimitive {
	private:
		unsigned short fOverlay;
		bool fSelected;
	
	protected:
		arRealRect fExtent;
		wxColour fColor;
		
        // Absolute X,Y position of the alias.  Not used for "base" objects, though
        // it is harmless to set it for them.
        //
        // There are several reasons why Alias contains ABSOLUTE coordinates instead
        // of RELATIVE coordinates, all of which relate to GroupPrimitive objects:
        //
        // 1. Groups don't know where they are.
        //
        // GroupPrimitive objects neither contain nor use coordinate information;
        // they merely contain other DrawPrimitive objects that contain absolute
        // coordinates and therefore know where they are.  If aliases within a group
        // contained relative coordinates, they would need to know the position to
        // which they were relative, which means that groups would have to know their
        // positions (or be able to get it from their Parents--see below).
        //
        // 2. The need for "parent" information.
        //
        // Giving groups positional information is useless unless DrawPrimitives
        // know the groups to which they belong.  That means adding something like
        // a Parent field, and all the necessary code to build this information and
        // maintain its integrity.  It would also render certain information
        // meaningless, such as LinePrimitive (X1,Y1) coordinates, hyperlink
        // coordinates, and starting coordinates for curves, polycurves, etc.
        //
        // 3. SPEED!
        //
        // Many calculations have to be performed in real-time in which it is
        // necessary to know where an alias object's coordinate actually is.  For
        // instance, dragging a polycurve node requires that the program know where
        // that node is in real-time.  When alias objects contain absolute
        // coordinates, they can simply refer to their base objects and do a fast
        // calculation to find out the actual position.  When they contain relative
        // coordinates, however, they first have to walk a parent tree.  I felt that
        // this would take far too much time for many operations. 

		arRealPoint Alias;

        // For a given "base" object, this list contains pointers to all of its
        // alias objects.  In each alias, this list is empty by definition.
		arStringList<DrawPrimitive> Copies;

        void SetExtent(const arRealRect& value);
        void MakeCopy(DrawPrimitive& from);
        ViewPoint MakeAliasView(ViewPoint view);
        coord GetAdjustedX(coord x);
        coord GetAdjustedY(coord y);
        arRealPoint GetAdjustedPoint(arRealPoint p);
        void RecalcAliasFromExtent();
        void RefreshCopies();

    public:
        // For alias objects, Base contains a pointer to its "base" object.  For
        // base objects, this pointer MUST contain NULL (it's how we differentiate
        // between base and alias objects).
        DrawPrimitive* Base;
        DrawPrimitive* Next;

        // MapCollection; I can't set the type here because it would cause a
        // circular unit reference.  We'll just have to typecast it where it's
        // used and deal with it.  See DrawPrimitive.SetMap() for a full
        // explanation of this field's purpose.
        wxObject* MapC;

		DrawPrimitive();
		~DrawPrimitive();

		virtual void SetMap(wxObject* M);
		void ClearChain();
		void InsertIntoBaseList();
		virtual void AddToBaseOrCopies(bool DoChain = false);
		virtual void ClearThis(bool deallocate);
		void Clear();
		virtual void CopyFromBase(bool AliasOnly);

		virtual DrawPrimitive* Copy();
		arRealRect getExtent() {return (fExtent);};
		void setExtent();
		virtual void ComputeExtent();
		virtual bool IsClosed();

		void SetSize(coord w, coord h);
		coord width();
		coord height();

		bool IsWithin(arRealRect rect);
		bool IsTouching(arRealRect rect);
		bool IsInOverlay(OverlaySet& overlay);
		bool IsSelected();
		void Select(ViewPoint* View, bool b);
		virtual bool SelectClick(const double within, arRealPoint p);

		bool OnScreen(const arRealRect& rect);
		void Invalidate(const wxObject& handle, const ViewPoint& view);

		virtual bool Decompose(const ViewPoint& view, DrawPrimitive& NewChain, bool testinside=true);
		void InvalidateHandle(const wxObject& handle, const ViewPoint& view, coord x, coord y);
		void DrawHandle(const ViewPoint& view, coord x, coord y);
		void DrawOverlayHandle(ViewPoint view, coord x, coord y);
		bool TestHandle(ViewPoint& view, coord tx, coord ty, coord px, coord py);
		int PointClosestInArray(coord x, coord y, VPoints points, int count);
		int PointClosestInAdjustedArray(coord x, coord y, VPoints points, int count);
		virtual VPoints GetLines(const ViewPoint* view, int& polycount);

		virtual bool FindHandle(ViewPoint& view, coord x, coord y);
		virtual bool FindHyperLink(const ViewPoint& view, coord x, coord y, wxString& hypertext, HyperlinkFlags& hyperflags);
		virtual bool FindEndPoint(const ViewPoint& view, coord x, coord y);
		virtual bool FindPointOn(const ViewPoint& view, coord x, coord y, coord angle);
		virtual bool MoveHandle(ViewPoint& view, HandleMode& mode, coord origx, coord origy, coord dx, coord dy);
		virtual void Move(coord dx, coord dy);
		virtual void Draw(ViewPoint* view);
		virtual void DrawHandles(const ViewPoint& view);
		virtual void DrawOverlayHandles(ViewPoint& view, coord x, coord y);
		virtual void PointClosestTo(coord x, coord y, coord& px, coord& py);
		virtual void InvalidateHandles(const wxObject& handle, const ViewPoint& view);
		virtual bool FindScalpelPoint(const ViewPoint& view, coord x, coord y, int& index);
		virtual bool SeparateNode(const ViewPoint& view, int index, DrawPrimitive& NewObject);
		virtual void DeleteNode(const ViewPoint& view, int index);
		virtual bool SliceAlong(arRealPoint s1, arRealPoint s2, DrawPrimitive& np);

		wxColour DisplayColor(wxColour color);
		wxColour DisplayFillColor(wxColour color);
		void CopyCore(DrawPrimitive obj);
		virtual bool ApplyMatrix(Matrix3& mat);
		virtual bool SetStyle(StyleAttrib style);
		virtual StyleAttrib GetStyle();
		virtual bool SetSeed(int seed);
		virtual int GetSeed();
		virtual bool SetRoughness(int rough);
		virtual int GetRoughness();
		virtual bool SetColor(wxColour color);
		virtual wxColour GetColor();
		virtual bool SetFillColor(wxColour color);
		virtual wxColour GetFillColor();
		virtual bool SetOverlay(unsigned short overlay);
		virtual int GetOverlay();
		virtual bool SetTextAttrib(const ViewPoint& view, const TextAttrib& attrib);
		virtual TextAttrib GetTextAttrib();
		virtual void CloseFigure();
		virtual void Reverse();
		virtual bool SetFractal(FractalState state);

		bool ChainApplyMatrix(Matrix3 mat, bool all);
		arRealRect ChainExtent(bool all);
		bool ChainSetStyle(StyleAttrib style, bool all);
		StyleAttrib ChainGetStyle(bool all);
		bool ChainSetSeed(int seed, bool all);
		int ChainGetSeed(bool all);
		bool ChainSetRoughness(int rough, bool all);
		int ChainGetRoughness(bool all);
		bool ChainSetColor(wxColour color, bool all);
		wxColour ChainGetColor(bool all);
		bool ChainSetFillColor(wxColour color, bool all);
		wxColour ChainGetFillColor(bool all);
		bool ChainSetOverlay(unsigned short overlay, bool all);
		int ChainGetOverlay(bool all);
		bool ChainSetTextAttrib(const ViewPoint& view, TextAttrib attrib, bool all);
		TextAttrib ChainGetTextAttrib(bool all);
		bool ChainSetFractal(FractalState state, bool all);

		int CountSiblings();

		static DrawPrimitive IdToObject(wxString id);
		virtual wxString GetId();
        bool IsSimilarTo(const DrawPrimitive& d);
		void SplitOff();

        static DrawPrimitive ReadChain(wxFileInputStream& ins, int version, bool selected, bool Full, bool UseAliasInfo, wxObject M);
        virtual void DoRead(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo);
        virtual void Read(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo);

        static DrawPrimitive ReadChainFromDOMElement(wxXmlNode E, int version, bool selected, wxObject M);
        wxXmlNode GetChainAsDOMElement(wxXmlDocument D, bool all, bool undo);
        bool ReadBaseFromDOMElement(wxXmlNode E);
        bool GetAsAliasDOMElement(wxXmlDocument D, wxXmlNode E);
        virtual void ReadFromDOMElement(wxXmlNode E, int version);
        virtual wxXmlNode GetAsDOMElement(wxXmlDocument D, bool undo);
};

DrawPrimitive* CombineObjects(DrawPrimitive o1, DrawPrimitive o2);
DrawPrimitive* ConvertObject(DrawPrimitive obj, wxString newtype);
#endif
