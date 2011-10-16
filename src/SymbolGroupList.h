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
#ifndef SYMBOLGROUPLIST_H
#define SYMBOLGROUPLIST_H
#include "globals.h"
#include <wx/xrc/xmlres.h>

#include "Symbol.h"
#include "SymbolGroup.h"

/**
 * @class SymbolGroupList
 *
 * @brief This class is used to BRIEFDESC
 *
 * FULLDESC
 */
class SymbolGroupList {
    public:
        /**
         * @brief Default constructor
         */
        SymbolGroupList();
		~SymbolGroupList();

		void Clear();

		void Save(wxString symdir);
		void Load(wxString symdir);

		int Count();

		void NewGroup(wxString name);
		void OpenGroup(wxString filename);
		void DeleteGroup(SymbolGroup which);

		SymbolGroup FirstGroup();
		SymbolGroup NextGroup(SymbolGroup p);

		SymbolGroup FindGroup(wxString name);
		
		wxString CreateReference(SymbolGroup grp, Symbol sym);
		Symbol GetReference(wxString ref);

		int RemoveCachedImage(int index);

		SymbolGroup GroupHead;
		wxString symboldirectory;
};
#endif //SYMBOLGROUPLIST_H
