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
#ifndef TCHARTGRIDTOOLHANDLER_H
#define TCHARTGRIDTOOLHANDLER_H
#include "globals.h"
#include <wx/xrc/xmlres.h>
#include <wx/dc.h>

#include "types.h"
#include "ToolObject.h"

/**
 * @class TChartGridToolHandler
 *
 * @brief This class is used to BRIEFDESC
 *
 * FULLDESC
 */
class TChartGridToolHandler : public ToolObject {
    public:
        /**
         * @brief Default constructor
         */
        TChartGridToolHandler(wxDC* canvas);
		bool AskGrid();
		virtual void Draw(bool erase);
		virtual void Done();
		void FreshenLineList();
		virtual void MouseUp();
		virtual bool MouseDown();
		virtual void MouseMose();
	private:
		arRealPoint center;
		double radius;
		arRealRect croprect;
		bool iscropping;
		bool FinishedCircle;
		int allocatedlines;
		int linecount;
		VPoints linelist;
};
#endif //TCHARTGRIDTOOLHANDLER_H
