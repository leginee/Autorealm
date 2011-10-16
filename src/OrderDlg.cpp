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
#include "OrderDlg.h"

#include "Map.xpm"

static wxString className=wxT("OrderDlg");

IMPLEMENT_DYNAMIC_CLASS(OrderDlg, wxDialog)

BEGIN_EVENT_TABLE(OrderDlg, wxDialog)
END_EVENT_TABLE()

/**
 * Normal constructor, simply calls the create function. Parameters are
 * identical to parameters for wxDialog::wxDialog()
 */
OrderDlg::OrderDlg(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    wxLogTrace(className, wxT("Entering OrderDlg"));
    Create(parent, id, title, pos, size, style, name);
    wxLogTrace(className, wxT("Exiting OrderDlg"));
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
bool OrderDlg::Create(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    
    wxLogTrace(className, wxT("Entering Create"));

    wxLogTrace(className, wxT("Loading resource"));
    wxXmlResource::Get()->LoadDialog(this, GetParent(), wxT("dlgOrder"));

    wxLogTrace(className, wxT("Constructing and setting icon"));
    SetIcon(wxICON(autorealm));

    wxLogTrace(className, wxT("Exiting Create"));
}

OrderDlg* orderdlg=NULL;
