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
#include "CTManager.h"

#include "Map.xpm"

static const wxString className=wxT("CTManager");

IMPLEMENT_DYNAMIC_CLASS(CTManager, wxFrame)

BEGIN_EVENT_TABLE(CTManager, wxFrame)
END_EVENT_TABLE()

/**
 * Normal constructor, simply calls the create function. Parameters are
 * identical to parameters for wxDialog::wxDialog()
 */
CTManager::CTManager(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    wxLogTrace(className, wxT("Entering CTManager::CTManager"));
    Create(parent, id, title, pos, size, style, name);
    wxLogTrace(className, wxT("Exiting CTManager::CTManager"));
}

/**
 * This routine is responsible for initializing the dialog window for
 * rotations. It loads up the xrc resource, and makes sure all is ready for
 * first onscreen display. For a blow-by-blow, read the wxLogTrace
 * statements in the code.
 * 
 * Parameters are identical to wxDialog::Create()
 *
 * @return Required by Create(), but unused
 */
bool CTManager::Create(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    
    wxLogTrace(className, wxT("Entering CTManager::Create"));

    wxLogTrace(className, wxT("Loading resource"));
    wxXmlResource::Get()->LoadFrame(this, GetParent(), wxT("frmColorTranslationManager"));

    wxLogTrace(className, wxT("Constructing and setting icon"));
    SetIcon(wxICON(autorealm));

    wxLogTrace(className, wxT("Exiting CTManager::Create"));
}


///@todo Document this method
void CTManager::FormShow() {
    wxLogTrace(className, wxT("CTManager::FormShow(): Entering"));
    wxLogTrace(className, wxT("CTManager::FormShow(): Exiting"));
}

///@todo Document this method
void CTManager::FormResize() {
    wxLogTrace(className, wxT("CTManager::FormResize(): Entering"));
    wxLogTrace(className, wxT("CTManager::FormResize(): Exiting"));
}

///@todo Document this method
void CTManager::FormDestroy() {
    wxLogTrace(className, wxT("CTManager::FormDestroy(): Entering"));
    wxLogTrace(className, wxT("CTManager::FormDestroy(): Exiting"));
}

///@todo Document this method
void CTManager::FormCreate() {
    wxLogTrace(className, wxT("CTManager::FormCreate(): Entering"));
    wxLogTrace(className, wxT("CTManager::FormCreate(): Exiting"));
}

///@todo Document this method
void CTManager::lblSelectionItemsClick() {
    wxLogTrace(className, wxT("CTManager::lblSelectionItemsClick(): Entering"));
    wxLogTrace(className, wxT("CTManager::lblSelectionItemsClick(): Exiting"));
}

///@todo Document this method
void CTManager::dgSelectionColorsDrawCell(wxObject sender, int ACol, int ARow, wxRect rect) {
    wxLogTrace(className, wxT("CTManager::dgSelectionColorsDrawCell(wxObject sender, int ACol, int ARow, wxRect rect): Entering"));
    wxLogTrace(className, wxT("CTManager::dgSelectionColorsDrawCell(wxObject sender, int ACol, int ARow, wxRect rect): Exiting"));
}

///@todo Document this method
void CTManager::cbProfilesChange() {
    wxLogTrace(className, wxT("CTManager::cbProfilesChange(): Entering"));
    wxLogTrace(className, wxT("CTManager::cbProfilesChange(): Exiting"));
}

///@todo Document this method
void CTManager::btnNewClick() {
    wxLogTrace(className, wxT("CTManager::btnNewClick(): Entering"));
    wxLogTrace(className, wxT("CTManager::btnNewClick(): Exiting"));
}

///@todo Document this method
void CTManager::btnSaveClick() {
    wxLogTrace(className, wxT("CTManager::btnSaveClick(): Entering"));
    wxLogTrace(className, wxT("CTManager::btnSaveClick(): Exiting"));
}

///@todo Document this method
void CTManager::btnRenameClick() {
    wxLogTrace(className, wxT("CTManager::btnRenameClick(): Entering"));
    wxLogTrace(className, wxT("CTManager::btnRenameClick(): Exiting"));
}

///@todo Document this method
void CTManager::sgSelectionColorsDrawCell(wxObject sender, int ACol, int ARow, wxRect rect) {
    wxLogTrace(className, wxT("CTManager::sgSelectionColorsDrawCell(wxObject sender, int ACol, int ARow, wxRect rect): Entering"));
    wxLogTrace(className, wxT("CTManager::sgSelectionColorsDrawCell(wxObject sender, int ACol, int ARow, wxRect rect): Exiting"));
}

