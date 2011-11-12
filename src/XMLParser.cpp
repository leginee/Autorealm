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
 * @file XMLParser.cpp
 *
 * This is the XML file parser for AutoREALM XML map files. Currently it only
 * provides a load() method. Eventually, it'll provide a save() as well.
 *
 */

/**
 *
 * @brief Parser for AutoREALM maps stored in XML format
 */

#include "XMLParser.h"
#include "Tracer.h"

#include <wx/wfstream.h>

TRACEFLAG(wxT("XMLParser"));



/**
 *
 * @brief parse() is the main entry point. It opens the file in m_filename
 * and calls expat's parseFile() to parse the file. Each of the callbacks
 * listed below will be invoked by expat when the appropriate tags are hit.
 *
 */
bool
XMLParser::parse() throw (IOException) {
	TRACER(wxT("parse()"));
	TRACE(wxT("filename=") + m_filename);

	/*
	 * Open the file
	 */
	wxFFile pMap(m_filename.c_str(), wxT("r"));

	if (pMap.IsOpened() == false or pMap.Error() == true) {
		
		IOException ioe(errno, m_filename);
		TRACE(ioe.what());
		EXCEPT(IOException, ioe.what());
	}

	/*
	 * Get the FILE* for the wxFFile since
	 * expat needs it to read from.
	 */
	wxFFileInputStream mapFile(pMap);

	/**
	 * We force ALL AutoREALM XML map files to be UTF-8 encoded. All 
	 * existing AutoRealm maps use Latin-1 so forcing UTF-8 is a safe 
	 * operation. UTF-8 is one of the 4 available encodings available 
	 * in expat - Latin-1 is NOT one of them.
	 *
	 */
	XML_SetEncoding(mParser, "UTF-8");

	/*
	 * start parsing the file using expatpp's parseFile()
	 */
	XML_Status parseResult;
	parseResult = parseFile(mapFile);

	return parseResult == XML_STATUS_OK;
}


/**
 * @brief startElement is called by expat whenever an new element is
 * encountered. We, in turn, call ObjectBuilder::startNewObject to begin
 * the object building process for that new element.
 *
 * @param p_name  the element (tag) name
 * @param p_attrs the list of attributes associated with the element
 *
 */
void
XMLParser::startElement(const XML_Char* p_name, const XML_Char** p_attrs) {

	/*
	 * Convert the element name to a wxString for tracing
	 */
	TRACER(wxT("startElement"));
		   wxString elemName(p_name, *wxConvCurrent);
	TRACE(elemName);

	/*
	 * Do some conversion for ObjectBuilder. Start with the element name
	 */
	wxString name(p_name, *wxConvCurrent);

	/*
	 * Now, convert the attributes to ObjectAttributesDef
	 */
	ObjectAttributes attrs;
	ObjectAttributesDef attr;

	for (int i = 0; p_attrs[i]; i+=2) {
		wxString attrName (p_attrs[i], *wxConvCurrent);
		wxASSERT(p_attrs[i+1] != NULL);
		wxString attrValue (p_attrs[i+1], *wxConvCurrent);
		attr.m_name = attrName;
		attr.m_value = attrValue;
		attrs.push_back(attr);
	}

	/*
	 * Call startNewObject to begin the building process for the new element
	 */
	m_objectBuilder.startNewObject(name, attrs);
}



/**
 * @brief charData is called by expat whenever there is char data in
 * an element to be processed. For AutoRealm, this includes data like
 * overlay names, point data, etc.
 *
 * @param data the char data
 * @param len the length of the char data
 *
 */
void
XMLParser::charData(const XML_Char* data, int len) {

	TRACER(wxT("charData"));
	wxString charData(data, *wxConvCurrent, len);
	TRACE(wxT("char data: ") + charData);

	/*
	 * Call ObjectBuilder::appendData to stuff the char data into the object
	 */
	m_objectBuilder.appendData(charData);
}




/**
 * @brief endElement is called by expat whenever an XML end tag is encountered.
 *        We, in turn call ObjectBuilder.endObject() in order to complete the
 *        object construction process.
 *
 * @param name the name of the element
 *
 */
void
XMLParser::endElement(const XML_Char* p_name) {

	TRACER(wxT("endElement:"));
	wxString elemName(p_name, *wxConvCurrent);
	TRACE(wxT("name=") + elemName);

	m_objectBuilder.endObject();
}



/**
 * @brief xmlDeclCallback is called when the <?xml... declaration is encountered
 *
 * @param userData userData to be supplied when callback is called
 * @param version XML version
 * @param encoding encoding (for Autorealm it'll be Latin-1 until we start
 *                 writing XML maps using UTF-8.
 * @param standalone whether or not this doc has a DTD (?)
     *
 */
void
XMLParser::xmlDeclCallback(void *userData,
                           const XML_Char* version,
                           const XML_Char* encoding,
                           int standalone)
{
	TRACER(wxT("xmlDeclCallback"));
}



/**
 * @brief startDotypeDecl is called when <doctype ...> is encountered
 *
 * @todo identify params
 *
 */
void
XMLParser::startDoctypeDecl(const XML_Char *doctypeName,
			    const XML_Char *sysid,
                 	    const XML_Char *pubid,
                 	    int has_internal_subset)
{
	TRACER(wxT("startDoctypeDecl"));
}



/**
 * @brief endDoctypeDecl is called at end of <doctype ...>
 *
 */
void
XMLParser::endDoctypeDecl()
{
	TRACER(wxT("endDoctypeDecl"));
}

