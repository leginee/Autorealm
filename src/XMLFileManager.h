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

#ifndef XMLFILEMANAGER_H
#define XMLFILEMANAGER_H


#include <wx/wx.h>
#include <wx/stream.h>

#include <expat.h>
#include "expatpp.h"

#include "XMLParser.h"
#include "FileManager.h"
#include "ObjectWriter.h"


class XMLFileManager : public FileManager {

	public:
		/** 
		 * @brief Constructor - takes a filename and an object builder
		 * 
		 * @param p_filename the filename to open and parse
		 * @param p_objectBuilder the object builder we used to build the in
		 *                        memory representation of the XML file
		 */
		XMLFileManager(wxString&      p_filename,
			       ObjectBuilder& p_objectBuilder, ObjectWriter& p_objectWriter) :
																m_filename(p_filename),
                                                                m_objectBuilder(p_objectBuilder),
																m_objectWriter(p_objectWriter)
		{
			m_parser = new XMLParser(m_filename, m_objectBuilder);
		}

		/** 
		 * @brief Destructor
		 */
		~XMLFileManager();

		/** 
		 * @brief Parses (loads from disk) an XML AutoRealm map file
		 * 
		 * @return true on successful parse, false otherwise.
		 */
		bool load();


		/** 
		 * @brief Saves an AutoRealm map to disk in XML format
		 * 
		 * @return true on successful save, false otherwise
		 */
		bool save(wxOutputStream& out);


	private:
		/** 
		 * @brief Our XMLParser instance
		 */
		XMLParser*    m_parser;


		/** 
		 * @brief The filename to load or save
		 */
		wxString      m_filename;


		/** 
		 * @brief The object builder to use when parsing this file
		 */
		ObjectBuilder m_objectBuilder;

		ObjectWriter m_objectWriter;
};

#endif
