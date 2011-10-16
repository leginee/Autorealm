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
#ifndef TFREEHANDFRACTALTOOLHANDLER_H
#define TFREEHANDFRACTALTOOLHANDLER_H
#include "globals.h"
#include <wx/xrc/xmlres.h>
#include <wx/dc.h>

#include "TFractalPolyLineToolHandler.h"

/**
 * @class TFreehandFractalToolHandler
 *
 * @brief This class is used to BRIEFDESC
 *
 * FULLDESC
 */
class TFreehandFractalToolHandler : public TFractalPolyLineToolHandler {
    public:
        /**
         * @brief Default constructor
         */
        TFreehandFractalToolHandler(wxDC* canvas);
		virtual void Cancel();
		virtual bool MouseDown();
		virtual void MouseMove();
		virtual void MouseUp();
		virtual void CreateClosedFigure();
		virtual void CreateOpenFigure();
		virtual void Done();
		virtual void Backspace();
};
#endif //TFREEHANDFRACTALTOOLHANDLER_H
