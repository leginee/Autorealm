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
#ifndef SELECTIONTOOL_H
#define SELECTIONTOOL_H
#include "globals.h"
#include <wx/xrc/xmlres.h>
#include "types.h"
#include "ToolObject.h"
#include "CustomHint.h"
#include "Primitives.h"

/**
 * @class SelectionTool
 *
 * @brief This class is used to BRIEFDESC
 *
 * FULLDESC
 */
class SelectionTool : ToolObject {
    public:
        arRealRect Extent;

        SelectionTool(wxDC* cv);
        ~SelectionTool();

        void Draw(bool erase);
        void Paint();
        void Done();
        void Refresh();
        void MouseUp();
        void MouseMove();
        bool MouseDown();
        void Adjust(coord& x, coord& y);
        void DoSnap(coord& x, coord& y);
    private:
        //@todo TShiftState ShiftState;
        SelectMode mode;
        HandleMode PointMode;
        double aspect;
        arRealRect OriginalExtent;
        CustomHint* hint;
        coord LastX, LastY;
        coord Origx, OrigY;
        coord SOrigX, SOrigY;
        coord LastA;
};
#endif //SELECTIONTOOL_H
