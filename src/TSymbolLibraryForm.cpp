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
#include "TSymbolLibraryForm.h"

#include "Map.xpm"

static wxString className=wxT("TSymbolLibraryForm");

IMPLEMENT_DYNAMIC_CLASS(TSymbolLibraryForm, wxDialog)

BEGIN_EVENT_TABLE(TSymbolLibraryForm, wxDialog)
END_EVENT_TABLE()

/**
 * Normal constructor, simply calls the create function. Parameters are
 * identical to parameters for wxDialog::wxDialog()
 */
TSymbolLibraryForm::TSymbolLibraryForm(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    wxLogTrace(className, wxT("Entering TSymbolLibraryForm"));
    Create(parent, id, title, pos, size, style, name);
    wxLogTrace(className, wxT("Exiting TSymbolLibraryForm"));
}

/**
 * This routine is responsible for initializing the dialog window.
 * It loads up the xrc resource, and makes sure all is ready for
 * first onscreen display. For a blow-by-blow, read the wxLogTrace
 * statements in the code.
 * 
 * Parameters are identical to wxDialog::Create()
 *
 * @return Required by Create(), but unused
 */
bool TSymbolLibraryForm::Create(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    
    wxLogTrace(className, wxT("Entering Create"));

    wxLogTrace(className, wxT("Loading resource"));
    wxXmlResource::Get()->LoadDialog(this, GetParent(), wxT("FIXME:RESNAMEHERE"));

    wxLogTrace(className, wxT("Constructing and setting icon"));
    SetIcon(wxICON(autorealm));

    wxLogTrace(className, wxT("Exiting Create"));
}

TSymbolLibraryForm::~TSymbolLibraryForm() {
	wxLogTrace(className, wxT("~TSymbolLibraryForm(): beginning"));
	wxLogTrace(className, wxT("~TSymbolLibraryForm(): ending"));
}

void TSymbolLibraryForm::btnRevertClick() {
	wxLogTrace(className, wxT("btnRevertClick(): beginning"));
	wxLogTrace(className, wxT("btnRevertClick(): ending"));
}

void TSymbolLibraryForm::btnAddGroupClick() {
	wxLogTrace(className, wxT("btnAddGroupClick(): beginning"));
	wxLogTrace(className, wxT("btnAddGroupClick(): ending"));
}

void TSymbolLibraryForm::btnSaveAllClick() {
	wxLogTrace(className, wxT("btnSaveAllClick(): beginning"));
	wxLogTrace(className, wxT("btnSaveAllClick(): ending"));
}

void TSymbolLibraryForm::btnDelGroupClick() {
	wxLogTrace(className, wxT("btnDelGroupClick(): beginning"));
	wxLogTrace(className, wxT("btnDelGroupClick(): ending"));
}

void TSymbolLibraryForm::btnInsertClick() {
	wxLogTrace(className, wxT("btnInsertClick(): beginning"));
	wxLogTrace(className, wxT("btnInsertClick(): ending"));
}

void TSymbolLibraryForm::btnDefineClick() {
	wxLogTrace(className, wxT("btnDefineClick(): beginning"));
	wxLogTrace(className, wxT("btnDefineClick(): ending"));
}

void TSymbolLibraryForm::LargeSymbolPaint() {
	wxLogTrace(className, wxT("LargeSymbolPaint(): beginning"));
	wxLogTrace(className, wxT("LargeSymbolPaint(): ending"));
}

void TSymbolLibraryForm::btnDeleteClick() {
	wxLogTrace(className, wxT("btnDeleteClick(): beginning"));
	wxLogTrace(className, wxT("btnDeleteClick(): ending"));
}

void TSymbolLibraryForm::btnCancelClick() {
	wxLogTrace(className, wxT("btnCancelClick(): beginning"));
	wxLogTrace(className, wxT("btnCancelClick(): ending"));
}

void TSymbolLibraryForm::btnEditClick() {
	wxLogTrace(className, wxT("btnEditClick(): beginning"));
	wxLogTrace(className, wxT("btnEditClick(): ending"));
}

void TSymbolLibraryForm::btnEditPicClick() {
	wxLogTrace(className, wxT("btnEditPicClick(): beginning"));
	wxLogTrace(className, wxT("btnEditPicClick(): ending"));
}

void TSymbolLibraryForm::SymbolTreeChange() {
	wxLogTrace(className, wxT("SymbolTreeChange(): beginning"));
	wxLogTrace(className, wxT("SymbolTreeChange(): ending"));
}

void TSymbolLibraryForm::FormShow() {
	wxLogTrace(className, wxT("FormShow(): beginning"));
	wxLogTrace(className, wxT("FormShow(): ending"));
}

bool TSymbolLibraryForm::getEditing() {
	wxLogTrace(className, wxT("getEditing(): beginning"));
	wxLogTrace(className, wxT("getEditing(): ending"));
}

void TSymbolLibraryForm::setEditing(bool b) {
	wxLogTrace(className, wxT("setEditing(bool b): beginning"));
	wxLogTrace(className, wxT("setEditing(bool b): ending"));
}

void TSymbolLibraryForm::RefreshTree() {
	wxLogTrace(className, wxT("RefreshTree(): beginning"));
	wxLogTrace(className, wxT("RefreshTree(): ending"));
}

Symbol TSymbolLibraryForm::getSymbol() {
	wxLogTrace(className, wxT("getSymbol(): beginning"));
	wxLogTrace(className, wxT("getSymbol(): ending"));
}

SymbolGroup TSymbolLibraryForm::getGroup() {
	wxLogTrace(className, wxT("getGroup(): beginning"));
	wxLogTrace(className, wxT("getGroup(): ending"));
}

void TSymbolLibraryForm::LoadGroupList() {
	wxLogTrace(className, wxT("LoadGroupList(): beginning"));
	wxLogTrace(className, wxT("LoadGroupList(): ending"));
}

void TSymbolLibraryForm::SelectGroup(SymbolGroup grp) {
	wxLogTrace(className, wxT("SelectGroup(SymbolGroup grp): beginning"));
	wxLogTrace(className, wxT("SelectGroup(SymbolGroup grp): ending"));
}

TSymbolLibraryForm* tsymbollibraryform=NULL;
