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

#include "ARDocument.h"
#include "base64.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("ARDocument"));


ARDocument::ARDocument()
: ObjectInterface(),
  m_bgColor(wxColor(0xff, 0xff, 0xff)),
  m_comments(wxT("")),
  m_designGridUnits(16),
  m_displayGrid(false),
  m_gridColor(wxColor(0x00, 0xff, 0xff)),
  m_landscape(false),
  m_overlays(),
  m_pins(),
  m_rotateSnap(false),
  m_snapAlong(false),
  m_snapToGrid(false),
  m_snapToPoint(false),
  m_version(0)
{
	TRACER(wxT("ARDocument()"));
    m_overlays.clear();
    m_overlays.reserve(20);
}


ARDocument::~ARDocument()
{
	TRACER(wxT("~ARDocument()"));
}


///////////////////////////////////////////////
// Inherit virtual methods
///////////////////////////////////////////////

bool ARDocument::compare(const ObjectInterface* p_other) const
{
    TRACER(wxT("compare()"));
    bool retval = false;
    
    if (ObjectInterface::compare(p_other))
    {    
        const ARDocument* other = dynamic_cast<const ARDocument*>(p_other);
        if (!isValid() or (other == NULL) or (!(const_cast<ARDocument*>(other))->isValid()))
        {
            TRACE( wxT("either this was !isValid(), or other was null or !isValid()"));
        }
        else
        {
            TRACE( wxT("all was valid, proceeding"));
            retval = (m_version == other->m_version);
            TRACE( wxT("after version check, retval=") + retval ? wxT("true") : wxT("false"));
            retval = retval and (m_comments == other->m_comments);
            TRACE( wxT("after comments check, retval=") + retval ? wxT("true") : wxT("false"));
            retval = retval and (m_landscape == other->m_landscape);
            TRACE( wxT("after landscape check, retval=") + retval ? wxT("true") : wxT("false"));
            retval = retval and (m_snapToGrid == other->m_snapToGrid);
            TRACE( wxT("after snapToGrid check, retval=") + retval ? wxT("true") : wxT("false"));
            retval = retval and (m_snapToPoint == other->m_snapToPoint);
            TRACE( wxT("after snapToPoint check, retval=") + retval ? wxT("true") : wxT("false"));
            retval = retval and (m_snapAlong == other->m_snapAlong);
            TRACE( wxT("after snapAlong check, retval=") + retval ? wxT("true") : wxT("false"));
            retval = retval and (m_rotateSnap == other->m_rotateSnap);
            TRACE( wxT("after rotateSnap check, retval=") + retval ? wxT("true") : wxT("false"));
            retval = retval and (m_displayGrid == other->m_displayGrid);
            TRACE( wxT("after displayGrid check, retval=") + retval ? wxT("true") : wxT("false"));
            retval = retval and (m_designGridUnits == other->m_designGridUnits);
            TRACE( wxT("after designGridUnits check, retval=") + retval ? wxT("true") : wxT("false"));
            retval = retval and (m_pins == other->m_pins);
            TRACE(wxT("after pins check, retval=") + retval ? wxT("true") : wxT("false"));
            
            if (!retval or !m_gridColor.Ok() or !other->m_gridColor.Ok() or (m_gridColor != other->m_gridColor))
            {
                retval = false;
            }
            TRACE( wxT("after grid color check, retval=") + retval ? wxT("true") : wxT("false"));
            if (!retval or !m_bgColor.Ok() or !other->m_bgColor.Ok() or (m_bgColor != other->m_bgColor))
            {
                retval = false;
            }
            TRACE( wxT("after background color check, retval=") + retval ? wxT("true") : wxT("false"));
            if (retval)
            {
                retval = (m_children.size() == other->m_children.size());
                TRACE( wxT("after children count check, retval=") + retval ? wxT("true") : wxT("false"));
                if (retval)
                {
                    for (unsigned int i = 0; (i < m_children.size()) and (retval == true); ++i)
                    {
                        retval = (m_children.at(i)->compare(other->m_children.at(i)));
    #ifdef __WXDEBUG__
                        wxString tmsg;
                        tmsg.Printf(wxT("after children %d check, retval=%s"), i, retval ? wxT("true") : wxT("false"));
                        TRACE(tmsg);
    #endif
                    }
                }
            }
            if (retval)
            {
                retval = (m_overlays.size() == other->m_overlays.size());
                TRACE( wxT("after overlays count check, retval=") + retval ? wxT("true") : wxT("false"));
                if (retval)
                {
                    for (unsigned int i = 0; i < m_overlays.size() and (retval == true); ++i)
                    {
                        retval = (m_overlays.at(i) == other->m_overlays.at(i));
    #ifdef __WXDEBUG__
                        wxString tmsg;
                        tmsg.Printf(wxT("after overlay %d  check, retval=%s"), i, retval ? wxT("true") : wxT("false"));
    #endif
                    }
                }
            }
        }
    }
    return retval;
}


