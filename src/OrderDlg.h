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
#ifndef ORDERDLG_H
#define ORDERDLG_H
#include "globals.h"
#include <wx/xrc/xmlres.h>

/**
 * @class OrderDlg
 *
 * @brief Descended from wxDialog, this class is used to BRIEFDESC
 *
 * FULLDESC
 */
class OrderDlg : public wxDialog {
    public:
        /**
         * @brief Default constructor, used in two step window creation.
         */
        OrderDlg(){};

        /**
         * @brief Main constructor, should be the most used
         */
        OrderDlg(wxWindow *parent, wxWindowID id, const wxString& title,
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

    private:
        DECLARE_DYNAMIC_CLASS(OrderDlg)
        DECLARE_EVENT_TABLE()
};
#endif //ORDERDLG_H
