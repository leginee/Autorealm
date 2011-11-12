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
#include <iostream>

#include "ObjectInterface.h"
#include "ViewPointModel.h"
#include "ARDocument.h"
#include "GridObjectModel.h"
#include "DrawnObjectModel.h"
#include "GroupModel.h"
#include "arRealTypes.h"
#include "Pushpin.h"

#include <wx/wx.h>

#define SZOUT(CLASS) std::cout<< "sizeof(" #CLASS "): " << sizeof(CLASS) << std::endl;

extern void PrintHeader(const char * szHeading);
extern void PrintFooter();

/**
 * Main driver for the sizes output. This is a simple test, meant to help us
 * keep track of sizes of various primitives, so we can try to keep them small
 * (and see when we're letting them get too big).
 *
 * All we really have to do is include the proper header file, and add another
 * line (such as the one below) whenever we create another primitive.
 */
void sizesTest() {
	
	PrintHeader("Primitives");
	SZOUT(arRealPoint);
	SZOUT(arRealRect);
	SZOUT(wxColor);
	PrintFooter();
	
	PrintHeader("Model Objects");
	SZOUT(ObjectInterface);
	SZOUT(ARDocument);
	SZOUT(ViewPointModel);
	SZOUT(GridObjectModel);
	SZOUT(Pushpin);
	SZOUT(DrawnObjectModel);
	SZOUT(GroupModel);
	PrintFooter();
}
