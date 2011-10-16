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
#include "clkStaticBitmap.h"

static wxString className=wxT("clkStaticBitmap");

IMPLEMENT_DYNAMIC_CLASS(clkStaticBitmap, wxStaticBitmap)

BEGIN_EVENT_TABLE(clkStaticBitmap, wxStaticBitmap)
    EVT_LEFT_UP(clkStaticBitmap::OnSingleClick)
    EVT_LEFT_DCLICK(clkStaticBitmap::OnDoubleClick)
END_EVENT_TABLE()

/**
 * The constructor for our clickable wxStaticBitmap is here. All it does,
 * really, is call the Create() function from the wxStaticBitmap class.
 * 
 * Parameters are identical to the constructor for wxStaticBitmap
 */
clkStaticBitmap::clkStaticBitmap(wxWindow *parent, wxWindowID id, const wxBitmap& label,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    wxLogTrace(className, wxT("Entering clkStaticBitmap"));
    Create(parent, id, label, pos, size, style, name);
    wxLogTrace(className, wxT("Exiting clkStaticBitmap"));
}

/**
 * This method just passes a left single click up the event
 * propagation tree
 *
 * @param evt wxMouseEvent An event which is just passed up the
 * event propagation tree.
 */
void clkStaticBitmap::OnSingleClick(wxMouseEvent& evt) {
    evt.SetId(GetId());
    GetParent()->ProcessEvent(evt);
}

/**
 * This method just passes a left double click up the event
 * propagation tree
 *
 * @param evt wxMouseEvent An event which is just passed up the
 * event propagation tree.
 */
void clkStaticBitmap::OnDoubleClick(wxMouseEvent& evt) {
    evt.SetId(GetId());
    GetParent()->ProcessEvent(evt);
}
