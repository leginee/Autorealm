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


#include "GridObjectModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("GridObjectModel"));


///////////////////////////////////////////////    
// Constructor and Destructor
/////////////////////////////////////////////// 

GridObjectModel::GridObjectModel()
: ObjectInterface(),
  m_boldUnits(5),
  m_currentGraphUnits(1),
  m_currentGridSize(1),
  m_flags(0),
  m_graphScale(1.0),
  m_graphUnitConvert(1.0),
  m_graphUnits(wxT("Feet")),
  m_position(0),
  m_primaryStyle(GridObjectModel::gpsDefault),
  m_secondaryStyle(GridObjectModel::gpsDefault),
  m_type(GridObjectModel::gtSquare)
{
	TRACER(wxT("GridObjectModel()"));
}


GridObjectModel::~GridObjectModel()
{
    TRACER(wxT("~GridObjectModel()"));
}


///////////////////////////////////////////////
// Inherit virtual methods
///////////////////////////////////////////////

bool GridObjectModel::compare(const ObjectInterface* p_other) const
{
    TRACER(wxT("GridObjectModel::compare(const ObjectInterface* p_other)"));
    bool retval = false;
    
    if (ObjectInterface::compare(p_other))
    {
        const GridObjectModel* grid = dynamic_cast<const GridObjectModel*>(p_other);
        if (grid != NULL)
        {
            retval = (m_boldUnits         == grid->m_boldUnits) 
                  && (m_currentGraphUnits == grid->m_currentGraphUnits)
                  && (m_currentGridSize   == grid->m_currentGridSize)
                  && (m_flags             == grid->m_flags)
                  && (m_graphScale        == grid->m_graphScale)
                  && (m_graphUnitConvert  == grid->m_graphUnitConvert)
                  && (m_graphUnits        == grid->m_graphUnits)
                  && (m_position          == grid->m_position)
                  && (m_primaryStyle      == grid->m_primaryStyle)
                  && (m_secondaryStyle    == grid->m_secondaryStyle)
                  && (m_type              == grid->m_type);
        }
    }
    return retval;
}


bool GridObjectModel::copy(const ObjectInterface* p_other)
{
    TRACER(wxT("GridObjectModel::copy(const ObjectInterface* p_other)"));
    bool retval = false;
    
    if (ObjectInterface::copy(p_other))
    {
        const GridObjectModel* grid = dynamic_cast<const GridObjectModel*>(p_other);
        if (grid != NULL)
        {
            m_boldUnits         = grid->m_boldUnits;
            m_currentGraphUnits = grid->m_currentGraphUnits;
            m_currentGridSize   = grid->m_currentGridSize;
            m_flags             = grid->m_flags;
            m_graphScale        = grid->m_graphScale;
            m_graphUnitConvert  = grid->m_graphUnitConvert;
            m_graphUnits        = grid->m_graphUnits;
            m_position          = grid->m_position;
            m_primaryStyle      = grid->m_primaryStyle;
            m_secondaryStyle    = grid->m_secondaryStyle;
            m_type              = grid->m_type;
        
            retval = true;
        }
    }
    return retval;
}


bool GridObjectModel::isValid() const
{
	TRACER(wxT("iGridObjectModel::sValid()"));
    
	return ObjectInterface::isValid();
}


///////////////////////////////////////////////
// Getter and Setter Methods
///////////////////////////////////////////////

int GridObjectModel::getBoldUnits() const
{
    TRACER(wxT("getBoldUnits()"));
    return m_boldUnits;
}


int GridObjectModel::getCurrentGraphUnits() const
{
    TRACER(wxT("getCurrentGraphUnits()"));
    return m_currentGraphUnits;
}


double GridObjectModel::getCurrentGridSize() const
{
    TRACER(wxT("getCurrentGridSize()"));
    return m_currentGridSize;
}


unsigned int GridObjectModel::getFlags() const
{
    TRACER(wxT("getFlags()"));
    return m_flags;
}


double GridObjectModel::getGraphScale() const
{
    TRACER(wxT("getGraphScale()"));
    return m_graphScale;
}


double GridObjectModel::getGraphUnitConvert() const
{
    TRACER(wxT("getGraphUnitConvert()"));
    return m_graphUnitConvert;
}


wxString GridObjectModel::getGraphUnits() const
{
    TRACER(wxT("getGraphUnits()"));
    return m_graphUnits;
}


unsigned int GridObjectModel::getPosition() const
{
    TRACER(wxT("getPosition()"));
    return m_position;
}


GridObjectModel::GridPenStyle GridObjectModel::getPrimaryStyle() const
{
    TRACER(wxT("getPrimaryStyle()"));
    return m_primaryStyle;
}


GridObjectModel::GridPenStyle GridObjectModel::getSecondaryStyle() const
{
    TRACER(wxT("getSecondaryStyle()"));
    return m_secondaryStyle;
}


GridObjectModel::GridType GridObjectModel::getType() const
{
    TRACER(wxT("getType()"));
    return m_type;
}


void GridObjectModel::setBoldUnits(unsigned int p_units)
{
    TRACER(wxT("setBoldUnits(unsigned int p_units)"));
    m_boldUnits = p_units;
}


void GridObjectModel::setCurrentGraphUnits(unsigned int p_units)
{
    TRACER(wxT("setCurrentGraphUnits(unsigned int p_units)"));
    m_currentGraphUnits = p_units;
}


void GridObjectModel::setCurrentGridSize(double p_size)
{
    TRACER(wxT("setCurrentGridSize(double p_size)"));
    m_currentGridSize = p_size;
}


void GridObjectModel::setFlags(unsigned int p_flags)
{
    TRACER(wxT("setFlags(unsigned int p_flags)"));
    m_flags = p_flags;
}


void GridObjectModel::setGraphScale(double p_scale)
{
	TRACER(wxT("setGraphScale(double p_scale)"));
	m_graphScale = p_scale;
}


void GridObjectModel::setGraphUnitConvert(double p_convert)
{
	TRACER(wxT("setGraphUnitConvert(double p_convert)"));
	m_graphUnitConvert = p_convert;
}


void GridObjectModel::setGraphUnits(const wxString& p_units)
{
	TRACER(wxT("setGraphUnits(const wxString& p_units)"));
	m_graphUnits = p_units;
}


void GridObjectModel::setPosition(unsigned int p_position)
{
    TRACER(wxT("setPosition(unsigned int p_position)"));
    m_position = p_position;
}


void GridObjectModel::setPrimaryStyle(GridObjectModel::GridPenStyle p_style)
{
    TRACER(wxT("setPrimaryStyle(GridPenStyle p_style)"));
    m_primaryStyle = p_style;
}


void GridObjectModel::setSecondaryStyle(GridObjectModel::GridPenStyle p_style)
{
    TRACER(wxT("setSecondaryStyle(GridPenStyle p_style)"));
    m_secondaryStyle = p_style;
}


void GridObjectModel::setType(GridObjectModel::GridType p_type)
{
	TRACER(wxT("setType(GridType p_type)"));
	m_type = p_type;
}
