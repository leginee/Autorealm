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

#include "ARExcept.h"
#include "Tracer.h"

TRACEFLAG(wxT("ARExcept"));

ARException::ARException(const wxString& p_msg) : m_msg(p_msg) {
	TRACER(wxT("ARException()"));
}

wxString ARException::what() {
	TRACER(wxT("what()"));
	return(m_msg);
}





/** 
 * @brief IOException constructor - builds a nicely formated error 
 *        string which includes the appropriate strerror string for 
 *        easy debugging.
 * 
 * @param p_errno     the errno value for this error
 * @param p_filename  the filename for which the error occurred
 */
void IOException::setErrorMsg(int p_errno, wxString& p_filename) {

	/*
	 * This method uses errno and strerror to
	 * build a meaningful error message.
	 */

	/* make sure errno is at least a positive number */
	wxASSERT(p_errno >= 0); 

	wxString msg(_("File error on file '"));

	/* include the filename */
	msg.append(p_filename.c_str());

	/* include the strerror text to help user/debugger */
	msg.append(_("' ("));
	wxString sysMessage(strerror(errno), *wxConvCurrent);
	msg.append(sysMessage);
	msg.append(_(")"));

	m_msg = msg;
}
