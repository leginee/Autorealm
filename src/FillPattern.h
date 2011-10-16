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
#ifndef FILLPATTERN_H
#define FILLPATTERN_H
#include "globals.h"

/**
 * @class FillPattern
 *
 * @brief Descended from wxDialog, this class is used to display a list of
 * fill patterns and allow the user to select one of them.
 *
 * Derived from wxDialog, this class is responsible for selecting the
 * fill pattern to be used by the main program. It is intended to be
 * displayed modally.
 */
class FillPattern : public wxDialog {
    public:
        /**
         * @brief Default constructor, used in two step window creation.
         */
        FillPattern(){};

        /**
         * @brief Main constructor, should be the most used
         */
        FillPattern(wxWindow *parent, wxWindowID id, const wxString& title,
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
         * @brief Overriding behavior when OnCancel is called, so that we
         * revert the bitmap stored in this dialog for others to use
         */
        void OnCancel(wxCommandEvent& evt);

        /**
         * @brief Used for single click in window, activated when
         * button released
         */
        void OnSelectPattern(wxMouseEvent& evt);

        /**
         * @brief Used for double click in window
         */
        void OnChangePattern(wxMouseEvent& evt);

        /**
         * @brief sets the current selected bitmap using a passed in bitmap
         */
        void setCurrentBitmap(wxBitmap inbmp);

        /**
         * @brief sets the current selected bitmap used a string
         * resource name
         */
        void setCurrentBitmap(wxString resName);

        /**
         * @brief sets the current selected bitmap used a string
         * resource name
         */
        void setCurrentBitmap(int patternnum);

        /**
         * @brief returns a copy of the current selected bitmap
         */
        wxBitmap getCurrentBitmap();

    protected:
        /**
         * A holder to the previous bitmap pattern. Useful for the dialog
         * which comes up, and reverts on cancellation
         */
        wxBitmap prevbmp;

    private:
        DECLARE_DYNAMIC_CLASS(FillPattern)
        DECLARE_EVENT_TABLE()
};
#endif //FILLPATTERN_H
