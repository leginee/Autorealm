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
#ifndef ROTATEBITMAP_H
#define ROTATEBITMAP_H
#include "globals.h"
#include <wx/spinctrl.h>

/**
 * @class RotateBitmap
 *
 * @brief Descended from wxDialog, this class is used to display a
 * heading control, allowing the user to select a degree of rotation for
 * a bitmap.
 *
 * Derived from wxDialog, this class is responsible for selecting the
 * degree of rotation to be used by the main program. It is intended to be
 * displayed modally.
 */
class RotateBitmap : public wxDialog {
    public:
        /**
         * @brief Default constructor, used in two step window creation.
         */
        RotateBitmap(){};

        /**
         * @brief Main constructor, should be the most used
         */
        RotateBitmap(wxWindow *parent, wxWindowID id, const wxString& title,
            const wxPoint& pos = wxDefaultPosition,
            const wxSize& size = wxDefaultSize,
            long style = wxDEFAULT_DIALOG_STYLE,
            const wxString& name = wxT("dialogBox"));

        /**
         * @brief Part two of two step window creation
         */
        bool Create(wxWindow *parent, wxWindowID id, const wxString& title,
            const wxPoint& pos = wxDefaultPosition,
            const wxSize& size = wxDefaultSize,
            long style = wxDEFAULT_DIALOG_STYLE,
            const wxString& name = wxT("dialogBox"));

        /**
         * @brief Destructor, cleans up after window is closed.
         */
        ~RotateBitmap();

        /**
         * @brief sets the current selected bitmap using a passed in bitmap
         */
        void setBackgroundBitmap(wxBitmap inbmp);

        /**
         * @brief Called when the "-5" button is pressed.
         */
        void OnMinusFive(wxCommandEvent& evt);
        
        /**
         * @brief Called when the "-1" button is pressed.
         */
        void OnMinusOne(wxCommandEvent& evt);
        
        /**
         * @brief Called when the "+1" button is pressed.
         */
        void OnPlusOne(wxCommandEvent& evt);
        
        /**
         * @brief Called when the "+5" button is pressed.
         */
        void OnPlusFive(wxCommandEvent& evt);
        
        /**
         * @brief Called when the spin control is updated
         */
        void OnSpinChange(wxSpinEvent& evt);
        
        /**
         * @brief Responsible for updating the picture by rotating it around.
         */
        void RotatePic(int degrees);

        /**
         * @brief Gets the value of the rotation specified by the user
         * in degrees
         */
        int GetHeading();

    protected:
        /**
         * This is used to prevent a perpetual re-run of the RotatePic method, by
         * providing a way to let the method decide if it should run
         */
        int prevheading;

        /**
         * This will contain the bitmap given from the outside, to be show in
         * the dial control. If it is null, then no bitmap has been given.
         */
        wxImage* outside;

    private:
        DECLARE_DYNAMIC_CLASS(RotateBitmap)
        DECLARE_EVENT_TABLE()
};
#endif //ROTATEBITMAP_H
