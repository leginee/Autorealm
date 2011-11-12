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


#include "subbuilder/PolyCurveModelBuilder.h"
#include "PolyCurveModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("PolyCurveModelBuilder"));

namespace subbuilderComponents
{

    void PolyCurveModelBuilder::startObject(BuilderStackEntry &p_tag)
    {
        TRACER(wxT("PolyCurveModelBuilder::startObject"));
        if (p_tag.m_tag == wxT("polycurve"))
        {
            TRACE(wxT("new PolyCurveModel"));
            p_tag.m_obj = new PolyCurveModel;
        }
    }
    
    void PolyCurveModelBuilder::endObject(const BuilderStackEntry &p_tag)
    {
        TRACER(wxT("PolyCurveModelBuilder::endObject"));
        PolyCurveModel* pcurve = dynamic_cast<PolyCurveModel*>(p_tag.m_obj);
        wxASSERT(pcurve != NULL);
        wxString tag = p_tag.m_tag;
        wxString data = pcurve->m_extraData[tag];
        if (p_tag.m_tag == wxT("color"))
        {
            TRACE(wxT("color: %s"), data.c_str());
            long int color = 0;
            if (!data.ToLong(&color))
            {
                EXCEPT(ARBadColorException, wxT("problem with polycurve color tag data"));
            }                
            pcurve->setColor(LongToColor(color));
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("overlay_id"))
        {
            TRACE(wxT("overlay_id: %s"), data.c_str());
            OverlayVector overlays = StringToOverlayVector(data);
            pcurve->setOverlays(overlays);
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("extent"))
        {
            TRACE(wxT("extent: %s"), data.c_str());
            // do nothing because we will calc extent
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("selected"))
        {
            TRACE(wxT("selected: %s"), data.c_str());
            pcurve->setSelected(StringToBool(data));
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("fillcolor"))
        {
            TRACE(wxT("fillcolor: %s"), data.c_str());
            long int fillColor = 0;
            if (!data.ToLong(&fillColor))
            {
                EXCEPT(ARBadColorException, wxT("problem with polycurve fillcolor tag data"));
            }                
            pcurve->setFillColor(LongToColor(fillColor));
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("count"))
        {
            TRACE(wxT("count: %s"), data.c_str());
            long int count = 0;
            if (!data.ToLong(&count))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with polycurve count tag data"));
            }
            m_pointCounter = count;
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("points"))
        {
            TRACE(wxT("points: %s"), data.c_str());
            VPoints points = StringToVPoints(data, m_pointCounter);
            pcurve->setPoints(points, true);
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("style"))
        {
            TRACE(wxT("style: %s"), data.c_str());
            StyleAttrib style = { 1 }; // = StringToStyle(data);
            pcurve->setStyle(style);
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("thickness"))
        {
            TRACE(wxT("thickness: %s"), data.c_str());
            long int thickness = 0;
            if (!data.ToLong(&thickness))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with polycurve thickness tag data"));
            }
            pcurve->setThickness(thickness);
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("fractal"))
        {
            TRACE(wxT("fractal: %s"), data.c_str());
            pcurve->setFractal(StringToBool(data));
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("sthickness"))
        {
            TRACE(wxT("sthickness: %s"), data.c_str());
            long int sthickness = 0;
            if (!data.ToLong(&sthickness))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with polycurve sthickness tag data"));
            }
            pcurve->setSthickness(sthickness);
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("seed"))
        {
            TRACE(wxT("seed: %s"), data.c_str());
            long int seed = 0;
            if (!data.ToLong(&seed))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with polycurve seed tag data"));
            }
            pcurve->setSeed(seed);
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("roughness"))
        {
            TRACE(wxT("roughness: %s"), data.c_str());
            long int roughness = 0;
            if (!data.ToLong(&roughness))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with polycurve roughness tag data"));
            }
            pcurve->setRoughness(roughness);
            pcurve->m_extraData.erase(pcurve->m_extraData.find(tag));
        }            
    }

}   // namespace subbuilderComponents