///@todo Document this method
void CTManager::btnAddClick() {
    wxLogTrace(className, wxT("CTManager::btnAddClick(): Entering"));
    wxLogTrace(className, wxT("CTManager::btnAddClick(): Exiting"));
}

///@todo Document this method
void CTManager::sgProfileClick() {
    wxLogTrace(className, wxT("CTManager::sgProfileClick(): Entering"));
    wxLogTrace(className, wxT("CTManager::sgProfileClick(): Exiting"));
}

///@todo Document this method
void CTManager::ColorButton2Change() {
    wxLogTrace(className, wxT("CTManager::ColorButton2Change(): Entering"));
    wxLogTrace(className, wxT("CTManager::ColorButton2Change(): Exiting"));
}

///@todo Document this method
void CTManager::btnRemoveTranslationClick() {
    wxLogTrace(className, wxT("CTManager::btnRemoveTranslationClick(): Entering"));
    wxLogTrace(className, wxT("CTManager::btnRemoveTranslationClick(): Exiting"));
}

///@todo Document this method
void CTManager::btnDeleteClick() {
    wxLogTrace(className, wxT("CTManager::btnDeleteClick(): Entering"));
    wxLogTrace(className, wxT("CTManager::btnDeleteClick(): Exiting"));
}

///@todo Document this method
void CTManager::FormClose() {
    wxLogTrace(className, wxT("CTManager::FormClose(): Entering"));
    wxLogTrace(className, wxT("CTManager::FormClose(): Exiting"));
}

///@todo Document this method
void CTManager::dgSelectionColorsClick() {
    wxLogTrace(className, wxT("CTManager::dgSelectionColorsClick(): Entering"));
    wxLogTrace(className, wxT("CTManager::dgSelectionColorsClick(): Exiting"));
}

///@todo Document this method
void CTManager::TranslateSelectionColors() {
    wxLogTrace(className, wxT("CTManager::TranslateSelectionColors(): Entering"));
    wxLogTrace(className, wxT("CTManager::TranslateSelectionColors(): Exiting"));
}

///@todo Document this method
void CTManager::InverseTranslateSelectionColors() {
    wxLogTrace(className, wxT("CTManager::InverseTranslateSelectionColors(): Entering"));
    wxLogTrace(className, wxT("CTManager::InverseTranslateSelectionColors(): Exiting"));
}

///@todo Document this method
void CTManager::PopulateColorList(DrawPrimitive D) {
    wxLogTrace(className, wxT("CTManager::PopulateColorList(DrawPrimitive D): Entering"));
    wxLogTrace(className, wxT("CTManager::PopulateColorList(DrawPrimitive D): Exiting"));
}

///@todo Document this method
void CTManager::AddColor(wxArrayString list, wxColour C) {
    wxLogTrace(className, wxT("CTManager::AddColor(wxArrayString list, wxColour C): Entering"));
    wxLogTrace(className, wxT("CTManager::AddColor(wxArrayString list, wxColour C): Exiting"));
}

///@todo Document this method
void CTManager::SetupColorList() {
    wxLogTrace(className, wxT("CTManager::SetupColorList(): Entering"));
    wxLogTrace(className, wxT("CTManager::SetupColorList(): Exiting"));
}

///@todo Document this method
void CTManager::SetupProfileColorList() {
    wxLogTrace(className, wxT("CTManager::SetupProfileColorList(): Entering"));
    wxLogTrace(className, wxT("CTManager::SetupProfileColorList(): Exiting"));
}

///@todo Document this method
void CTManager::ClearCTProfiles() {
    wxLogTrace(className, wxT("CTManager::ClearCTProfiles(): Entering"));
    wxLogTrace(className, wxT("CTManager::ClearCTProfiles(): Exiting"));
}

///@todo Document this method
void CTManager::LoadCTProfiles() {
    wxLogTrace(className, wxT("CTManager::LoadCTProfiles(): Entering"));
    wxLogTrace(className, wxT("CTManager::LoadCTProfiles(): Exiting"));
}

///@todo Document this method
void CTManager::SetModified(bool b) {
    wxLogTrace(className, wxT("CTManager::SetModified(bool b): Entering"));
    wxLogTrace(className, wxT("CTManager::SetModified(bool b): Exiting"));
}

///@todo Document this method
void CTManager::Translate(DrawPrimitive D) {
    wxLogTrace(className, wxT("CTManager::Translate(DrawPrimitive D): Entering"));
    wxLogTrace(className, wxT("CTManager::Translate(DrawPrimitive D): Exiting"));
}

///@todo Document this method
void CTManager::InverseTranslate(DrawPrimitive D) {
    wxLogTrace(className, wxT("CTManager::InverseTranslate(DrawPrimitive D): Entering"));
    wxLogTrace(className, wxT("CTManager::InverseTranslate(DrawPrimitive D): Exiting"));
}

