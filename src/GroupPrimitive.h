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

#ifndef GROUPPRIMITIVE_H
#define GROUPPRIMITIVE_H

#include "globals.h"
#include "Primitives.h"
#include "DrawPrimitive.h"

/**
 * This class is used to display a group on the map
 *
 * @todo Document this class
 */
class GroupPrimitive : public DrawPrimitive {
    private:
        DrawPrimitive head;

    public:
        GroupPrimitive();
        GroupPrimitive(DrawPrimitive starting_head);

        DrawPrimitive* Copy();
        void CopyFromBase(bool AliasOnly);
        void SetMap(wxObject M);
        void AddToBaseOrCopies(bool DoChain);
        void ClearThis(bool Deallocate);
        bool Decompose(const ViewPoint& view, DrawPrimitive& NewChain, bool testinside=true);
        bool SetHead(DrawPrimitive newHead);
        DrawPrimitive GetHead();
        void Draw(ViewPoint view);
        bool ApplyMatrix(Matrix3& mat);
        bool MoveHandle(const ViewPoint& view, HandleMode& mode, coord origx, coord origy, coord dx, coord dy);
        void Move(coord dx, coord dy);
        bool SetStyle(StyleAttrib new_style);
        StyleAttrib GetStyle();
        bool SetSeed(int new_seed);
        int GetSeed();
        bool SetRoughness(int rough);
        int GetRoughness();
        bool SetColor(wxColour color);
        wxColour GetColor();
        bool SetOverlay(unsigned short overlay);
        int GetOverlay();
        bool SetTextAttrib(const ViewPoint& view, const TextAttrib& text);
        TextAttrib GetTextAttrib();
        bool SetFillColor(wxColour color);
        wxColour GetFillColor();
        void ComputeExtent();
        bool SelectClick(const double within, arRealPoint p);
        void Reverse();
        bool SetFractal(FractalState state);

        wxString GetId();
        bool IsSimilarTo(DrawPrimitive D);
        void DoRead(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo);
        void ReadFromDOMElement(wxXmlNode e, int version);
        wxXmlNode GetAsDOMElement(wxXmlDocument D, bool undo);
};
#endif
