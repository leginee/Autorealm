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


#ifndef OBJECT_INTERFACE_H
#define OBJECT_INTERFACE_H


#include <memory>
#include <map>

#include <wx/hashmap.h>

#include "xmltypes.h"
#include "ARExcept.h"
#include "types.h"


/**
 * We need to declare a new string hash type for use in ObjectInterface.
 * That type (ObjPublicData) is declared with the standard STL map.
 */
typedef std::map<wxString, wxString> ObjPublicData;


/**
 * @brief Used to provide consistent interface to objects to be stored
 * on the map.
 *
 * This class is used to provide a consistent interface to objects on the
 * map, map metadata, and even the map itself. This class is an empty
 * class, providing only pure virtual functions which subclasses must
 * implement. The end result is a system which should be very easy to
 * update and expand as we see fit.
 * 
 * How to use the ObjectInterface and its inherit classes:
 * @code
 * ObjectInterface* top = new ObjectInterface;
 * ObjectInterface* firstChild = new ObjectInterface(top);
 * 
 * ObjectInterface* secondChild = new ObjectInterface;
 * ... do something with secondChild ...
 * ObjectInterface* lowerChild = new ObjectInterface;
 * lowerChild->setParent(lowerChild);
 * secondChild->setParent(top);
 * 
 * delete top; // delete all childs!
 * @endcode 
 */
class ObjectInterface 
{
	public:
		/**
		 * @brief Constructs an ObjectInterface with parent object parent.
		 *
		 * The parent of an object may be viewed as the object's owner.
		 * Setting parent to NULL constructs an object with no parent.
		 * The destructor of a parent object destroys all child objects.
		 * 
		 * @param p_parent The pointer to the parent object of this object.
		 */
		ObjectInterface(ObjectInterface* p_parent = NULL);

		/**
		 * @brief Constructs a copy of the ObjectInterface.
		 *
		 * The constructor creates a copy with the children of the given object.
		 * This is a deep copy of the given object that creates the children on
		 * the heap.
		 * 
		 * @param p_copy The ObjectInterface to use for the copy.
		 */
		ObjectInterface(const ObjectInterface& p_copy);

        /**
         * @brief Destroys the object, deleting all its child objects.
         *
         * Does <em>not</em> delete m_parent. m_parent is managed by
         * something else in the application. The pointer is simply a
         * nice way to find the parent object.
         * 
         * @warning All child objects are deleted. If any of these objects
         * are on the stack or global, sooner or later your program will crash.
         * We do not recommend holding pointers to child objects from outside
         * the parent. 
         */
        virtual ~ObjectInterface();

		/**
		 * @brief The assignment operator for the class ObjectInterface.
		 * 
		 * The assignment operator is like as a clone of the object. It copies
		 * also the children of this object. The parent object is also copied.
		 *
		 * @param p_other The other object that is assign to this object.
		 * @return This object as a reference.
		 */
		ObjectInterface& operator=(const ObjectInterface& p_other);
		
		/**
		 * @brief Clones the object and return a new object.
		 *
		 * This is a deep copy of the object without the parent object.
		 * All children will also be cloned and new objects. They are not
		 * references.
		 * 
		 * @return A pointer to a clone of the object.  
		 */
		virtual ObjectInterface* clone(void) const;
		
		/**
		 * @brief Assignment operator, used to handle copying data from one
		 * object safely to another one.
		 * 
		 * This method should be overridden in all subclasses, with the 
		 * subclass calling the base class.
		 *
		 * Furthermore, this method must <em>not</em> copy the children.
		 * Only the object itself may be copied.
		 *
		 * @param p_other The item (conforming to this interface) to copy
		 * from. It will copy to *this.
		 * @return The status of the copy.
         * @retval true  The copy succeded.
         * @retval false The copy failed.
		 */
		virtual bool copy(const ObjectInterface* p_other)
		{
		    // nothing to copy because
		    // parent and children don't be copy!
			return true;
		};
		
		/**
		 * @brief Compares two ObjectInterface objects.
		 *
		 * As a special case, two ObjectInterface objects will be
		 * considered to be equivalent if one is an alias of the other,
		 * regardless of position.
		 *
		 * This method should be overridden in all subclasses, with the 
		 * subclass calling the base class.
		 *
		 * @param p_other The item to compare this one to.
		 * @return The comparison status.
         * @retval true  They are the same.
         * @retval false They are different.
		 */
		virtual bool compare(const ObjectInterface* p_other) const
		{
		    // empty implementation because
		    // don't compare children and parent member 
		    return (p_other != NULL);
		};

