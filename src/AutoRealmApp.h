/*
 * Rewrite of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
 * Used in rpgs and hobbyist GIS applications for mapmaking
 * Copyright 2004-2006 The AutoRealm Team (http://www.autorealm.org/)
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the Lesser GNU General Public License as published by
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

#ifndef AUTOREALMAPP_H
#define AUTOREALMAPP_H
#include <wx/wx.h>
#include <wx/image.h>
#include <wx/xrc/xmlres.h>
#include <wx/intl.h>

/**
 * @class AutoRealmApp
 *
 * @brief Main driver for the whole application
 *
 * Derived from wxApp, this class is the main driver for the entire
 * application. It will be responsible for startup, shutdown, and
 * everything in between.
 */
class AutoRealmApp: public wxApp {
    public:
        /**
         * @brief Startup routines for the whole application
         */
        virtual bool OnInit();

		/** 
		 * @brief This will be called if an exception occurs and is not
		 * handled elsewhere. Basically, if it reaches this point, we're
		 * FUBAR'ed anyway. Let the user know, and exit.
		 */
		virtual void OnUnhandledException();

    protected:
        /**
         * This is the main window for the application. It does not use
         * std::auto_ptr for pointer management as this causes a runtime
         * crash at exit (as both wxWidgets and std::auto_ptr try to delete
         * the same memory).
         */
        wxFrame *m_mainwin;

        /**
         * Used to make sure i18n functions are properly available, to make for
         * nicer application to maintain
         */
        wxLocale m_locale;
};

/**
 * @class wxDialog
 * This class is the parent class of any dialog window used by AutoREALM.
 * The documentation for it is maintained within wxWidgets
 */
/**
 * @class wxApp
 * This class documentation is maintained within wxWidgets
 */
/**
 * @class wxStaticBitmap
 * This class documentation is maintained within wxWidgets
 */
/**
 * @class wxFrame
 * This class documentation is maintained within wxWidgets
 */
#endif //AUTOREALMAPP_H
