/*
 * Port of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
 * Used in rpgs and hobbyist GIS applications for mapmaking
 * Copyright 2004-2006 The AutoRealm Team (http://www.autorealm.org/)
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
#include <wx/string.h>

/** 
 * @brief Convenience routine for converting a string into its base64
 * representation. Calls base64encode(const void* data, const int len)
 * 
 * @param data The string to encode into base64
 * 
 * @return The encoded string
 */
wxString base64encode(const wxString& data);

/** 
 * @brief The workhorse for encoding, converts raw memory, one byte at a
 * time, into a wxString representation
 * 
 * @param data A pointer to the memory holding the data to be converted
 * @param len How much memory to convert, in bytes
 * 
 * @return The encoded string
 */
wxString base64encode(const void* data, const int len);

/** 
 * @brief The main workhorse decoder. Converts from a wxString into the
 * equivalent memory representation. Returns the length of the converted
 * memory into the integer referenced by len, and the data stored as a
 * void*.
 * 
 * @param instring The string to be decoded
 * @param len An "out" parameter that contains the length of the memory
 * which was decoded.
 *
 * @return A pointer to the decoded data. Note that the caller is
 * responsible for deleting this data!
 */
void* base64decode(const wxString& instring, int& len);

/** 
 * @brief A convenience routine for decoding base64 into a wxString
 * 
 * This uses base64decode(void* data, int len).
 *
 * @param instring The base64 encoded string
 * 
 * @return The decoded string, as a string
 */
wxString base64decode(const wxString& instring);
