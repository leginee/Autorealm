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


#include "subbuilder/LineModelBuilder.h"
#include "LineModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("LineModelBuilder"));

namespace subbuilderComponents
{

    void LineModelBuilder::startObject(BuilderStackEntry &p_tag)
    {
        TRACER(wxT("LineModelBuilder::startObject"));
        if (p_tag.m_tag == wxT("line"))
        {
            TRACE(wxT("new LineModel"));
            p_tag.m_obj = new LineModel;
        }
    }
    
    void LineModelBuilder::endObject(const BuilderStackEntry &p_tag)
    {
        TRACER(wxT("LineModelBuilder::endObject"));
        LineModel* line = dynamic_cast<LineModel*>(p_tag.m_obj);
        wxASSERT(line != NULL);
        wxString tag = p_tag.m_tag;
        wxString data = line->m_extraData[tag];
        if (p_tag.m_tag == wxT("color"))
        {
            TRACE(wxT("color: %s"), data.c_str());
            long int color = 0;
            if (!data.ToLong(&color))
            {
                EXCEPT(ARBadColorException, wxT("problem with line color tag data"));
            }                
            line->setColor(LongToColor(color));
            line->m_extraData.erase(line->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("overlay_id"))
        {
            TRACE(wxT("overlay_id: %s"), data.c_str());
            OverlayVector overlays = StringToOverlayVector(data);
            line->setOverlays(overlays);
            line->m_extraData.erase(line->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("extent"))
        {
            TRACE(wxT("extent: %s"), data.c_str());
            // do nothing because we will calc extent
            line->m_extraData.erase(line->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("selected"))
        {
            TRACE(wxT("selected: %s"), data.c_str());
            line->setSelected(StringToBool(data));
            line->m_extraData.erase(line->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("x1"))
        {
            TRACE(wxT("x1: %s"), data.c_str());
            double x1 = 0.0;
            if (!data.ToDouble(&x1))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with line x1 tag data"));
            }
            line->setX1(x1, false);
            line->m_extraData.erase(line->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("y1"))
        {
            TRACE(wxT("y1: %s"), data.c_str());
            double y1 = 0.0;
            if (!data.ToDouble(&y1))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with line y1 tag data"));
            }
            line->setY1(y1, false);
            line->m_extraData.erase(line->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("x2"))
        {
            TRACE(wxT("x2: %s"), data.c_str());
            double x2 = 0.0;
            if (!data.ToDouble(&x2))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with line x2 tag data"));
            }
            line->setX2(x2, false);
            line->m_extraData.erase(line->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("y2"))
        {
            TRACE(wxT("y2: %s"), data.c_str());
            double y2 = 0.0;
            if (!data.ToDouble(&y2))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with line y2 tag data"));
            }
            // read last point, start recalc of extent
            line->setY2(y2, true);
            line->m_extraData.erase(line->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("style"))
        {
            TRACE(wxT("style: %s"), data.c_str());
            StyleAttrib style = { 1 }; // = StringToStyle(data);
            line->setStyle(style);
            line->m_extraData.erase(line->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("thickness"))
        {
            TRACE(wxT("thickness: %s"), data.c_str());
            long int thickness = 0;
            if (!data.ToLong(&thickness))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with line thickness tag data"));
            }
            line->setThickness(thickness);
            line->m_extraData.erase(line->m_extraData.find(tag));
        } 
        else if (p_tag.m_tag == wxT("fractal"))
        {
            TRACE(wxT("fractal: %s"), data.c_str());
            line->setFractal(StringToBool(data));
            line->m_extraData.erase(line->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("sthickness"))
        {
            TRACE(wxT("sthickness: %s"), data.c_str());
            long int sthickness = 0;
            if (!data.ToLong(&sthickness))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with line sthickness tag data"));
            }
            line->setSthickness(sthickness);
            line->m_extraData.erase(line->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("seed"))
        {
            TRACE(wxT("seed: %s"), data.c_str());
            long int seed = 0;
            if (!data.ToLong(&seed))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with line seed tag data"));
            }
            line->setSeed(seed);
            line->m_extraData.erase(line->m_extraData.find(tag));
        }
        else if (p_tag.m_tag == wxT("roughness"))
        {
            TRACE(wxT("roughness: %s"), data.c_str());
            long int roughness = 0;
            if (!data.ToLong(&roughness))
            {
                EXCEPT(ARBadNumberFormat, wxT("problem with line roughness tag data"));
            }
            line->setRoughness(roughness);
            line->m_extraData.erase(line->m_extraData.find(tag));
        }            
    }

}   // namespace subbuilderComponents