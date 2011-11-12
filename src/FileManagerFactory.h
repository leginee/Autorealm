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

#ifndef FILEMANAGERFACTORY_H
#define FILEMANAGERFACTORY_H

#include <wx/wx.h>
#include <wx/ffile.h>

#include "FileManager.h"
#include "XMLFileManager.h"
#include "ObjectBuilder.h"
#include "ObjectWriter.h"
#include "ARExcept.h"


class FileManagerFactory {
	
	public:
		/** 
		 * @brief getFileManager determines which type of FileManager needs to be
		 *        created and returned.
		 * 
		 * @param p_fileName the filename to load
		 * @param p_objectBuilder the object builder to use to build the object
		 *
		 * @note p_objectBuilder is required so that we can (eventually) create
		 *       a FileManager with the correct ObjectBuilder. It's essentially
		 *       'passed through' here to the creation of the actual FileManager
		 *       subclass instance.
		 * 
		 * @return the FileManager of the correct type for the file being loaded or saved.
		 */
		FileManager* getFileManager(wxString&      p_fileName,
				            ObjectBuilder& p_objectBuilder,
							ObjectWriter& p_objectWriter,
							bool p_isLoading=true);

		~FileManagerFactory() { delete m_fileManager; };

		/** 
		 * @enum indicates type of file manager determined by examining
		 *       first few bytes of the file.
		 */
		enum fileManagerType {invalid, binary, xml, zip};

		/** 
		 * @brief returns the type of FileManager for the file we're loading
		 * 
		 * @return the FileManager type 
		 */
		fileManagerType getType();

	protected:
		/**
		 * @brief returns the file type for load operations
		 *
		 * When determining the file type, there are two operations, each
		 * of which has distinct requirements. load() needs to look at the
		 * file on disk, determine the file type, and find the correct
		 * FileManager. save() needs to look at the file information in
		 * memory (usually, the extension will be enough), and determine
		 * the correct FileManager from that.
		 *
		 * So, getFileManager() uses two protected methods to determine
		 * what to do, one for each file operation. This is the first one,
		 * to get the correct FileManager for load operations.
		 *
		 * @param p_fileName the filename to load
		 * @param p_objectBuilder the object builder to use to build the object
		 *
		 * @note p_objectBuilder is required so that we can (eventually) create
		 *       a FileManager with the correct ObjectBuilder. It's essentially
		 *       'passed through' here to the creation of the actual FileManager
		 *       subclass instance.
		 * 
		 * @return the FileManager of the correct type for the file being loaded.
		 */
		FileManager* getForLoad(wxString&      p_filename,
				            ObjectBuilder& p_objectBuilder, ObjectWriter& p_objectWriter)
			throw(IOException, ARInvalidFileType);

		/**
		 * @brief returns the file type for save operations
		 *
		 * When determining the file type, there are two operations, each
		 * of which has distinct requirements. load() needs to look at the
		 * file on disk, determine the file type, and find the correct
		 * FileManager. save() needs to look at the file information in
		 * memory (usually, the extension will be enough), and determine
		 * the correct FileManager from that.
		 *
		 * So, getFileManager() uses two protected methods to determine
		 * what to do, one for each file operation. This is the second one,
		 * to get the correct FileManager for save operations.
		 *
		 * @param p_fileName the filename to save
		 * @param p_objectBuilder the object builder to use to build the object
		 *
		 * @note p_objectBuilder is required so that we can (eventually) create
		 *       a FileManager with the correct ObjectBuilder. It's essentially
		 *       'passed through' here to the creation of the actual FileManager
		 *       subclass instance.
		 * 
		 * @return the FileManager of the correct type for the file being loaded.
		 */
		FileManager* getForSave(wxString&      p_filename, ObjectBuilder& p_objectBuilder, ObjectWriter& p_objectWriter);
	private: 
		/**
		 * @var FileManager subclass returned to caller
		 */
		FileManager* m_fileManager;

		/** 
		 * @var file manager type determined by actually examining
		 *       first few bytes of the file.
		 */
		fileManagerType m_fileManagerType;
};



#endif