/**
 ********************************************************************
 */

///@todo Document this method
CTProfile::CTProfile() {
    wxLogTrace(className, wxT("CTProfile: Entering"));
    wxLogTrace(className, wxT("CTProfile: Exiting"));
}

///@todo Document this method
CTProfile::~CTProfile() {
    wxLogTrace(className, wxT("~CTProfile: Entering"));
    wxLogTrace(className, wxT("~CTProfile: Exiting"));
}

///@todo Document this method
void CTProfile::LoadFromFile(wxString file) {
    wxLogTrace(className, wxT("LoadFromFile(wxString file): Entering"));
    wxLogTrace(className, wxT("LoadFromFile(wxString file): Exiting"));
}

///@todo Document this method
void CTProfile::SaveToFile(wxString file) {
    wxLogTrace(className, wxT("SaveToFile(wxString file): Entering"));
    wxLogTrace(className, wxT("SaveToFile(wxString file): Exiting"));
}

///@todo Document this method
void CTProfile::SaveToFile() {
    wxLogTrace(className, wxT("SaveToFile(): Entering"));
    wxLogTrace(className, wxT("SaveToFile(): Exiting"));
}

///@todo Document this method
void CTProfile::Add(wxColour oldc, wxColour newc) {
    wxLogTrace(className, wxT("Add(wxColour oldc, wxColour newc): Entering"));
    wxLogTrace(className, wxT("Add(wxColour oldc, wxColour newc): Exiting"));
}

///@todo Document this method
void CTProfile::Remove(int index) {
    wxLogTrace(className, wxT("Remove(int index): Entering"));
    wxLogTrace(className, wxT("Remove(int index): Exiting"));
}

///@todo Document this method
int CTProfile::IndexOfOld(wxColour oldc) {
    wxLogTrace(className, wxT("IndexOfOld(wxColour oldc): Entering"));
    wxLogTrace(className, wxT("IndexOfOld(wxColour oldc): Exiting"));
}

///@todo Document this method
int CTProfile::IndexOfNew(wxColour newc) {
    wxLogTrace(className, wxT("IndexOfNew(wxColour newc): Entering"));
    wxLogTrace(className, wxT("IndexOfNew(wxColour newc): Exiting"));
}

///@todo Document this method
void CTProfile::CopyFrom(CTProfile P) {
    wxLogTrace(className, wxT("CopyFrom(CTProfile P): Entering"));
    wxLogTrace(className, wxT("CopyFrom(CTProfile P): Exiting"));
}

///@todo Document this method
void CTProfile::Clear() {
    wxLogTrace(className, wxT("Clear(): Entering"));
    wxLogTrace(className, wxT("Clear(): Exiting"));
}

///@todo Document this method
wxString CTProfile::GetFName() {
    wxLogTrace(className, wxT("GetFName(): Entering"));
    wxLogTrace(className, wxT("GetFName(): Exiting"));
}

///@todo Document this method
void CTProfile::SetFName() {
    wxLogTrace(className, wxT("SetFName(): Entering"));
    wxLogTrace(className, wxT("SetFName(): Exiting"));
}

///@todo Document this method
wxString CTProfile::GetFileName() {
    wxLogTrace(className, wxT("GetFileName(): Entering"));
    wxLogTrace(className, wxT("GetFileName(): Exiting"));
}

///@todo Document this method
void CTProfile::SetFileName() {
    wxLogTrace(className, wxT("SetFileName(): Entering"));
    wxLogTrace(className, wxT("SetFileName(): Exiting"));
}

///@todo Document this method
int CTProfile::GetNumColors() {
    wxLogTrace(className, wxT("GetNumColors(): Entering"));
    wxLogTrace(className, wxT("GetNumColors(): Exiting"));
}

///@todo Document this method
wxColour CTProfile::GetOldColor(int index) {
    wxLogTrace(className, wxT("GetOldColor(int index): Entering"));
    wxLogTrace(className, wxT("GetOldColor(int index): Exiting"));
}

///@todo Document this method
wxColour CTProfile::GetNewColor(int index) {
    wxLogTrace(className, wxT("GetNewColor(int index): Entering"));
    wxLogTrace(className, wxT("GetNewColor(int index): Exiting"));
}

///@todo Document this method
void CTProfile::SetNewColor(int index, wxColour C) {
    wxLogTrace(className, wxT("SetNewColor(int index, wxColour C): Entering"));
    wxLogTrace(className, wxT("SetNewColor(int index, wxColour C): Exiting"));
}

CTManager* ctmanager=NULL;
