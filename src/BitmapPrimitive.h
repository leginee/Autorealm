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
#ifndef BITMAPPRIMITIVE_H
#define BITMAPPRIMITIVE_H

#include "globals.h"
#include <wx/xml/xml.h>

#include "Primitives.h"
#include "DrawPrimitive.h"
#include "ViewPoint.h"

/**
 * This class is used to display a bitmap on the map
 *
 * @todo Must document this class
 */
class BitmapPrimitive : public DrawPrimitive {
    private:
        wxBitmap image;
        arRealRect corners;

    public:
        BitmapPrimitive();
        BitmapPrimitive(const wxBitmap start, arRealRect InitialRect);
        DrawPrimitive* Copy();
        void CopyFromBase(bool AliasOnly);
        void ClearThis(bool Deallocate);
        void Draw(ViewPoint view);
        bool ApplyMatrix(Matrix3& mat);
        bool MoveHandle(const ViewPoint& view, HandleMode& mode, coord origx, coord origy, coord dx, coord dy);
        void Move(coord dx, coord dy);
        void ComputeExtent();
        bool SelectClick(const double within, arRealPoint p);
        bool SetFillColor(wxColour color);
        wxColour GetFillColor();

        wxString GetId();
        void DoRead(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo);
        void ReadFromDOMElement(wxXmlNode e, int version);
        wxXmlNode GetAsDOMElement(wxXmlDocument D, bool undo);

        bool IsSimilarTo(DrawPrimitive D);
};
#endif
