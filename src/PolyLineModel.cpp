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


#include "PolyLineModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("PolyLineModel"));


PolyLineModel::PolyLineModel()
: PolyObjectModel()
{
    TRACER(wxT("PolyLineModel()"));
    create(NULL);
}


PolyLineModel::PolyLineModel(StyleAttrib p_style)
: PolyObjectModel(p_style)
{
    TRACER(wxT("PolyLineModel(p_style)"));  
    create(NULL);
}


PolyLineModel::PolyLineModel(int p_seed, int p_roughness, StyleAttrib p_style,
                             wxColor p_fillcolor, bool p_fractal)
: PolyObjectModel(p_seed, p_roughness, p_style, p_fillcolor, p_fractal) 
{
    TRACER(wxT("PolyLineModel(int p_seed,...,p_fractal)"));    
    create(NULL);
}


PolyLineModel::~PolyLineModel()
{
    TRACER(wxT("~PolyLineModel()"));
}


bool PolyLineModel::compare(const ObjectInterface* p_other) const
{
    TRACER(wxT("compare(const ObjectInterface*)"));
    bool retval = false;
    
    if (PolyObjectModel::compare(p_other))
    {
        const PolyLineModel *pd = dynamic_cast<const PolyLineModel*>(p_other);
        // try to cast to a PolyLineModel object, if this failed then we returned false
        // because this two objects are not equal! (one is a PolyLineModel() and the other
        // one is a DrawnObjectModel())
        if (pd != NULL) 
        {
            // if all members have the same value then retval is true
            // PolyLineModel has no own members yet
            retval = true;
        }
    }
    return retval;
}


bool PolyLineModel::copy(const ObjectInterface* p_other) 
{
    TRACER(wxT("copy(const ObjectInterface*)"));
    bool retval = false;
    
    if (PolyObjectModel::copy(p_other))
    {
        const PolyLineModel *pd = dynamic_cast<const PolyLineModel*>(p_other);
        if (pd != NULL)
        {
            // nothing to copy - PolyLineModel has no own members yet
            retval = true;
        }
    }
    return retval;
}


void PolyLineModel::create(const ObjectInterface* p_parent)
{
    TRACER(wxT("create(ObjectInterface*)"));    
    PolyObjectModel::create(p_parent);
    // nothing more to do...
}


bool PolyLineModel::isValid() const
{
    TRACER(wxT("isValid()"));   
    return PolyObjectModel::isValid();
}
