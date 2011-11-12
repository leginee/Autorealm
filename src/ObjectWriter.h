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

#ifndef OBJECTWRITER_H
#define OBJECTWRITER_H
#include <wx/wx.h>
#include <wx/tokenzr.h>
#include <wx/log.h>
#include <wx/txtstrm.h>

#include "ObjectInterface.h"
#include "ARDocument.h"
#include "ARExcept.h"

/**
 * This is a fairly simple implementation of a fairly simple idea.
 * 
 * This is a class which knows how to write out an XML file that can be read
 * back in. It has two methods: A constructor (which needs to know what
 * ARDocument it will be working with), and a method which calls the actual
 * writing.
 */
class ObjectWriter {
	public:
		/**
		 * Constructor
		 * 
		 * @param p_doc Pointer to the ARDocument which is to be saved.
		 */
		ObjectWriter(ARDocument* p_doc);

		/**
		 * Perform the actual save to some place.
		 * 
		 * @param out The stream on which the data should be saved. Must be
		 * valid, and ready to go, before calling this method.
		 */
		void write(wxTextOutputStream& out);

	protected:
		ARDocument* m_doc;
};
#endif
