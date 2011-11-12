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

#ifndef ARCOLORBUTTON_H
#define ARCOLORBUTTON_H
#include <wx/bmpbuttn.h>
#include <wx/xrc/xmlres.h>


/**
 * A custom control to be used with XML ResourCe files (XRC). This control
 * will present a bitmap to the user showing the currently selected color.
 * When the user clicks it, the platform specific color selection dialog
 * box will be presented. If the user selects a color (and hits OK), then
 * the bitmap will be replaced with the new color.
 * 
 * This also provides a method for getting/setting the current color of this control.
 */
class arColorButton : public wxBitmapButton {
		DECLARE_DYNAMIC_CLASS(arColorButton)
		DECLARE_EVENT_TABLE()
	public:
		/**
		 * Default constructor, used primarily in two stage creation by XRC
		 * files.
		 */
		arColorButton();
		/**
		 * Standard constructor. If making an arColorButton without using XRC
		 * files, use this constructor.
		 * 
		 * @param p_parent The parent window which will contain this arColorButton.
		 * @param p_id     The window id of this control.
		 * @param p_color  The starting color for this control. Default value: wxColor(0xff, 0x00, 0x00)
		 * @param p_pos    The on-screen location of this control. Default value: wxDefaultPosition
		 * @param p_size   The on-screen size of this control. Default value: wxDefaultSize
		 * @param p_style  The default style for this control. Acceptable values: All values from wxBitmapButton. Default value: wxBU_AUTODRAW.
		 * @param p_name   Name of this control in the window hierarchy. Default value: button
		 */
		arColorButton(wxWindow* p_parent, wxWindowID p_id,
				const wxColor& p_color = wxColor(0xff, 0x00, 0x00), 
				const wxPoint& p_pos = wxDefaultPosition,
				const wxSize& p_size = wxDefaultSize, long p_style = wxBU_AUTODRAW,
				const wxString& p_name = wxT("button"));
		/**
		 * Stage two constructor, used in two step object creation by XRC
		 * files.
		 * 
		 * @param p_parent The parent window which will contain this arColorButton.
		 * @param p_id     The window id of this control.
		 * @param p_color  The starting color for this control. Default value: wxColor(0xff, 0x00, 0x00)
		 * @param p_pos    The on-screen location of this control. Default value: wxDefaultPosition
		 * @param p_size   The on-screen size of this control. Default value: wxDefaultSize
		 * @param p_style  The default style for this control. Acceptable values: All values from wxBitmapButton. Default value: wxBU_AUTODRAW.
		 * @param p_name   Name of this control in the window hierarchy. Default value: button
		 */
		bool Create(wxWindow* p_parent, wxWindowID p_id,
				const wxColor& p_color = wxColor(0xff, 0x00, 0x00), 
				const wxPoint& p_pos = wxDefaultPosition,
				const wxSize& p_size = wxDefaultSize,
				long p_style = wxBU_AUTODRAW,
				const wxString& p_name = wxT("button"));

		/**
		 * The event handler for this control. Called in response to any
		 * event which occurs, such as mouse click, key-press, etc.
		 * 
		 * This method is responsible for making sure that any events
		 * are handled properly.
		 * 
		 * @param evt The event which occurred for this control.
		 */
		virtual bool ProcessEvent(wxEvent& evt);

		/**
		 * Called in response to a left mouse button up event, this method is
		 * responsible for showing the color dialog and changing the color if
		 * the user did, in fact, change the color.
		 */
		void SelectColor();

		/**
		 * This method returns the minimum size for the button. The size was
		 * chosen to be 8x8. It can, of course, be bigger.
		 * 
		 * @return 
		 */
		wxSize GetMinSize() const;
		/**
		 * Called whenever the size of the button changes, this event handler
		 * simply calls the method to update the background color bitmap
		 * 
		 * @param evt    Ignored
		 */
		void Resize(wxSizeEvent& evt);

		/**
		 * This method has the most "meat" to it. It is responsible for updating
		 * the actual bitmap which is used.
		 */
		void setColorBitmap();

		/**
		 * Gets the current value of the color being used by the user.
		 * 
		 * @return The current color which fills the bitmap.
		 */
		wxColor getColor();
		/**
		 * Change the color value for this control.
		 * 
		 * @param p_color A valid wxColor which will be used to change the color used by this
		 *                control.
		 */
		void setColor(const wxColor& p_color);

	protected:
		/**
		 * The value of the color being used by this control
		 */
		wxColor m_color;
};

/**
 * This is the custom XmlHandler for the arColorButton. Code in
 * arColorButton.cpp ensures that it is inserted into the
 * xmlhandler tree automatically. Simply linking the .o file
 * into the program ensures that it will be found and used.
 * inserted into the xmlhandler tree like so:
 * 
 * The XRC node structure for the arColorButton class is as follows:
 * @verbatim
 <pre>
     <object class="arColorButton" name="btnColorTextOutline">
         <nocolor>1</nocolor>
         <defaultcolor>#ff0000</defaultcolor>
     </object>
 </pre>
 @endverbatim
 * 
 * Either @verbatim<pre><nocolor></pre>@endverbatim or
 * @verbatim<pre><defaultcolor></pre>@endverbatim may be defined. If
 * nocolor is defined, it takes precedence over defaultcolor.
 * 
 * Any other XRC nodes may be used as usual (tooltip, etc).
 */
class arColorButtonXmlHandler : public wxXmlResourceHandler {
    DECLARE_DYNAMIC_CLASS(arColorButtonXmlHandler)
public:
	/**
	 * Default constructor for the arColorButtonXmlHandler
	 */
    arColorButtonXmlHandler();
	/**
	 * This routine is responsible for creating the actual arColorButton
	 * from the data in the XRC file.
	 * 
	 * @return A fully constructed arColorButton.
	 */
    virtual wxObject * DoCreateResource();
	/**
	 * This method is responsible for determining whether or not this class
	 * can handle this node of the XML file.
	 * 
	 * @param node   The current node, which should indicate the class of object to be
	 *               built.
	 * 
	 * @return True if the node class is of type "arColorButton", false otherwise.
	 */
    virtual bool CanHandle(wxXmlNode *node);
};
#endif //ARCOLORBUTTON_H
