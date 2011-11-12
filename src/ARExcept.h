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

#ifndef AREXCEPT_H
#define AREXCEPT_H

#include <errno.h>

#include <wx/wx.h>

/**
 * @brief Convenience macro for throwing an exception.
 *
 * This macro takes two arguments: The exception type to throw, and a
 * message. It then throws the exception type, using the file, line, and
 * message to create the new exception.
 *
 * @param EXCEPT_TYPE The type of exception to throw. This must be defined
 * in this file!
 *
 * @param EXCEPT_MSG The message to be given to the exception. This may be
 * either a string surround by wxT(), or a wxString object
 */
#define EXCEPT(EXCEPT_TYPE, EXCEPT_MSG) {\
	wxString except_msg;\
	except_msg.Printf(wxT("%s: Exception in file %s at line %d: %s"), wxT(#EXCEPT_TYPE), wxT(__FILE__), __LINE__, wxString(EXCEPT_MSG).c_str());\
	throw EXCEPT_TYPE(except_msg);\
}

/** 
 * @brief The root class for exceptions in AutoRealm
 *
 * This class is the root class for all exceptions in AutoRealm. All
 * exceptions should be descended from it.
 */
class ARException {
	public:
		/** 
		 * @brief The only valid constructor for the exceptions
		 * 
		 * @param p_msg The message to be given to the user when they
		 * see this exception
		 */
		ARException(const wxString& p_msg);

		/** 
		 * @brief Return the error message stored in this exception
		 * 
		 * @return The error message stored in this exception
		 */
		wxString what();

	protected:
		/** 
		 * @brief The error message for this exception
		 */
		wxString m_msg;
	
	private:
		/** 
		 * @brief What would ordinarily be the default constructor. Made
		 * private to prevent accidental usage.
		 */
		ARException() {};
};

/**
 * @brief Used when attempting to use/make an invalid color.
 */
class ARBadColorException : public ARException {
	public:
		/** 
		 * @brief Default constructor
		 * 
		 * @param p_msg Error message for the bad color
		 */
		ARBadColorException(const wxString& p_msg) : ARException(p_msg) {};
};

/**
 * @brief Used when attempting to use/make an invalid number (either
 * floating point or int).
 */
class ARBadNumberFormat : public ARException {
	public:
		/** 
		 * @brief Default constructor
		 * 
		 * @param p_msg Error message for the bad number format
		 */
		ARBadNumberFormat(const wxString& p_msg) : ARException(p_msg) {};
};



/** 
 * @brief Used when opening a file of an unknown type
 */
class ARInvalidFileType: public ARException {
	public: 
		/** 
		 * @brief Default constructor
		 * 
		 * @param p_msg Error message for invalid file type
		 */
		ARInvalidFileType(const wxString& p_msg) : ARException(p_msg) {};
};


/**
 * Used to indicate that the caller has tried to use an overlay which does
 * not exist
 */
class ARMissingOverlayException : public ARException {
	public:
		/** 
		 * @brief Default constructor
		 * 
		 * @param p_msg Error message for the bad number format
		 */
		ARMissingOverlayException(const wxString& p_msg) : ARException(p_msg) {};
};

/**:
 * Used to indicate an attempt to access a child (by index), and the index
 * is invalid
 */
class ARInvalidChildException : public ARException {
	public:
		/**
		 * @brief Default constructor
		 * 
		 * @param p_msg Error message for the bad number format
		 */
		ARInvalidChildException(const wxString& p_msg) : ARException(p_msg) {};
};

/**
 * Used to indicate an invalid tag was passed in for parsing
 */
class ARInvalidTagException : public ARException {
	public:
		/**
		 * @brief Default constructor
		 * 
		 * @param p_msg Error message for the bad number format
		 */
		ARInvalidTagException(const wxString& p_msg) : ARException(p_msg) {};
};

class ARInvalidBoolString : public ARException {
	public:
		/**
		 * @brief Default constructor
		 * 
		 * @param p_msg Error message for the bad number format
		 */
		ARInvalidBoolString(const wxString& p_msg) : ARException(p_msg) {};
};

/**
 * @brief Exception used when Pushpin PushpinCollection or PushpinHistory
 * is given invalid data
 */
class ARInvalidPushpin : public ARException {
	public:
		/**
		 * @brief Default constructor
		 * 
		 * @param p_msg Error message for the bad number format
		 */
		ARInvalidPushpin(const wxString& p_msg) : ARException(p_msg) {};
};

/*
 * IOException
 */


/** 
 * @brief Exception used for file I/O exceptions. setErrorMsg method
 *        requires the errno value to look up the appropriate 
 *        error text in strerror. It sticks this text into
 *        the m_msg result for easier reading.
 */
class IOException : public ARException {
	public:
		IOException() : ARException(wxT("")) {};
		IOException(wxString& p_msg) : ARException(p_msg) {};
		IOException(int p_errno, wxString& p_msg) : ARException(wxT("")) 
			{setErrorMsg(p_errno, p_msg);};
		void setErrorMsg(int p_errno, wxString& p_filename);
};

class FileExistsException : public ARException {
	public:
		FileExistsException(wxString p_msg) : ARException(p_msg) {};
};
#endif //AREXCEPT_H
