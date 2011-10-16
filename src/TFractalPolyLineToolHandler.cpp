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
#include "TFractalPolyLineToolHandler.h"

#include "Map.xpm"

static wxString className=wxT("TFractalPolyLineToolHandler");

TFractalPolyLineToolHandler::TFractalPolyLineToolHandler(wxDC* canvas) : TNormalPolyLineToolHandler(canvas) {
	wxLogTrace(className, wxT("TFractalPolyLineToolHandler(wxDC* canvas): beginning"));
	wxLogTrace(className, wxT("TFractalPolyLineToolHandler(wxDC* canvas): ending"));
}

void TFractalPolyLineToolHandler::Draw(bool erase) {
	wxLogTrace(className, wxT("Draw(bool erase): beginning"));
	wxLogTrace(className, wxT("Draw(bool erase): ending"));
}

void TFractalPolyLineToolHandler::Start() {
	wxLogTrace(className, wxT("Start(): beginning"));
	wxLogTrace(className, wxT("Start(): ending"));
}

void TFractalPolyLineToolHandler::Add(VPoints list, int count) {
	wxLogTrace(className, wxT("Add(VPoints list, int count): beginning"));
	wxLogTrace(className, wxT("Add(VPoints list, int count): ending"));
}

void TFractalPolyLineToolHandler::DrawXorPortion() {
	wxLogTrace(className, wxT("DrawXorPortion(): beginning"));
	wxLogTrace(className, wxT("DrawXorPortion(): ending"));
}

void TFractalPolyLineToolHandler::SetSeed() {
	wxLogTrace(className, wxT("SetSeed(): beginning"));
	wxLogTrace(className, wxT("SetSeed(): ending"));
}
