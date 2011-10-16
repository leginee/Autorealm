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
#include "MapSettingsDlg.h"

#include "Map.xpm"

static wxString className=wxT("MapSettingsDlg");

IMPLEMENT_DYNAMIC_CLASS(MapSettingsDlg, wxDialog)

BEGIN_EVENT_TABLE(MapSettingsDlg, wxDialog)
END_EVENT_TABLE()

/**
 * Normal constructor, simply calls the create function. Parameters are
 * identical to parameters for wxDialog::wxDialog()
 */
MapSettingsDlg::MapSettingsDlg(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    wxLogTrace(className, wxT("Entering MapSettingsDlg::MapSettingsDlg"));
    Create(parent, id, title, pos, size, style, name);
    wxLogTrace(className, wxT("Exiting MapSettingsDlg::MapSettingsDlg"));
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
bool MapSettingsDlg::Create(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    
    wxLogTrace(className, wxT("Entering MapSettingsDlg::Create"));

    wxLogTrace(className, wxT("Loading resource"));
    wxXmlResource::Get()->LoadDialog(this, GetParent(), wxT("dlgMapSettings"));

    wxLogTrace(className, wxT("Constructing and setting icon"));
    SetIcon(wxICON(autorealm));

    wxLogTrace(className, wxT("Exiting MapSettingsDlg::Create"));
}

///@todo Document this method
void MapSettingsDlg::SetGraphScale(int which, wxString text, double multiplier) {
    wxLogTrace(className, wxT("SetGraphScale(int which, wxString text, double multiplier): Entering"));
    wxLogTrace(className, wxT("SetGraphScale(int which, wxString text, double multiplier): Exiting"));
}

///@todo Document this method
void MapSettingsDlg::UnitComboBoxChange() {
    wxLogTrace(className, wxT("UnitComboBoxChange(): Entering"));
    wxLogTrace(className, wxT("UnitComboBoxChange(): Exiting"));
}

///@todo Document this method
void MapSettingsDlg::AEditChange() {
    wxLogTrace(className, wxT("AEditChange(): Entering"));
    wxLogTrace(className, wxT("AEditChange(): Exiting"));
}

///@todo Document this method
void MapSettingsDlg::BEditChange() {
    wxLogTrace(className, wxT("BEditChange(): Entering"));
    wxLogTrace(className, wxT("BEditChange(): Exiting"));
}

///@todo Document this method
void MapSettingsDlg::CEditChange() {
    wxLogTrace(className, wxT("CEditChange(): Entering"));
    wxLogTrace(className, wxT("CEditChange(): Exiting"));
}

///@todo Document this method
void MapSettingsDlg::FormCreate() {
    wxLogTrace(className, wxT("FormCreate(): Entering"));
    wxLogTrace(className, wxT("FormCreate(): Exiting"));
}

///@todo Document this method
void MapSettingsDlg::FormShow() {
    wxLogTrace(className, wxT("FormShow(): Entering"));
    wxLogTrace(className, wxT("FormShow(): Exiting"));
}

///@todo Document this method
void MapSettingsDlg::GridOnTopClick() {
    wxLogTrace(className, wxT("GridOnTopClick(): Entering"));
    wxLogTrace(className, wxT("GridOnTopClick(): Exiting"));
}

///@todo Document this method
void MapSettingsDlg::FormClose() {
    wxLogTrace(className, wxT("FormClose(): Entering"));
    wxLogTrace(className, wxT("FormClose(): Exiting"));
}

///@todo Document this method
void MapSettingsDlg::CommentsChange() {
    wxLogTrace(className, wxT("CommentsChange(): Entering"));
    wxLogTrace(className, wxT("CommentsChange(): Exiting"));
}

///@todo Document this method
long MapSettingsDlg::StrToCardinals(wxString s) {
    wxLogTrace(className, wxT("StrToCardinals(wxString s): Entering"));
    wxLogTrace(className, wxT("StrToCardinals(wxString s): Exiting"));
}

MapSettingsDlg* mapsettingsdlg=NULL;
