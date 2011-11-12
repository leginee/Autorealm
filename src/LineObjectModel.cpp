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


#include "LineObjectModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("LineObjectModel"));


LineObjectModel::LineObjectModel()
: DrawnObjectModel(),
  m_style(StyleAttrib()),
  m_sthickness(0),
  m_thickness(0),
  m_fractal(false),
  m_roughness(0),
  m_seed(0) 
{
    TRACER(wxT("LineObjectModel()"));
}


LineObjectModel::LineObjectModel(StyleAttrib p_style)
: DrawnObjectModel(),
  m_style(p_style),
  m_sthickness(0),
  m_thickness(0),
  m_fractal(false),
  m_roughness(0),
  m_seed(0) 
{
    TRACER(wxT("LineObjectModel(p_style)"));
}


LineObjectModel::LineObjectModel(int p_seed, int p_roughness, StyleAttrib p_style, bool p_fractal)
: DrawnObjectModel(),
  m_style(p_style),
  m_sthickness(0),
  m_thickness(0),
  m_fractal(p_fractal),
  m_roughness(p_roughness),
  m_seed(p_seed) 
{
    TRACER(wxT("LineObjectModel(...,p_fractal)"));
}


LineObjectModel::~LineObjectModel()
{
    TRACER(wxT("~LineObjectModel()"));
}


bool LineObjectModel::compare(const ObjectInterface* p_other) const
{
    TRACER(wxT("compare(const ObjectInterface*)"));
    bool retval = false;
    
    if (DrawnObjectModel::compare(p_other))
    {
        const LineObjectModel *pd = dynamic_cast<const LineObjectModel*>(p_other);
        // try to cast to a LineObjectModel object, if this failed then we returned false
        // because this two objects are not equal! (one is a LineObjectModel() and the other
        // one is a DrawnObjectModel() 
        if (pd != NULL) 
        {
            // if all members have the same value then retval is true
            retval = (m_style.type == pd->m_style.type)
                  && (m_sthickness == pd->m_sthickness)
                  && (m_thickness  == pd->m_thickness)
                  && (m_fractal    == pd->m_fractal)
                  && (m_roughness  == pd->m_roughness)
                  && (m_seed       == pd->m_seed);
        }
    }
    return retval;
}


bool LineObjectModel::copy(const ObjectInterface* p_other) 
{
    TRACER(wxT("copy(const ObjectInterface*)"));
    bool retval = false;
    
    if (DrawnObjectModel::copy(p_other))
    {
        const LineObjectModel *pd = dynamic_cast<const LineObjectModel*>(p_other);
        if (pd != NULL)
        {
            m_style      = pd->m_style;
            m_sthickness = pd->m_sthickness;
            m_thickness  = pd->m_thickness;
            m_fractal    = pd->m_fractal;
            m_roughness  = pd->m_roughness;
            m_seed       = pd->m_seed;
            
            retval = true;
        }
    }
    return retval;
}


bool LineObjectModel::isValid() const
{
    TRACER(wxT("isValid()"));
    
    return DrawnObjectModel::isValid();
}
