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
#include <wx/colordlg.h>
#include <wx/xrc/xmlres.h>

#include "versioninfo.h"

#include "MainWin.h"
#include "FillPattern.h"
#include "RotateBitmap.h"
#include "AlignDlg.h"
#include "Map.xpm"

static wxString className=wxT("MainWin");

IMPLEMENT_DYNAMIC_CLASS(MainWin, wxFrame)

BEGIN_EVENT_TABLE(MainWin, wxFrame)
    EVT_CLOSE(MainWin::OnClose)
    EVT_BUTTON(XRCID("btnToolSelect"), MainWin::OnToolSelect)
    EVT_BUTTON(XRCID("btnToolOpen"), MainWin::OnToolOpen)
    EVT_BUTTON(XRCID("btnToolSave"), MainWin::OnToolSave)
    EVT_BUTTON(XRCID("btnToolPan"), MainWin::OnToolPan)
    EVT_BUTTON(XRCID("btnToolRuler"), MainWin::OnToolRuler)
    EVT_BUTTON(XRCID("btnToolMeasurementString"), MainWin::OnToolMeasurementString)
    EVT_BUTTON(XRCID("btnToolRepaint"), MainWin::OnToolRepaint)
    EVT_BUTTON(XRCID("btnToolUndo"), MainWin::OnToolUndo)
    EVT_BUTTON(XRCID("btnToolRedo"), MainWin::OnToolRedo)
    EVT_BUTTON(XRCID("btnToolReadOnly"), MainWin::OnToolReadOnly)
    EVT_BUTTON(XRCID("btnToolFreehand"), MainWin::OnToolFreehand)
    EVT_BUTTON(XRCID("btnToolLine"), MainWin::OnToolLine)
    EVT_BUTTON(XRCID("btnToolPolyline"), MainWin::OnToolPolyline)
    EVT_BUTTON(XRCID("btnToolCurve"), MainWin::OnToolCurve)
    EVT_BUTTON(XRCID("btnToolPolycurve"), MainWin::OnToolPolycurve)
    EVT_BUTTON(XRCID("btnToolMainColor"), MainWin::OnToolMainColor)
    EVT_BUTTON(XRCID("btnToolFillColor"), MainWin::OnToolFillColor)
    EVT_BUTTON(XRCID("btnToolFillPattern"), MainWin::OnToolFillPattern)
    EVT_BUTTON(XRCID("btnToolOutlineColor"), MainWin::OnToolOutlineColor)
    EVT_BUTTON(XRCID("btnToolBackgroundColor"), MainWin::OnToolBackgroundColor)
    EVT_BUTTON(XRCID("btnToolGridColor"), MainWin::OnToolGridColor)
    EVT_BUTTON(XRCID("btnToolShowColorTranslationManager"), MainWin::OnToolShowColorTranslationManager)
    EVT_BUTTON(XRCID("btnToolTranslateColor"), MainWin::OnToolTranslateColor)
    EVT_BUTTON(XRCID("btnToolInverseTranslateColor"), MainWin::OnToolInverseTranslateColor)
    EVT_BUTTON(XRCID("btnToolRectangle"), MainWin::OnToolRectangle)
    EVT_BUTTON(XRCID("btnToolCircle"), MainWin::OnToolCircle)
    EVT_BUTTON(XRCID("btnToolPolygon"), MainWin::OnToolPolygon)
    EVT_BUTTON(XRCID("btnToolArc"), MainWin::OnToolArc)
    EVT_BUTTON(XRCID("btnToolRosetteChartLines"), MainWin::OnToolRosetteChartLines)
    EVT_BUTTON(XRCID("btnToolText"), MainWin::OnToolText)
    EVT_BUTTON(XRCID("btnToolCurvedText"), MainWin::OnToolCurvedText)
    EVT_BUTTON(XRCID("btnToolHyperlinkPopup"), MainWin::OnToolHyperlinkPopup)
    EVT_BUTTON(XRCID("btnToolGroup"), MainWin::OnToolGroup)
    EVT_BUTTON(XRCID("btnToolUngroup"), MainWin::OnToolUngroup)
    EVT_BUTTON(XRCID("btnToolDecompose"), MainWin::OnToolDecompose)
    EVT_BUTTON(XRCID("btnToolFracFreehand"), MainWin::OnToolFracFreehand)
    EVT_BUTTON(XRCID("btnToolFracLine"), MainWin::OnToolFracLine)
    EVT_BUTTON(XRCID("btnToolFracPolyline"), MainWin::OnToolFracPolyline)
    EVT_BUTTON(XRCID("btnToolFracCurve"), MainWin::OnToolFracCurve)
    EVT_BUTTON(XRCID("btnToolFracPolycurve"), MainWin::OnToolFracPolycurve)
    EVT_BUTTON(XRCID("btnToolAlign"), MainWin::OnToolAlign)
    EVT_BUTTON(XRCID("btnToolFlip"), MainWin::OnToolFlip)
    EVT_BUTTON(XRCID("btnToolSkew"), MainWin::OnToolSkew)
    EVT_BUTTON(XRCID("btnToolRotate"), MainWin::OnToolRotate)
    EVT_BUTTON(XRCID("btnToolScale"), MainWin::OnToolScale)
    EVT_BUTTON(XRCID("btnToolMove"), MainWin::OnToolMove)
    EVT_BUTTON(XRCID("btnToolRotate90"), MainWin::OnToolRotate90)
    EVT_BUTTON(XRCID("btnToolRotate45"), MainWin::OnToolRotate45)
    EVT_BUTTON(XRCID("btnToolArray"), MainWin::OnToolArray)
    EVT_BUTTON(XRCID("btnToolOrder"), MainWin::OnToolOrder)
    EVT_BUTTON(XRCID("btnToolToggleOverlayTags"), MainWin::OnToolToggleOverlayTags)
    EVT_BUTTON(XRCID("btnToolToggleDesignGrid"), MainWin::OnToolToggleDesignGrid)
    EVT_BUTTON(XRCID("btnToolToggleGravitySnap"), MainWin::OnToolToggleGravitySnap)
    EVT_BUTTON(XRCID("btnToolToggleGridSnap"), MainWin::OnToolToggleGridSnap)
    EVT_BUTTON(XRCID("btnToolToggleGravitySnapAlongLinesAndCurves"), MainWin::OnToolToggleGravitySnapAlongLinesAndCurves)
    EVT_BUTTON(XRCID("btnToolRotateSnappedObjects"), MainWin::OnToolRotateSnappedObjects)
    EVT_BUTTON(XRCID("btnToolSendToBack"), MainWin::OnToolSendToBack)
    EVT_BUTTON(XRCID("btnToolSendBackward"), MainWin::OnToolSendBackward)
    EVT_BUTTON(XRCID("btnToolBringForward"), MainWin::OnToolBringForward)
    EVT_BUTTON(XRCID("btnToolBringToFront"), MainWin::OnToolBringToFront)
    EVT_BUTTON(XRCID("btnToolPaste"), MainWin::OnToolPaste)
    EVT_BUTTON(XRCID("btnToolCopy"), MainWin::OnToolCopy)
    EVT_BUTTON(XRCID("btnToolCut"), MainWin::OnToolCut)
    EVT_BUTTON(XRCID("btnToolDelete"), MainWin::OnToolDelete)
    EVT_BUTTON(XRCID("btnToolScalpel"), MainWin::OnToolScalpel)
    EVT_BUTTON(XRCID("btnToolGlue"), MainWin::OnToolGlue)
    EVT_BUTTON(XRCID("btnToolSingleIcon"), MainWin::OnToolSingleIcon)
    EVT_BUTTON(XRCID("btnToolSquarePlacement"), MainWin::OnToolSquarePlacement)
    EVT_BUTTON(XRCID("btnToolDiamondPlacement"), MainWin::OnToolDiamondPlacement)
    EVT_BUTTON(XRCID("btnToolRandomPlacement"), MainWin::OnToolRandomPlacement)
    EVT_BUTTON(XRCID("btnToolDefineSelectionAsSymbol"), MainWin::OnToolDefineSelectionAsSymbol)
    EVT_BUTTON(XRCID("btnToolSymbolLibrary"), MainWin::OnToolSymbolLibrary)
    EVT_BUTTON(XRCID("btnToolGraphNone"), MainWin::OnToolGraphNone)
    EVT_BUTTON(XRCID("btnToolGraphSquare"), MainWin::OnToolGraphSquare)
    EVT_BUTTON(XRCID("btnToolGraphHex"), MainWin::OnToolGraphHex)
    EVT_BUTTON(XRCID("btnToolGraphRHex"), MainWin::OnToolGraphRHex)
    EVT_BUTTON(XRCID("btnToolGraphTriangle"), MainWin::OnToolGraphTriangle)
    EVT_BUTTON(XRCID("btnToolGraphDiamond"), MainWin::OnToolGraphDiamond)
    EVT_BUTTON(XRCID("btnToolGraphHDiamond"), MainWin::OnToolGraphHDiamond)
    EVT_BUTTON(XRCID("btnToolGraphCircle"), MainWin::OnToolGraphCircle)
    EVT_CHOICE(XRCID("cbToolBeginLineStyle"), MainWin::OnToolBeginLineStyle)
    EVT_CHOICE(XRCID("cbToolLineStyle"), MainWin::OnToolLineStyle)
    EVT_CHOICE(XRCID("cbToolEndLineStyle"), MainWin::OnToolEndLineStyle)
    EVT_CHOICE(XRCID("cbOverlay"), MainWin::OnOverlayChange)
    EVT_CHOICE(XRCID("chPriGridStyle"), MainWin::OnPriGridStyleChange)
    EVT_CHOICE(XRCID("chSecGridStyle"), MainWin::OnSecGridStyleChange)
    EVT_COMBOBOX(XRCID("cbToolZoom"), MainWin::OnToolZoom)
    EVT_TEXT(XRCID("txtXSize"), MainWin::OnTxtXSizeChange)
    EVT_TEXT(XRCID("txtYSize"), MainWin::OnTxtYSizeChange)
    EVT_TEXT(XRCID("spnFracSeed"), MainWin::OnSeedText)
    EVT_TEXT(XRCID("txtGridSize"), MainWin::OnGridSizeChange)
    EVT_TEXT(XRCID("spnBoldUnit"), MainWin::OnTxtBoldUnitChange)
    EVT_CHECKBOX(XRCID("chAspect"), MainWin::OnAspectChange)
    EVT_CHECKLISTBOX(XRCID("clPushpinList"), MainWin::OnPushpinChange)
    EVT_CHECKLISTBOX(XRCID("clOverlayList"), MainWin::OnOverlayListChange)
    EVT_SPINCTRL(XRCID("spnFracSeed"), MainWin::OnSeedSpin)
    EVT_SPINCTRL(XRCID("spnBoldUnit"), MainWin::OnBoldUnitChange)
    EVT_MENU(XRCID("mnuFileExit"), MainWin::FileExit)
    EVT_MENU(XRCID("mnuHelpAbout"), MainWin::HelpAbout)
