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
#include "ToolObject.h"
#include "Symbol.h"

#include "Map.xpm"

static wxString className=wxT("ToolObject");

ToolObject::ToolObject(wxDC* dc) {
    wxLogTrace(className, wxT("Entering constructor"));
    wxLogTrace(className, wxT("Exiting constructor"));
}

ToolObject::~ToolObject() {
    wxLogTrace(className, wxT("Entering destructor"));
    wxLogTrace(className, wxT("Exiting destructor"));
}

bool ToolObject::MouseDown() {
    wxLogTrace(className, wxT("Entering MouseDown()"));
    wxLogTrace(className, wxT("Exiting MouseDown()"));
}

void ToolObject::MouseMove() {
    wxLogTrace(className, wxT("Entering MouseMove()"));
    wxLogTrace(className, wxT("Exiting MouseMove()"));
}

void ToolObject::MouseUp() {
    wxLogTrace(className, wxT("Entering MouseUp()"));
    wxLogTrace(className, wxT("Exiting MouseUp()"));
}

void ToolObject::Cancel() {
    wxLogTrace(className, wxT("Entering Cancel()"));
    wxLogTrace(className, wxT("Exiting Cancel()"));
}

void ToolObject::Done() {
    wxLogTrace(className, wxT("Entering Done()"));
    wxLogTrace(className, wxT("Exiting Done()"));
}

void ToolObject::Draw(bool erase) {
    wxLogTrace(className, wxT("Entering Draw(bool erase)"));
    wxLogTrace(className, wxT("Exiting Draw(bool erase)"));
}

void ToolObject::Paint() {
    wxLogTrace(className, wxT("Entering Paint()"));
    wxLogTrace(className, wxT("Exiting Paint()"));
}

void ToolObject::Refresh() {
    wxLogTrace(className, wxT("Entering Refresh()"));
    wxLogTrace(className, wxT("Exiting Refresh()"));
}

void ToolObject::RefreshCursor() {
    wxLogTrace(className, wxT("Entering RefreshCursor()"));
    wxLogTrace(className, wxT("Exiting RefreshCursor()"));
}

void ToolObject::CreateClosedFigure() {
    wxLogTrace(className, wxT("Entering CreateClosedFigure()"));
    wxLogTrace(className, wxT("Exiting CreateClosedFigure()"));
}

void ToolObject::CreateOpenFigure() {
    wxLogTrace(className, wxT("Entering CreateOpenFigure()"));
    wxLogTrace(className, wxT("Exiting CreateOpenFigure()"));
}

void ToolObject::Move(int dx, int dy) {
    wxLogTrace(className, wxT("Entering Move(int dx, int dy)"));
    wxLogTrace(className, wxT("Exiting Move(int dx, int dy)"));
}

bool ToolObject::Pan(int& x, int& y) {
    wxLogTrace(className, wxT("Entering Pan(int& x, int& y)"));
    wxLogTrace(className, wxT("Exiting Pan(int& x, int& y)"));
}

void ToolObject::Escape() {
    wxLogTrace(className, wxT("Entering Escape()"));
    wxLogTrace(className, wxT("Exiting Escape()"));
}

void ToolObject::Backspace() {
    wxLogTrace(className, wxT("Entering Backspace()"));
    wxLogTrace(className, wxT("Exiting Backspace()"));
}

void ToolObject::ShowCrosshair(int x, int y) {
    wxLogTrace(className, wxT("Entering ShowCrosshair(int x, int y)"));
    wxLogTrace(className, wxT("Exiting ShowCrosshair(int x, int y)"));
}

void ToolObject::HideCrosshair() {
    wxLogTrace(className, wxT("Entering HideCrosshair()"));
    wxLogTrace(className, wxT("Exiting HideCrosshair()"));
}

StyleAttrib GetCurrentlySetStyles() {
    wxLogTrace(className, wxT("Entering GetCurrentlySetStyles()"));
    wxLogTrace(className, wxT("Exiting GetCurrentlySetStyles()"));
}

Symbol* InsertSymbol;
