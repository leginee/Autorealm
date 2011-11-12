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

#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <wx/wx.h>
#include <wx/stream.h>

class FileManager {

	public:
		/** 
		 * @brief loads a map file from disk
		 *
		 * In order to support the multiple existing 
		 * AutoRealm map file formats, there will be
		 * multiple subclasses of FileManager, each of
		 * which overrides load() in order to load that
		 * map file type.
		 *
		 */
		virtual bool load() = 0;  

		/*
		 * @brief saves a map file to disk.
		 *
		 * In order to support saving to any number of formats, each subclass
		 * of FileManager will be responsible for implementing a save()
		 * function.
		 *
		 * However, saving in an alien format is optional. As a result, this
		 * is not a required method for the respective file manager classes.
		 */
		virtual bool save(wxOutputStream& out);

		/*
		 * Avoid g++ "class has virtual functions but non-virtual destructor"
		 * warnings for our subclasses.
		 */
		virtual ~FileManager() {};

};

#endif
