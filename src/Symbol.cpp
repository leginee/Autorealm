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
#include "Symbol.h"

#include "Map.xpm"

static wxString className=wxT("Symbol");

Symbol::Symbol() {
	wxLogTrace(className, wxT("Symbol(): beginning"));
	wxLogTrace(className, wxT("Symbol(): ending"));
}

Symbol::~Symbol() {
	wxLogTrace(className, wxT("~Symbol(): beginning"));
	wxLogTrace(className, wxT("~Symbol(): ending"));
}

void Symbol::DrawImage(wxDC* canvas, int width, int height, float zoom) {
	wxLogTrace(className, wxT("(wxDC* canvas, int width, int height, float zoom): beginning"));
	wxLogTrace(className, wxT("(wxDC* canvas, int width, int height, float zoom): ending"));
}

wxBitmap Symbol::CreateBitmap(int width, int height, bool AntiAliased) {
	wxLogTrace(className, wxT("CreateBitmap(int width, int height, bool AntiAliased=false): beginning"));
	wxLogTrace(className, wxT("CreateBitmap(int width, int height, bool AntiAliased=false): ending"));
}

wxString Symbol::getComments() {
	wxLogTrace(className, wxT("getComments(): beginning"));
	wxLogTrace(className, wxT("getComments(): ending"));
}

void Symbol::setComments(const wxString& comments) {
	wxLogTrace(className, wxT("setComments(const wxString& comments): beginning"));
	wxLogTrace(className, wxT("setComments(const wxString& comments): ending"));
}

int Symbol::getImageIndex() {
	wxLogTrace(className, wxT("getImageIndex(): beginning"));
	wxLogTrace(className, wxT("getImageIndex(): ending"));
}

void Symbol::setImageIndex(int index) {
	wxLogTrace(className, wxT("setImageIndex(int index): beginning"));
	wxLogTrace(className, wxT("setImageIndex(int index): ending"));
}

wxString Symbol::CreateTempFile() {
	wxLogTrace(className, wxT("CreateTempFile(): beginning"));
	wxLogTrace(className, wxT("CreateTempFile(): ending"));
}

void Symbol::LoadTempFile(wxString filename) {
	wxLogTrace(className, wxT("LoadTempFile(wxString filename): beginning"));
	wxLogTrace(className, wxT("LoadTempFile(wxString filename): ending"));
}

