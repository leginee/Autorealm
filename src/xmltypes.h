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

#ifndef XMLTYPES_H
#define XMLTYPES_H

#include <vector>

#include <wx/wx.h>

/**
 * @brief Used in loading/saving of objects. Acts as a holding area for
 * object attributes.
 *
 * Primarily used in the load/save of XML files, but could still be used
 * elsewere.
 */
struct ObjectAttributesDef {
	/**
	 * Each attribute has a name. This specifies the name.
	 */
	wxString m_name;

	/**
	 * Each attribute has a value. This specifies the value. If you need to
	 * attach a binary value, we recommend using the base64encode/decode
	 * functions available elsewhere in AutoRealm.
	 */
	wxString m_value;
};

/**
 * A convenience typedef for usage in passing this around as a method
 * paramter.
 */
typedef std::vector<ObjectAttributesDef> ObjectAttributes;

#endif //XMLTYPES_H
