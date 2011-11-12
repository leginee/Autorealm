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


#include "subbuilder/ViewPointBuilder.h"
#include "ViewPointModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("ViewPointBuilder"));

namespace subbuilderComponents
{

    void ViewPointBuilder::startObject(BuilderStackEntry &p_tag)
    {
        TRACER(wxT("ViewPointBuilder::startObject"));
        if (p_tag.m_tag == wxT("viewpoint"))
        {
            TRACE(wxT("new ViewPointModel"));
            p_tag.m_obj = new ViewPointModel;
        }
    }
    
    void ViewPointBuilder::endObject(const BuilderStackEntry &p_tag)
    {
        TRACER(wxT("ViewPointBuilder::endObject"));
        ViewPointModel* view = dynamic_cast<ViewPointModel*>(p_tag.m_obj);
        wxASSERT(view != NULL);
        wxString tag = p_tag.m_tag;
        wxString data = view->m_extraData[tag];
        if (p_tag.m_tag == wxT("name"))
        {
            TRACE(wxT("name: %s"), data.c_str());
            view->setName(data);
            view->m_extraData.erase(view->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("clientwidth"))
        {
            TRACE(wxT("clientwidth: %s"), data.c_str());
            double width;
            if (!data.ToDouble(&width))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid width"));
            }
            view->setWidth(width);
            view->m_extraData.erase(view->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("clientheight"))
        {
            TRACE(wxT("clientheight: %s"), data.c_str());
            double height;
            if (!data.ToDouble(&height))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid height"));
            }
            view->setHeight(height);
            view->m_extraData.erase(view->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("area"))
        {
            TRACE(wxT("area: %s"), data.c_str());
            view->setArea(StringToRect(data));
            view->m_extraData.erase(view->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("visible_overlays"))
        {
            TRACE(wxT("visible_overlays: %s"), data.c_str());
            OverlayVector overlays = StringToOverlayVector(data);
            view->setActiveOverlays(overlays);
            view->m_extraData.erase(view->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("active_overlays"))
        {
            TRACE(wxT("active_overlays: %s"), data.c_str());
            OverlayVector overlays = StringToOverlayVector(data);
            view->setVisibleOverlays(overlays);
            view->m_extraData.erase(view->m_extraData.find(tag));
        }
    }

}   // namespace subbuilderComponents