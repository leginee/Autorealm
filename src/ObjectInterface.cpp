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


#include "ObjectInterface.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("ObjectInterface"));


ObjectInterface::ObjectInterface(ObjectInterface* p_parent)
 : m_extraData()
 , m_children()
 , m_parent(NULL)
{
	TRACER(wxT("ObjectInterface(ObjectInterface* p_parent)"));
    setParent(p_parent);
}


ObjectInterface::ObjectInterface(const ObjectInterface& p_copy)
 : m_extraData(p_copy.m_extraData)
 , m_children()
 , m_parent(NULL)
{
	TRACER(wxT("ObjectInterface(const ObjectInterface& p_copy)"));
	setParent(p_copy.m_parent);	
	cloneChildren(this, p_copy);
}


ObjectInterface& ObjectInterface::operator=(const ObjectInterface& p_other)
{
	TRACER(wxT("ObjectInterface operator=(const ObjectInterface& p_other)"));
	// if the other object a different one. 
	if (this != &p_other)
	{
		setParent(p_other.m_parent);
		removeAllChildren();
		cloneChildren(this, p_other);
	}
	
	return *this;
}


ObjectInterface::~ObjectInterface()
{
	TRACER(wxT("~ObjectInterface()"));
	setParent(0);
	removeAllChildren();
}


void ObjectInterface::addChild(ObjectInterface* p_child)
{
	TRACER(wxT("ObjectInterface::addChild(ObjectInterface* p_child)"));
    m_children.push_back(p_child);
}


ObjectInterface* ObjectInterface::clone(void) const
{
	TRACER(wxT("ObjectInterface::clone(void)"));
	ObjectInterface* retval = new ObjectInterface(0);
	
	retval->copy(this);
	cloneChildren(retval, *this);
	
	return retval;
}


void ObjectInterface::cloneChildren(ObjectInterface* p_parent, const ObjectInterface& p_clone) const
{
	TRACER(wxT("ObjectInterface::cloneChildren()"));
	
	ObjectInterface* child;
	for (unsigned int i = 0; i < p_clone.m_children.size(); ++i)
	{
		child = p_clone.m_children.at(i)->clone();
		child->setParent(p_parent);
	}
}


void ObjectInterface::removeChild(const ObjectInterface* p_child)
{
	TRACER(wxT("ObjectInterface::removeChild(const ObjectInterface* p_child)"));

	if (p_child && m_children.size())
	{
		// The preformance is higher than we will iterate form the last
		// to the begin of list.	
		std::vector<ObjectInterface*>::iterator index = m_children.end();
		do
		{
			--index;
			if (*index == p_child)
			{
				m_children.erase(index);
				break;
			}
		} while (index != m_children.begin());
	}
}


void ObjectInterface::removeAllChildren(void)
{
	TRACER(wxT("ObjectInterface::removeAllChildren(void)"));
	
 	while (m_children.size())
    {
 		ObjectInterface* next = m_children.at(m_children.size() - 1);
 		try
        {
            if (next)
            {
            	// the destructor calls setParent(0)
            	// and that removes the child from the list!
            	// So that wont be an endless loop.
 			    delete next;
            }
            else
            {
            	m_children.erase(m_children.end());
            }
 		}
 		catch (...)
        {
            // catch every exception and ignore
            m_children.erase(m_children.end());
 		}
 	}
}


void ObjectInterface::setParent(ObjectInterface* p_parent)
{
	TRACER(wxT("ObjectInterface::setParent(ObjectInterface* p_parent)"));
	// An old parent is available and the new parent is different one.
	if (m_parent && p_parent != m_parent)
	{
		// Remove this child from the parent children list without deleting the child.
		m_parent->removeChild(this);
	}
	// The new parent object is an object and it is not the same parent.
	if (p_parent && p_parent != m_parent)
	{
		// Add this child to the new parent children list. 
		p_parent->addChild(this);
	}
	m_parent = p_parent;
}
