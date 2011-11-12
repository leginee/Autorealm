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


#include "CurveModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("CurveModel"));


CurveModel::CurveModel()
: LineObjectModel()
{
    TRACER(wxT("CurveModel()"));
}


CurveModel::CurveModel(arRealPoint p_point1, arRealPoint p_point2,
                       arRealPoint p_point3, arRealPoint p_point4, StyleAttrib p_style)
: LineObjectModel(p_style)
{
    TRACER(wxT("CurveModel(arRealPoint p_point1,...,p_style)"));
    
    // write the last point first to do the resize only once
    DrawnObjectModel::setPoint(3, p_point4, false);
    DrawnObjectModel::setPoint(2, p_point3, false);
    DrawnObjectModel::setPoint(1, p_point2, false);
    DrawnObjectModel::setPoint(0, p_point1, true);
}


CurveModel::CurveModel(arRealPoint p_point1, arRealPoint p_point2,
                       arRealPoint p_point3, arRealPoint p_point4, int p_seed, int p_roughness,
                       StyleAttrib p_style, bool p_fractal)
: LineObjectModel(p_seed, p_roughness, p_style, p_fractal) 
{
    TRACER(wxT("CurveModel(arRealPoint p_point1,...,p_fractal)"));
    
    // write the last point first to do the resize only once, see also setPoint()
    DrawnObjectModel::setPoint(3, p_point4, false);
    DrawnObjectModel::setPoint(2, p_point3, false);
    DrawnObjectModel::setPoint(1, p_point2, false);
    // at the last point we do a recalc for m_extent in DrawnModelObject 
    DrawnObjectModel::setPoint(0, p_point1, true);
}


CurveModel::~CurveModel()
{
    TRACER(wxT("~CurveModel()"));
}


bool CurveModel::compare(const ObjectInterface* p_other) const
{
    TRACER(wxT("compare(const ObjectInterface*)"));
    bool retval = false;
    
    if (LineObjectModel::compare(p_other))
    {
        const CurveModel *pd = dynamic_cast<const CurveModel*>(p_other);
        // try to cast to a CurveModel object, if this failed then we returned false
        // because this two objects are not equal! (one is a CurveModel() and the other
        // one is a DrawnObjectModel() 
        if (pd != NULL) 
        {
            // if all members have the same value then retval is true
            // CurvePriumitive has no members
            retval = true;
        }
    }
    return retval;
}


bool CurveModel::copy(const ObjectInterface* p_other) 
{
    TRACER(wxT("copy(const ObjectInterface*)"));
    bool retval = false;
    
    if (LineObjectModel::copy(p_other))
    {
        const CurveModel *pd = dynamic_cast<const CurveModel*>(p_other);
        if (pd != NULL)
        {
            // nothing to copy - CurveModel has no members
            retval = true;
        }
    }
    return retval;
}


bool CurveModel::isValid() const
{
    TRACER(wxT("isValid()"));
    
    return LineObjectModel::isValid();
}
