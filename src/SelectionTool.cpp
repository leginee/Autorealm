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
#include "SelectionTool.h"

#include "Map.xpm"

static wxString className=wxT("SelectionTool");

SelectionTool::SelectionTool(wxDC* cv) : ToolObject(cv) {
    wxLogTrace(className, wxT("Entering SelectionTool(wxDC* cv)"));
    wxLogTrace(className, wxT("Exiting SelectionTool(wxDC* cv)"));
}

SelectionTool::~SelectionTool() {
    wxLogTrace(className, wxT("Entering ~SelectionTool()"));
    wxLogTrace(className, wxT("Exiting ~SelectionTool()"));
}

void SelectionTool::Draw(bool erase) {
    wxLogTrace(className, wxT("Entering Draw(bool erase)"));
    wxLogTrace(className, wxT("Exiting Draw(bool erase)"));
}

void SelectionTool::Paint() {
    wxLogTrace(className, wxT("Entering Paint()"));
    wxLogTrace(className, wxT("Exiting Paint()"));
}

void SelectionTool::Done() {
    wxLogTrace(className, wxT("Entering Done()"));
    wxLogTrace(className, wxT("Exiting Done()"));
}

void SelectionTool::Refresh() {
    wxLogTrace(className, wxT("Entering Refresh()"));
    wxLogTrace(className, wxT("Exiting Refresh()"));
}

void SelectionTool::MouseUp() {
    wxLogTrace(className, wxT("Entering MouseUp()"));
    wxLogTrace(className, wxT("Exiting MouseUp()"));
}

void SelectionTool::MouseMove() {
    wxLogTrace(className, wxT("Entering MouseMove()"));
    wxLogTrace(className, wxT("Exiting MouseMove()"));
}

bool SelectionTool::MouseDown() {
    wxLogTrace(className, wxT("Entering MouseDown()"));
    wxLogTrace(className, wxT("Exiting MouseDown()"));
}

void SelectionTool::Adjust(coord& x, coord& y) {
    wxLogTrace(className, wxT("Entering Adjust(coord& x, coord& y)"));
    wxLogTrace(className, wxT("Exiting Adjust(coord& x, coord& y)"));
}

void SelectionTool::DoSnap(coord& x, coord& y) {
    wxLogTrace(className, wxT("Entering DoSnap(coord& x, coord& y)"));
    wxLogTrace(className, wxT("Exiting DoSnap(coord& x, coord& y)"));
}