		/** 
		 * @brief Returns the number of children of this object.
		 * 
		 * @return An int which tells how many children this object has.
		 */
		unsigned int countChildren(void) const
		{ 
			return m_children.size();
	 	};

		/**
		 * @brief Gets the parent object of this object.
		 *
		 * @warning If you delete this pointer the caller object will be invalid!
		 * @return A pointer to the parent object of this object. This pointer
		 * is not managed by this class.
		 */
		ObjectInterface* getParent(void) const
		{
			return m_parent;
		};
		
		/** 
		 * @brief Returns the pointer to the child object at the specified
		 * index.
		 *
		 * This child is still managed by this object. But you can delete this child.
		 * The child will be notify itself the parent so that the child will be 
		 * removed from thier children list.
		 * 
		 * @param index Which child to return.
		 * @return A pointer to the child at the specified index. If the index is too
         * large, it throws an exception ARInvalidChildException.
		 */
		ObjectInterface* getChild(unsigned int p_index) const throw (ARInvalidChildException)
        {
			if (p_index >= m_children.size())
            {
				EXCEPT(ARInvalidChildException, wxT("Invalid child index"));
			}
			return m_children.at(p_index);
		};

		/**
		 * @brief Checks to make sure the object is valid.
		 *
		 * As we now have creation happening in at least two steps, we
		 * need a way to tell if this object is a valid object, or a
		 * broken object. This method serves that purpose.
		 * 
		 * This method should be overridden in all subclasses, with the 
		 * subclass calling the base class.
		 *
		 * @return The initialization status of the object.
         * @retval true  The object has been fully initialized.
		 * @retval false It has not been fully initialized.
		 */
		virtual bool isValid(void) const
		{
		    // empty implementation
		    return true;
		};

        /**
         * @brief Sets the parent object for this object. Useful in building.
         *
         * @param p_parent A pointer to the new parent object. Note that it is
         * important that this pointer may <em>not</em> change, ever. The
         * parent object is fixed.
         */
        void setParent(ObjectInterface* p_parent);

		/**
		 * A wxHashMap of extra data. All extra data is stored in a string
		 * format, and is readily accesible to the world. This is mainly
		 * useful when importing external formats. It is kept publicly
		 * accessible since this is considered non-essential, unmanaged
		 * data for the object. Anything can go in here, and anything can
		 * come out. We provide a standard means of doing so, but don't
		 * care about what it is (other than strings).
		 *
		 * For storing non-string data, we recommend using the
		 * base64encode functions provided elsewhere in AutoRealm to add
		 * and retrieve data into the correct formats.
		 *
		 * The key into the hash is stored in the form:
		 * tagname-attributename.
		 */
		ObjPublicData m_extraData;
        
	protected:
		/**
		 * @brief A vector of child objects. Used to list all the children of this
		 * object.
		 */
		std::vector<ObjectInterface*> m_children;
		
	private:
		/**
		 * @brief A pointer to the parent of this object.
		 */
		ObjectInterface* m_parent;
		
		/**
		 * @brief Adds a child object to this object. Useful (for instance)
		 * with grouped objects.
		 *
		 * Once this function is executed, this object now <em>owns</em>
		 * p_child, and will handle deletion. Do <em>not</em> attempt to
		 * delete it in future!
		 *
		 * @param p_child A child conforming to the ObjectInterface which is to
		 * be added to this object.
		 */
		void addChild(ObjectInterface* p_child);
		
		/**
		 * @brief Clones the children of the given object and set thier parent object.
		 * 
		 * @param p_parent The parent object of the cloned children.
		 * @param p_clone  The object from there the children are cloned.
		 */
		void cloneChildren(ObjectInterface* p_parent, const ObjectInterface& p_clone) const;

		/**
		 * @brief Removes a given child from the children list.
		 * 
		 * The given child will be removed from the children list. The child object does
		 * not longer belong to this object and it wont be deleted. If the child object does
		 * not a child of this object nothing will happen.
		 * 
		 * @param p_child The pointer to the child object that will be removed from the
		 * children list.
		 */
		 void removeChild(const ObjectInterface* p_child);
		 
		/**
		 * @brief Removes all children from the list.
		 *
		 * It removes all children from the list and delete the objects. 
		 */
		 void removeAllChildren(void);
};


#endif //OBJECT_INTERFACE_H