END_EVENT_TABLE()

//GLOBALS
wxColour CurrentColor(wxNullColour), CurrentFillColor(wxNullColour);
MainWin* glbMainWin=NULL;

/**
 * Generally speaking, this will be used in code of the following form:
 *
 * @code
 * mainwin = new MainWin(NULL, XRCID("frmMain"), wxT("frmMain"));
 * @endcode
 */
MainWin::MainWin(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos, const wxSize& size, long style, const wxString& name ) {
    wxLogTrace(className, wxT("Entering MainWin(verbose constructor)"));
    Create(parent, id, title, pos, size, style, name);
    wxLogTrace(className, wxT("Exiting MainWin(verbose constructor)"));
}

/**
 * Generally speaking, this will be used in code of the following form:
 *
 * @code
 * mainwin->Create(NULL, XRCID("frmMain"), wxT("frmMain"));
 * @endcode
 *
 * @return required by wxWidgets, but ignored
 */
bool MainWin::Create(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    wxLogTrace(className, wxT("Entering Create"));
    wxButton *btn;
    wxSize sz;

    cfg = NULL;
    cfg = new wxConfig(appname);
    
    wxLogTrace(className, wxT("Configuring resource"));
    SetParent(parent);
    wxXmlResource::Get()->LoadFrame(this, GetParent(), wxT("frmMain"));
    SetMenuBar(wxXmlResource::Get()->LoadMenuBar(wxT("mnuMain")));

    wxLogTrace(className, wxT("Constructing and setting icon"));
    SetIcon(wxICON(autorealm));

    wxLogTrace(className, wxT("Resizing everything"));
    GetSizer()->Fit(this);

    wxLogTrace(className, wxT("Getting size of buttons next to the color and pattern buttons"));
    btn = (wxButton*) FindWindowByName(wxT("btnToolTranslateColor"));
    sz = btn->GetSize();

    wxLogTrace(className, wxT("Setting size of btnToolMainColor"));
    btn = (wxButton*) FindWindowByName(wxT("btnToolMainColor"));
    btn->SetSizeHints(sz.GetWidth(), sz.GetHeight(), sz.GetWidth(), sz.GetHeight());
    resetColour(wxT("btnToolMainColor"), false);

    wxLogTrace(className, wxT("Setting size of btnToolFillColor"));
    btn = (wxButton*) FindWindowByName(wxT("btnToolFillColor"));
    btn->SetSizeHints(sz.GetWidth(), sz.GetHeight(), sz.GetWidth(), sz.GetHeight());
    resetColour(wxT("btnToolFillColor"), false);

    wxLogTrace(className, wxT("Setting size of btnToolFillPattern"));
    btn = (wxButton*) FindWindowByName(wxT("btnToolFillPattern"));
    btn->SetSizeHints(sz.GetWidth(), sz.GetHeight(), sz.GetWidth(), sz.GetHeight());

    wxLogTrace(className, wxT("Setting size of btnToolOutlineColor"));
    btn = (wxButton*) FindWindowByName(wxT("btnToolOutlineColor"));
    btn->SetSizeHints(sz.GetWidth(), sz.GetHeight(), sz.GetWidth(), sz.GetHeight());
    resetColour(wxT("btnToolOutlineColor"), false);

    wxLogTrace(className, wxT("Setting size of btnToolBackgroundColor"));
    btn = (wxButton*) FindWindowByName(wxT("btnToolBackgroundColor"));
    btn->SetSizeHints(sz.GetWidth(), sz.GetHeight(), sz.GetWidth(), sz.GetHeight());
    resetColour(wxT("btnToolBackgroundColor"), false);

    wxLogTrace(className, wxT("Setting size of btnToolGridColor"));
    btn = (wxButton*) FindWindowByName(wxT("btnToolGridColor"));
    btn->SetSizeHints(sz.GetWidth(), sz.GetHeight(), sz.GetWidth(), sz.GetHeight());
    resetColour(wxT("btnToolGridColor"), false);

    wxLogTrace(className, wxT("Rerunning Layout() to get all correct sizes"));
    Layout();

    wxLogTrace(className, wxT("Exiting Create"));
    return(true);
}

