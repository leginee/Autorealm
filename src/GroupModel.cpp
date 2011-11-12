/*
 * Rewrite of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
 * Used in rpgs and hobbyist GIS applications for mapmaking
 * Copyright (C) 2004 Michael J. Pedersen <m.pedersen@icelus.org>,
 *                    Michael D. Condon <mcondon@austin.rr.com>
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


#include "GroupModel.h"
#include "Tracer.h"


/**
 * @brief Add this traceflag to the list of available traceflags
 */
TRACEFLAG(wxT("GroupModel"));


GroupModel::GroupModel()
: DrawnObjectModel()
{
	TRACER(wxT("GroupModel()"));
}


GroupModel::~GroupModel()
{
	TRACER(wxT("~GroupModel()"));
}


bool GroupModel::compare(const ObjectInterface* p_other) const
{
	TRACER(wxT("compare(const ObjectInterface*)"));
	bool retval = false;
	
    if (DrawnObjectModel::compare(p_other))
    {
    	GroupModel* grp = const_cast<GroupModel*>(dynamic_cast<const GroupModel*>(p_other));
    	if (grp != NULL)
        {
        	// don't compare the children!
        	retval = true;
    	}
    }
	return retval;
}
