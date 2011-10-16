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
#include <wx/xrc/xmlres.h>

#include "FillPattern.h"
#include "clkStaticBitmap.h"
#include "Map.xpm"

static wxString className=wxT("FillPattern");

IMPLEMENT_DYNAMIC_CLASS(FillPattern, wxDialog)

BEGIN_EVENT_TABLE(FillPattern, wxDialog)
    EVT_LEFT_UP(FillPattern::OnSelectPattern)
    EVT_LEFT_DCLICK(FillPattern::OnChangePattern)
END_EVENT_TABLE()

/**
 * Normal constructor, simply calls the create function. Parameters are
 * identical to parameters for wxDialog::wxDialog()
 */
FillPattern::FillPattern(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    wxLogTrace(className, wxT("Entering FillPattern"));
    Create(parent, id, title, pos, size, style, name);
    wxLogTrace(className, wxT("Exiting FillPattern"));
}

/**
 * This routine is responsible for initializing the dialog window for fill
 * patterns. It loads up the xrc resource, and makes sure all is ready for
 * first onscreen display. For a blow-by-blow, read the wxLogTrace
 * statements in the code.
 * 
 * Parameters are identical to wxDialog::Create()
 *
 * @return Required by Create(), but unused
 */
bool FillPattern::Create(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    
    wxLogTrace(className, wxT("Entering Create"));

    wxStaticBitmap* temp;
    wxStaticBitmap* bmp;
    wxString selected;

    wxLogTrace(className, wxT("Setting up selected"));
    selected.Printf(wxT("fill-00"));

    wxLogTrace(className, wxT("Loading resource"));
    wxXmlResource::Get()->LoadDialog(this, GetParent(), wxT("dlgFillPattern"));

    wxLogTrace(className, wxT("Finding current window and selection display window"));
    temp = (wxStaticBitmap*)FindWindowByName(selected);
    bmp = (wxStaticBitmap*)FindWindowByName(wxT("bmpCurrPattern"));

    wxLogTrace(className, wxT("Putting currently selected graphic into display window"));
    setCurrentBitmap(selected);

    prevbmp=temp->GetBitmap();

    wxLogTrace(className, wxT("Constructing and setting icon"));
    SetIcon(wxICON(autorealm));

    wxLogTrace(className, wxT("Exiting Create"));
}

/**
 * Override of OnCancel to return to the previous bitmap pattern
 *
 * @param evt UNUSED
 */
void FillPattern::OnCancel(wxCommandEvent& evt) {
    wxLogTrace(className, wxT("Entering OnCancel"));

    wxLogTrace(className, wxT("Reverting to previously selected graphic"));
    setCurrentBitmap(prevbmp);

    wxLogTrace(className, wxT("Closing FillPattern Dialog"));
    EndModal(wxID_CANCEL);
    wxLogTrace(className, wxT("Exiting OnCancel"));
}

/**
 * This routine determines which bitmap was clicked, and notes it for
 * future reference (when either it is double-clicked, or when the ok
 * button is clicked).
 *
 * @param evt wxMouseEvent Used to indicate the wxStaticBitmap in which
 * the user clicked.
 */
void FillPattern::OnSelectPattern(wxMouseEvent& evt) {
    wxLogTrace(className, wxT("Entering OnSelectPattern"));
    wxStaticBitmap* bmp;
    wxStaticBitmap* fill;
    wxStaticBitmap* temp;
    wxString bmpname, tmps;
    int x, y;

    wxLogTrace(className, wxT("Setting up variables"));
    fill = (wxStaticBitmap*) FindWindowById(evt.GetId());
    bmpname = wxT("");
    
    wxLogTrace(className, wxT("Found Window Name: %s"), fill->GetName().c_str());
    if ((fill != NULL) and (fill->GetName().StartsWith(wxT("fill-")) != 0)) {
        wxLogTrace(className, wxT("Found matching bitmap: %s"), fill->GetName().c_str());
        setCurrentBitmap(fill->GetBitmap());
        Layout();
    }
    wxLogTrace(className, wxT("Exiting OnSelectPattern"));
}

