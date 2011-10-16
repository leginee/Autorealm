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
#include "TNormalCurveToolHandler.h"

#include "Map.xpm"

static wxString className=wxT("TNormalCurveToolHandler");

TNormalCurveToolHandler::TNormalCurveToolHandler(wxDC* canvas) : ToolObject(canvas) {
	wxLogTrace(className, wxT("TNormalCurveToolHandler(wxDC* canvas): beginning"));
	wxLogTrace(className, wxT("TNormalCurveToolHandler(wxDC* canvas): ending"));
}

void TNormalCurveToolHandler::Draw(bool erase) {
	wxLogTrace(className, wxT("void Draw(bool erase): beginning"));
	wxLogTrace(className, wxT("void Draw(bool erase): ending"));
}

void TNormalCurveToolHandler::Done() {
	wxLogTrace(className, wxT("void Done(): beginning"));
	wxLogTrace(className, wxT("void Done(): ending"));
}

void TNormalCurveToolHandler::Cancel() {
	wxLogTrace(className, wxT("void Cancel(): beginning"));
	wxLogTrace(className, wxT("void Cancel(): ending"));
}

void TNormalCurveToolHandler::Backspace() {
	wxLogTrace(className, wxT("void Backspace(): beginning"));
	wxLogTrace(className, wxT("void Backspace(): ending"));
}

bool TNormalCurveToolHandler::MouseDown() {
	wxLogTrace(className, wxT("bool MouseDown(): beginning"));
	wxLogTrace(className, wxT("bool MouseDown(): ending"));
}

void TNormalCurveToolHandler::MouseUp() {
	wxLogTrace(className, wxT("void MouseUp(): beginning"));
	wxLogTrace(className, wxT("void MouseUp(): ending"));
}

void TNormalCurveToolHandler::Add(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4) {
	wxLogTrace(className, wxT("void Add(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4): beginning"));
	wxLogTrace(className, wxT("void Add(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4): ending"));
}

void TNormalCurveToolHandler::DrawCurve(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4) {
	wxLogTrace(className, wxT("void DrawCurve(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4): beginning"));
	wxLogTrace(className, wxT("void DrawCurve(arRealPoint sp1, arRealPoint sp2, arRealPoint sp3, arRealPoint sp4): ending"));
}

void TNormalCurveToolHandler::Move(int dx, int dy) {
	wxLogTrace(className, wxT("void Move(int dx, int dy): beginning"));
	wxLogTrace(className, wxT("void Move(int dx, int dy): ending"));
}