/**
 * Destructor. Cleans up the items from the window which need to
 * be cleaned up, and lets everything close successfully.
 */
MainWin::~MainWin() {
    wxLogTrace(className, wxT("Entering ~MainWin"));
    wxLogTrace(className, wxT("Deleting config object"));
    try {
        delete cfg;
    }
    catch (...) {
    }
    wxLogTrace(className, wxT("Done deleting config object"));
    wxLogTrace(className, wxT("Exiting ~MainWin"));
}

/**
 * This routine is used to update the fractal seed value, and is
 * in place because two separate event styles can trigger the same
 * code (namely, wxSpinEvent and wxCommandEvent)
 */
void MainWin::UpdateSeed() {
    wxLogTrace(className, wxT("Entering UpdateSeed"));
    wxLogTrace(className, wxT("Exiting UpdateSeed"));
}

/**
 * This routine is used to update the grid size, as it can be called
 * from two places (similar to UpdateSeed above).
 */
void MainWin::UpdateGridSize() {
    wxLogTrace(className, wxT("Entering UpdateGridSize"));
    wxLogTrace(className, wxT("Exiting UpdateGridSize"));
}

/**
 * Again, a routine created to share code between two separate
 * items updating the same information
 */
void MainWin::UpdateBoldUnit() {
    wxLogTrace(className, wxT("Entering UpdateBoldUnit"));
    wxLogTrace(className, wxT("Exiting UpdateBoldUnit"));
}

