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

#include "Pushpin.h"
#include "Tracer.h"

/**
 * Used to set up trace flags for this file
 */
TRACEFLAG(wxT("Pushpin"));

PushpinHistory::PushpinHistory(arRealPoint p_pt, wxString p_nt) : m_point(p_pt), m_note(p_nt) {
	TRACER(wxT("PushpinHistory()"));
}

Pushpin::Pushpin() : m_point(0.0, 0.0) {
	TRACER(wxT("Pushpin()"));

	m_checked = m_placed = false;

	m_name = wxT("");
}

PushpinHistory Pushpin::getHist(unsigned int p_index) {
	TRACER(wxT("getHist(int index)"));
	return (m_history.size() >= p_index ? m_history.at(p_index) : PushpinHistory());
}

bool PushpinHistory::operator==(const PushpinHistory& p_other) const {
	TRACER(wxT("PushpinHistory::operator=="));
	return((m_point == p_other.m_point) and (m_note == p_other.m_note));
}

void Pushpin::addHist(PushpinHistory p_ph) {
	TRACER(wxT("addHist(PushpinHistory p_ph"));
	m_history.insert(m_history.begin(), p_ph);
}

bool Pushpin::operator==(Pushpin& p_other) const {
	TRACER(wxT("Pushpin::operator=="));
	bool retval = 
		(m_checked == p_other.m_checked) and
		(m_placed == p_other.m_placed) and
		(m_point == p_other.m_point) and
		(m_name == p_other.m_name);
	if (retval and (p_other.m_history.size() == m_history.size())) {
		for (unsigned int i=0; i<m_history.size(); i++) {
			PushpinHistory pin1 = m_history.at(i);
			PushpinHistory pin2 = p_other.m_history.at(i);
			retval &= (m_history.at(i) == p_other.m_history.at(i));
		}
	}
	return(retval);
}

PushpinCollection::PushpinCollection() {
	TRACER(wxT("PushpinCollection()"));
	m_pins.resize(MAX_PUSHPINS);
	m_waypointsVisible = m_showNumber = m_showNote = false;
}

bool PushpinCollection::operator==(const PushpinCollection& p_other) const {
	TRACER(wxT("PushpinCollection::operator==()"));
	bool retval= (m_waypointsVisible == p_other.m_waypointsVisible) and
		(m_showNumber == p_other.m_showNumber) and
		(m_showNote == p_other.m_showNote);
	TRACE(wxT("after members: retval=") + retval ? wxT("true") : wxT("false"));
	retval = retval and (m_pins.size() == p_other.m_pins.size());
	TRACE(wxT("after m_pins.size(): retval=") + retval ? wxT("true") : wxT("false"));
	if (retval) {
		for (unsigned int i=0; i<m_pins.size(); i++) {
			Pushpin pin1 = m_pins.at(i);
			Pushpin pin2 = m_pins.at(i);
			retval = retval and (pin1 == pin2);
			TRACE(wxT("after child %d, retval = %s"), i, retval ? wxT("true") : wxT("false"));
		}
	}
	return(retval);
}
