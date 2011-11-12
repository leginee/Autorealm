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


#include "LineModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("LineModel"));


LineModel::LineModel()
: LineObjectModel()
{
    TRACER(wxT("LineModel()"));
    arRealPoint defaultPoint(0.0, 0.0);
    DrawnObjectModel::setPoint(1, defaultPoint, false);
    DrawnObjectModel::setPoint(0, defaultPoint, true);
}


LineModel::LineModel(double p_x1, double p_y1, double p_x2, double p_y2,
                     StyleAttrib p_style)
: LineObjectModel(p_style)
{
    TRACER(wxT("LineModel(double p_x1,...,p_style)"));
    
    arRealPoint coord1(p_x1, p_y1);
    arRealPoint coord2(p_x2, p_y2);
    // write the last point first to do the resize only once
    DrawnObjectModel::setPoint(1, coord2, false);
    DrawnObjectModel::setPoint(0, coord1, true);
}


LineModel::LineModel(double p_x1, double p_y1, double p_x2, double p_y2,
                     int p_seed, int p_roughness, StyleAttrib p_style, bool p_fractal)
: LineObjectModel(p_seed, p_roughness, p_style, p_fractal) 
{
    TRACER(wxT("LineModel(double p_x1,...,p_fractal)"));
    
    arRealPoint coord1(p_x1, p_y1);
    arRealPoint coord2(p_x2, p_y2);
    // write the last point first to do the resize only once
    DrawnObjectModel::setPoint(1, coord2, false);
    DrawnObjectModel::setPoint(0, coord1, true);
}


LineModel::~LineModel()
{
    TRACER(wxT("~LineModel()"));
}


bool LineModel::compare(const ObjectInterface* p_other) const
{
    TRACER(wxT("compare(const ObjectInterface*)"));
    bool retval = false;
    
    if (LineObjectModel::compare(p_other))
    {
        const LineModel *pd = dynamic_cast<const LineModel*>(p_other);
        // try to cast to a LineModel object, if this failed then we returned false
        // because this two objects are not equal! (one is a LineModel() and the other
        // one is a DrawnObjectModel() 
        if (pd != NULL) 
        {
            // if all members have the same value then retval is true
            // LinePriumitive has no members
            retval = true;
        }
    }
    return retval;
}


bool LineModel::copy(const ObjectInterface* p_other) 
{
    TRACER(wxT("copy(const ObjectInterface*)"));
    bool retval = false;
    
    if (LineObjectModel::copy(p_other))
    {
        const LineModel *pd = dynamic_cast<const LineModel*>(p_other);
        if (pd != NULL)
        {
            // nothing to copy - LineModel has no members
            retval = true;
        }
    }
    return retval;
}


bool LineModel::isValid() const
{
    TRACER(wxT("isValid()"));
    
    return LineObjectModel::isValid();
}