/**
 * This routine is a convenience routine, used by the color buttons
 * which set main color, background color, outline color, etc. It
 * takes a wxColour and a bitmap, and returns a new bitmap with the
 * same dimensions as the bitmap given which is a solid block of color
 * that matches the wxColour paramter.
 *
 * @param col This parameter is a wxColour parameter, and is what should
 * be used to fill the generated bitmap.
 * 
 * @param bmp This parameter is used to keep the bitmaps the same size
 * on the user's screen. After all, the screen should be consistent, and
 * having bitmaps of different sizes will be confusing. This is a 
 * cross check, to make sure they stay that way.
 *
 * @return A new bitmap will be allocated on the heap. It is the user's
 * responsibility to delete it! The bitmap will be a simple rectangle
 * filled with the specified color.
 */
wxBitmap* MainWin::genBitmap(wxColour col, const wxBitmap& bmp) {
    wxLogTrace(className, wxT("Entering genBitmap"));
    wxBitmap *colormatch;
    wxMemoryDC dc;
    wxBrush colbrush(col, wxSOLID);
    wxPen outliner(wxT("BLACK"), 1, wxSOLID);

    wxLogTrace(className, wxT("Allocating bitmap memory"));
    colormatch = new wxBitmap(bmp.GetWidth(), bmp.GetHeight(), bmp.GetDepth());

    wxLogTrace(className, wxT("Selecting and filling bitmap"));
    dc.BeginDrawing();
    dc.SelectObject(*colormatch);
    dc.SetBrush(colbrush);
    dc.SetPen(outliner);
    dc.DrawRectangle(0,0,bmp.GetWidth(),bmp.GetHeight());
    dc.EndDrawing();

    wxLogTrace(className, wxT("Exiting genBitmap"));
    return(colormatch);
}

/**
 * This routine is used both during window initialization and
 * regular runtime. As such, it should ask nothing during
 * initialization, but should do so during runtime.
 *
 * Basically, this routine will take the name of a button on
 * the screen, and replace the bitmap on that button with
 * another bitmap. In this case, the replacement bitmap will be
 * one produced by genBitmap (above), and so will be just a simple
 * rectangle filled with a single solid color.
 *
 * It's worth noting that I am doing something kind of sneaky here.
 * The wxBitmapButton class has a foreground color, but does not
 * use it. I'm stored the value of the color that the user chooses
 * in that foreground color member, and retrieve it when I need it.
 *
 * @param btnName The name of the button on the screen to be reset.
 *
 * @param usedlg (Default value = true) If usedlg is false, then the
 * window is assumed to be initializing. So, instead of asking for a
 * colour before the user even sees a usable window, we simply
 * take the current foreground color of the button, and use it for
 * the bitmap. Otherwise, ask for the color, and reset it where
 * possible.
 */
void MainWin::resetColour(wxString btnName, bool usedlg) {
    wxBitmapButton *btn, *openbtn;
    wxColour col;
    wxBitmap* bmp=NULL;

    wxLogTrace(className, wxT("Finding necessary buttons"));
    openbtn=(wxBitmapButton*)FindWindowByName(wxT("btnToolOpen"));
    btn=(wxBitmapButton*)FindWindowByName(btnName);

    wxLogTrace(className, wxT("Getting new colour"));
    if (usedlg) {
        col = wxGetColourFromUser(this, btn->GetForegroundColour());
    } else {
        col = btn->GetForegroundColour();
    }
    
    if (col.Ok()) {
        wxLogTrace(className, wxT("Colour was okay, generating bitmap"));
        bmp = genBitmap(col, openbtn->GetBitmapLabel());
        btn->SetBitmapDisabled(*bmp);
        btn->SetBitmapFocus(*bmp);
        btn->SetBitmapLabel(*bmp);
        btn->SetBitmapSelected(*bmp);
        btn->SetForegroundColour(col);
        delete bmp;
    }
}

/**
 * Called as an event handler, and is located here in the main area
 * as a fallback. It should prevent accidental exit by the user,
 * while avoiding making it difficult to do so.
 *
 * @param evt An event identifier passed in from wxWidgets to this
 * window.
 */
void MainWin::OnClose(wxCloseEvent &evt) {
    wxLogTrace(className, wxT("Entering OnClose"));
    if (true == evt.CanVeto()) {
        if (wxNO == wxMessageBox(_("Really exit?"), appname, wxYES_NO, this)) {
            wxLogTrace(className, wxT("no, don't really shut down"));
            evt.Veto();
        } else {
            wxLogTrace(className, wxT("yes, really shut down"));
            Destroy();
        }
    } else {
        Destroy();
    }
    wxLogTrace(className, wxT("Exiting OnClose"));
}

/**
 */
void MainWin::OnToolSelect(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolSelect"));
    wxLogTrace(className, wxT("Exiting OnToolSelect"));
}

/**
 */
void MainWin::OnToolOpen(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolOpen"));
    wxLogTrace(className, wxT("Exiting OnToolOpen"));
}

/**
 */
void MainWin::OnToolSave(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolSave"));
    wxLogTrace(className, wxT("Exiting OnToolSave"));
}

/**
 */
void MainWin::OnToolPan(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolPan"));
    wxLogTrace(className, wxT("Exiting OnToolPan"));
}

/**
 */
void MainWin::OnToolRuler(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolRuler"));
    wxLogTrace(className, wxT("Exiting OnToolRuler"));
}

/**
 */
void MainWin::OnToolMeasurementString(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolMeasurementString"));
    wxLogTrace(className, wxT("Exiting OnToolMeasurementString"));
}

