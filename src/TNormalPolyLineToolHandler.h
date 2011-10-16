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
#ifndef TNORMALPOLYLINETOOLHANDLER_H
#define TNORMALPOLYLINETOOLHANDLER_H
#include <vector>
#include "globals.h"
#include <wx/xrc/xmlres.h>
#include <wx/dc.h>

#include "ToolObject.h"
#include "DrawLines.h"
#include "types.h"

/**
 * @class TNormalPolyLineToolHandler
 *
 * @brief This class is used to BRIEFDESC
 *
 * FULLDESC
 */
class TNormalPolyLineToolHandler : public ToolObject {
    public:
        /**
         * @brief Default constructor
         */
        TNormalPolyLineToolHandler(wxDC* canvas);
		~TNormalPolyLineToolHandler();
		virtual void Done();
		virtual void Cancel();
		virtual bool MouseDown();
		virtual void MouseMove();
		virtual void MouseUp();
		virtual void Start();
		virtual void Add(VPoints list, int count);
		virtual void DrawXorPortion();
		virtual void SetSeed();
		virtual void ClearList();
		virtual void CreateClosedFigure();
		virtual void CreateOpenFigure();
		virtual void Move(int dx, int dy);
		virtual void Backspace();
		
		std::vector<void*> linelist;
		TLineContinue cont;
	protected:
		bool SnapWhenDone;
};
#endif //TNORMALPOLYLINETOOLHANDLER_H
