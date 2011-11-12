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


#include "subbuilder/CurveModelBuilder.h"
#include "CurveModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("CurveModelBuilder"));


namespace subbuilderComponents
{

    void CurveModelBuilder::startObject(BuilderStackEntry &p_tag)
    {
        TRACER(wxT("CurveModelBuilder::startObject"));
        if (p_tag.m_tag == wxT("curve"))
        {
            TRACE(wxT("new CurveModel"));
            p_tag.m_obj = new CurveModel;
        }
    }
    
    void CurveModelBuilder::endObject(const BuilderStackEntry &p_tag)
    {
        TRACER(wxT("CurveModelBuilder::endObject"));
        CurveModel* curve = dynamic_cast<CurveModel*>(p_tag.m_obj);
        wxASSERT(curve != NULL);
        wxString tag = p_tag.m_tag;
        wxString data = curve->m_extraData[tag];
        if (p_tag.m_tag == wxT("color"))
        {
            TRACE(wxT("color: %s"), data.c_str());
            long int color = 0;
            if (!data.ToLong(&color))
            {
                EXCEPT(ARBadColorException, wxT("problem with curve color tag data"));
            }                
            curve->setColor(LongToColor(color));
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("overlay_id"))
        {
            TRACE(wxT("overlay_id: %s"), data.c_str());
            OverlayVector overlays = StringToOverlayVector(data);
            curve->setOverlays(overlays);
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("extent"))
        {
            TRACE(wxT("extent: %s"), data.c_str());
            // do nothing because we will calc extent
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("selected"))
        {
            TRACE(wxT("selected: %s"), data.c_str());
            curve->setSelected(StringToBool(data));
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("p1"))
        {
            TRACE(wxT("p1: %s"), data.c_str());
            arRealPoint point = StringToPoint(data);
            curve->setPoint(0, point, false);
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("p2"))
        {
            TRACE(wxT("p2: %s"), data.c_str());
            arRealPoint point = StringToPoint(data);
            curve->setPoint(1, point, false);
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("p3"))
        {
            TRACE(wxT("p3: %s"), data.c_str());
            arRealPoint point = StringToPoint(data);
            curve->setPoint(2, point, false);
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("p4"))
        {
            TRACE(wxT("p4: %s"), data.c_str());
            arRealPoint point = StringToPoint(data);
            // read last point, start recalc of extent
            curve->setPoint(3, point, true);
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("style"))
        {
            TRACE(wxT("style: %s"), data.c_str());
            StyleAttrib style = { 1 }; // = StringToStyle(data);
            curve->setStyle(style);
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("thickness"))
        {
            TRACE(wxT("thickness: %s"), data.c_str());
            long int thickness = 0;
            if (!data.ToLong(&thickness))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with curve thickness tag data"));
            }
            curve->setThickness(thickness);
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("fractal"))
        {
            TRACE(wxT("fractal: %s"), data.c_str());
            curve->setFractal(StringToBool(data));
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("sthickness"))
        {
            TRACE(wxT("sthickness: %s"), data.c_str());
            long int sthickness = 0;
            if (!data.ToLong(&sthickness))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with curve sthickness tag data"));
            }
            curve->setSthickness(sthickness);
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("seed"))
        {
            TRACE(wxT("seed: %s"), data.c_str());
            long int seed = 0;
            if (!data.ToLong(&seed))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with curve seed tag data"));
            }
            curve->setSeed(seed);
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("roughness"))
        {
            TRACE(wxT("roughness: %s"), data.c_str());
            long int roughness = 0;
            if (!data.ToLong(&roughness))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with curve roughness tag data"));
            }
            curve->setRoughness(roughness);
            curve->m_extraData.erase(curve->m_extraData.find(tag));
        }            
    }

}   // namespace subbuilderComponents