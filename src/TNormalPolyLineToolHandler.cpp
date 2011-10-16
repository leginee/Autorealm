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
#include "TNormalPolyLineToolHandler.h"

#include "Map.xpm"

static wxString className=wxT("TNormalPolyLineToolHandler");

TNormalPolyLineToolHandler::TNormalPolyLineToolHandler(wxDC* canvas):ToolObject(canvas) {
	wxLogTrace(className, wxT("TNormalPolyLineToolHandler(wxDC* canvas):ToolObject(canvas){}: beginning"));
	wxLogTrace(className, wxT("TNormalPolyLineToolHandler(wxDC* canvas):ToolObject(canvas){}: ending"));
}

TNormalPolyLineToolHandler::~TNormalPolyLineToolHandler() {
	wxLogTrace(className, wxT("~TNormalPolyLineToolHandler(): beginning"));
	wxLogTrace(className, wxT("~TNormalPolyLineToolHandler(): ending"));
}

void TNormalPolyLineToolHandler::Done() {
	wxLogTrace(className, wxT("Done(): beginning"));
	wxLogTrace(className, wxT("Done(): ending"));
}

void TNormalPolyLineToolHandler::Cancel() {
	wxLogTrace(className, wxT("Cancel(): beginning"));
	wxLogTrace(className, wxT("Cancel(): ending"));
}

bool TNormalPolyLineToolHandler::MouseDown() {
	wxLogTrace(className, wxT("MouseDown(): beginning"));
	wxLogTrace(className, wxT("MouseDown(): ending"));
}

void TNormalPolyLineToolHandler::MouseMove() {
	wxLogTrace(className, wxT("MouseMove(): beginning"));
	wxLogTrace(className, wxT("MouseMove(): ending"));
}

void TNormalPolyLineToolHandler::MouseUp() {
	wxLogTrace(className, wxT("MouseUp(): beginning"));
	wxLogTrace(className, wxT("MouseUp(): ending"));
}

void TNormalPolyLineToolHandler::Start() {
	wxLogTrace(className, wxT("Start(): beginning"));
	wxLogTrace(className, wxT("Start(): ending"));
}

void TNormalPolyLineToolHandler::Add(VPoints list, int count) {
	wxLogTrace(className, wxT("Add(VPoints list, int count): beginning"));
	wxLogTrace(className, wxT("Add(VPoints list, int count): ending"));
}

void TNormalPolyLineToolHandler::DrawXorPortion() {
	wxLogTrace(className, wxT("DrawXorPortion(): beginning"));
	wxLogTrace(className, wxT("DrawXorPortion(): ending"));
}

void TNormalPolyLineToolHandler::SetSeed() {
	wxLogTrace(className, wxT("SetSeed(): beginning"));
	wxLogTrace(className, wxT("SetSeed(): ending"));
}

void TNormalPolyLineToolHandler::ClearList() {
	wxLogTrace(className, wxT("ClearList(): beginning"));
	wxLogTrace(className, wxT("ClearList(): ending"));
}

void TNormalPolyLineToolHandler::CreateClosedFigure() {
	wxLogTrace(className, wxT("CreateClosedFigure(): beginning"));
	wxLogTrace(className, wxT("CreateClosedFigure(): ending"));
}

void TNormalPolyLineToolHandler::CreateOpenFigure() {
	wxLogTrace(className, wxT("CreateOpenFigure(): beginning"));
	wxLogTrace(className, wxT("CreateOpenFigure(): ending"));
}

void TNormalPolyLineToolHandler::Move(int dx, int dy) {
	wxLogTrace(className, wxT("Move(int dx, int dy): beginning"));
	wxLogTrace(className, wxT("Move(int dx, int dy): ending"));
}

void TNormalPolyLineToolHandler::Backspace() {
	wxLogTrace(className, wxT("Backspace(): beginning"));
	wxLogTrace(className, wxT("Backspace(): ending"));
}
