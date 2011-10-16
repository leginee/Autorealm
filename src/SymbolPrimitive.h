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

#ifndef SYMBOLPRIMITIVE_H
#define SYMBOLPRIMITIVE_H

#include "globals.h"
#include "Primitives.h"
#include "DrawPrimitive.h"

/**
 * This class is used to display a symbol on the map
 *
 * @todo Document this class
 */
class SymbolPrimitive: public DrawPrimitive {
    public:
        coord x1;
        coord y1;
        coord ch;
        coord cw;
        coord cx;
        wxString text;
        wxFont font;
        int size;
        int angle;
        wxColour fOutlineColor;

        SymbolPrimitive();
        SymbolPrimitive(const ViewPoint& view, coord ix, coord iy, wxString symbol, int isize, wxColour outlinecolor);
        SymbolPrimitive(const ViewPoint& view, coord ix, coord iy, wxString symbol, wxFont ifont, wxColour outlinecolor);
        
        DrawPrimitive* Copy();
        void CopyFromBase(bool AliasOnly);
        void ClearThis(bool deallocate);
        
        bool Decompose(const ViewPoint& view, DrawPrimitive& NewChain, bool testinside=true);
        void ComputeSize(const ViewPoint& view);
        bool PrepareFont(const ViewPoint& view, int& sx, int& sy, int formatflags);
        bool MoveHandle(const ViewPoint& view, HandleMode& mode, coord origx, coord origy, coord dx, coord dy);
        void ComputeExtent();
        void Draw(ViewPoint view);
        bool ApplyMatrix(Matrix3& mat);
        void Move(coord dx, coord dy);
        TextAttrib GetTextAttrib();
        bool SetTextAttrib(const ViewPoint& view, const TextAttrib& attrib);
        arRealRect RotatedBox(coord w, coord h, int formatflags);
        bool SelectClick(const double within, arRealPoint p);

        wxString GetId();
        bool IsSimilarTo(DrawPrimitive D);
        void DoRead(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo);
        void ReadFromDOMElement(wxXmlNode e, int version);
        wxXmlNode GetAsDOMElement(wxXmlDocument D, bool undo);
};
#endif
