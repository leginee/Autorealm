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

#ifndef HYPERLINKPRIMITIVE_H
#define HYPERLINKPRIMITIVE_H

#include "globals.h"
#include "Primitives.h"
#include "DrawPrimitive.h"

/**
 * This class is used to display a hyperlink on the map
 *
 * @todo Document this class
 */
class HyperlinkPrimitive : public DrawPrimitive {
    private:
        coord x1;
        coord y1;
        HyperlinkFlags flags;
        wxString text;

    public:
        HyperlinkPrimitive();
        HyperlinkPrimitive(const coord x, const coord y, wxString str, HyperlinkFlags flag);
        DrawPrimitive* Copy();
        void CopyFromBase(bool AliasOnly);
        
        void Draw(ViewPoint view);
        bool ApplyMatrix(Matrix3& mat);
        void Move(coord dx, coord dy);
        void ComputeExtent();
        bool SelectClick(const double within, arRealPoint p);
        TextAttrib GetTextAttrib();
        bool SetTextAttrib(const ViewPoint view, const TextAttrib attrib);
        bool FindHyperlink(const ViewPoint view, coord x, coord y, wxString& hypertext, HyperlinkFlags& hyperflags);

        wxString GetId();
        bool IsSimilarTo(DrawPrimitive D);
        coord GetAdjustedX1();
        coord GetAdjustedY1();
        void DoRead(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo);
        void ReadFromDOMElement(wxXmlNode e, int version);
        wxXmlNode GetAsDOMElement(wxXmlDocument D, bool undo);
};
#endif
