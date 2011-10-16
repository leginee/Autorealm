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
#include "TChartGridToolHandler.h"

#include "Map.xpm"

static wxString className=wxT("TChartGridToolHandler");

TChartGridToolHandler::TChartGridToolHandler(wxDC* canvas) : ToolObject(canvas) {
	wxLogTrace(className, wxT("TChartGridToolHandler(wxDC* canvas): beginning"));
	wxLogTrace(className, wxT("TChartGridToolHandler(wxDC* canvas): ending"));
}

bool TChartGridToolHandler::AskGrid() {
	wxLogTrace(className, wxT("AskGrid(): beginning"));
	wxLogTrace(className, wxT("AskGrid(): ending"));
}

void TChartGridToolHandler::Draw(bool erase) {
	wxLogTrace(className, wxT("Draw(bool erase): beginning"));
	wxLogTrace(className, wxT("Draw(bool erase): ending"));
}

void TChartGridToolHandler::Done() {
	wxLogTrace(className, wxT("Done(): beginning"));
	wxLogTrace(className, wxT("Done(): ending"));
}

void TChartGridToolHandler::FreshenLineList() {
	wxLogTrace(className, wxT("FreshenLineList(): beginning"));
	wxLogTrace(className, wxT("FreshenLineList(): ending"));
}

void TChartGridToolHandler::MouseUp() {
	wxLogTrace(className, wxT("MouseUp(): beginning"));
	wxLogTrace(className, wxT("MouseUp(): ending"));
}

bool TChartGridToolHandler::MouseDown() {
	wxLogTrace(className, wxT("MouseDown(): beginning"));
	wxLogTrace(className, wxT("MouseDown(): ending"));
}

void TChartGridToolHandler::MouseMose() {
	wxLogTrace(className, wxT("MouseMose(): beginning"));
	wxLogTrace(className, wxT("MouseMose(): ending"));
}

