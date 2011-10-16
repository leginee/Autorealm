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
#include "GlueHandler.h"

#include "Map.xpm"

static wxString className=wxT("GlueHandler");

GlueHandler::GlueHandler(wxDC* cv) : ToolObject(cv) {
    wxLogTrace(className, wxT("Entering GlueHandler(wxDC* cv)"));
    wxLogTrace(className, wxT("Exiting GlueHandler(wxDC* cv)"));
}

void GlueHandler::Cancel() {
    wxLogTrace(className, wxT("Entering Cancel()"));
    wxLogTrace(className, wxT("Exiting Cancel()"));
}

void GlueHandler::Done() {
    wxLogTrace(className, wxT("Entering Done()"));
    wxLogTrace(className, wxT("Exiting Done()"));
}

void GlueHandler::Refresh() {
    wxLogTrace(className, wxT("Entering Refresh()"));
    wxLogTrace(className, wxT("Exiting Refresh()"));
}

void GlueHandler::MouseMove() {
    wxLogTrace(className, wxT("Entering MouseMove()"));
    wxLogTrace(className, wxT("Exiting MouseMove()"));
}

bool GlueHandler::MouseDown() {
    wxLogTrace(className, wxT("Entering MouseDown()"));
    wxLogTrace(className, wxT("Exiting MouseDown()"));
}

void GlueHandler::MouseUp() {
    wxLogTrace(className, wxT("Entering MouseUp()"));
    wxLogTrace(className, wxT("Exiting MouseUp()"));
}

void GlueHandler::ResetCursor() {
    wxLogTrace(className, wxT("Entering ResetCursor()"));
    wxLogTrace(className, wxT("Exiting ResetCursor()"));
}

