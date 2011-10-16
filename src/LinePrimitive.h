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

#ifndef LINEPRIMITIVE_H
#define LINEPRIMITIVE_H

#include "globals.h"
#include "Primitives.h"
#include "DrawPrimitive.h"

/**
 * This class is used to display a line on the map
 *
 * @todo Document this class
 */
class LinePrimitive : public DrawPrimitive {
    public:
        // Standard attributes
        coord x1;
        coord y1;
        coord x2;
        coord y2;
        StyleAttrib style;

        // Fractal attributes
        int seed;
        int roughness;
        bool fractal;

        LinePrimitive(bool frac);
        LinePrimitive(coord ix1, coord iy1, coord ix2, coord iy2, StyleAttrib istyle);
        LinePrimitive(coord ix1, coord iy1, coord ix2, coord iy2, int iseed, int irough, StyleAttrib istyle);
        LinePrimitive(coord ix1, coord iy1, coord ix2, coord iy2, int iseed, int irough, StyleAttrib istyle, bool frac);
        DrawPrimitive* Copy();
        void CopyFromBase(bool AliasOnly);
        
        void Draw(ViewPoint& view);
        void DrawHandles(const ViewPoint& view);
        void DrawOverlayHandles(const ViewPoint& view);
        bool ApplyMatrix(Matrix3& mat);
        bool FindHandle(const ViewPoint& view, coord x, coord y);
        bool FindEndPoint(const ViewPoint& view, coord& x, coord& y);
        bool FindPointOn(const ViewPoint& view, coord& x, coord& y, coord& angle);
        bool MoveHandle(const ViewPoint& view, HandleMode& mode, coord origx, coord origy, coord dx, coord dy);
        bool SetStyle(StyleAttrib new_style);
        StyleAttrib GetStyle();
        void Move(coord dx, coord dy);
        void ComputeExtent();
        void PointClosestTo(coord x, coord y, coord& px, coord& py);
        bool SliceAlong(arRealPoint s1, arRealPoint s2, DrawPrimitive& np);
        void Reverse();
        VPoints GetLines(const ViewPoint& view, int& polycount);

        // Fractal functions
        bool Decompose(const ViewPoint& view, DrawPrimitive& NewChain, bool testinside=true);
        bool SetSeed(int new_seed);
        int GetSeed();
        bool SetRoughness(int rough);
        int GetRoughness();
        double RFact();
        bool SetFractal(FractalState state);

        wxString GetId();
        bool IsSimilarTo(DrawPrimitive D);
        coord GetAdjustedX1();
        coord GetAdjustedY1();
        coord GetAdjustedX2();
        coord GetAdjustedY2();
        void DoRead(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo);
        void ReadFromDOMElement(wxXmlNode e, int version);
        wxXmlNode GetAsDOMElement(wxXmlDocument D, bool undo);
};
#endif