/**
 */
void MainWin::OnToolRepaint(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolRepaint"));
    wxLogTrace(className, wxT("Exiting OnToolRepaint"));
}

/**
 */
void MainWin::OnToolUndo(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolUndo"));
    wxLogTrace(className, wxT("Exiting OnToolUndo"));
}

/**
 */
void MainWin::OnToolRedo(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolRedo"));
    wxLogTrace(className, wxT("Exiting OnToolRedo"));
}

/**
 */
void MainWin::OnToolReadOnly(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolReadOnly"));
    wxLogTrace(className, wxT("Exiting OnToolReadOnly"));
}

/**
 */
void MainWin::OnToolFreehand(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolFreehand"));
    wxLogTrace(className, wxT("Exiting OnToolFreehand"));
}

/**
 */
void MainWin::OnToolLine(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolLine"));
    wxLogTrace(className, wxT("Exiting OnToolLine"));
}

/**
 */
void MainWin::OnToolPolyline(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolPolyline"));
    wxLogTrace(className, wxT("Exiting OnToolPolyline"));
}

/**
 */
void MainWin::OnToolCurve(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolCurve"));
    wxLogTrace(className, wxT("Exiting OnToolCurve"));
}

/**
 */
void MainWin::OnToolPolycurve(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolPolycurve"));
    wxLogTrace(className, wxT("Exiting OnToolPolycurve"));
}

/**
 * This routine (and the other OnTool*Color routines) are all very similar.
 * They simply call resetColour, telling it which button to use. They all
 * receive an event which is entirely unused by us, but which wxWidgets gives
 * to use anyway.
 *
 * @param evt UNUSED
 */
void MainWin::OnToolMainColor(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolMainColor"));
    resetColour(wxT("btnToolMainColor"));
    wxLogTrace(className, wxT("Exiting OnToolMainColor"));
}

/**
 * This routine (and the other OnTool*Color routines) are all very similar.
 * They simply call resetColour, telling it which button to use. They all
 * receive an event which is entirely unused by us, but which wxWidgets gives
 * to use anyway.
 *
 * @param evt UNUSED
 */
void MainWin::OnToolFillColor(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolFillColor"));
    resetColour(wxT("btnToolFillColor"));
    wxLogTrace(className, wxT("Exiting OnToolFillColor"));
}

/**
 * When clicked, this button brings up a small dialog box which allows the
 * user to select the fill pattern of his choice. It will then copy that
 * fill pattern to the various bitmap labels for the bitmap button, and
 * return back to the main program. This allows the bitmaps to be copied
 * away and used for fills later.
 *
 * @param evt UNUSED
 */
void MainWin::OnToolFillPattern(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolFillPattern"));

    wxBitmapButton* btn;
    wxBitmap bmp;

    wxLogTrace(className, wxT("Setting up fill patterns dialog"));
    fill = new FillPattern(this, XRCID("dlgFillPattern"), wxT("Select the fill pattern"));
    wxLogTrace(className, wxT("fill patterns dialog loaded"));

    wxLogTrace(className, wxT("Locate button"));
    btn = (wxBitmapButton*)FindWindowByName(wxT("btnToolFillPattern"));

    fill->setCurrentBitmap(btn->GetBitmapLabel());
    if (wxID_OK == fill->ShowModal()) {

        wxLogTrace(className, wxT("get fill pattern bitmap"));
        bmp = fill->getCurrentBitmap();

        wxLogTrace(className, wxT("set label"));
        btn->SetBitmapDisabled(bmp);
        btn->SetBitmapFocus(bmp);
        btn->SetBitmapLabel(bmp);
        btn->SetBitmapSelected(bmp);

        wxLogTrace(className, wxT("layout window"));
        Layout();
        btn->Refresh(true);
        btn->Update();
    }

    wxLogTrace(className, wxT("Deleting fill pattern dialog object"));
    try {
        delete fill;
    }
    catch (...) {
    }
    wxLogTrace(className, wxT("Done deleting fill pattern dialog object"));

    wxLogTrace(className, wxT("Exiting OnToolFillPattern"));
}

/**
 * This routine (and the other OnTool*Color routines) are all very similar.
 * They simply call resetColour, telling it which button to use. They all
 * receive an event which is entirely unused by us, but which wxWidgets gives
 * to use anyway.
 *
 * @param evt UNUSED
 */
void MainWin::OnToolOutlineColor(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolOutlineColor"));
    resetColour(wxT("btnToolOutlineColor"));
    wxLogTrace(className, wxT("Exiting OnToolOutlineColor"));
}

/**
 * This routine (and the other OnTool*Color routines) are all very similar.
 * They simply call resetColour, telling it which button to use. They all
 * receive an event which is entirely unused by us, but which wxWidgets gives
 * to use anyway.
 *
 * @param evt UNUSED
 */
void MainWin::OnToolBackgroundColor(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolBackgroundColor"));
    resetColour(wxT("btnToolBackgroundColor"));
    wxLogTrace(className, wxT("Exiting OnToolBackgroundColor"));
}

/**
 * This routine (and the other OnTool*Color routines) are all very similar.
 * They simply call resetColour, telling it which button to use. They all
 * receive an event which is entirely unused by us, but which wxWidgets gives
 * to use anyway.
 *
 * @param evt UNUSED
 */
void MainWin::OnToolGridColor(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolGridColor"));
    resetColour(wxT("btnToolGridColor"));
    wxLogTrace(className, wxT("Exiting OnToolGridColor"));
}

/**
 */
