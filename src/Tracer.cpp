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


#include "Tracer.h"
#include <wx/log.h>

tracesvector* TracerSingleton::m_traces=NULL;

Tracer::Tracer(const wxString & traceFlag, 	const wxString & message) : m_traceFlag(traceFlag), m_message(message) 
{
	wxLogTrace(m_traceFlag, wxT("> ") + m_message);
}
		
void Tracer::trace(const wxString& p_msg) {
	wxLogTrace(m_traceFlag, m_message + wxT(": ") + p_msg);
}                                             

Tracer::~Tracer()
{
	wxLogTrace(m_traceFlag, wxT("< ") + m_message);
}

