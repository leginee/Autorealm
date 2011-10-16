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
#include "TTextToolHandler.h"

#include "Map.xpm"

static wxString className=wxT("TTextToolHandler");

TTextToolHandler::TTextToolHandler(wxDC* canvas) : ToolObject(canvas) {
	wxLogTrace(className, wxT("TTextToolHandler(wxDC* canvas): beginning"));
	wxLogTrace(className, wxT("TTextToolHandler(wxDC* canvas): ending"));
}

TTextToolHandler::~TTextToolHandler() {
	wxLogTrace(className, wxT("~TTextToolHandler(): beginning"));
	wxLogTrace(className, wxT("~TTextToolHandler(): ending"));
}

void TTextToolHandler::UpdateFont() {
	wxLogTrace(className, wxT("UpdateFont(): beginning"));
	wxLogTrace(className, wxT("UpdateFont(): ending"));
}

void TTextToolHandler::Done() {
	wxLogTrace(className, wxT("Done(): beginning"));
	wxLogTrace(className, wxT("Done(): ending"));
}

void TTextToolHandler::Draw(bool erase) {
	wxLogTrace(className, wxT("Draw(bool erase): beginning"));
	wxLogTrace(className, wxT("Draw(bool erase): ending"));
}

bool TTextToolHandler::MouseDown() {
	wxLogTrace(className, wxT("MouseDown(): beginning"));
	wxLogTrace(className, wxT("MouseDown(): ending"));
}

void TTextToolHandler::MouseMove() {
	wxLogTrace(className, wxT("MouseMove(): beginning"));
	wxLogTrace(className, wxT("MouseMove(): ending"));
}
