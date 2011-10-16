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
#ifndef TFRACTALPOLYCURVETOOLHANDLER_H
#define TFRACTALPOLYCURVETOOLHANDLER_H
#include "globals.h"
#include <wx/xrc/xmlres.h>
#include <wx/dc.h>

#include "types.h"
#include "TPolyCurveToolHandler.h"

/**
 * @class TFractalPolyCurveToolHandler
 *
 * @brief This class is used to BRIEFDESC
 *
 * FULLDESC
 */
class TFractalPolyCurveToolHandler : public TPolyCurveToolHandler {
    public:
        /**
         * @brief Default constructor
         */
        TFractalPolyCurveToolHandler(wxDC* canvas);
		virtual void Start();
		virtual void AddCurve(VPoints list, int count);
		virtual void DrawCurve(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4);
	protected:
		int seed;
		int roughness;
};
#endif //TFRACTALPOLYCURVETOOLHANDLER_H
