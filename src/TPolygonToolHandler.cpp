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
#include "TPolygonToolHandler.h"

#include "Map.xpm"

static wxString className=wxT("TPolygonToolHandler");

TPolygonToolHandler::TPolygonToolHandler(wxDC* canvas) : ToolObject(canvas) {
	wxLogTrace(className, wxT("TPolygonToolHandler(wxDC* canvas): beginning"));
	wxLogTrace(className, wxT("TPolygonToolHandler(wxDC* canvas): ending"));
}

void TPolygonToolHandler::Draw(bool erase) {
	wxLogTrace(className, wxT("Draw(bool erase): beginning"));
	wxLogTrace(className, wxT("Draw(bool erase): ending"));
}

void TPolygonToolHandler::Done() {
	wxLogTrace(className, wxT("Done(): beginning"));
	wxLogTrace(className, wxT("Done(): ending"));
}

void TPolygonToolHandler::Add(coord cx1, coord cy1, coord cx2, coord cy2) {
	wxLogTrace(className, wxT("Add(coord cx1, coord cy1, coord cx2, coord cy2): beginning"));
	wxLogTrace(className, wxT("Add(coord cx1, coord cy1, coord cx2, coord cy2): ending"));
}

bool TPolygonToolHandler::AskSides() {
	wxLogTrace(className, wxT("AskSides(): beginning"));
	wxLogTrace(className, wxT("AskSides(): ending"));
}
