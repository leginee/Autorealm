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
#ifndef CLKSTATICBITMAP_H
#define CLKSTATICBITMAP_H
#include "globals.h"
#include <wx/statbmp.h>

/**
 * @class clkStaticBitmap
 *
 * @brief wxStaticBitmap does not pass mouse clicks up the event tree, but
 * we need it to do so. This class, directly derived from it, does just that.
 *
 * This is, mainly, a utility class. All it does is process a left single
 * click or a left double click by passing it up to the parent's event
 * handler. This is needed because wxStaticBitmap, the parent class, does
 * not do this, and FillPattern does rely on it. In addition, it may be
 * useful elsewhere.
 */
class clkStaticBitmap : public wxStaticBitmap {
    public:
        /**
         * @brief Default constructor, used in two step window creation.
         */
        clkStaticBitmap(){};

        /**
         * @brief Main constructor, should be the most used
         */
        clkStaticBitmap(wxWindow *parent, wxWindowID id, const wxBitmap& label,
            const wxPoint& pos,
            const wxSize& size = wxDefaultSize,
            long style = 0,
            const wxString& name = wxT("staticBitmap"));

        /**
         * @brief overridden event processor, needed to make bitmap
         * clickable in FillPattern
         */
        void OnSingleClick(wxMouseEvent& evt);

        /**
         * @brief overridden event processor, needed to make bitmap
         * clickable in FillPattern
         */
        void OnDoubleClick(wxMouseEvent& evt);
    private:
        DECLARE_DYNAMIC_CLASS(clkStaticBitmap)
        DECLARE_EVENT_TABLE()
};
#endif //CLKSTATICBITMAP_H
