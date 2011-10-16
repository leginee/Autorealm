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

#ifndef MAINWIN_H
#define MAINWIN_H
#include "globals.h"
#include <wx/config.h>
#include <wx/spinctrl.h>

#include "FillPattern.h"

/**
 * @class MainWin
 *
 * @brief The main window of the application, controls startup, shutdown,
 * and usage of other dialogs.
 *
 * This class is the main window of the AutoREALM application. It is what
 * does the real work. AutoRealmApp, a required class (as in we must derive
 * a class from wxApp), simply creates a MainWin, and fires things off from
 * there.
 *
 * @todo Add event dispatchers for all menubar IDs
 * @todo Make sure that bmpMainMap should be a wxStaticBitmap. And if it
 * should not, then do something about it.
 * @todo Fix up the slider controls to generate proper scroll events.
 * Basically, learn how to do it, and then do it for all sliders
 */
class MainWin : public wxFrame {
    public:
        /**
         * @brief Minimum constructor, required for subclassing in XRC.
         *
         * The following constructor should only be used in conjunction
         * with the Create() method below.
         */
        MainWin(){};

        /**
         * @brief Used to allow subclassing of an XRC item
         */
        MainWin(wxWindow* parent, wxWindowID id, const wxString& title,
            const wxPoint& pos = wxDefaultPosition,
            const wxSize& size = wxDefaultSize,
            long style = wxDEFAULT_FRAME_STYLE,
            const wxString& name = wxT("frame"));

        /**
         * @brief Used to allow subclassing of an XRC item
         */
        bool Create(wxWindow* parent, wxWindowID id, const wxString& title,
            const wxPoint& pos = wxDefaultPosition,
            const wxSize& size = wxDefaultSize,
            long style = wxDEFAULT_FRAME_STYLE,
            const wxString& name = wxT("frame"));

        /**
         * @brief Destructor, does cleanup details
         */
        ~MainWin();

        /**
         * @brief Updates map fractal seed value
         */
        void UpdateSeed();

        /**
         * @brief Updates map grid size
         */
        void UpdateGridSize();

        /**
         * @brief Upates the secondary grid size information
         */
        void UpdateBoldUnit();

        /**
         * @brief generates a color bitmap (used by what could be
         * color buttons) and returns it to the caller
         */
        wxBitmap *genBitmap(wxColour col, const wxBitmap& bmp);

        /**
         * @brief resets the color bitmap on a color button
         */
        void resetColour(wxString btnName, bool usedlg=true);

        /**
         * @brief Checks to make sure user meant to close the app
         */
        void OnClose(wxCloseEvent &evt);

        // The following items are all used in some control easily visible on
        // screen. Many of these items correspond to menu items, but those are
        // not yet hooked up correctly (heck, I just got their names done).
        // Future revs will hook menu items to the same procedures as the buttons
        // on screen.
        //
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolSelect(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolOpen(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolSave(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolPan(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolRuler(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolMeasurementString(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolRepaint(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolUndo(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolRedo(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolReadOnly(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolFreehand(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolLine(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolPolyline(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolCurve(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolPolycurve(wxCommandEvent &evt);
        /**
         * @brief Sets the main foreground color as specified by the user.
         */
        void MainWin::OnToolMainColor(wxCommandEvent &evt);
        /**
         * @brief Sets the main fill color as specified by the user.
         */
        void MainWin::OnToolFillColor(wxCommandEvent &evt);
        /**
         * @brief Sets the main fill pattern as specified by the user.
         */
        void MainWin::OnToolFillPattern(wxCommandEvent &evt);
        /**
         * @brief Sets the main outline color as specified by the user.
         */
        void MainWin::OnToolOutlineColor(wxCommandEvent &evt);
        /**
         * @brief Sets the main background color as specified by the user.
         */
        void MainWin::OnToolBackgroundColor(wxCommandEvent &evt);
        /**
         * @brief Sets the main grid color as specified by the user.
         */
        void MainWin::OnToolGridColor(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolShowColorTranslationManager(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolTranslateColor(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolInverseTranslateColor(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolRectangle(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolCircle(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolPolygon(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolArc(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolRosetteChartLines(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolText(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolCurvedText(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolHyperlinkPopup(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolGroup(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolUngroup(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolDecompose(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolFracFreehand(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolFracLine(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolFracPolyline(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolFracCurve(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolFracPolycurve(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolAlign(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolFlip(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolSkew(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolRotate(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolScale(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolMove(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolRotate90(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolRotate45(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolArray(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolOrder(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolToggleOverlayTags(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolToggleDesignGrid(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolToggleGravitySnap(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolToggleGridSnap(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolToggleGravitySnapAlongLinesAndCurves(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolRotateSnappedObjects(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolSendToBack(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolSendBackward(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolBringForward(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolBringToFront(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolPaste(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolCopy(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolCut(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolDelete(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolScalpel(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolGlue(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolSingleIcon(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolSquarePlacement(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolDiamondPlacement(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolRandomPlacement(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolDefineSelectionAsSymbol(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolSymbolLibrary(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolGraphNone(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolGraphSquare(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolGraphHex(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolGraphRHex(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolGraphTriangle(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolGraphDiamond(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolGraphHDiamond(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolGraphCircle(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolLineStyle(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolEndLineStyle(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolBeginLineStyle(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnToolZoom(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnVertScroll(wxScrollEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnHorzScroll(wxScrollEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnTxtXSizeChange(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnTxtYSizeChange(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnAspectChange(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnPushpinChange(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnOverlayChange(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnOverlayListChange(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnRoughnessScroll(wxScrollEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnSeedSpin(wxSpinEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnSeedText(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnImgSizeChange(wxScrollEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnImgDensityChange(wxScrollEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnGridSizeChange(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnSldgridSizeChange(wxScrollEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnBoldUnitChange(wxSpinEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnTxtBoldUnitChange(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnPriGridStyleChange(wxCommandEvent &evt);
        /**
         * @brief Stub routine for wxWidgets, not used yet.
         */
        void OnSecGridStyleChange(wxCommandEvent &evt);

        // The following items are for menu items which do not have toolbar
        // buttons anywhere on screen.

        /**
         * @brief Called by clicking File->Exit
         */
        void FileExit(wxCommandEvent &evt);
        /**
         * @brief Called by clicking Help->About
         */
        void HelpAbout(wxCommandEvent &evt);

		wxImageList OverlayImages;
    protected:
        /**
        * This is used to read and write configuration values from the
        * application. It is of type wxConfig, which already exists on all
        * platforms, and reads/saves its data correctly on them (for instance,
        * using the registry on Windows)
        */
        wxConfig* cfg;

        /**
         * This is used for setting/maintaining the fill patterns
         */
        FillPattern* fill;

    private:
        DECLARE_DYNAMIC_CLASS(MainWin)
        DECLARE_EVENT_TABLE()
};

#endif //MAINWIN_H
