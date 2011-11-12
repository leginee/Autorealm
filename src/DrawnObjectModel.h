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


#ifndef DRAWN_OBJECT_MODEL_H
#define DRAWN_OBJECT_MODEL_H


#include "ObjectInterface.h"


/**
 * @brief This object represents an object that is drawn on the map.
 *
 * This class encapsulates all of the common data pertaining to objects drawn
 * a map.  In general, it will probably never be instantiated itself, and only as 
 * one of its derived classes.
 */
class DrawnObjectModel : public ObjectInterface
{
	public:
        ///////////////////////////////////////////////    
        // Constructor and Destuctor
        ///////////////////////////////////////////////    
        /**
         * @brief Default constructor which initialze all members
         * to their default values.
         */
		DrawnObjectModel();

        /**
		 * @brief Destructor. Cleans up all owned memory.
		 */
		virtual ~DrawnObjectModel();

        ///////////////////////////////////////////////
        // Inherit virtual methods
        ///////////////////////////////////////////////
        /**
         * @brief Simple comparison to determine if two DrawnObjectModels
         * are equivalent.
         *
         * @param p_other A pointer to second DrawnObjectModel to compare to.
         * @return A flag whether the two objects are equivalent. 
         * @retval true  Yes the two objects are equivalent.
         * @retval false No the two objects are not equivalent.
         */
        virtual bool compare(const ObjectInterface* p_other) const;
        
        /**
         * @brief A copy method, useful for copying one DrawnObjectModel into another.
         *
         * @param p_other A pointer to second DrawnObjectModel to copy.
         * @return A flag whether the copy operation was successful. 
         * @retval true  The copy was successful.
         * @retval false The copy failed.
         */
		virtual bool copy(const ObjectInterface* p_other);

        /**
         * Have all of the initialization steps been performed?
         *
         * @return A flag whether the two objects are equivalent. 
         * @retval true  Yes the object is valid.
         * @retval false No the object is not valid.
         */
        virtual bool isValid(void) const;

        ///////////////////////////////////////////////
        // Getter and Setter Methods
        ///////////////////////////////////////////////
        /**
         * @brief Get the color of the object.
         * 
         * @return The color of the DrawnObjectModel.
         */
        wxColor getColor(void) const
        {
            return m_color;
        };
        
        /**
         * @brief Get the rectangular extent of this object.
         * 
         * @return A rectangular that describes the size of the whole object.
         */
        arRealRect getExtent(void) const
        {
            return m_extent;
        };

        /**
         * @brief Get the top left location of the object.
         * 
         * @return A point of the location.
         */
        arRealPoint getLocation(void) const
        {
            return m_location;
        };

		/**
		 * @brief Get the overlay associted with this object.
         * 
         * @param p_index The index of the overlay to get to.
         * @return A flag to indicate if the overlay active or not.
         * @retval true  The overlay is active.
         * @retval false The overlay is inactive.
		 */
		bool getOverlay(unsigned int p_index) const throw (ARMissingOverlayException);
		
		/**
		 * @brief Get all overlays of the DrawnObjectModel.
         * 
         * @return An array of overlays from the object.
		 */
		OverlayVector getOverlays(void) const
        {
            return m_overlay;
        };

        /**
         * @brief Get a specific point in the list.
         * 
         * @param p_num The index of the point.
         * @return The point in question. Note that if the index is
         * out of bounds, the origin (0.0, 0,.0) is returned.
         */
        arRealPoint getPoint(unsigned int p_num) const
        {
            if (p_num < m_points.size())
            {
                return m_points.at(p_num);
            }
            return arRealPoint(0.0,0.0);
        };

        /**
         * @brief Get the list of points used by this object.
         * 
         * @return A VPoints structure which is the list of points used.
         */
        VPoints getPoints(void) const
        {
            return m_points;
        };
  
