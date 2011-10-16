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

#include "globals.h"
#include "TFractalCurveToolHandler.h"

#include "Map.xpm"

static wxString className=wxT("TFractalCurveToolHandler");

TFractalCurveToolHandler::TFractalCurveToolHandler(wxDC* canvas) : TNormalCurveToolHandler(canvas) {
	wxLogTrace(className, wxT("TFractalCurveToolHandler(wxDC* canvas): beginning"));
	wxLogTrace(className, wxT("TFractalCurveToolHandler(wxDC* canvas): ending"));
}

void TFractalCurveToolHandler::Add(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4) {
	wxLogTrace(className, wxT("void Add(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4): beginning"));
	wxLogTrace(className, wxT("void Add(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4): ending"));
}

void TFractalCurveToolHandler::DrawCurve(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4) {
	wxLogTrace(className, wxT("void DrawCurve(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4): beginning"));
	wxLogTrace(className, wxT("void DrawCurve(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4): ending"));
}

