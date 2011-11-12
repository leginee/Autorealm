/*
 * Rewrite of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
 * Used in rpgs and hobbyist GIS applications for mapmaking
 * Copyright (C) 2004 Michael J. Pedersen <m.pedersen@icelus.org>,
 *                    Michael D. Condon <mcondon@austin.rr.com>
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


#include "ObjectBuilder.h"
#include "subbuilder/SubBuilder.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("ObjectBuilder"));


using namespace subbuilderComponents;


ObjectBuilder::ObjectBuilder(ARDocument* p_doc)
 : m_doc(p_doc)
{
	TRACER(wxT("ObjectBuilder(ObjectBuilder*)"));
	bldrstack.clear();
}

void ObjectBuilder::startNewObject(const wxString& p_name, const ObjectAttributes& p_attribs)
{
	TRACER(wxT("startNewObject(p_name, p_attribs)"));
	BuilderStackEntry bldr = getBuilder(p_name, m_doc);
	wxASSERT(bldr.m_bldr != NULL);
	if (bldr.m_bldr != NULL)
    {
		bldr.m_bldr->addAttribs(p_attribs, bldr);
	}
}

void ObjectBuilder::appendData(const wxString& p_data)
{
	TRACER(wxT("appendData(p_data)"));
	if (bldrstack.size() >= 1)
    {
		BuilderStackEntry bldr = bldrstack.at(bldrstack.size() - 1);
		wxASSERT(bldr.m_obj != NULL);
		if (bldr.m_bldr != NULL)
        {
			bldr.m_obj->m_extraData[bldr.m_tag] += p_data;
		}
	}
    else
    {
		TRACE(wxT("Error. Missing begin tag for data %s"), p_data.c_str());
	}
}

void ObjectBuilder::endObject() throw (ARBadColorException, ARBadNumberFormat, ARInvalidTagException)
{
	TRACER(wxT("endObject()"));
	if (bldrstack.size() >= 1)
    {
		BuilderStackEntry bldr = bldrstack.at(bldrstack.size() - 1);
		bldrstack.pop_back();
		wxASSERT(bldr.m_bldr != NULL);
		if (bldr.m_bldr != NULL)
        {
			bldr.m_bldr->endObject(bldr);
		}
		if (   (bldrstack.size() >= 1) 
            && (bldr.m_obj != bldrstack.at(bldrstack.size() - 1).m_obj)
            && (bldr.m_obj->getParent() == NULL)
           )
        {
			ObjectInterface* parent;
            ObjectInterface* child;
			child = bldr.m_obj;
			parent = bldrstack.at(bldrstack.size() - 1).m_obj;
            // set the parent object for the child
			child->setParent(parent);
		}
	}
    else
    {
		TRACE(wxT("Error. Missing begin tag."));
	}
}

ObjectBuilder::~ObjectBuilder()
{
}
