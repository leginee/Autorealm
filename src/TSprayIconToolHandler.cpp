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
#include "TSprayIconToolHandler.h"

#include "Map.xpm"

static wxString className=wxT("TSprayIconToolHandler");

TSprayIconToolHandler::TSprayIconToolHandler(wxDC* canvas) : ToolObject(canvas) {
	wxLogTrace(className, wxT("TSprayIconToolHandler(wxDC* canvas): beginning"));
	wxLogTrace(className, wxT("TSprayIconToolHandler(wxDC* canvas): ending"));
}

TSprayIconToolHandler::~TSprayIconToolHandler() {
	wxLogTrace(className, wxT("~TSprayIconToolHandler(): beginning"));
	wxLogTrace(className, wxT("~TSprayIconToolHandler(): ending"));
}

void TSprayIconToolHandler::Draw(bool erase) {
	wxLogTrace(className, wxT("Draw(bool erase): beginning"));
	wxLogTrace(className, wxT("Draw(bool erase): ending"));
}

void TSprayIconToolHandler::Done() {
	wxLogTrace(className, wxT("Done(): beginning"));
	wxLogTrace(className, wxT("Done(): ending"));
}

void TSprayIconToolHandler::Cancel() {
	wxLogTrace(className, wxT("Cancel(): beginning"));
	wxLogTrace(className, wxT("Cancel(): ending"));
}

bool TSprayIconToolHandler::MouseDown() {
	wxLogTrace(className, wxT("MouseDown(): beginning"));
	wxLogTrace(className, wxT("MouseDown(): ending"));
}

void TSprayIconToolHandler::MouseMove() {
	wxLogTrace(className, wxT("MouseMove(): beginning"));
	wxLogTrace(className, wxT("MouseMove(): ending"));
}

void TSprayIconToolHandler::ShowCrosshair(int x, int y) {
	wxLogTrace(className, wxT("ShowCrosshair(int x, int y): beginning"));
	wxLogTrace(className, wxT("ShowCrosshair(int x, int y): ending"));
}

void TSprayIconToolHandler::HideCrosshair() {
	wxLogTrace(className, wxT("HideCrosshair(): beginning"));
	wxLogTrace(className, wxT("HideCrosshair(): ending"));
}

void TSprayIconToolHandler::ClearList() {
	wxLogTrace(className, wxT("ClearList(): beginning"));
	wxLogTrace(className, wxT("ClearList(): ending"));
}

void TSprayIconToolHandler::Move(int dx, int dy) {
	wxLogTrace(className, wxT("Move(int dx, int dy): beginning"));
	wxLogTrace(className, wxT("Move(int dx, int dy): ending"));
}

