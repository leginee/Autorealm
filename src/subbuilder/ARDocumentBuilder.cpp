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


#include "subbuilder/ARDocumentBuilder.h"
#include "Tracer.h"

/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("ARDocumentBuilder"));

namespace subbuilderComponents
{

    void ARDocumentBuilder::startObject(BuilderStackEntry &p_tag)
    {
        TRACER(wxT("ARDocumentBuilder::startObject()"));
        if (p_tag.m_tag == wxT("document"))
        {
            TRACE(wxT("Using existing document"));
            p_tag.m_obj = m_doc;
        }
    }
    
    void ARDocumentBuilder::endObject(const BuilderStackEntry &p_tag)
    {
        TRACER(wxT("ARDocumentBuilder::endObject"));
        ARDocument* doc = dynamic_cast<ARDocument*>(p_tag.m_obj);
        wxASSERT(doc != NULL);
        wxString tag = p_tag.m_tag;
        wxString data = doc->m_extraData[tag];
        if (tag == wxT("version"))
        {
            TRACE(wxT("version: %s"), data.c_str());
            long int version = 0;
            if (!data.ToLong(&version))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid version number"));
            }
            doc->setVersion(version);
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("current_grid_color"))
        {
            TRACE(wxT("current_grid_color: %s"), data.c_str());
            long int color = 0;
            if (!data.ToLong(&color))
            {
                EXCEPT(ARBadColorException, wxT("problem with current grid color tag data"));
            }
            doc->setGridColor(LongToColor(color));
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("background_color"))
        {
            TRACE(wxT("background_color: %s"), data.c_str());
            long int color = 0;
            if (!data.ToLong(&color))
            {
                EXCEPT(ARBadColorException, wxT("problem with background grid color tag data"));
            }
            doc->setBgColor(LongToColor(color));
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("comments"))
        {
            TRACE(wxT("comments: %s"), data.c_str());
            doc->setComments(base64decode(data));
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("landscape"))
        {
            TRACE(wxT("landscape: %s"), data.c_str());
            doc->setLandscape(StringToBool(data));
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("snaptogrid"))
        {
            TRACE(wxT("snaptogrid: %s"), data.c_str());
            doc->setSnapToGrid(StringToBool(data));
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("snaptopoint"))
        {
            TRACE(wxT("snaptopoint: %s"), data.c_str());
            doc->setSnapToPoint(StringToBool(data));
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("snapalong"))
        {
            TRACE(wxT("snapalong: %s"), data.c_str());
            doc->setSnapAlong(StringToBool(data));
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("rotatesnap"))
        {
            TRACE(wxT("rotatesnap: %s"), data.c_str());
            doc->setRotateSnap(StringToBool(data));
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("displaygrid"))
        {
            TRACE(wxT("displaygrid: %s"), data.c_str());
            doc->setDisplayGrid(StringToBool(data));
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("designgridunits"))
        {
            TRACE(wxT("designgridunits: %s"), data.c_str());
            long int units = 0;
            if (!data.ToLong(&units))
            {
                EXCEPT(ARBadNumberFormat,wxT ("Invalid design grid units"));
            }
            doc->setDesignGridUnits(units);
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
    }

}   // namespace subbuilderComponents