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


#ifndef OBJECT_BUILDER_H
#define OBJECT_BUILDER_H


#include "ARDocument.h"


/**
 * @brief The ObjectBuilder class creates all objects of the map at the loading
 * process.
 * 
 * Used by various FileManager classes, this class takes events 
 * as determined by the FileManager and turns them into objects which
 * are then attached to the current ARDocument.
 *
 * The normal sequence of events is as follows:
 *
 * - ARDocument receives a message to load a file
 * - ARDocument accesses the FileManagerFactory, asking it for a
 *   FileManager which can handle the requested file
 * - ARDocument tells the returned FileManager to load the file, giving it
 *   an ObjectBuilder to use
 * - FileManager reads the file. At any of three major events (begin new
 *   object, end current object, addData to object) it informs
 *   ObjectBuilder of the event, giving it the necessary data.
 * - ObjectBuilder reads the incoming data, and determines what to do with
 *   it. These actions can vary in many ways, so are not discussed here.
 * - When the time is right (i.e.: An object has been completed),
 *   ObjectBuilder adds the object to the ARDocument.
 * - After processing the event, control returns to the FileManager to
 *   continue parsing the file
 * - After parsing the file, control returns to the ARDocument
 * 
 * @warning <b>FIRST NOTE: THIS CODE IS NOT THREAD SAFE! MULTITHREADING IT WILL FAIL!</b>
 */
class ObjectBuilder
{
	public:
		/**
	 	* This method is used to construct a new ObjectBuilder. It requires
	 	* knowledge of which map document to be building onto.
	 	*
	 	* @param p_doc The map document to add the new objects to.
	 	*/
		ObjectBuilder(ARDocument* p_doc);
		
		/**
		 * @brief The destructor.
		 */
		~ObjectBuilder();

		/**
		 * @brief Responsible for beginning of an object.
		 *
		 * This routine is the most tricky, especially when you consider
		 * how the XML data is stored. Objects have child elements to
		 * represent the points for the objects. As a result, this
		 * particular method will be called when the points element starts,
		 * but this is not a true child object from the perspective of
		 * AutoRealm.
		 *
		 * Each and every member which is <em>understood</em> by AutoRealm
		 * is listed in the file ObjectBuilder.cpp, variable ::allNames.
		 *
		 * If a FileManager gives a type that is not listed in
		 * ObjectBuilder.cpp::allNames, then it will be treated as extra
		 * data, and stored in the object accordingly.
		 *
		 * @param p_name The name of the new object being examined.
		 * @param p_attribs A list of attributes to be associated with this
		 * object.
		 */
		void startNewObject(const wxString& p_name, const ObjectAttributes& p_attribs);

		/**
		 * @brief Append otherwise unidentified data to the current object.
		 *
		 * When parsing large files, it will be possible to receive large
		 * chunks of data which are part of the already identified current
		 * object, but which are received separately. This method allows
		 * for just appending data to the open object.
		 *
		 * @param p_data The data to be appended to the current object.
		 */
		void appendData(const wxString& p_data);

		/**
		 * @brief Used to close out the current object.
		 *
		 * This method is called when all information about the current
		 * object has been read from the file, and we need to close it out
		 * so that it can be appended to the ARDocument which needs it.
		 */
		void endObject() throw (ARBadColorException, ARBadNumberFormat, ARInvalidTagException);
		
	protected:
  		/**
		 * The ARDocument which is being worked on. This will allow us to
		 * always know the actual document to work with.
		 */
		ARDocument * m_doc;
};

#endif  // OBJECT_BUILDER_H