/**
 * This routine determines which bitmap was clicked, and notes it for
 * future reference (when either it is double-clicked, or when the ok
 * button is clicked).
 *
 * @param evt wxMouseEvent Used to indicate the wxStaticBitmap in which
 * the user clicked.
 */
void FillPattern::OnChangePattern(wxMouseEvent& evt) {
    wxLogTrace(className, wxT("Entering OnChangePattern"));
    wxStaticBitmap* fill;
    OnSelectPattern(evt);
    fill = (wxStaticBitmap*) FindWindowById(evt.GetId());
    if ((fill != NULL) and (fill->GetName().StartsWith(wxT("fill-")) != 0)) {
        EndModal(wxID_OK);
    }
    wxLogTrace(className, wxT("Exiting OnChangePattern"));
}

/**
 * This routine takes a bitmap in, sets the default to it, and returns
 * control to the caller.
 *
 * @param inbmp wxBitmap a wxBitmap which will be used as the default
 * choice for the fill pattern.
 */
void FillPattern::setCurrentBitmap(wxBitmap inbmp) {
    wxLogTrace(className, wxT("Entering setCurrentBitmap"));
    wxStaticBitmap* bmp;
    wxWindow* win;

    wxLogTrace(className, wxT("Locating current bmp window"));
    win = FindWindowByName(wxT("bmpCurrPattern"));
    if ((win != NULL) && (win->IsKindOf(CLASSINFO(clkStaticBitmap)))) {
        bmp = (wxStaticBitmap*)win;
        bmp->ClearBackground();

        wxLogTrace(className, wxT("Copying bitmap over"));
        bmp->SetBitmap(inbmp);

        wxLogTrace(className, wxT("Resizing images"));
        Layout();
    }

    wxLogTrace(className, wxT("Exiting setCurrentBitmap"));
}

/**
 * @brief sets the current selected bitmap used a string
 * resource name
 *
 * @param resName wxString the name of an xrc resource which will be
 * found and used for the current bitmap
 */
void FillPattern::setCurrentBitmap(wxString resName) {
    wxLogTrace(className, wxT("Entering setCurrentBitmap"));
    wxWindow* win;
    wxStaticBitmap* bmp;

    wxLogTrace(className, wxT("Locating window"));
    win = FindWindowByName(resName);
    
    if ((win != NULL) && (win->IsKindOf(CLASSINFO(wxStaticBitmap)))) {
        wxLogTrace(className, wxT("Found control, and is bitmap. Setting..."));
        bmp = (wxStaticBitmap*)win;
        setCurrentBitmap(bmp->GetBitmap());
    }
    wxLogTrace(className, wxT("Exiting setCurrentBitmap"));
}

/**
 * @brief sets the current selected bitmap used a string
 * resource name
 *
 * @param patternnum int the number of an xrc resource which will be
 * found and used for the current bitmap
 */
void FillPattern::setCurrentBitmap(int patternnum) {
    wxLogTrace(className, wxT("Entering setCurrentBitmap"));
    wxString resName;
    resName.Printf(wxT("fill-%02d"), patternnum);
    wxLogTrace(className, wxT("Setting fill pattern to %s"), resName.c_str());
    setCurrentBitmap(resName);
    wxLogTrace(className, wxT("Exiting setCurrentBitmap"));
}

/**
 * This routine returns a copy of the currently selected bitmap to be
 * used for the current fill pattern.
 *
 * @return wxBitmap this is the bitmap which has been selected by the user.
 */
wxBitmap FillPattern::getCurrentBitmap() {
    wxLogTrace(className, wxT("Entering getCurrentBitmap"));
    wxStaticBitmap* bmp = (wxStaticBitmap*)FindWindowByName(wxT("bmpCurrPattern"));
    return (bmp->GetBitmap());
    wxLogTrace(className, wxT("Exiting getCurrentBitmap"));
}

FillPattern* fillpattern=NULL;
