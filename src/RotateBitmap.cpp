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
#include <wx/image.h>
#include <math.h>

#include "types.h"
#include "RotateBitmap.h"
#include "Map.xpm"

static wxString className=wxT("RotateBitmap");

IMPLEMENT_DYNAMIC_CLASS(RotateBitmap, wxDialog)

BEGIN_EVENT_TABLE(RotateBitmap, wxDialog)
        EVT_BUTTON(XRCID("btnPlusFive"), RotateBitmap::OnPlusFive)
        EVT_BUTTON(XRCID("btnPlusOne"), RotateBitmap::OnPlusOne)
        EVT_BUTTON(XRCID("btnMinusOne"), RotateBitmap::OnMinusOne)
        EVT_BUTTON(XRCID("btnMinusFive"), RotateBitmap::OnMinusFive)
        EVT_SPINCTRL(XRCID("spnDegree"), RotateBitmap::OnSpinChange)
END_EVENT_TABLE()

/**
 * Normal constructor, simply calls the create function. Parameters are
 * identical to parameters for wxDialog::wxDialog()
 */
RotateBitmap::RotateBitmap(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    wxLogTrace(className, wxT("Entering RotateBitmap"));
    Create(parent, id, title, pos, size, style, name);
    wxLogTrace(className, wxT("Exiting RotateBitmap"));
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
bool RotateBitmap::Create(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    
    wxLogTrace(className, wxT("Entering Create"));

    outside = NULL;
    wxStaticBitmap* winbmp;

    wxLogTrace(className, wxT("Loading resource"));
    wxXmlResource::Get()->LoadDialog(this, GetParent(), wxT("dlgRotate"));

    wxLogTrace(className, wxT("Locating standard heading picture"));
    winbmp = (wxStaticBitmap*)FindWindowByName(wxT("bmpRotatePicture"));

    wxLogTrace(className, wxT("Finding degrees spin control"));
    wxSpinCtrl* ctrl = (wxSpinCtrl*)FindWindowByName(wxT("spnDegree"), this);

    wxLogTrace(className, wxT("Setting default heading"));
    ctrl->SetValue(0);

    wxLogTrace(className, wxT("Drawing due north heading"));
    RotatePic(0);

    wxLogTrace(className, wxT("Constructing and setting icon"));
    SetIcon(wxICON(autorealm));

    wxLogTrace(className, wxT("Exiting Create"));
}

/**
 * Destructor, cleans up after window is closed and being Destroy()'ed.
 * At this time, just makes sure to free up memory used by the wxImage
 * for the background, but may do more in future.
 */
RotateBitmap::~RotateBitmap() {
    try {
        delete outside;
    }
    catch (...) {
    }
}

/**
 * sets the current selected bitmap using a passed in bitmap, allowing the
 * user to get a better preview of what the output will look like once the
 * rotation is complete.
 *
 * @param inbmp wxBitmap a bitmap to be rotated
 */
void RotateBitmap::setBackgroundBitmap(wxBitmap inbmp) {
    wxLogTrace(className, wxT("Entering setBackgroundBitmap"));
    if (outside != NULL) {
        wxLogTrace(className, wxT("Deleting old bitmap"));
        delete outside;
        outside = NULL;
    }
    wxLogTrace(className, wxT("Setting outside to inbmp"));
    outside = new wxImage(inbmp.ConvertToImage());
    wxLogTrace(className, wxT("Rescaling the image"));
    outside->Rescale(90,90);

    wxLogTrace(className, wxT("Redrawing image"));
    RotatePic(prevheading);

    wxLogTrace(className, wxT("Exiting setBackgroundBitmap"));
}

/**
 * When the "-5" button is pressed, this handler is called. It decrements
 * the heading by 5, and redraws the picture.
 *
 * @param evt wxCommandEvent UNUSED
 */
void RotateBitmap::OnMinusFive(wxCommandEvent& evt) {
    wxLogTrace(className, wxT("Entering OnMinusFive"));
    int degrees, min, max;
    wxSpinCtrl *ctrl;

    wxLogTrace(className, wxT("Finding degrees spin control"));
    ctrl = (wxSpinCtrl*)FindWindowByName(wxT("spnDegree"), this);

    wxLogTrace(className, wxT("Getting current degrees"));
    degrees = ctrl->GetValue();

    wxLogTrace(className, wxT("Getting current range"));
    min = ctrl->GetMin();
    max = ctrl->GetMax();

    degrees += -5;
    if (degrees < min) {
        degrees = min;
    }
    if (degrees > max) {
        degrees = max;
    }
    
    wxLogTrace(className, wxT("Setting degrees to %d"), degrees);
    if (degrees != prevheading) {
        ctrl->SetValue(degrees);
        RotatePic(degrees);
    }
    wxLogTrace(className, wxT("Exiting OnMinusFive"));
}

/**
 * When the "-1" button is pressed, this handler is called. It decrements
 * the heading by 1, and redraws the picture.
 *
 * @param evt wxCommandEvent UNUSED
 */
void RotateBitmap::OnMinusOne(wxCommandEvent& evt) {
    wxLogTrace(className, wxT("Entering OnMinusOne"));
    int degrees, min, max;
    wxSpinCtrl *ctrl;

    wxLogTrace(className, wxT("Finding degrees spin control"));
    ctrl = (wxSpinCtrl*)FindWindowByName(wxT("spnDegree"), this);

    wxLogTrace(className, wxT("Getting current degrees"));
    degrees = ctrl->GetValue();

    wxLogTrace(className, wxT("Getting current range"));
    min = ctrl->GetMin();
    max = ctrl->GetMax();

    degrees += -1;
    if (degrees < min) {
        degrees = min;
    }
    if (degrees > max) {
        degrees = max;
    }
    
    wxLogTrace(className, wxT("Setting degrees to %d"), degrees);
    if (degrees != prevheading) {
        ctrl->SetValue(degrees);
        RotatePic(degrees);
    }
    wxLogTrace(className, wxT("Exiting OnMinusOne"));
}

/**
 * When the "+1" button is pressed, this handler is called. It increments
 * the heading by 1, and redraws the picture.
 *
 * @param evt wxCommandEvent UNUSED
 */
void RotateBitmap::OnPlusOne(wxCommandEvent& evt) {
    wxLogTrace(className, wxT("Entering OnPlusOne"));
    int degrees, min, max;
    wxSpinCtrl *ctrl;

    wxLogTrace(className, wxT("Finding degrees spin control"));
    ctrl = (wxSpinCtrl*)FindWindowByName(wxT("spnDegree"), this);

    wxLogTrace(className, wxT("Getting current degrees"));
    degrees = ctrl->GetValue();

    wxLogTrace(className, wxT("Getting current range"));
    min = ctrl->GetMin();
    max = ctrl->GetMax();

    degrees += 1;
    if (degrees < min) {
        degrees = min;
    }
    if (degrees > max) {
        degrees = max;
    }
    
    wxLogTrace(className, wxT("Setting degrees to %d"), degrees);
    if (degrees != prevheading) {
        ctrl->SetValue(degrees);
        RotatePic(degrees);
    }
    wxLogTrace(className, wxT("Exiting OnPlusOne"));
}

/**
 * When the "+5" button is pressed, this handler is called. It increments
 * the heading by 5, and redraws the picture.
 *
 * @param evt wxCommandEvent UNUSED
 */
void RotateBitmap::OnPlusFive(wxCommandEvent& evt) {
    wxLogTrace(className, wxT("Entering OnPlusFive"));
    int degrees, min, max;
    wxSpinCtrl *ctrl;

    wxLogTrace(className, wxT("Finding degrees spin control"));
    ctrl = (wxSpinCtrl*)FindWindowByName(wxT("spnDegree"), this);

    wxLogTrace(className, wxT("Getting current degrees"));
    degrees = ctrl->GetValue();

    wxLogTrace(className, wxT("Getting current range"));
    min = ctrl->GetMin();
    max = ctrl->GetMax();

    degrees += 5;
    if (degrees < min) {
        degrees = min;
    }
    if (degrees > max) {
        degrees = max;
    }
    
    wxLogTrace(className, wxT("Setting degrees to %d"), degrees);
    if (degrees != prevheading) {
        ctrl->SetValue(degrees);
        RotatePic(degrees);
    }
    wxLogTrace(className, wxT("Exiting OnPlusFive"));
}

/**
 * This routine is called whenever the value in the spin control is updated,
 * either by the user typing (and then exiting the control), or by way of the
 * associated spin buttons. It reads the value in the control, and then
 * redraws the picture with the new heading.
 *
 * @param evt wxSpinEvent UNUSED
 */
void RotateBitmap::OnSpinChange(wxSpinEvent& evt) {
    wxLogTrace(className, wxT("Entering OnSpinChange"));
    int degrees, min, max;
    wxSpinCtrl *ctrl;

    wxLogTrace(className, wxT("Finding degrees spin control"));
    ctrl = (wxSpinCtrl*)FindWindowByName(wxT("spnDegree"), this);

    wxLogTrace(className, wxT("Getting current degrees"));
    degrees = ctrl->GetValue();

    wxLogTrace(className, wxT("Getting current range"));
    min = ctrl->GetMin();
    max = ctrl->GetMax();

    if (degrees < min) {
        degrees = min;
    }
    if (degrees > max) {
        degrees = max;
    }
    
    if (degrees != prevheading) {
        RotatePic(degrees);
    }
    wxLogTrace(className, wxT("Exiting OnSpinChange"));
}

/**
 * This routine redraws the compass rose, and the picture passed in, showing
 * the user how it would look when the picture is actually rotated.
 *
 * @param degrees int how many degrees to rotate the picture.
 */
void RotateBitmap::RotatePic(int degrees) {
    wxLogTrace(className, wxT("Entering RotatePic"));
    wxStaticBitmap* winbmp;
    wxBitmap blank;
    int width, height, depth;
    double outerrad=85.0, innerrad=75.0;
    
    wxLogTrace(className, wxT("Locating standard heading picture"));
    winbmp = (wxStaticBitmap*)FindWindowByName(wxT("bmpRotatePicture"));

    wxLogTrace(className, wxT("Getting image information"));
    if (winbmp->GetBitmap() != wxNullBitmap) {
        width = winbmp->GetBitmap().GetWidth();
        height = winbmp->GetBitmap().GetHeight();
        depth = winbmp->GetBitmap().GetDepth();
    } else {
        width=180;
        height=180;
        depth=-1;
    }
    
    wxLogTrace(className, wxT("Engaging missing constructor for blank wxStaticBitmap"));
    blank.Create(width, height, depth);

    wxLogTrace(className, wxT("Beginning drawing routine"));
    wxMemoryDC dc;
    dc.SelectObject(blank);

    wxLogTrace(className, wxT("Clearing out bitmap"));
    dc.SetBrush(*wxTRANSPARENT_BRUSH);
    dc.Clear();
    
    wxLogTrace(className, wxT("Drawing user supplied bitmap"));
    if ((outside != NULL) && (outside->Ok())) {
        wxLogTrace(className, wxT("Rotating it"));
        wxImage rotated(outside->Rotate(rad*degrees, wxPoint(45,45), false));
        wxLogTrace(className, wxT("Rescaling it"));
        rotated.Rescale(90,90);
        wxLogTrace(className, wxT("Placing it"));
        dc.DrawBitmap(wxBitmap(rotated), 45, 45, false);
    }

    wxLogTrace(className, wxT("Setting 0 to point due north by adding 90 degrees to what is passed in"));
    degrees -= 90;

    wxLogTrace(className, wxT("Setting up pen"));
    wxPen blackpen(wxColour(0,0,0), 3);

    wxLogTrace(className, wxT("Selecting pen into dc"));
    dc.SetPen(blackpen);

    wxLogTrace(className, wxT("Drawing outer boundary"));
    dc.DrawCircle(wxPoint(90,90), (int)outerrad);

    wxLogTrace(className, wxT("Drawing inner boundary"));
    dc.DrawCircle(wxPoint(90,90), (int)innerrad);

    wxLogTrace(className, wxT("Drawing markers"));
    int i;
    int x1, y1, x2, y2;
    for (i=0; i<360; i+=15) {
        x1 = (int)(outerrad * cos(rad * (double)i)) + 90;
        x2 = (int)(innerrad * cos(rad * (double)i)) + 90;
        y1 = (int)(outerrad * sin(rad * (double)i)) + 90;
        y2 = (int)(innerrad * sin(rad * (double)i)) + 90;
        dc.DrawLine(x1,y1,x2,y2);
    }
    
    wxLogTrace(className, wxT("Drawing arrow"));
    wxPen redpen(wxColour(255,0,0), 3);
    dc.SetPen(redpen);
    x1=90; y1=90;
    x2=(int)(40.0 * cos(rad * (double)degrees)) + 90;
    y2=(int)(40.0 * sin(rad * (double)degrees)) + 90;
    dc.DrawLine(x1,y1,x2,y2);
    wxLogTrace(className, wxT("Closing out dc"));
    dc.SelectObject(wxNullBitmap);

    wxLogTrace(className, wxT("Setting new background bitmap"));
    winbmp->SetBitmap(blank);

    wxLogTrace(className, wxT("Setting prevheading"));
    prevheading = degrees + 90;

    wxLogTrace(className, wxT("Exiting RotatePic"));
}

/**
 * This routine is used by any routines which present this rotation box
 * to allow them to find out what the user chose for the rotation.
 *
 * @return int How many degrees to rotate the item.
 */
int RotateBitmap::GetHeading() {
    return prevheading;
}

RotateBitmap* rotatebitmap=NULL;
