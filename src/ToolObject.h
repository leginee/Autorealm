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
#ifndef TOOLOBJECT_H
#define TOOLOBJECT_H
#include "globals.h"
#include "types.h"
#include <wx/xrc/xmlres.h>

#include "DrawLines.h"

const int SelBorder=3;

enum TToolState {tsOff, tsStarted};

enum SelectMode {smMoveTop, smMoveBottom, smMoveLeft, smMoveRight, smMovePoint, smSelect, smRotate, smPopup, smStretchTL, smStretchTR, smStretchBL, smStretchBR};

/**
 * @class ToolObject
 *
 * @brief This class is used to BRIEFDESC
 *
 * FULLDESC
 */
class ToolObject {
    public:
        ToolObject(wxDC* dc);
        virtual ~ToolObject();

        virtual bool MouseDown();
        virtual void MouseMove();
        virtual void MouseUp();
        virtual void Cancel();
        virtual void Done();
        virtual void Draw(bool erase);
        virtual void Paint();
        virtual void Refresh();
        void RefreshCursor();
        virtual void CreateClosedFigure();
        virtual void CreateOpenFigure();
        virtual void Move(int dx, int dy);
        bool Pan(int& x, int& y);
        void Escape();
        virtual void Backspace();
        virtual void ShowCrosshair(int x, int y);
        virtual void HideCrosshair();

    protected:
        coord StartX, StartY;
        coord EndX, EndY;
        TToolState state;
        wxDC* canvas;
        bool AutoPan;
        int CustomCursor;
};

StyleAttrib GetCurrentlySetStyles();
#endif //TOOLOBJECT_H
