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


#include "subbuilder/PushpinBuilder.h"
#include "Pushpin.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("PushpinBuilder"));

namespace subbuilderComponents
{

    void PushpinBuilder::startObject(BuilderStackEntry &p_tag)
    {
        TRACER(wxT("PushpinBuilder::startObject()"));
        if (p_tag.m_tag.Matches(wxT("pin_history_*")))
        {
            TRACE(wxT("overlay tag: %s"), p_tag.m_tag.c_str());
            wxString tag = p_tag.m_tag;
            tag.Remove(0, 12);
            long int data;
            if (tag.ToLong(&data))
            {
                m_pinnum = data;
            }
        }
        else if (p_tag.m_tag.Matches(wxT("pin_*")))
        {
            TRACE(wxT("overlay tag: %s"), p_tag.m_tag.c_str());
            wxString tag = p_tag.m_tag;
            tag.Remove(0, 4);
            long int data;
            if (tag.ToLong(&data))
            {
                m_pinnum = data;
            }
        }
    }
    
    void PushpinBuilder::endObject(const BuilderStackEntry &p_tag)
    {
        TRACER(wxT("PushpinBuilder::endObject"));
        ARDocument* doc = dynamic_cast<ARDocument*>(p_tag.m_obj);
        wxASSERT(doc != NULL);
        wxString tag = p_tag.m_tag;
        wxString data = doc->m_extraData[tag];
        PushpinCollection pins;
        if (tag == wxT("waypoints_visible"))
        {
            TRACE(wxT("%s: %s"), tag.c_str(), data.c_str());
            pins = doc->getPushpins();
            pins.m_waypointsVisible = StringToBool(data);
            doc->setPushpins(pins);
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("show_number"))
        {
            TRACE(wxT("%s: %s"), tag.c_str(), data.c_str());
            pins = doc->getPushpins();
            pins.m_showNumber = StringToBool(data);
            doc->setPushpins(pins);
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("show_note"))
        {
            TRACE(wxT("%s: %s"), tag.c_str(), data.c_str());
            pins = doc->getPushpins();
            pins.m_showNote = StringToBool(data);
            doc->setPushpins(pins);
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("name"))
        {
            TRACE(wxT("%s: %s"), tag.c_str(), data.c_str());
            Pushpin pin = doc->getPushpin(m_pinnum);
            pin.m_name = base64decode(data);
            doc->setPushpin(m_pinnum, pin);
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("hist_"))
        {
            TRACE(wxT("%s: %s"), tag.c_str(), data.c_str());
            PushpinHistory hst;
            Pushpin pin = doc->getPushpin(m_pinnum);
            hst.m_point = pin.m_point;
            hst.m_note  = doc->m_extraData[wxT("note")];
            pin.addHist(hst);
            doc->setPushpin(m_pinnum, pin);
            doc->m_extraData.erase(doc->m_extraData.find(tag));
            doc->m_extraData.erase(doc->m_extraData.find(wxT("note")));
        }
        else if (tag == wxT("note"))
        {
            TRACE(wxT("%s: %s"), tag.c_str(), data.c_str());
            doc->m_extraData[tag] = base64decode(data);
        }
        else if (tag == wxT("checked"))
        {
            TRACE(wxT("%s: %s"), tag.c_str(), data.c_str());
            Pushpin pin = doc->getPushpin(m_pinnum);
            pin.m_checked = StringToBool(data);
            doc->setPushpin(m_pinnum, pin);
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("placed"))
        {
            TRACE(wxT("%s: %s"), tag.c_str(), data.c_str());
            Pushpin pin = doc->getPushpin(m_pinnum);
            pin.m_placed = StringToBool(data);
            doc->setPushpin(m_pinnum, pin);
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
        else if (tag == wxT("point"))
        {
            TRACE(wxT("%s: %s"), tag.c_str(), data.c_str());
            Pushpin pin = doc->getPushpin(m_pinnum);
            pin.m_point = StringToPoint(data);
            doc->setPushpin(m_pinnum, pin);
            doc->m_extraData.erase(doc->m_extraData.find(tag));
        }
    }

}   // namespace subbuilderComponents