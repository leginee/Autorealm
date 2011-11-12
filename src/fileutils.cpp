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

#include <wx/filefn.h>
#include <wx/wfstream.h>

#include "fileutils.h"
#include "ARExcept.h"
#include "FileManagerFactory.h"
#include "ObjectBuilder.h"
#include "ObjectWriter.h"

namespace {
	wxString lastErrors(wxT(""));
}

void fileLoad(const wxString& p_filename, ARDocument* p_doc) {
	/*
	 * Open the file
	 */
	wxFFile pMap;
	{
		wxLogNull no;
		pMap.Open(p_filename.c_str(), wxT("r"));
	}

	if (pMap.IsOpened() == false or pMap.Error() == true) {
		IOException ioe;
		ioe.setErrorMsg(errno, const_cast<wxString&>(p_filename));
		EXCEPT(IOException, ioe.what());
	}

	ObjectBuilder bld(p_doc);
	ObjectWriter  wrt(p_doc);
	FileManagerFactory fm;
	
	try {
		FileManager* file = fm.getFileManager(const_cast<wxString&>(p_filename), bld, wrt, true);
		file->load();
		///@todo re-enable error reporting from object builder
		//if (bld.hasErrors()) {
			//lastErrors = bld.getErrors();
		//} else {
			lastErrors = wxT("");
		//}

	} catch (ARInvalidTagException e) {
		throw ARInvalidFileType(e.what());
	} catch (ARInvalidFileType e) {
		throw ARInvalidFileType(e.what());
	} catch (...) {
		throw ARInvalidFileType(wxString(_("Unknown error occurred with file: ")) + p_filename);
	}
}

void fileSave(const wxString& p_filename, ARDocument* p_doc, bool p_overwrite) {
	ObjectBuilder bld(p_doc);
	ObjectWriter  wrt(p_doc);
	FileManagerFactory fm;

	FileManager* mgr = fm.getFileManager(const_cast<wxString&>(p_filename), bld, wrt, false);
	if (mgr != NULL) {
		if (wxFileExists(p_filename) and not(p_overwrite)) {
			throw FileExistsException(wxString(_("File exists: ") + p_filename));
		} else {
			wxFileOutputStream fos(p_filename);
			mgr->save(fos);
			fos.Close();
		}
	} else {
		throw ARInvalidFileType(wxString(_("Invalid file type for: ")) + p_filename);
	}
}

wxString fileGetLastErrors() {
	return(lastErrors);
}
