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


#include "subbuilder/GroupModelBuilder.h"
#include "GroupModel.h"
#include "DrawnObjectModel.h" 
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("GroupModelBuilder"));

namespace subbuilderComponents
{

    void GroupModelBuilder::startObject(BuilderStackEntry &p_tag)
    {
        TRACER(wxT("GroupModelBuilder::startObject()"));
        if (p_tag.m_tag == wxT("drawchain"))
        {
            TRACE(wxT("Making new group model"));
            p_tag.m_obj = new GroupModel;
        }
    }
    
    void GroupModelBuilder::endObject(const BuilderStackEntry &p_tag)
    {
        DrawnObjectModel* dom = dynamic_cast<DrawnObjectModel*>(p_tag.m_obj);
        wxASSERT(p_tag.m_obj != NULL);
        wxASSERT(dom != NULL);
        wxString tag = p_tag.m_tag;
        if (ProcessTag(dom, p_tag.m_tag, p_tag.m_obj->m_extraData[p_tag.m_tag]))
        {
            dom->m_extraData.erase(dom->m_extraData.find(tag));
        }
    }

}   // namespace subbuilderComponents