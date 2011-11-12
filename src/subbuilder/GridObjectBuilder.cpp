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


#include "subbuilder/GridObjectBuilder.h"
#include "GridObjectModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("GridObjectBuilder"));

namespace subbuilderComponents
{

    void GridObjectBuilder::startObject(BuilderStackEntry &p_tag)
    {
        TRACER(wxT("GridObjectBuilder::startObject()"));
        if (p_tag.m_tag == wxT("gridobject"))
        {
            TRACE(wxT("new GridObjectModel"));
            p_tag.m_obj = new GridObjectModel;
        }
    }
    
    void GridObjectBuilder::endObject(const BuilderStackEntry &p_tag)
    {
        TRACER(wxT("GridObjectBuilder::endObject"));
        GridObjectModel* grid = dynamic_cast<GridObjectModel*>(p_tag.m_obj);
        wxASSERT(grid != NULL);
        wxString tag = p_tag.m_tag;
        wxString data = grid->m_extraData[tag];
        if (tag == wxT("graph_scale"))
        {
            TRACE(wxT("graph_scale: %s"), data.c_str());
            double ddata;
            if (!data.ToDouble(&ddata))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid graph scale"));
            }
            grid->setGraphScale(ddata);
            grid->m_extraData.erase(grid->m_extraData.find(tag));
        }
        else if (tag == wxT("graph_unit_convert"))
        {
            TRACE(wxT("graph_unit_convert: %s"), data.c_str());
            double ddata;
            if (!data.ToDouble(&ddata))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid graph unit conversion"));
            }
            grid->setGraphUnitConvert(ddata);
            grid->m_extraData.erase(grid->m_extraData.find(tag));
        }
        else if (tag == wxT("graph_units"))
        {
            TRACE(wxT("graph_units: %s"), data.c_str());
            grid->setGraphUnits(data);
            grid->m_extraData.erase(grid->m_extraData.find(tag));
        }
        else if (tag == wxT("current_graph_units"))
        {
            TRACE(wxT("current_graph_units: %s"), data.c_str());
            long ddata;
            if (!data.ToLong(&ddata))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid current graph units"));
            }
            grid->setCurrentGraphUnits(ddata);
            grid->m_extraData.erase(grid->m_extraData.find(tag));
        }
        else if (tag == wxT("current_size"))
        {
            TRACE(wxT("current_size: %s"), data.c_str());
            double ddata;
            if (!data.ToDouble(&ddata))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid current size"));
            }
            grid->setCurrentGridSize(ddata);
            grid->m_extraData.erase(grid->m_extraData.find(tag));
        }
        else if (tag == wxT("type"))
        {
            TRACE(wxT("type: %s"), data.c_str());
            grid->setType(StringToGridType(data));
            grid->m_extraData.erase(grid->m_extraData.find(tag));
        }
        else if (tag == wxT("bold_units"))
        {
            TRACE(wxT("bold_units: %s"), data.c_str());
            long ddata;
            if (!data.ToLong(&ddata))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid bold units"));
            }
            grid->setBoldUnits(ddata);
            grid->m_extraData.erase(grid->m_extraData.find(tag));
        }
        else if (tag == wxT("flags"))
        {
            TRACE(wxT("flags: %s"), data.c_str());
            long ddata;
            if (!data.ToLong(&ddata))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid flags"));
            }
            grid->setFlags(ddata);
            grid->m_extraData.erase(grid->m_extraData.find(tag));
        }
        else if (tag == wxT("position"))
        {
            TRACE(wxT("position: %s"), data.c_str());
            long ddata;
            if (!data.ToLong(&ddata))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid position"));
            }
            grid->setPosition(ddata);
            grid->m_extraData.erase(grid->m_extraData.find(tag));
        }
        else if (tag == wxT("primary_style"))
        {
            TRACE(wxT("primary_style: %s"), data.c_str());
            grid->setPrimaryStyle(StringToGridPenStyle(data));
            grid->m_extraData.erase(grid->m_extraData.find(tag));
        }
        else if (tag == wxT("secondary_style"))
        {
            TRACE(wxT("secondary_style: %s"), data.c_str());
            grid->setSecondaryStyle(StringToGridPenStyle(data));
            grid->m_extraData.erase(grid->m_extraData.find(tag));
        }
    }

}   // namespace subbuilderComponents