bool ARDocument::copy(const ObjectInterface* p_other)
{
    TRACER(wxT("copy()"));
    bool retval = false;
    
    if (ObjectInterface::copy(p_other))
    {
        const ARDocument* other = dynamic_cast<const ARDocument*>(p_other);
        if ((other == NULL) or (!(const_cast<ARDocument*>(other))->isValid()))
        {
            TRACE(wxT("other was NULL or !isValid()"));
        }
        else
        {
            TRACE(wxT("Other was valid, copying all information"));
            m_bgColor         = other->m_bgColor;
            m_comments        = other->m_comments;
            m_designGridUnits = other->m_designGridUnits;
            m_displayGrid     = other->m_displayGrid;
            m_gridColor       = other->m_gridColor;
            m_landscape       = other->m_landscape;
            m_overlays        = other->m_overlays;
            m_pins            = other->m_pins;
            m_rotateSnap      = other->m_rotateSnap;
            m_snapAlong       = other->m_snapAlong;
            m_snapToGrid      = other->m_snapToGrid;
            m_snapToPoint     = other->m_snapToPoint;
            m_version         = other->m_version;

            retval = true;
        }
    }
    return retval;
}


bool ARDocument::isValid() const
{
	TRACER(wxT("isValid"));
    
	return ObjectInterface::isValid()
	    && (m_version > 0) 
		&& (m_gridColor.Ok() == true) 
		&& (m_bgColor.Ok() == true);
}


///////////////////////////////////////////////
// Getter and Setter Methods
///////////////////////////////////////////////

wxColor ARDocument::getBgColor(void) const
{
    TRACER( wxT("wxColor getBgColor()"));
    return m_bgColor;
}


wxString ARDocument::getComments(void) const
{
    TRACER( wxT("wxString getComments()"));
    return m_comments;
}


wxColor ARDocument::getGridColor(void) const
{
    TRACER( wxT("wxColor getGridColor("));
    return m_gridColor;
}


bool ARDocument::getLandscape(void) const
{
    TRACER( wxT("getLandscape"));
    return m_landscape;
}


unsigned int ARDocument::getOverlayCount(void) const
{
    TRACER( wxT("getOverlayCount()"));
    return m_overlays.size();
}


wxString ARDocument::getOverlayName(unsigned int p_index) const throw (ARMissingOverlayException)
{
    TRACER( wxT("getOverlayName(int p_index)"));
    if (p_index >= m_overlays.size())
    {
        wxString msg;
        msg.Printf(wxT("index %d out of bounds"), p_index);
        EXCEPT(ARMissingOverlayException, msg);
    }
    return m_overlays.at(p_index);
}


Pushpin ARDocument::getPushpin(unsigned int p_index) const throw (ARInvalidPushpin)
{
    TRACER(wxT("getPushpin"));
    if (p_index >= MAX_PUSHPINS)
    {
        TRACE(wxT("Invalid pushpin: %d"), p_index);
        EXCEPT(ARInvalidPushpin, wxT("Invalid pushpin"));
    }
    return m_pins.m_pins.at(p_index);
}

PushpinCollection ARDocument::getPushpins(void) const
{
    TRACER(wxT("getPushpins"));
    return m_pins;
}

unsigned int ARDocument::getVersion(void) const
{
    TRACER( wxT("int getVersion("));
    return m_version;
}


void ARDocument::setBgColor(const wxColor& p_bgColor) throw(ARBadColorException)
{
	TRACER(wxT("void setBgColor(wxColor p_bgColor"));
	if (p_bgColor.Ok() == true)
    {
		m_bgColor = p_bgColor;
	}
    else
    {
		EXCEPT(ARBadColorException, wxT("p_bgColor.Ok() != true"));
	}
}


void ARDocument::setComments(const wxString& p_comments)
{
	TRACER(wxT("void setComments(const wxString& p_comments)"));
	m_comments = p_comments;
}


void ARDocument::setGridColor(const wxColor& p_gridColor) throw(ARBadColorException)
{
    TRACER(wxT("void setGridColor(wxColor p_gridColor"));
    if (p_gridColor.Ok() == true)
    {
        m_gridColor = p_gridColor;
    }
    else
    {
        EXCEPT(ARBadColorException, wxT("p_gridColor.Ok() != true"));
    }
}


void ARDocument::setLandscape(bool p_landscape)
{
	TRACER(wxT("setLandscape"));
	m_landscape = p_landscape;
}


void ARDocument::setOverlayName(unsigned int p_index, const wxString& p_overlay) throw (ARMissingOverlayException)
{
    TRACER(wxT("setOverlayName(int p_index, const wxString& p_overlay)"));
    if (p_index >= MAX_OVERLAYS)
    {
        TRACE(wxT("Invalid Overlay index: %d"), p_index);
        EXCEPT(ARMissingOverlayException, wxT("Invalid Overlay index"));
    }
    if (p_index >= m_overlays.size())
    {
        m_overlays.resize(p_index + 1);
    }
    m_overlays.at(p_index) = p_overlay;
}


void ARDocument::setPushpin(unsigned int p_index, const Pushpin& p_pin) throw (ARInvalidPushpin)
{
	TRACER(wxT("setPushpin"));
	if (p_index >= MAX_PUSHPINS)
    {
		TRACE(wxT("Invalid pushpin: %d"), p_index);
		EXCEPT(ARInvalidPushpin, wxT("Invalid pushpin"));
	}
	m_pins.m_pins.at(p_index) = p_pin;
}


void ARDocument::setPushpins(const PushpinCollection& p_pins)
{
	TRACER(wxT("setPushpins"));
	m_pins = p_pins;
}


void ARDocument::setVersion(unsigned int p_version)
{
    TRACER( wxT("void setVersion(int p_version"));
    m_version = p_version;
}


unsigned int ARDocument::addOverlayName(const wxString& p_overlay)
{
    TRACER( wxT("addOverlayName(const wxString& p_overlay)"));
    if (m_overlays.size() < MAX_OVERLAYS)
    {
        m_overlays.push_back(p_overlay);
    }
    return m_overlays.size();
}
