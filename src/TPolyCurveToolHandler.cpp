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
#include "TPolyCurveToolHandler.h"

#include "Map.xpm"

static wxString className=wxT("TPolyCurveToolHandler");

TPolyCurveToolHandler::TPolyCurveToolHandler(wxDC* canvas) : TNormalCurveToolHandler(canvas) {
	wxLogTrace(className, wxT("TPolyCurveToolHandler(wxDC* canvas): beginning"));
	wxLogTrace(className, wxT("TPolyCurveToolHandler(wxDC* canvas): ending"));
}

TPolyCurveToolHandler::~TPolyCurveToolHandler() {
	wxLogTrace(className, wxT("~TPolyCurveToolHandler(): beginning"));
	wxLogTrace(className, wxT("~TPolyCurveToolHandler(): ending"));
}

void TPolyCurveToolHandler::Done() {
	wxLogTrace(className, wxT("Done(): beginning"));
	wxLogTrace(className, wxT("Done(): ending"));
}

void TPolyCurveToolHandler::Cancel() {
	wxLogTrace(className, wxT("Cancel(): beginning"));
	wxLogTrace(className, wxT("Cancel(): ending"));
}

bool TPolyCurveToolHandler::MouseDown() {
	wxLogTrace(className, wxT("MouseDown(): beginning"));
	wxLogTrace(className, wxT("MouseDown(): ending"));
}

void TPolyCurveToolHandler::AddPoint(arRealPoint pt) {
	wxLogTrace(className, wxT("AddPoint(arRealPoint pt): beginning"));
	wxLogTrace(className, wxT("AddPoint(arRealPoint pt): ending"));
}

void TPolyCurveToolHandler::AddCurve(VPoints list, int count) {
	wxLogTrace(className, wxT("AddCurve(VPoints list, int count): beginning"));
	wxLogTrace(className, wxT("AddCurve(VPoints list, int count): ending"));
}

void TPolyCurveToolHandler::AddCurveSection() {
	wxLogTrace(className, wxT("AddCurveSection(): beginning"));
	wxLogTrace(className, wxT("AddCurveSection(): ending"));
}

void TPolyCurveToolHandler::Start() {
	wxLogTrace(className, wxT("Start(): beginning"));
	wxLogTrace(className, wxT("Start(): ending"));
}

void TPolyCurveToolHandler::ClearList() {
	wxLogTrace(className, wxT("ClearList(): beginning"));
	wxLogTrace(className, wxT("ClearList(): ending"));
}

void TPolyCurveToolHandler::CreateClosedFigure() {
	wxLogTrace(className, wxT("CreateClosedFigure(): beginning"));
	wxLogTrace(className, wxT("CreateClosedFigure(): ending"));
}

void TPolyCurveToolHandler::CreateOpenFigure() {
	wxLogTrace(className, wxT("CreateOpenFigure(): beginning"));
	wxLogTrace(className, wxT("CreateOpenFigure(): ending"));
}

void TPolyCurveToolHandler::Move(int dx, int dy) {
	wxLogTrace(className, wxT("Move(int dx, int dy): beginning"));
	wxLogTrace(className, wxT("Move(int dx, int dy): ending"));
}

void TPolyCurveToolHandler::Backspace() {
	wxLogTrace(className, wxT("Backspace(): beginning"));
	wxLogTrace(className, wxT("Backspace(): ending"));
}

void TPolyCurveToolHandler::MouseMove() {
	wxLogTrace(className, wxT("MouseMove(): beginning"));
	wxLogTrace(className, wxT("MouseMove(): ending"));
}

void TPolyCurveToolHandler::ForceContinuity(int x, int y) {
	wxLogTrace(className, wxT("ForceContinuity(int x, int y): beginning"));
	wxLogTrace(className, wxT("ForceContinuity(int x, int y): ending"));
}
