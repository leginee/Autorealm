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
#include "PanToolHandler.h"

#include "Map.xpm"

static wxString className=wxT("PanToolHandler");

PanToolHandler::PanToolHandler(wxDC* cv) : ToolObject(cv) {
    wxLogTrace(className, wxT("Entering PanToolHandler(wxDC* cv)"));
    wxLogTrace(className, wxT("Exiting PanToolHandler(wxDC* cv)"));
}

void PanToolHandler::Done() {
    wxLogTrace(className, wxT("Entering Done()"));
    wxLogTrace(className, wxT("Exiting Done()"));
}

void PanToolHandler::MouseMove() {
    wxLogTrace(className, wxT("Entering MouseMove()"));
    wxLogTrace(className, wxT("Exiting MouseMove()"));
}

bool PanToolHandler::MouseDown() {
    wxLogTrace(className, wxT("Entering MouseDown()"));
    wxLogTrace(className, wxT("Exiting MouseDown()"));
}

void PanToolHandler::MouseUp() {
    wxLogTrace(className, wxT("Entering MouseUp()"));
    wxLogTrace(className, wxT("Exiting MouseUp()"));
}

