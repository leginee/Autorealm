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
#include "ChooseFontDlg.h"

#include "Map.xpm"

static wxString className=wxT("ChooseFontDlg");

IMPLEMENT_DYNAMIC_CLASS(ChooseFontDlg, wxDialog)

BEGIN_EVENT_TABLE(ChooseFontDlg, wxDialog)
END_EVENT_TABLE()

/**
 * Normal constructor, simply calls the create function. Parameters are
 * identical to parameters for wxDialog::wxDialog()
 */
ChooseFontDlg::ChooseFontDlg(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    wxLogTrace(className, wxT("Entering ChooseFontDlg::ChooseFontDlg"));
    Create(parent, id, title, pos, size, style, name);
    wxLogTrace(className, wxT("Exiting ChooseFontDlg::ChooseFontDlg"));
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
bool ChooseFontDlg::Create(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    
    wxLogTrace(className, wxT("Entering ChooseFontDlg::Create"));

    wxLogTrace(className, wxT("Loading resource"));
    wxXmlResource::Get()->LoadDialog(this, GetParent(), wxT("dlgChooseFont"));

    wxLogTrace(className, wxT("Constructing and setting icon"));
    SetIcon(wxICON(autorealm));

    wxLogTrace(className, wxT("Exiting ChooseFontDlg::Create"));
}

///@todo Document this method
void ChooseFontDlg::ApplyChanges(const wxString lbl, bool compress, const TextAttrib attrib) {
    wxLogTrace(className, wxT("ApplyChanges(const wxString lbl, bool compress, const TextAttrib attrib): Entering"));
    wxLogTrace(className, wxT("ApplyChanges(const wxString lbl, bool compress, const TextAttrib attrib): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::FormCreate() {
    wxLogTrace(className, wxT("FormCreate(): Entering"));
    wxLogTrace(className, wxT("FormCreate(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::FontNameChange() {
    wxLogTrace(className, wxT("FontNameChange(): Entering"));
    wxLogTrace(className, wxT("FontNameChange(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::FontSizeChange() {
    wxLogTrace(className, wxT("FontSizeChange(): Entering"));
    wxLogTrace(className, wxT("FontSizeChange(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::BoldButtonClick() {
    wxLogTrace(className, wxT("BoldButtonClick(): Entering"));
    wxLogTrace(className, wxT("BoldButtonClick(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::ItalicButtonClick() {
    wxLogTrace(className, wxT("ItalicButtonClick(): Entering"));
    wxLogTrace(className, wxT("ItalicButtonClick(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::UnderlineButtonClick() {
    wxLogTrace(className, wxT("UnderlineButtonClick(): Entering"));
    wxLogTrace(className, wxT("UnderlineButtonClick(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::AlignLeftButtonClick() {
    wxLogTrace(className, wxT("AlignLeftButtonClick(): Entering"));
    wxLogTrace(className, wxT("AlignLeftButtonClick(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::AlignCenterButtonClick() {
    wxLogTrace(className, wxT("AlignCenterButtonClick(): Entering"));
    wxLogTrace(className, wxT("AlignCenterButtonClick(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::AlignRightButtonClick() {
    wxLogTrace(className, wxT("AlignRightButtonClick(): Entering"));
    wxLogTrace(className, wxT("AlignRightButtonClick(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::CutMenuItemClick() {
    wxLogTrace(className, wxT("CutMenuItemClick(): Entering"));
    wxLogTrace(className, wxT("CutMenuItemClick(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::CopyMenuItemClick() {
    wxLogTrace(className, wxT("CopyMenuItemClick(): Entering"));
    wxLogTrace(className, wxT("CopyMenuItemClick(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::PasteMenuItemClick() {
    wxLogTrace(className, wxT("PasteMenuItemClick(): Entering"));
    wxLogTrace(className, wxT("PasteMenuItemClick(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::DeleteMenuItemClick() {
    wxLogTrace(className, wxT("DeleteMenuItemClick(): Entering"));
    wxLogTrace(className, wxT("DeleteMenuItemClick(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::CancelMenuItemClick() {
    wxLogTrace(className, wxT("CancelMenuItemClick(): Entering"));
    wxLogTrace(className, wxT("CancelMenuItemClick(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::TextContentEnter() {
    wxLogTrace(className, wxT("TextContentEnter(): Entering"));
    wxLogTrace(className, wxT("TextContentEnter(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::FormActivate() {
    wxLogTrace(className, wxT("FormActivate(): Entering"));
    wxLogTrace(className, wxT("FormActivate(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::FormShow() {
    wxLogTrace(className, wxT("FormShow(): Entering"));
    wxLogTrace(className, wxT("FormShow(): Exiting"));
}

///@todo Document this method
void ChooseFontDlg::TextContentChange() {
    wxLogTrace(className, wxT("TextContentChange(): Entering"));
    wxLogTrace(className, wxT("TextContentChange(): Exiting"));
}

ChooseFontDlg* choosefontdlg=NULL;