void MainWin::OnToolShowColorTranslationManager(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolShowColorTranslationManager"));
    wxLogTrace(className, wxT("Exiting OnToolShowColorTranslationManager"));
}

/**
 */
void MainWin::OnToolTranslateColor(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolTranslateColor"));
    wxLogTrace(className, wxT("Exiting OnToolTranslateColor"));
}

/**
 */
void MainWin::OnToolInverseTranslateColor(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolInverseTranslateColor"));
    wxLogTrace(className, wxT("Exiting OnToolInverseTranslateColor"));
}

/**
 */
void MainWin::OnToolRectangle(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolRectangle"));
    wxLogTrace(className, wxT("Exiting OnToolRectangle"));
}

/**
 */
void MainWin::OnToolCircle(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolCircle"));
    wxLogTrace(className, wxT("Exiting OnToolCircle"));
}

/**
 */
void MainWin::OnToolPolygon(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolPolygon"));
    wxLogTrace(className, wxT("Exiting OnToolPolygon"));
}

/**
 */
void MainWin::OnToolArc(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolArc"));
    wxLogTrace(className, wxT("Exiting OnToolArc"));
}

/**
 */
void MainWin::OnToolRosetteChartLines(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolRosetteChartLines"));
    wxLogTrace(className, wxT("Exiting OnToolRosetteChartLines"));
}

/**
 */
void MainWin::OnToolText(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolText"));
    wxLogTrace(className, wxT("Exiting OnToolText"));
}

/**
 */
void MainWin::OnToolCurvedText(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolCurvedText"));
    wxLogTrace(className, wxT("Exiting OnToolCurvedText"));
}

/**
 */
void MainWin::OnToolHyperlinkPopup(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolHyperlinkPopup"));
    wxLogTrace(className, wxT("Exiting OnToolHyperlinkPopup"));
}

/**
 */
void MainWin::OnToolGroup(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolGroup"));
    wxLogTrace(className, wxT("Exiting OnToolGroup"));
}

/**
 */
void MainWin::OnToolUngroup(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolUngroup"));
    wxLogTrace(className, wxT("Exiting OnToolUngroup"));
}

/**
 */
void MainWin::OnToolDecompose(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolDecompose"));
    wxLogTrace(className, wxT("Exiting OnToolDecompose"));
}

/**
 */
void MainWin::OnToolFracFreehand(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolFracFreehand"));
    wxLogTrace(className, wxT("Exiting OnToolFracFreehand"));
}

/**
 */
void MainWin::OnToolFracLine(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolFracLine"));
    wxLogTrace(className, wxT("Exiting OnToolFracLine"));
}

/**
 */
void MainWin::OnToolFracPolyline(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolFracPolyline"));
    wxLogTrace(className, wxT("Exiting OnToolFracPolyline"));
}

/**
 */
void MainWin::OnToolFracCurve(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolFracCurve"));
    wxLogTrace(className, wxT("Exiting OnToolFracCurve"));
}

/**
 */
void MainWin::OnToolFracPolycurve(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolFracPolycurve"));
    wxLogTrace(className, wxT("Exiting OnToolFracPolycurve"));
}

/**
 * @todo Finish the work on using the alignment dialog, now that the
 * code is in place for it.
 */
void MainWin::OnToolAlign(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolAlign"));
    AlignDlg* align;
    align = new AlignDlg(this, XRCID("dlgAlignment"), wxT("Alignment"));
    align->ShowModal();
    align->Destroy();
    wxLogTrace(className, wxT("Exiting OnToolAlign"));
}

/**
 */
void MainWin::OnToolFlip(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolFlip"));
    wxLogTrace(className, wxT("Exiting OnToolFlip"));
}

/**
 */
void MainWin::OnToolSkew(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolSkew"));
    wxLogTrace(className, wxT("Exiting OnToolSkew"));
}

/**
 */
void MainWin::OnToolRotate(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolRotate"));
    RotateBitmap *rot;
    int heading;

    rot = new RotateBitmap(this, XRCID("dlgRotate"), wxT("Select New Rotation"));
    if (rot->ShowModal() == wxID_OK) {
        heading = rot->GetHeading();
        ///@todo finish the OnToolRotate method, now that the form for it is
        ///done
    }
    rot->Destroy();
    wxLogTrace(className, wxT("Exiting OnToolRotate"));
}

/**
 */
void MainWin::OnToolScale(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolScale"));
    wxLogTrace(className, wxT("Exiting OnToolScale"));
}

/**
 */
void MainWin::OnToolMove(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolMove"));
    wxLogTrace(className, wxT("Exiting OnToolMove"));
}

/**
 */
void MainWin::OnToolRotate90(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolRotate90"));
    wxLogTrace(className, wxT("Exiting OnToolRotate90"));
}

/**
 */
void MainWin::OnToolRotate45(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolRotate45"));
    wxLogTrace(className, wxT("Exiting OnToolRotate45"));
}

/**
 */
void MainWin::OnToolArray(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolArray"));
    wxLogTrace(className, wxT("Exiting OnToolArray"));
}

/**
 */
void MainWin::OnToolOrder(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolOrder"));
    wxLogTrace(className, wxT("Exiting OnToolOrder"));
}

/**
 */
void MainWin::OnToolToggleOverlayTags(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolToggleOverlayTags"));
    wxLogTrace(className, wxT("Exiting OnToolToggleOverlayTags"));
}

/**
 */
void MainWin::OnToolToggleDesignGrid(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolToggleDesignGrid"));
    wxLogTrace(className, wxT("Exiting OnToolToggleDesignGrid"));
}

/**
 */
