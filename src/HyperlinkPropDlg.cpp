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
#include "HyperlinkPropDlg.h"

#include "Map.xpm"

static wxString className=wxT("HyperlinkPropDlg");

IMPLEMENT_DYNAMIC_CLASS(HyperlinkPropDlg, wxDialog)

BEGIN_EVENT_TABLE(HyperlinkPropDlg, wxDialog)
END_EVENT_TABLE()

/**
 * Normal constructor, simply calls the create function. Parameters are
 * identical to parameters for wxDialog::wxDialog()
 */
HyperlinkPropDlg::HyperlinkPropDlg(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    wxLogTrace(className, wxT("Entering HyperlinkPropDlg"));
    Create(parent, id, title, pos, size, style, name);
    wxLogTrace(className, wxT("Exiting HyperlinkPropDlg"));
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
bool HyperlinkPropDlg::Create(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    
    wxLogTrace(className, wxT("Entering Create"));

    wxLogTrace(className, wxT("Loading resource"));
    wxXmlResource::Get()->LoadDialog(this, GetParent(), wxT("dlgHyperlinkProps"));

    wxLogTrace(className, wxT("Constructing and setting icon"));
    SetIcon(wxICON(autorealm));

    wxLogTrace(className, wxT("Exiting Create"));
}

///@todo Document this method
void HyperlinkPropDlg::TextChange() {
    wxLogTrace(className, wxT("HyperlinkPropDlg::TextChange(): Entering"));
    wxLogTrace(className, wxT("HyperlinkPropDlg::TextChange(): Exiting"));
}

///@todo Document this method
void HyperlinkPropDlg::RadioClick() {
    wxLogTrace(className, wxT("HyperlinkPropDlg::RadioClick(): Entering"));
    wxLogTrace(className, wxT("HyperlinkPropDlg::RadioClick(): Exiting"));
}

///@todo Document this method
void HyperlinkPropDlg::CutMenuItemClick() {
    wxLogTrace(className, wxT("HyperlinkPropDlg::CutMenuItemClick(): Entering"));
    wxLogTrace(className, wxT("HyperlinkPropDlg::CutMenuItemClick(): Exiting"));
}

///@todo Document this method
void HyperlinkPropDlg::CopyMenuItemClick() {
    wxLogTrace(className, wxT("HyperlinkPropDlg::CopyMenuItemClick(): Entering"));
    wxLogTrace(className, wxT("HyperlinkPropDlg::CopyMenuItemClick(): Exiting"));
}

///@todo Document this method
void HyperlinkPropDlg::PasteMenuItemClick() {
    wxLogTrace(className, wxT("HyperlinkPropDlg::PasteMenuItemClick(): Entering"));
    wxLogTrace(className, wxT("HyperlinkPropDlg::PasteMenuItemClick(): Exiting"));
}

///@todo Document this method
void HyperlinkPropDlg::DeleteMenuItemClick() {
    wxLogTrace(className, wxT("HyperlinkPropDlg::DeleteMenuItemClick(): Entering"));
    wxLogTrace(className, wxT("HyperlinkPropDlg::DeleteMenuItemClick(): Exiting"));
}

///@todo Document this method
void HyperlinkPropDlg::CancelMenuItemClick() {
    wxLogTrace(className, wxT("HyperlinkPropDlg::CancelMenuItemClick(): Entering"));
    wxLogTrace(className, wxT("HyperlinkPropDlg::CancelMenuItemClick(): Exiting"));
}

///@todo Document this method
void HyperlinkPropDlg::ApplyChanges(const wxString lbl, bool compress, const TextAttrib attrib) {
    wxLogTrace(className, wxT("HyperlinkPropDlg::ApplyChanges(const wxString lbl, bool compress, const TextAttrib attrib): Entering"));
    wxLogTrace(className, wxT("HyperlinkPropDlg::ApplyChanges(const wxString lbl, bool compress, const TextAttrib attrib): Exiting"));
}

HyperlinkPropDlg* hyperlinkpropdlg=NULL;
