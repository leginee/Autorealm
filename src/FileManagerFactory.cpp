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

#include <wx/filename.h>
#include "FileManagerFactory.h"
#include "Tracer.h"

TRACEFLAG(wxT("FileManagerFactory"));

namespace {
	const int BufferSize = 4; // number of bytes to read when
				  // determining file type
}


/** 
 * @brief Determines type of AutoRealm file being opened, then creates and
 *        returns a FileManager subclass of the corresponding type.
 * 
 * @param p_filename      filename to open
 * @param p_objectBuilder an ObjectBuilder to pass to the constructor
 *                        of the FileManager subclass being returned
 * 
 * @return Filemanager subclass of appropriate type
 */
FileManager* FileManagerFactory::getFileManager(wxString&      p_filename,
						ObjectBuilder& p_objectBuilder,
						ObjectWriter& p_objectWriter,
						bool p_isLoading) 
{
	TRACER(wxT("getFileManager()"));
	TRACE(wxT("filename=") + p_filename);

	/* Make sure that the filemanager is, under worst possible case, NULL */
	m_fileManager = NULL;

	switch (p_isLoading) {
		case true:  m_fileManager = getForLoad(p_filename, p_objectBuilder, p_objectWriter);
				    break;
		case false: m_fileManager = getForSave(p_filename, p_objectBuilder, p_objectWriter);
					break;
	}
	return m_fileManager;
}

FileManager* FileManagerFactory::getForLoad(wxString& p_filename, ObjectBuilder& p_objectBuilder, ObjectWriter& p_objectWriter)
	throw(IOException, ARInvalidFileType) {
	TRACER(wxT("getForLoad()"));
	/* Reset errno prior to io operation */
	errno = 0;   

	/*
	 * Open the requested file
	 */
	wxFFile map;
	{
		wxLogNull logNo;
		map.Open(p_filename, wxT("r"));
	}

	if (map.IsOpened() == false or map.Error() == true) {
		IOException ioe(errno, p_filename);
		TRACE(ioe.what());
		EXCEPT(IOException, ioe.what());
	}

	/*
	 * We have to determine the file type we're opening. Start by
	 * reading the first BufferSize bytes from the file and comparing
	 * these bytes with "known" signatures. For example, an XML
	 * format map will start with "<?xm".
	 */
	char buffer[::BufferSize];
	int  numRead = -1;

	/* Reset errno prior to io operation */
	errno = 0;

	numRead = map.Read(buffer, ::BufferSize);

	if (map.Error() == true) {
		IOException ioe(errno, p_filename);
		TRACE(ioe.what());
		EXCEPT(IOException, ioe.what());
	}

	/*
	 * If we couldn't read at least BufferSize bytes,
	 * throw an appropriate IOException.
	 */
	if (numRead != ::BufferSize) {
		wxString msg;
		/*
		 * There is no EOF error in errno.h so we have to 
		 * build a message by hand here instead of using 
		 * the IOException ctor that takes an errnor and a msg.
		 */
		msg.Printf(_("File error on file '%s' (Unexpected end of file)"), p_filename.c_str());
		TRACE(msg);
		EXCEPT(IOException, msg);
	}

	/*
	 * Now, determine the file type.
	 *
	 * If the first 4 bytes are "<?xm" then it's
	 * an XML format map file. If they're "AutR" then
	 * it's a binary map file. For the time being, we
	 * don't know how to identify a zip file so anything
	 * other than XML or binary is considered invalid. This
	 * will change in the future, I'm sure.
	 *
	 * @todo add test for zip map file. Don't know how to do this yet.
	 *
	 */
	if (strncmp(buffer, "<?xm", BufferSize) == 0) {
		/*
		 * This is an XML map file
		 */
		m_fileManagerType = xml;
		TRACE(wxT("file type is XML"));
	}

	else if (strncmp(buffer, "AutR", BufferSize) == 0) {
		/*
		 * This is a binary map file
		 */
		m_fileManagerType = binary;
		TRACE(wxT("file type is BINARY"));
	}
	else {
		/*
		 * This is an invalid file type
		 */
		m_fileManagerType = invalid;
		TRACE( wxT("file type is INVALID"));
	}

	/*
	 * Finally, create and return the appropriate FileManager 
	 * subclass for the requested file.
	 */
	switch(m_fileManagerType) {
		case binary:
			TRACE( wxT("getFileManager: returning BINARY FileManager"));
			/// @todo return new BinaryFileManager
			break;

		case xml:
			TRACE( wxT("getFileManager: returning XML FileManager"));
			m_fileManager = new XMLFileManager(p_filename, p_objectBuilder, p_objectWriter);
			break;

		case zip:
			TRACE( wxT("getFileManager: returning Zip FileManager"));
			/// @todo return new ZipFileManager
			break;

		case invalid:
			/*
			 * Throw an ARInvalidFileType exception for an unknown file type
			 */
			wxString msg;
			msg.Printf(wxT("File '%s' is not  a valid AutoRealm file"), p_filename.c_str());
			TRACE( msg);
			EXCEPT(ARInvalidFileType, msg);
			break;
	}

	return(m_fileManager);
}

FileManager* FileManagerFactory::getForSave(wxString& p_filename, ObjectBuilder &p_objectBuilder, ObjectWriter& p_objectWriter) {
	wxFileName file(p_filename);
	wxString ext = file.GetExt().MakeLower();

	if (ext == wxT("aurx")) {
		m_fileManager = new XMLFileManager(p_filename, p_objectBuilder, p_objectWriter);
		m_fileManagerType = xml;
	} else if (ext == wxT("aur")) {
		m_fileManager = NULL;
		m_fileManagerType = binary;
	}
	return(m_fileManager);
}

/** 
 * @brief returns the type of FileManager for the map file opened.
 */
FileManagerFactory::fileManagerType FileManagerFactory::getType()
{
	return m_fileManagerType;
}
