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
#include "TIconToolHandler.h"

#include "Map.xpm"

static wxString className=wxT("TIconToolHandler");

TIconToolHandler::TIconToolHandler(wxDC* canvas) : ToolObject(canvas) {
	wxLogTrace(className, wxT("TIconToolHandler(wxDC* canvas): beginning"));
	wxLogTrace(className, wxT("TIconToolHandler(wxDC* canvas): ending"));
}

void TIconToolHandler::Draw(bool erase) {
	wxLogTrace(className, wxT("Draw(bool erase): beginning"));
	wxLogTrace(className, wxT("Draw(bool erase): ending"));
}

void TIconToolHandler::Done() {
	wxLogTrace(className, wxT("Done(): beginning"));
	wxLogTrace(className, wxT("Done(): ending"));
}

void TIconToolHandler::Cancel() {
	wxLogTrace(className, wxT("Cancel(): beginning"));
	wxLogTrace(className, wxT("Cancel(): ending"));
}

bool TIconToolHandler::MouseDown() {
	wxLogTrace(className, wxT("MouseDown(): beginning"));
	wxLogTrace(className, wxT("MouseDown(): ending"));
}

void TIconToolHandler::ShowCrosshair(int x, int y) {
	wxLogTrace(className, wxT("ShowCrosshair(int x, int y): beginning"));
	wxLogTrace(className, wxT("ShowCrosshair(int x, int y): ending"));
}

void TIconToolHandler::HideCrosshair() {
	wxLogTrace(className, wxT("HideCrosshair(): beginning"));
	wxLogTrace(className, wxT("HideCrosshair(): ending"));
}
