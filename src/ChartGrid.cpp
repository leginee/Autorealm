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
#include "ChartGrid.h"

#include "Map.xpm"

static wxString className=wxT("ChartGrid");

IMPLEMENT_DYNAMIC_CLASS(ChartGrid, wxDialog)

BEGIN_EVENT_TABLE(ChartGrid, wxDialog)
END_EVENT_TABLE()

/**
 * Normal constructor, simply calls the create function. Parameters are
 * identical to parameters for wxDialog::wxDialog()
 */
ChartGrid::ChartGrid(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    wxLogTrace(className, wxT("Entering ChartGrid::ChartGrid"));
    Create(parent, id, title, pos, size, style, name);
    wxLogTrace(className, wxT("Exiting ChartGrid::ChartGrid"));
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
bool ChartGrid::Create(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    
    wxLogTrace(className, wxT("Entering ChartGrid::Create"));

    wxLogTrace(className, wxT("Loading resource"));
    wxXmlResource::Get()->LoadDialog(this, GetParent(), wxT("dlgChartGrid"));

    wxLogTrace(className, wxT("Constructing and setting icon"));
    SetIcon(wxICON(autorealm));

    wxLogTrace(className, wxT("Exiting ChartGrid::Create"));
}

///@todo Document this method
void ChartGrid::Perimeter8Click() {
    wxLogTrace(className, wxT("Perimeter8Click(): Entering"));
    wxLogTrace(className, wxT("Perimeter8Click(): Exiting"));
}

///@todo Document this method
void ChartGrid::Perimeter16Click() {
    wxLogTrace(className, wxT("Perimeter16Click(): Entering"));
    wxLogTrace(className, wxT("Perimeter16Click(): Exiting"));
}

///@todo Document this method
void ChartGrid::Perimeter32Click() {
    wxLogTrace(className, wxT("Perimeter32Click(): Entering"));
    wxLogTrace(className, wxT("Perimeter32Click(): Exiting"));
}

///@todo Document this method
void ChartGrid::OtherChange() {
    wxLogTrace(className, wxT("OtherChange(): Entering"));
    wxLogTrace(className, wxT("OtherChange(): Exiting"));
}

///@todo Document this method
void ChartGrid::CropRosetteClick() {
    wxLogTrace(className, wxT("CropRosetteClick(): Entering"));
    wxLogTrace(className, wxT("CropRosetteClick(): Exiting"));
}

///@todo Document this method
void ChartGrid::PerimeterOtherClick() {
    wxLogTrace(className, wxT("PerimeterOtherClick(): Entering"));
    wxLogTrace(className, wxT("PerimeterOtherClick(): Exiting"));
}

///@todo Document this method
void ChartGrid::OtherKeyDown(wxKeyEvent& key) {
    wxLogTrace(className, wxT("OtherKeyDown(wxKeyEvent& key): Entering"));
    wxLogTrace(className, wxT("OtherKeyDown(wxKeyEvent& key): Exiting"));
}

///@todo Document this method
void ChartGrid::SetPerimeterPoints(int n) {
    wxLogTrace(className, wxT("SetPerimeterPoints(int n): Entering"));
    wxLogTrace(className, wxT("SetPerimeterPoints(int n): Exiting"));
}

ChartGrid* chartgrid=NULL;
