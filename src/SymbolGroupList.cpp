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
#include "SymbolGroupList.h"

#include "Map.xpm"

static wxString className=wxT("SymbolGroupList");

SymbolGroupList::SymbolGroupList() {
	wxLogTrace(className, wxT("SymbolGroupList(): beginning"));
	wxLogTrace(className, wxT("SymbolGroupList(): ending"));
}

SymbolGroupList::~SymbolGroupList() {
	wxLogTrace(className, wxT("~SymbolGroupList(): beginning"));
	wxLogTrace(className, wxT("~SymbolGroupList(): ending"));
}

void SymbolGroupList::Clear() {
	wxLogTrace(className, wxT("Clear(): beginning"));
	wxLogTrace(className, wxT("Clear(): ending"));
}

void SymbolGroupList::Save(wxString symdir) {
	wxLogTrace(className, wxT("Save(wxString symdir): beginning"));
	wxLogTrace(className, wxT("Save(wxString symdir): ending"));
}

void SymbolGroupList::Load(wxString symdir) {
	wxLogTrace(className, wxT("Load(wxString symdir): beginning"));
	wxLogTrace(className, wxT("Load(wxString symdir): ending"));
}

int SymbolGroupList::Count() {
	wxLogTrace(className, wxT("Count(): beginning"));
	wxLogTrace(className, wxT("Count(): ending"));
}

void SymbolGroupList::NewGroup(wxString name) {
	wxLogTrace(className, wxT("NewGroup(wxString name): beginning"));
	wxLogTrace(className, wxT("NewGroup(wxString name): ending"));
}

void SymbolGroupList::OpenGroup(wxString filename) {
	wxLogTrace(className, wxT("OpenGroup(wxString filename): beginning"));
	wxLogTrace(className, wxT("OpenGroup(wxString filename): ending"));
}

void SymbolGroupList::DeleteGroup(SymbolGroup which) {
	wxLogTrace(className, wxT("DeleteGroup(SymbolGroup which): beginning"));
	wxLogTrace(className, wxT("DeleteGroup(SymbolGroup which): ending"));
}

SymbolGroup SymbolGroupList::FirstGroup() {
	wxLogTrace(className, wxT("FirstGroup(): beginning"));
	wxLogTrace(className, wxT("FirstGroup(): ending"));
}

SymbolGroup SymbolGroupList::NextGroup(SymbolGroup p) {
	wxLogTrace(className, wxT("NextGroup(SymbolGroup p): beginning"));
	wxLogTrace(className, wxT("NextGroup(SymbolGroup p): ending"));
}

SymbolGroup SymbolGroupList::FindGroup(wxString name) {
	wxLogTrace(className, wxT("FindGroup(wxString name): beginning"));
	wxLogTrace(className, wxT("FindGroup(wxString name): ending"));
}

wxString SymbolGroupList::CreateReference(SymbolGroup grp, Symbol sym) {
	wxLogTrace(className, wxT("CreateReference(SymbolGroup grp, Symbol sym): beginning"));
	wxLogTrace(className, wxT("CreateReference(SymbolGroup grp, Symbol sym): ending"));
}

Symbol SymbolGroupList::GetReference(wxString ref) {
	wxLogTrace(className, wxT("GetReference(wxString ref): beginning"));
	wxLogTrace(className, wxT("GetReference(wxString ref): ending"));
}

int SymbolGroupList::RemoveCachedImage(int index) {
	wxLogTrace(className, wxT("RemoveCachedImage(int index): beginning"));
	wxLogTrace(className, wxT("RemoveCachedImage(int index): ending"));
}

SymbolGroupList* CurrentLibrary=NULL;
