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

#ifndef GENERIC_LIBRARY_H
#define GENERIC_LIBRARY_H
#include <string>
#include <wx/string.h>

/**
 * @brief Round a given number to a given number of decimal places
 *
 * @param val The number to be rounded to
 * @param decimals the number of decimal places to round to. 2 would be
 * hundredths/pennies.
 * @return The number rounded to the specified number of decimal places.
 */
double round(double val, int decimals=0);

/**
 * This takes a wxString, and converts it into a std::string. I would make
 * this into a global macro, but I don't want to include wx/strconv.h in
 * every single file.
 *
 * @param str The wxString to be converted
 * @return a std::string built from the passed in string
 */
std::string wxToStd(const wxString& str);
#endif // GENERIC_LIBRARY_H