void MainWin::OnToolToggleGravitySnap(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolToggleGravitySnap"));
    wxLogTrace(className, wxT("Exiting OnToolToggleGravitySnap"));
}

/**
 */
void MainWin::OnToolToggleGridSnap(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolToggleGridSnap"));
    wxLogTrace(className, wxT("Exiting OnToolToggleGridSnap"));
}

/**
 */
void MainWin::OnToolToggleGravitySnapAlongLinesAndCurves(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolToggleGravitySnapAlongLinesAndCurves"));
    wxLogTrace(className, wxT("Exiting OnToolToggleGravitySnapAlongLinesAndCurves"));
}

/**
 */
void MainWin::OnToolRotateSnappedObjects(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolRotateSnappedObjects"));
    wxLogTrace(className, wxT("Exiting OnToolRotateSnappedObjects"));
}

/**
 */
void MainWin::OnToolSendToBack(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolSendToBack"));
    wxLogTrace(className, wxT("Exiting OnToolSendToBack"));
}

/**
 */
void MainWin::OnToolSendBackward(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolSendBackward"));
    wxLogTrace(className, wxT("Exiting OnToolSendBackward"));
}

/**
 */
void MainWin::OnToolBringForward(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolBringForward"));
    wxLogTrace(className, wxT("Exiting OnToolBringForward"));
}

/**
 */
void MainWin::OnToolBringToFront(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolBringToFront"));
    wxLogTrace(className, wxT("Exiting OnToolBringToFront"));
}

/**
 */
void MainWin::OnToolPaste(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolPaste"));
    wxLogTrace(className, wxT("Exiting OnToolPaste"));
}

/**
 */
void MainWin::OnToolCopy(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolCopy"));
    wxLogTrace(className, wxT("Exiting OnToolCopy"));
}

/**
 */
void MainWin::OnToolCut(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolCut"));
    wxLogTrace(className, wxT("Exiting OnToolCut"));
}

/**
 */
void MainWin::OnToolDelete(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolDelete"));
    wxLogTrace(className, wxT("Exiting OnToolDelete"));
}

/**
 */
void MainWin::OnToolScalpel(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolScalpel"));
    wxLogTrace(className, wxT("Exiting OnToolScalpel"));
}

/**
 */
void MainWin::OnToolGlue(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolGlue"));
    wxLogTrace(className, wxT("Exiting OnToolGlue"));
}

/**
 */
void MainWin::OnToolSingleIcon(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolSingleIcon"));
    wxLogTrace(className, wxT("Exiting OnToolSingleIcon"));
}

/**
 */
void MainWin::OnToolSquarePlacement(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolSquarePlacement"));
    wxLogTrace(className, wxT("Exiting OnToolSquarePlacement"));
}

/**
 */
void MainWin::OnToolDiamondPlacement(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolDiamondPlacement"));
    wxLogTrace(className, wxT("Exiting OnToolDiamondPlacement"));
}

/**
 */
void MainWin::OnToolRandomPlacement(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolRandomPlacement"));
    wxLogTrace(className, wxT("Exiting OnToolRandomPlacement"));
}

/**
 */
void MainWin::OnToolDefineSelectionAsSymbol(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolDefineSelectionAsSymbol"));
    wxLogTrace(className, wxT("Exiting OnToolDefineSelectionAsSymbol"));
}

/**
 */
void MainWin::OnToolSymbolLibrary(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolSymbolLibrary"));
    wxLogTrace(className, wxT("Exiting OnToolSymbolLibrary"));
}

/**
 */
void MainWin::OnToolGraphNone(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolGraphNone"));
    wxLogTrace(className, wxT("Exiting OnToolGraphNone"));
}

/**
 */
void MainWin::OnToolGraphSquare(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolGraphSquare"));
    wxLogTrace(className, wxT("Exiting OnToolGraphSquare"));
}

/**
 */
void MainWin::OnToolGraphHex(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolGraphHex"));
    wxLogTrace(className, wxT("Exiting OnToolGraphHex"));
}

/**
 */
void MainWin::OnToolGraphRHex(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolGraphRHex"));
    wxLogTrace(className, wxT("Exiting OnToolGraphRHex"));
}

/**
 */
void MainWin::OnToolGraphTriangle(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolGraphTriangle"));
    wxLogTrace(className, wxT("Exiting OnToolGraphTriangle"));
}

/**
 */
void MainWin::OnToolGraphDiamond(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolGraphDiamond"));
    wxLogTrace(className, wxT("Exiting OnToolGraphDiamond"));
}

/**
 */
void MainWin::OnToolGraphHDiamond(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolGraphHDiamond"));
    wxLogTrace(className, wxT("Exiting OnToolGraphHDiamond"));
}

/**
 */
void MainWin::OnToolGraphCircle(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolGraphCircle"));
    wxLogTrace(className, wxT("Exiting OnToolGraphCircle"));
}

/**
 */
void MainWin::OnToolBeginLineStyle(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolBeginLineStyle"));
    wxLogTrace(className, wxT("Exiting OnToolBeginLineStyle"));
}

/**
 */
void MainWin::OnToolLineStyle(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolLineStyle"));
    wxLogTrace(className, wxT("Exiting OnToolLineStyle"));
}

/**
 */
void MainWin::OnToolEndLineStyle(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolEndLineStyle"));
    wxLogTrace(className, wxT("Exiting OnToolEndLineStyle"));
}

/**
 */
void MainWin::OnToolZoom(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnToolZoom"));
    wxLogTrace(className, wxT("Exiting OnToolZoom"));
}

/**
 */