        /**
         * @brief Get the selected status of the object.
         * 
         * @return A flag if the object is selected or not.
         * @retval true  The object is selected.
         * @retval false The object is not selected.
         */
        bool getSelected(void) const
        {
            return m_selected;
        };
        
		/**
		 * @brief Set the color of the object.
         * 
         * @param p_color The new color to set to. 
		 */
		void setColor(const wxColor& p_color) throw (ARBadColorException);
		
        /**
         * @brief Set the top left location of the object.
         * 
         * @param p_location The new location for the object.
         */
        void setLocation(const arRealPoint& p_location)
        { 
            m_location = p_location;
        };
        
        /**
         * @brief Set the overlay associated with this object.
         * 
         * @param p_index The index of the overlay in the list to set to.
         * @param p_state The state of the overlay. It can be true or false.
         */
        void setOverlay(unsigned int p_index, bool p_state);
        
        /**
         * @brief Set all overlays at once. Utility routine for loading.
         *
         * @param p_overlays The overlays vector to use.
         */
        void setOverlays(const OverlayVector& p_overlays)
        {
            m_overlay = p_overlays;
        };

        /**
         * @brief Set a specific point for this object.
         * 
         * @param p_num    The index of the point to set. Note that if
         *        the index is out of bounds, the points vector is grown
         *        to accomodate the new index.
         * @param p_point  The point to set into the list.
         * @param p_recalc A flag that indicates to recalculated the extent member. 
         */
        void setPoint(unsigned int p_num, const arRealPoint& p_point, bool p_recalc = true)
        {
            if (p_num >= m_points.size())
            {
                m_points.resize(p_num + 1);
            }
            m_points.at(p_num) = p_point;
            if (p_recalc)
            {
                reCalcExtent();
            }
        };
  
        /**
         * @brief Reset all points used by this object.
         * 
         * @param p_points The new list of points for this object.
         * @param p_recalc A flag that indicates to recalculated the extent member. 
         */
        void setPoints(const VPoints& p_points, bool p_recalc = true)
        {
            m_points = p_points;
            if (p_recalc)
            {
                reCalcExtent();
            }
        };
  
        /**
         * @brief Set the selection of this object.
         * 
         * @param p_selected The new selected status of the object. 
         */
        void setSelected(bool p_selected)
        {
            m_selected = p_selected;
        };
          
        ///////////////////////////////////////////////    
        // Calculations
        ///////////////////////////////////////////////     
        /**
         * @brief Recalculate the extent of this object and all child objects.
         */
        void reCalcExtent(void);
        
	protected:
        /**
         * @brief Perform the actual creation of the DrawnObjectModel, used in two
         * step creation. Used with the default constructor.
         * 
         * @param p_newparent A pointer to a parent object.
         */
        virtual void create(const ObjectInterface* p_newparent);

		/**
		 * @brief Recalculate the extents of all child objects which are
		 * DrawnObjectModels.
		 *
		 * This should only be used internal to the class, so marking it
		 * protected.
		 */
		void reCalcChildExtents(void);

        ///////////////////////////////////////////////
        // Members they are all in the protected scope,
        // that the inherit class can use it.
        ///////////////////////////////////////////////
        /**
         * @brief The color of the drawn item.
         */
        wxColor m_color;
        
        /**
         * @brief The smallest rectangle containing the object.
         */
        arRealRect m_extent;

        /**
         * @brief The location where the object is placed.
         *
         * It's important to note that this is *not* the upper left corner
         * of the object, though it may start that way. When reCalcExtent()
         * is called, this location may actually be in the middle, or even
         * lower-right of the object. This is just where the user placed it.
         */
        arRealPoint m_location;

		/**
		 * @brief The index of the overlay this object belongs to.
		 */
		OverlayVector m_overlay;

        /**
         * @brief The map points for this drawn object model.
         */
        VPoints m_points;

		/**
		 * @brief A flag indicating if this object is selected.  
		 * @todo  Does m_selected really belong here?
		 */
		bool m_selected;

};


#endif  // DRAWN_OBJECT_MODEL_H
