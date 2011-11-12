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
 * @brief This headerfile implements the file operations.
 * 
 * An ARDocument has a map and edits the map. After creating or editing a map
 * this function store a map in a file and can load the map again into the
 * memory for ARDocument.
 */


#include <wx/wx.h>
#include "ARDocument.h"


/**
 * @brief Load a file into an ARDocument.
 * 
 * @param p_filename A filename which contains a map for the ARDocument.
 * @param p_doc      A pointer to ARDocument in that the map will be loaded. 
 */ 
void fileLoad(const wxString& p_filename, ARDocument* p_doc);


/**
 * @brief Save an ARDocument into a file.
 * 
 * @param p_filename  The name of the file to store the map from an ARDocument.
 * @param p_doc       The poitner to ARDocument that contains the map to store.
 * @param p_overwrite Set this flag to true for overwrite an existing file.
 */
void fileSave(const wxString& p_filename, ARDocument* p_doc, bool p_overwrite=false);


/**
 * @brief Get the last error that occurs at file operations.
 *
 * @return The error as a string.
 */
wxString fileGetLastErrors();
