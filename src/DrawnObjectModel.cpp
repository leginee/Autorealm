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

#include "DrawnObjectModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("DrawnObjectModel"));


DrawnObjectModel::DrawnObjectModel()
: ObjectInterface(),
  m_color(wxColor(0x00, 0x00, 0x00)),
  m_extent(arRealRect(0, 0, 0, 0)),
  m_location(arRealPoint(0, 0)),
  m_overlay(OverlayVector()),
  m_points(VPoints()),
  m_selected(false)
{
	TRACER(wxT("DrawnObjectModel()"));
	create(NULL);
}


DrawnObjectModel::~DrawnObjectModel()
{
	TRACER(wxT("~DrawnObjectModel()"));
}


bool DrawnObjectModel::compare(const ObjectInterface* p_other) const
{
    TRACER(wxT("compare(const ObjectInterface*)"));
    bool retval = false;
    
    if (ObjectInterface::compare(p_other))
    {
        const DrawnObjectModel *pd = dynamic_cast<const DrawnObjectModel*>(p_other);
        if (pd != NULL) 
        {
            // true, all member are equal
            // don't compare m_selected, see also copy()
            retval = (m_color    == pd->m_color) 
                  && (m_extent   == pd->m_extent)
                  && (m_location == pd->m_location)
                  && (m_overlay  == pd->m_overlay)                  
                  && (m_points   == pd->m_points);
        }
    }
    return retval;
}


bool DrawnObjectModel::copy(const ObjectInterface* p_other)
{
    TRACER(wxT("copy(const ObjectInterface*)"));
    bool retval = false;
        
    if (ObjectInterface::copy(p_other))
    {
        const DrawnObjectModel *pd = dynamic_cast<const DrawnObjectModel*>(p_other);
        if (pd != NULL)
        {
            m_color     = pd->m_color;
            m_extent    = pd->m_extent;
            m_location  = pd->m_location;            
            m_overlay   = pd->m_overlay;
            m_points    = pd->m_points;
            m_selected  = false;         //the new object should not copy the selection
            
            retval = true;
        }
    }
    return retval;
}


void DrawnObjectModel::create(const ObjectInterface* p_newparent)
{
	TRACER(wxT("create(ObjectInterface*)"));	
}


bool DrawnObjectModel::isValid() const
{
	TRACER(wxT("isValid()"));

	return ObjectInterface::isValid()
 		&& ((m_extent.GetWidth() > 0) || (m_extent.GetHeight() > 0));
}


bool DrawnObjectModel::getOverlay(unsigned int p_index) const throw (ARMissingOverlayException)
{
	TRACER(wxT("getOverlay"));
	if (p_index >= MAX_OVERLAYS)
    {
		EXCEPT(ARMissingOverlayException, wxT("Invalid overlay chosen"));
	}
	return m_overlay.at(p_index);
}


void DrawnObjectModel::setOverlay(unsigned int p_index, bool p_state)
{
	TRACER(wxT("setOverlay"));
	if (p_index >= MAX_OVERLAYS)
    {
		EXCEPT(ARMissingOverlayException, wxT("Invalid overlay chosen"));
	}
	m_overlay.at(p_index) = p_state;
}


void DrawnObjectModel::setColor(const wxColor& p_color) throw (ARBadColorException)
{
	TRACER(wxT("setColor"));
	if (p_color.Ok() == false)
    {
		EXCEPT(ARBadColorException, wxT("Error, incoming color is not valid!"));
	}
	m_color = p_color;
}


void DrawnObjectModel::reCalcChildExtents(void)
{
	for (unsigned int i = 0; i < m_children.size(); ++i)
    {
		DrawnObjectModel* dom = dynamic_cast<DrawnObjectModel*>(m_children.at(i));
		if (dom != NULL)
        {
			dom->reCalcExtent();
		}
	}
}


void DrawnObjectModel::reCalcExtent(void)
{
	TRACER(wxT("reCalcExtent()"));
	arRealPoint pt, pt2;
	reCalcChildExtents();
	DrawnObjectModel* dom;
	switch (m_points.size()) {
		case 0 :
			if (m_children.size() == 0) {
				m_extent = arRealRect(0, 0, 0, 0);
			} else if (m_children.size() == 1) {
				dom=dynamic_cast<DrawnObjectModel*>(m_children.at(0));
				if (dom != NULL) {
					m_extent = dom->getExtent();
				} else {
					m_extent = arRealRect(0, 0, 0, 0);
				}
			} else {
				bool firstfound = false;
				unsigned int i=0;
				while (i<m_children.size() and !firstfound) {
					dom=dynamic_cast<DrawnObjectModel*>(m_children.at(i));
					i++;
					if (dom != NULL) {
						firstfound = true;
						m_extent = dom->getExtent();
					}
				}
				for (; i<m_children.size(); i++) {
					dom=dynamic_cast<DrawnObjectModel*>(m_children.at(i));
					if (dom != NULL) {
						m_extent += dom->getExtent();
					}
				}
				if (!firstfound) {
					m_extent = arRealRect(0, 0, 0, 0);
				}
			}
			break;
		case 1 :
			pt = m_points.at(0);
			m_extent = arRealRect(pt.x, pt.y, 0, 0);
			for (unsigned int i=0; i<m_children.size(); i++) {
				dom=dynamic_cast<DrawnObjectModel*>(m_children.at(i));
				if (dom != NULL) {
					m_extent += dom->getExtent();
				}
			}
			break;
		case 2:
			pt = m_points.at(0);
			pt2 = m_points.at(1);
			m_extent = arRealRect(pt.x, pt.y, 0.0, 0.0);
			m_extent.SetRight(pt2.x);
			m_extent.SetBottom(pt2.y);
			for (unsigned int i=0; i<m_children.size(); i++) {
				dom=dynamic_cast<DrawnObjectModel*>(m_children.at(i));
				if (dom != NULL) {
					m_extent += dom->getExtent();
				}
			}
			break;
		default:
			pt = m_points.at(0);
			m_extent = arRealRect(pt.x, pt.y, 0, 0);
			for (unsigned int i=1; i<m_points.size(); i++) {
				pt2 = m_points.at(i);
				m_extent += arRealRect(pt2.x, pt2.y, 0, 0);
			}
			for (unsigned int i=0; i<m_children.size(); i++) {
				dom=dynamic_cast<DrawnObjectModel*>(m_children.at(i));
				if (dom != NULL) {
					m_extent += dom->getExtent();
				}
			}
			break;
	}
}
