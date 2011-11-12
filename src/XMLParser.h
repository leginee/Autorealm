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

#ifndef XMLPARSER_H
#define XMLPARSER_H


#include <wx/wx.h>
#include <wx/ffile.h>

#include "expat.h"
#include "expatpp.h"

#include "ObjectBuilder.h"
#include "ARExcept.h"


class XMLParser : public expatpp {
public:
	  /** 
	   * @brief Constructor for non-zipped AR XML map files
	   * 
	   * @param p_filename filename to open
	   * @param p_objectBuilder ObjectBuilder class to build in memory map objects
	   */
 	XMLParser(wxString&      p_filename,
	  	  ObjectBuilder& p_objectBuilder) : m_filename(p_filename),
					 	    m_objectBuilder(p_objectBuilder) {}

	/** 
	 * @brief Destructor calls expat's ReleaseParser to
	 *        free up parser resources
	 */
	~XMLParser() { ReleaseParser(); };


	/** 
	 * @brief main entry point - initializes and begins parsing file
	 */
	bool parse() throw(IOException);

protected:

	/**
	 * These are overridden expatpp methods
	 */
	/** 
	 * @brief expat callback when a new element is
	 *        encountered
	 * 
	 * @param name element name
	 * @param atts list of attributes in name1, value 1, name 2,
	 *             value2, ... name<n>, value<n> format
	 */
	void startElement(const XML_Char *name,
			  const XML_Char **atts);

	/** 
	 * @brief expat callback when a close tag is encountered
	 * 
	 * @param name element name
	 */
	void endElement(const XML_Char* name);

	/** 
	 * @brief expat callback when there is char data inside
	 *        an element.
	 * 
	 * @param s the char data 
	 * @param len length of the char data
	 */
	void charData(const XML_Char *s,
		      int len);

	/** 
	 * @brief expatt callback when an <?xml declaration is encountered
	 * 
	 * @param userData any user data set by user for this call back -
	 *        not used here.
	 * @param version XML version (1.0 for AutoRealm).
	 * @param encoding character encoding: Latin-1 for existing AutoRealm
	 *        map files. We force parsing to take place in UTF-8 since
	 *        that's 1 of the 4 supported expat encodings. This is a safe
	 *        operation since Latin-1 is a subset of UTF-8. Eventually,
	 *        AutoRealm will write out new map files using UTF-8.
	 * @param standalone does this document have a DTD associated with it?
	 */
	void xmlDeclCallback(void *userData,
                             const XML_Char* version,
                             const XML_Char* encoding,
                             int standalone);

	/** 
	 * @brief expat callback when (@todo-look up format of this decl) is encountered
	 *        Not used in AutoRealm, but included here for completeness
	 * 
	 * @param doctypeName @todo
	 * @param sysid @todo
	 * @param pubid @todo
	 * @param has_internal_subset @todo
	 */
	void startDoctypeDecl(const XML_Char *doctypeName,
                              const XML_Char *sysid,
                              const XML_Char *pubid,
                              int has_internal_subset);

	void endDoctypeDecl();


	/** 
	 * @brief name of XML format map file
	 */
	wxString m_filename;

	/** 
	 * @brief appropriate object builder for object being built
	 */
	ObjectBuilder m_objectBuilder;

};


#endif
