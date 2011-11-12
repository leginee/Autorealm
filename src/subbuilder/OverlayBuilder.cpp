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


#include "subbuilder/OverlayBuilder.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("OverlayBuilder"));

namespace subbuilderComponents
{

    void OverlayBuilder::startObject(BuilderStackEntry &p_tag)
    {
        TRACER(wxT("OverlayBuilder::startObject()"));
        if (p_tag.m_tag == wxT("document"))
        {
            TRACE(wxT("Using existing document"));
            p_tag.m_obj = m_doc;
        }
        if (p_tag.m_tag.Matches(wxT("overlay_*")))
        {
            TRACE(wxT("overlay tag: %s"), p_tag.m_tag.c_str());
            wxString tag = p_tag.m_tag;
            tag.Remove(0, 8);
            long int data;
            if (tag.ToLong(&data))
            {
                m_overlaynum = data;
            }
        }
    }
    
    void OverlayBuilder::endObject(const BuilderStackEntry &p_tag)
    {
        ARDocument* doc = dynamic_cast<ARDocument*>(p_tag.m_obj);
        wxASSERT(doc != NULL);
        wxString tag = p_tag.m_tag;
        wxString data = doc->m_extraData[tag];
        if (tag == wxT("name"))
        {
            if ((m_overlaynum >= 0) and (m_overlaynum <= MAX_OVERLAYS))
            {
                doc->setOverlayName(m_overlaynum, base64decode(data));
                doc->m_extraData.erase(doc->m_extraData.find(tag));
            }
        }
    }

}   // namespace subbuilderComponents