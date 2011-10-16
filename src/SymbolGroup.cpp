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
#include "SymbolGroup.h"

#include "Map.xpm"

static wxString className=wxT("SymbolGroup");

SymbolGroup::SymbolGroup() {
	wxLogTrace(className, wxT("SymbolGroup(): beginning"));
	wxLogTrace(className, wxT("SymbolGroup(): ending"));
}

SymbolGroup::~SymbolGroup() {
	wxLogTrace(className, wxT("~SymbolGroup(): beginning"));
	wxLogTrace(className, wxT("~SymbolGroup(): ending"));
}

void SymbolGroup::Clear() {
	wxLogTrace(className, wxT("Clear(): beginning"));
	wxLogTrace(className, wxT("Clear(): ending"));
}

bool SymbolGroup::Prepare(wxString fname) {
	wxLogTrace(className, wxT("Prepare(wxString fname): beginning"));
	wxLogTrace(className, wxT("Prepare(wxString fname): ending"));
}

void SymbolGroup::Ready() {
	wxLogTrace(className, wxT("Ready(): beginning"));
	wxLogTrace(className, wxT("Ready(): ending"));
}

bool SymbolGroup::Load(wxString fname) {
	wxLogTrace(className, wxT("Load(wxString fname): beginning"));
	wxLogTrace(className, wxT("Load(wxString fname): ending"));
}

bool SymbolGroup::Save(wxString fname) {
	wxLogTrace(className, wxT("Save(wxString fname): beginning"));
	wxLogTrace(className, wxT("Save(wxString fname): ending"));
}

wxString SymbolGroup::getGroupName() {
	wxLogTrace(className, wxT("getGroupName(): beginning"));
	wxLogTrace(className, wxT("getGroupName(): ending"));
}

int SymbolGroup::count() {
	wxLogTrace(className, wxT("count(): beginning"));
	wxLogTrace(className, wxT("count(): ending"));
}

bool SymbolGroup::HasBeenLoaded() {
	wxLogTrace(className, wxT("HasBeenLoaded(): beginning"));
	wxLogTrace(className, wxT("HasBeenLoaded(): ending"));
}

void SymbolGroup::AddSymbol(Symbol sym) {
	wxLogTrace(className, wxT("AddSymbol(Symbol sym): beginning"));
	wxLogTrace(className, wxT("AddSymbol(Symbol sym): ending"));
}

void SymbolGroup::DeleteSymbol(Symbol which, bool destroy) {
	wxLogTrace(className, wxT("DeleteSymbol(Symbol which, bool destroy=true): beginning"));
	wxLogTrace(className, wxT("DeleteSymbol(Symbol which, bool destroy=true): ending"));
}

void SymbolGroup::RemoveCachedImage(int index) {
	wxLogTrace(className, wxT("RemoveCachedImage(int index): beginning"));
	wxLogTrace(className, wxT("RemoveCachedImage(int index): ending"));
}

Symbol SymbolGroup::GetSymbol(int index) {
	wxLogTrace(className, wxT("GetSymbol(int index): beginning"));
	wxLogTrace(className, wxT("GetSymbol(int index): ending"));
}

Symbol SymbolGroup::FirstSymbol() {
	wxLogTrace(className, wxT("FirstSymbol(): beginning"));
	wxLogTrace(className, wxT("FirstSymbol(): ending"));
}

Symbol SymbolGroup::NextSymbol(Symbol p) {
	wxLogTrace(className, wxT("NextSymbol(Symbol p): beginning"));
	wxLogTrace(className, wxT("NextSymbol(Symbol p): ending"));
}

Symbol SymbolGroup::FindSymbol(int uid) {
	wxLogTrace(className, wxT("FindSymbol(int uid): beginning"));
	wxLogTrace(className, wxT("FindSymbol(int uid): ending"));
}

bool SymbolGroup::getModified() {
	wxLogTrace(className, wxT("getModified(): beginning"));
	wxLogTrace(className, wxT("getModified(): ending"));
}

void SymbolGroup::setModified(bool modified) {
	wxLogTrace(className, wxT("setModified(bool modified): beginning"));
	wxLogTrace(className, wxT("setModified(bool modified): ending"));
}
