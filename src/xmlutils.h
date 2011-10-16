/*
 * Port of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
 * Used in rpgs and hobbyist GIS applications for mapmaking
 * Copyright (C) 2004 Michael J. Pedersen <m.pedersen@icelus.org>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
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
#ifndef XMLUTILS_H
#define XMLUTILS_H
#include "globals.h"
#include "types.h"

#include <wx/xml/xml.h>
#include <wx/wfstream.h>

/**
 * @brief Finds the first child of an xml element which has a given named.
 *
 * Basically, this is a convenience routine which cycles through the
 * children of a given XML element, and checks to see if any of them have
 * a given name. If so, it returns the first one it finds.
 *
 * @param cname The name of the child element to find
 * @param el The wxXmlNode to be searched
 *
 * @return a pointer to the node found, or NULL if no node found
 */
wxXmlNode* findNamedChild(const wxString& cname, const wxXmlNode& el);
/**
 * @brief Constructs a new wxXmlNode and gives it data as a child element.
 *
 * This routine is useful for creating an xml node of the form:
 *
 * <pre>
 * <element>hello</element>
 * </pre>
 *
 * easily. Since this is normally two operations with the wxXmlNode
 * provided by wxWidgets
 *
 * @param elname The name of the element to create ("element" in the above
 * example)
 * @param eldata The data to be attached to the element ("hello" in the
 * above example)
 *
 * @return a pointer to a new wxXmlNode which conforms to what is need to
 * produce the above XML
 */
wxXmlNode* newElWithChild(const wxString& elname, const wxString& eldata);

double      getElContentd(wxXmlNode* el);
float       getElContentf(wxXmlNode* el);
int         getElContenti(wxXmlNode* el);
long        getElContentl(wxXmlNode* el);
wxString    getElContents(wxXmlNode* el);
bool        getElContentb(wxXmlNode* el);
arRealPoint getElContentp(wxXmlNode* el);
VPoints     getElContentv(wxXmlNode* el);
arRealRect  getElContentr(wxXmlNode* el);

wxXmlNode* getAsXml(const wxString& name, int i);
wxXmlNode* getAsXml(const wxString& name, unsigned int i);
wxXmlNode* getAsXml(const wxString& name, const wxString& data);
wxXmlNode* getAsXml(const wxString& name, bool val);
wxXmlNode* getAsXml(const wxString& name, double val);
wxXmlNode* getAsXml(const wxString& name, const arRealPoint& p);
wxXmlNode* getAsXml(const wxString& name, const VPoints& p, int count);
wxXmlNode* getAsXml(const wxString& name, const arRealRect& r);

double      ReadDoubleFromBinaryStream(wxFileInputStream& ins);
float       ReadFloatFromBinaryStream(wxFileInputStream& ins);
int         ReadIntFromBinaryStream(wxFileInputStream& ins);
long        ReadLongFromBinaryStream(wxFileInputStream& ins);
int         ReadByteFromBinaryStream(wxFileInputStream& ins);
wxString    ReadStringFromBinaryStream(wxFileInputStream& ins);
bool        ReadBoolFromBinaryStream(wxFileInputStream& ins);
arRealPoint ReadarRealPointFromBinaryStream(wxFileInputStream& ins);
VPoints     ReadVPointsFromBinaryStream(wxFileInputStream& ins);
arRealRect  ReadarRealRectFromBinaryStream(wxFileInputStream& ins);
#endif //XMLUTILS_H