void MainWin::OnVertScroll(wxScrollEvent &evt) {
    wxLogTrace(className, wxT("Entering OnVertScroll"));
    wxLogTrace(className, wxT("Exiting OnVertScroll"));
}

/**
 */
void MainWin::OnHorzScroll(wxScrollEvent &evt) {
    wxLogTrace(className, wxT("Entering OnHorzScroll"));
    wxLogTrace(className, wxT("Exiting OnHorzScroll"));
}

/**
 */
void MainWin::OnTxtXSizeChange(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnTxtXSize"));
    wxLogTrace(className, wxT("Exiting OnTxtXSize"));
}

/**
 */
void MainWin::OnTxtYSizeChange(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnTxtYSize"));
    wxLogTrace(className, wxT("Exiting OnTxtYSize"));
}

/**
 */
void MainWin::OnAspectChange(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnAspectChange"));
    wxLogTrace(className, wxT("Exiting OnAspectChange"));
}

/**
 */
void MainWin::OnPushpinChange(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnPushpinChange"));
    wxLogTrace(className, wxT("Exiting OnPushpinChange"));
}

/**
 */
void MainWin::OnOverlayChange(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnOverlayChange"));
    wxLogTrace(className, wxT("Exiting OnOverlayChange"));
}

/**
 */
void MainWin::OnOverlayListChange(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnOverlayListChange"));
    wxLogTrace(className, wxT("Exiting OnOverlayListChange"));
}

/**
 */
void MainWin::OnRoughnessScroll(wxScrollEvent &evt) {
    wxLogTrace(className, wxT("Entering OnRoughnessScroll"));
    wxLogTrace(className, wxT("Exiting OnRoughnessScroll"));
}

/**
 */
void MainWin::OnSeedSpin(wxSpinEvent &evt) {
    wxLogTrace(className, wxT("Entering OnSeedSpin"));
    wxLogTrace(className, wxT("Exiting OnSeedSpin"));
}

/**
 */
void MainWin::OnSeedText(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnSeedText"));
    wxLogTrace(className, wxT("Exiting OnSeedText"));
}

/**
 */
void MainWin::OnImgSizeChange(wxScrollEvent &evt) {
    wxLogTrace(className, wxT("Entering OnImgSizeChange"));
    wxLogTrace(className, wxT("Exiting OnImgSizeChange"));
}

/**
 */
void MainWin::OnImgDensityChange(wxScrollEvent &evt) {
    wxLogTrace(className, wxT("Entering OnImgDensityChange"));
    wxLogTrace(className, wxT("Exiting OnImgDensityChange"));
}

/**
 */
void MainWin::OnGridSizeChange(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnGridSizeChange"));
    wxLogTrace(className, wxT("Exiting OnGridSizeChange"));
}

/**
 */
void MainWin::OnSldgridSizeChange(wxScrollEvent &evt) {
    wxLogTrace(className, wxT("Entering OnSldgridSizeChange"));
    wxLogTrace(className, wxT("Exiting OnSldgridSizeChange"));
}

/**
 */
void MainWin::OnBoldUnitChange(wxSpinEvent &evt) {
    wxLogTrace(className, wxT("Entering OnBoldUnitChange"));
    wxLogTrace(className, wxT("Exiting OnBoldUnitChange"));
}

/**
 */
void MainWin::OnTxtBoldUnitChange(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnTxtBoldUnitChange"));
    wxLogTrace(className, wxT("Exiting OnTxtBoldUnitChange"));
}

/**
 */
void MainWin::OnPriGridStyleChange(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnPriGridStyleChange"));
    wxLogTrace(className, wxT("Exiting OnPriGridStyleChange"));
}

/**
 */
void MainWin::OnSecGridStyleChange(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering OnSecGridStyleChange"));
    wxLogTrace(className, wxT("Exiting OnSecGridStyleChange"));
}

/**
 * This routine just calls Close(), but doesn't force the application to
 * close. This lets the OnClose() ask the user if we should close (to
 * prevent accidental program exit).
 *
 * @param evt UNUSED
 */
void MainWin::FileExit(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering FileExit"));
    Close();
    wxLogTrace(className, wxT("Exiting FileExit"));
}

/**
 * This routine will summon up the About box. First, it loads the XRC, then
 * sets the version label which is stored in versioninfo, and finally it
 * displays it. Once the user had clicked "OK", it will close the dialog
 * box.
 *
 * @param evt UNUSED
 */
void MainWin::HelpAbout(wxCommandEvent &evt) {
    wxLogTrace(className, wxT("Entering HelpAbout"));

    wxStaticText *lbl;
    wxDialog dlg;
    wxString version;

    wxLogTrace(className, wxT("Constructing version info string"));
    version.Printf(wxT("Version: %s, Built: %s"), BUILDVER.c_str(), BUILDTIME.c_str());
    wxLogTrace(className, version);
    wxLogTrace(className, wxT("Retrieving resource for about dialog"));
    wxXmlResource::Get()->LoadDialog(&dlg, this, wxT("dlgAbout"));
    wxLogTrace(className, wxT("Finding lblVerNum"));
    lbl = (wxStaticText*)dlg.FindWindowByName(wxT("lblVerNum"));
    if (lbl != NULL) {
        wxLogTrace(className, wxT("Setting text of label"));
        lbl->SetLabel(version);
    } else {
        wxLogTrace(className, wxT("lblVerNum was not found"));
    }

    wxLogTrace(className, wxT("Executing dialog"));
    dlg.ShowModal();
    
    wxLogTrace(className, wxT("Exiting HelpAbout"));
}
