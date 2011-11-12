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

#ifndef MAINWIN_H
#define MAINWIN_H

#include <wx/frame.h>

class MainWin : public wxFrame {
	DECLARE_DYNAMIC_CLASS(MainWin)
	DECLARE_EVENT_TABLE()
	public:
		MainWin() : wxFrame() {};
		MainWin(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = wxT("frame"));
		bool Create(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = wxT("frame"));
		void DisplayHelpContents(wxCommandEvent& evt);

		bool ProcessEvent(wxEvent& evt);

		//////////////////////////////////////
		// Close event handler
		//////////////////////////////////////
		/**
		 * @brief This mezhod handle the close event.
		 *
		 * If the user clicked on the close button of the program window this event will be send
		 * to the window. It asks the user 'Really exit AutoRealm?'. 
		 * 
		 * @param evt The event structure from wxWidget.
		 */
		void OnClose(wxCloseEvent& evt);

		//////////////////////////////////////
		// Menu and Button handling methods
		//////////////////////////////////////
		/**
		 * @brief Handle the event on exit from Menu.
		 * 
		 * If the user selected the menu entry 'Quit' the wxWidget framework send this event.
		 * A requester appeared and shows 'Really exit AutoRealm?'. If you click on the 'Yes'
		 * button the program exits.
		 * 
		 * @param evt The event structure from wxWidget.
		 */
		void OnExit(wxCommandEvent& evt);
		/**
		 * @brief Handle the event on load from Menu and Button.
		 * 
		 * If the user selected the menu entry 'Load' or the button with the load picture
		 * the wxWidget framework send OnLoad event. A file requester will be opened and
		 * user can selected a filename to load.
		 * 
		 * @param evt The event structure from wxWidget.
		 */
		void OnLoad(wxCommandEvent& evt);
		/**
		 * @brief Handle the event on save from Menu.
		 * 
		 * Every time when the user clicked on the save button or hit the 'Save' menu entry
		 * a file requester will be opened and ask the user for a filename. The map will be
		 * written into this filename.
		 * 
		 * @param evt The event structure from wxWidget.
		 */
		void OnSave(wxCommandEvent& evt);
};
#endif //MAINWIN_H
