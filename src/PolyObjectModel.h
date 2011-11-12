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

#ifndef POLY_OBJECT_MODEL_H
#define POLY_OBJECT_MODEL_H

#include "LineObjectModel.h"


/**
 * @brief This class is used to represents all poly objects on the map.
 *
 * This is an abstract class and store the necessary data for all kind of poly object.
 * There is the real polyline and a polycurve. The PolyObjectModel stores the common data for
 * the poly objects like PolyLineModel or PolyCurveModel.
 */
class PolyObjectModel : public LineObjectModel
{
    protected:
        ///////////////////////////////////////////////    
        // Constructor Abstract class
        ///////////////////////////////////////////////     
      
        /**
         * @brief Default constructor which initialze all members
         * to their default values.
         */
        PolyObjectModel();
        
        /**
         * @brief Constructs a PolyObjectModel object with a style attribute for the
         * drawing lines.
         *
         * @param p_style  The style to draw the line of the PolyObjectModel.
         */
        PolyObjectModel(StyleAttrib p_style);
                
        /**
         * @brief Constructs a PolyObjectModel object with seed, roughness, a style
         * attribute for the drawing lines, fillcolor, count and optional fractal.
         *
         * @param p_seed      The seed of the fractal.
         * @param p_roughness The roughness value for the fractal.
         * @param p_style     The style to draw the line of the PolyObjectModel.
         * @param p_fillColor The fill color for a closed shape PolyObjectModel.
         * @param p_fractal   The type of the curve. 
         */
        PolyObjectModel(int p_seed, int p_roughness, StyleAttrib p_style, wxColor p_fillColor,
                        bool p_fractal = false);
        
    public:
        ///////////////////////////////////////////////    
        // Destructor
        ///////////////////////////////////////////////     
        /**
         * @brief The default destructor for a PolyObjectModel object.
         */
        virtual ~PolyObjectModel();

        ///////////////////////////////////////////////
        // Inherit virtual methods
        ///////////////////////////////////////////////
        /**
         * @brief Simple comparison to determine if two PolyObjectModel objects
         * are equivalent.
         *
         * @param p_other A pointer to second PolyObjectModel object to compare to.
         * @return A flag whether the two object are equivalent. 
         * @retval true  Yes the two objects are equivalent.
         * @retval false No the two objects are not equivalent.
         */
        virtual bool compare(const ObjectInterface* p_other) const;
    
        /**
         * @brief A copy method, useful for copying one PolyObjectModel into another.
         *
         * @param p_other A pointer to second PolyObjectModel object to copy.
         * @return A flag whether the copy operation was successful. 
         * @retval true  The copy was successful.
         * @retval false The copy failed.
         */
        virtual bool copy(const ObjectInterface* p_other);
    
        /**
         * Have all of the initialization steps been performed?
         *
         * @return A flag whether the two object are equivalent. 
         * @retval true  Yes the object is valid.
         * @retval false No the object is not valid.
         */
        virtual bool isValid(void) const;
            
        ///////////////////////////////////////////////
        // Getter and Setter Methods
        ///////////////////////////////////////////////
        /**
         * @brief Gets the count of points for the PolyObjectModel.
         *  
         * @return The count of points.
         */
        int getCount(void) const
        {
            return m_points.size();
        }

        /**
         * @brief Gets the fill color of the PolyObjectModel.
         *  
         * @return The fill color of this object.
         */
        wxColor getFillColor(void) const
        {
            return m_fillColor;
        }
        
        /**
         * @brief Sets the fill color of the PolyObjectModel.
         *
         * @param p_fillColor The new fill color value of the object.
         */
        void setFillColor(wxColor p_fillColor)
        {
            m_fillColor = p_fillColor;
        }
        
        /////////////////////////////////////////////// 
        // Other methods
        ///////////////////////////////////////////////
        /**
         * @brief Adds a new point to the PolyObjectModel.
         *
         * @param p_point  The point that will be added to the object.
         * @param p_recalc The flag whether the base class should do a recalculation or not.
         * @return The current count of points of the PolyObjectModel. 
         */
        int addPoint(arRealPoint p_point, bool p_recalc = true);
        
    private:
        /////////////////////////////////////////////// 
        // Standard attributes
        ///////////////////////////////////////////////
        /**
         * @brief The fill color of the object if the shape are closed.
         */        
        wxColor  m_fillColor;
};

#endif  // POLY_OBJECT_MODEL_H
