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


#include "ViewPointModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("ViewPointModel"));


// warning! Initialize the base class and then every member variable of the class
// at the constructor. Never leave any member variable without an initialize.
// Be careful of the order of the member variable. The order has to be the same
// order of the declaration in the header of the class!
// Now every variable have the default value. 
ViewPointModel::ViewPointModel()
: ObjectInterface(),
  m_area(0.0, 0.0, 0.0, 0.0),
  m_name(),
  m_zoom(0.0),
  m_height(),
  m_width(),
  m_activeOverlays(),
  m_visibleOverlays()
{
	TRACER( wxT("ViewPointModel()"));
}


ViewPointModel::~ViewPointModel()
{
    TRACER(wxT("~ViewPointModel()"));
}


bool ViewPointModel::compare(const ObjectInterface* p_other) const
{
    TRACER( wxT("ViewPointModel::compare(const ObjectInterface* p_other)"));
    bool retval = false;
    
    if (ObjectInterface::compare(p_other))
    {
        const ViewPointModel *vp = dynamic_cast<const ViewPointModel*>(p_other);
        TRACE(wxT("pointer was valid"));
        if (vp != NULL)
        {
            retval = (m_area == vp->m_area);
            TRACE(wxT("m_area retval: ") + retval ? wxString(wxT("true")) : wxString(wxT("false")));
            retval = retval and (m_name == vp->m_name);
            TRACE(wxT("name retval: %s") + retval ? wxString(wxT("true")) : wxString(wxT("false")));
            retval = retval and (m_zoom == vp->m_zoom);
            TRACE(wxT("zoom retval: %s") + retval ? wxString(wxT("true")) : wxString(wxT("false")));
            retval = retval and (m_height == vp->m_height);
            TRACE(wxT("height retval: %s") + retval ? wxString(wxT("true")) : wxString(wxT("false")));
            retval = retval and (m_width == vp->m_width);
            TRACE(wxT("width retval: %s") + retval ? wxString(wxT("true")) : wxString(wxT("false")));
            
            //must check retVal to not overwrite
            if (retval && m_activeOverlays.size() == vp->m_activeOverlays.size())
            {
                for (unsigned int i = 0; i < m_activeOverlays.size(); ++i)
                {
                    retval = retval and (m_activeOverlays.at(i) == vp->m_activeOverlays.at(i));
                #ifdef __WXDEBUG__
                    wxString tmsg;
                    tmsg.Printf(wxT("active overlay %d retval: %s"), i, retval ? wxT("true") : wxT("false"));
                    TRACE(tmsg);
                #endif
                }
            }
            else
            {
                retval = false;
            }
            
            //must check retVal to not overwrite 
            if (retval && m_visibleOverlays.size() == vp->m_visibleOverlays.size())
            {
                for (unsigned int i = 0; i < m_visibleOverlays.size(); ++i)
                {
                    retval = retval and (m_visibleOverlays.at(i) == vp->m_visibleOverlays.at(i));
                #ifdef __WXDEBUG__
                    wxString tmsg;
                    tmsg.Printf(wxT("visible overlay %d retval: %s"), i, retval ? wxT("true") : wxT("false"));
                    TRACE(tmsg);
                #endif
                }
            }
            else
            {
                retval = false;
            }
            /* @todo 2006/10/05 andre trettin: to check the compare part 
             * that makes no sense! children are a member from ObjectInterface and should
             * there compare(), but the copy method don't copy any children.
            if (vp->m_children.size() == m_children.size()) {
                for (unsigned int i=0; i<m_children.size(); i++) {
                    retval = retval and m_children.at(i)->compare(vp->m_children.at(i));
                    TRACE(wxT("child %d retval: %s"), i, retval ? wxT("true") : wxT("false"));
                }
            } else {
                retval = false;
            }
            */
        }
    }    
    return retval;
}


bool ViewPointModel::copy(const ObjectInterface* p_other)
{
	TRACER( wxT("ViewPointModel::copy(const ObjectInterface* p_other)"));
	bool retval = false;
    
	if (ObjectInterface::copy(p_other))
	{
    	const ViewPointModel *vp = dynamic_cast<const ViewPointModel*>(p_other);
    	if (vp != NULL)
        {
    		m_area = vp->m_area;
    		m_name = vp->m_name;
    		m_zoom = vp->m_zoom;
    		m_height = vp->m_height;
    		m_width = vp->m_width;
    		m_activeOverlays = vp->m_activeOverlays;
    		m_visibleOverlays = vp->m_visibleOverlays;
            
            retval = true;
    	}
    }
	return retval;
}


bool ViewPointModel::isValid() const
{
    TRACER( wxT("ViewPointModel::isValid"));

    return 
        ObjectInterface::isValid()
        and 
        (m_name != wxT(""))
        and
        (m_area != arRealRect(0.0, 0.0, 0.0, 0.0)) 
        and 
        (m_zoom != 0.0);        
}


arRealRect ViewPointModel::getArea() const
{
	TRACER( wxT("ViewPointModel::getArea()"));
	return m_area;
}


void ViewPointModel::setArea(const arRealRect& p_area)
{
	TRACER( wxT("ViewPointModel::setArea(const arRealRect& p_area)"));
	m_area = p_area;
}


wxString ViewPointModel::getName() const
{
	TRACER( wxT("ViewPointModel::getName()"));
	return m_name;
}


void ViewPointModel::setName(const wxString& p_name)
{
	TRACER( wxT("ViewPointModel::setName(const wxString& p_name)"));
	m_name = p_name;
}


double ViewPointModel::getZoom() const
{
	TRACER( wxT("ViewPointModel::getZoom()"));
	return m_zoom;
}


void ViewPointModel::setZoom(double p_zoom)
{
	TRACER( wxT("ViewPointModel::setZoom(double p_zoom)"));
	m_zoom = p_zoom;
}
