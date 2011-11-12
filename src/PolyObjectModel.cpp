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


#include "PolyObjectModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("PolyObjectModel"));


PolyObjectModel::PolyObjectModel()
: LineObjectModel(),
  m_fillColor(wxColor(0x00, 0x00, 0x00)) 
{
    TRACER(wxT("PolyObjectModel()"));
}


PolyObjectModel::PolyObjectModel(StyleAttrib p_style)
: LineObjectModel(p_style),
  m_fillColor(wxColor(0x00, 0x00, 0x00)) 
{
    TRACER(wxT("PolyObjectModel(p_style)"));    
}


PolyObjectModel::PolyObjectModel(int p_seed, int p_roughness, StyleAttrib p_style,
                                 wxColor p_fillColor, bool p_fractal)
: LineObjectModel(p_seed, p_roughness, p_style, p_fractal),
  m_fillColor(p_fillColor) 
{
    TRACER(wxT("PolyObjectModel(int p_seed,...,p_fractal)"));    
}


PolyObjectModel::~PolyObjectModel()
{
    TRACER(wxT("~PolyObjectModel()"));
}


bool PolyObjectModel::compare(const ObjectInterface* p_other) const
{
    TRACER(wxT("compare(const ObjectInterface*)"));
    bool retval = false;
    
    if (LineObjectModel::compare(p_other))
    {
        const PolyObjectModel *pd = dynamic_cast<const PolyObjectModel*>(p_other);
        // try to cast to a PolyObjectModel object, if this failed then we returned false
        // because this two objects are not equal! (one is a PolyObjectModel() and the other
        // one is a DrawnObjectModel() 
        if (pd != NULL) 
        {
            // if all members have the same value then retval is true
            retval = (m_fillColor == pd->m_fillColor);
        }
    }
    return retval;
}


bool PolyObjectModel::copy(const ObjectInterface* p_other) 
{
    TRACER(wxT("copy(const ObjectInterface*)"));
    bool retval = false;
    
    if (LineObjectModel::copy(p_other))
    {
        const PolyObjectModel *pd = dynamic_cast<const PolyObjectModel*>(p_other);
        if (pd != NULL)
        {
            m_fillColor = pd->m_fillColor;
            
            retval = true;
        }
    }
    return retval;
}


bool PolyObjectModel::isValid() const
{
    TRACER(wxT("isValid()"));
    return LineObjectModel::isValid();
}


int PolyObjectModel::addPoint(arRealPoint p_point, bool p_recalc)
{
    // add a new point at the end of the vector
    // size() is beyond the vector border (or one point more than actually) 
    setPoint(m_points.size(), p_point, p_recalc);
    return m_points.size();
}
