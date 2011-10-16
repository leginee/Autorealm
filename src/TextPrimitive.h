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

#ifndef TEXTPRIMITIVE_H
#define TEXTPRIMITIVE_H

#include "globals.h"
#include "Primitives.h"
#include "DrawPrimitive.h"
#include "SymbolPrimitive.h"

/**
 * This class is used to display a string on the map
 *
 * @todo Document this class
 */
class TextPrimitive: public SymbolPrimitive {
    protected:
        int formatflags;
    public:
        TextPrimitive();
        TextPrimitive(const ViewPoint& view, coord ix, coord iy, wxString itext, wxFont ifont, int iformatflags, wxColour outline);

        DrawPrimitive* Copy();
        void CopyFromBase(bool AliasOnly);

        void Draw(ViewPoint view);
        void ComputeExtent();
        bool ApplyMatrix(Matrix3& mat);

        wxString GetId();
        bool SetTextAttrib(const ViewPoint& view, const TextAttrib attrib);
        TextAttrib GetTextAttrib();
        bool IsSimilarTo(DrawPrimitive D);
        void DoRead(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo);
        void ReadFromDOMElement(wxXmlNode e, int version);
        wxXmlNode GetAsDOMElement(wxXmlDocument D, bool undo);
};
#endif
