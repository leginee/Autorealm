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
 * 
 * 
 * @todo Add in the ability for arColorButton (and the whole color infrastructure) to handle alpha channel.
 */

#include <wx/colordlg.h> 
#include <wx/dcmemory.h>
#include <wx/log.h>

#include "arColorButton.h"
#include "HSLColor.h"
#include "Tracer.h"

/**
 * The traceflag for this file. Macro defined in Tracer.h
 */
TRACEFLAG(wxT("arColorButton"));

IMPLEMENT_DYNAMIC_CLASS(arColorButton, wxButton)
	
BEGIN_EVENT_TABLE(arColorButton, wxButton)
	EVT_SIZE(arColorButton::Resize)
END_EVENT_TABLE()

arColorButton::arColorButton() : wxBitmapButton(), m_color(wxNullColour) {
	TRACER(wxT("arColorButton::arColorButton()"));
}

arColorButton::arColorButton(wxWindow* p_parent, wxWindowID p_id,
		const wxColor& p_color,
		const wxPoint& p_pos,
		const wxSize& p_size, long p_style,
		const wxString& p_name) :
			wxBitmapButton(p_parent, p_id, wxNullBitmap, p_pos, p_size, p_style,
					wxDefaultValidator, p_name),
			m_color(p_color) {
	TRACER(wxT("arColorButton::arColorButton(...)"));
}

bool arColorButton::Create(wxWindow* p_parent, wxWindowID p_id,
		const wxColor& p_color,
		const wxPoint& p_pos,
		const wxSize& p_size, long p_style,
		const wxString& p_name) {
	TRACER(wxT("arColorButton::Create(...)"));
	wxBitmapButton::Create(p_parent, p_id, wxNullBitmap, p_pos, p_size, p_style, wxDefaultValidator, p_name);
	m_color = p_color;
	setColorBitmap();
	return true;
}

bool arColorButton::ProcessEvent(wxEvent& evt) {
	if (evt.GetEventType() == wxEVT_COMMAND_BUTTON_CLICKED) {
		SelectColor();
		return(true);
	} else {
		return(wxBitmapButton::ProcessEvent(evt));
	}
}

void arColorButton::SelectColor() {
	TRACER(wxT("arColorButton::SelectColor"));
	wxColor dcol = wxGetColourFromUser(GetParent(), m_color);
	if (dcol.Ok()) {
		m_color = dcol;
		setColorBitmap();
	}
}

wxSize arColorButton::GetMinSize() const {
	TRACER(wxT("GetMinSize"));
	return wxSize(8,8);
}                                 

void arColorButton::Resize(wxSizeEvent& evt) {
	TRACER(wxT("Resize"));
	setColorBitmap();
}

wxColor arColorButton::getColor() {
	TRACER(wxT("arColorButton::getColor"));
	return(m_color);
}

void arColorButton::setColor(const wxColor& p_color) {
	TRACER(wxT("arColorButton::setColor(...)"));
	if (p_color.Ok()) {
		m_color = p_color;
		setColorBitmap();
	}
}

void arColorButton::setColorBitmap() {
	TRACER(wxT("arColorButton::setColorBitmap(...)"));
	TRACE(wxT("Determine sizes"));
	wxSize size = GetSize();
	int ulx = 0, uly = 0, lrx = size.GetWidth(), lry = size.GetHeight();
	TRACE(wxT("Determine colors"));
	 
	wxColor brcol 				= m_color.Ok() ? m_color : wxColor(0x00, 0x00, 0x00);
	
	//in general the border color is black.  However if the bg color is "close" to black
	//then the border will be white.
	wxColor  innerBorderColor	= wxColor(0x00, 0x00, 0x00);
	
	HSLColor hslColor(brcol);
	
	if(hslColor.luminance() <= 65)
	{
		innerBorderColor	= wxColor(0xFF, 0xFF, 0xFF);
	}

	wxBrush brush(brcol, wxSOLID);	
	wxRect borderRect(ulx, uly, lrx, lry);
	
	wxPen penBorderRect(innerBorderColor, 1, wxSOLID);
	wxPen penBorderSelectedRect(innerBorderColor, 3, wxSOLID);
	wxPen penBorderFocusRect(innerBorderColor, 1, wxDOT);

	TRACE(wxT("Draw the bitmap with the appropriate color"));
	wxMemoryDC dc;
	wxBitmap bmp(lrx, lry, -1);
	dc.BeginDrawing();
	dc.SelectObject(bmp);
	dc.Clear();
	dc.SetBrush(brush);
	
	dc.SetPen(penBorderRect);
		
	dc.DrawRectangle(borderRect);
	
	dc.SelectObject(wxNullBitmap);
	dc.EndDrawing();
		
	//Draw a slightly different bitmap for the selected bitmap.
	TRACE(wxT("Draw the selected bitmap"));
	
	wxBitmap bmpSelected(lrx, lry, -1);
	dc.BeginDrawing();
	dc.SelectObject(bmpSelected);
	dc.Clear();
	dc.SetBrush(brush);
	
	dc.SetPen(penBorderSelectedRect);
	dc.DrawRectangle(borderRect);
	
	dc.SelectObject(wxNullBitmap);
	dc.EndDrawing();
	
	//Draw another slightly different bitmap for the focus bitmap.
	TRACE(wxT("Draw the Focused bitmap"));
	wxBitmap bmpFocused(lrx, lry, -1);
	dc.BeginDrawing();
	dc.SelectObject(bmpFocused);
	dc.Clear();
	dc.SetBrush(brush);
	
	dc.SetPen(penBorderRect);
	dc.DrawRectangle(borderRect);

	dc.SetBrush(*wxTRANSPARENT_BRUSH);
	
	dc.SetPen(penBorderFocusRect);
	dc.DrawRectangle(borderRect.Deflate(2));
	
	dc.SelectObject(wxNullBitmap);
	dc.EndDrawing();

	TRACE(wxT("Set bitmaps for all four states to the color"));
	SetBitmapDisabled(bmp);
	SetBitmapLabel(bmp);
	SetBitmapFocus(bmpFocused);
	SetBitmapSelected(bmpSelected);
	
	TRACE(wxT("Update the screen"));
	Refresh();
}

IMPLEMENT_DYNAMIC_CLASS(arColorButtonXmlHandler, wxXmlResourceHandler)

arColorButtonXmlHandler::arColorButtonXmlHandler() : wxXmlResourceHandler() {
	TRACER(wxT("arColorButtonXmlHandler"));
	AddWindowStyles();
}

bool arColorButtonXmlHandler::CanHandle(wxXmlNode* node) {
	TRACER(wxT("CanHandle"));
	return(IsOfClass(node, wxT("arColorButton")));
}

wxObject* arColorButtonXmlHandler::DoCreateResource() {
	TRACER(wxT("DoCreateResource"));
	XRC_MAKE_INSTANCE(button, arColorButton);

	wxColor col = wxNullColour;
	bool emptyColor = GetBool(wxT("nocolor"));
	if (!emptyColor) {
		col = GetColour(wxT("defaultcolor"));
		if (!col.Ok()) {
			col = wxNullColour;
		}
	}
	button->Create(m_parentAsWindow, GetID(), col,
				   GetPosition(), GetSize(), GetStyle(),
				   GetName());
	SetupWindow(button);
	return(button);
}

namespace {
	class InitarColorButtonXmlHandler {
		public:
			InitarColorButtonXmlHandler() {
				wxXmlResource::Get()->AddHandler(new arColorButtonXmlHandler);
			}
	};
	InitarColorButtonXmlHandler arxml;
}
