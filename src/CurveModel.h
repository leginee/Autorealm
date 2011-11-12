/*
 * Rewrite of AutoREALM from Delphi/Object Pascal to wxWidgets/C
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

#ifndef CURVE_MODEL_H
#define CURVE_MODEL_H

#include "LineObjectModel.h"


/**
 * @brief This class is used to represents a curve on the map.
 * 
 * @todo A detail description of this class!!
 */
class CurveModel : public LineObjectModel
{
    public:
       ///////////////////////////////////////////////    
       // Constructor and Destructor
       ///////////////////////////////////////////////     
       
       /**
        * @brief Default constructor which initialze all members
        * to thier default values.
        */
        CurveModel();
        
        /**
        * @brief Constructs a CurveModel object with four real points and 
        * an attribute style for the drawing lines.
        *
        * @param p_point1 The first point of the curve.
        * @param p_point2 The second point of the curve.
        * @param p_point3 The third point of the curve.
        * @param p_point4 The fourth point of the curve.
        * @param p_style  The style to draw the line of the curve.
        */
        CurveModel(arRealPoint p_point1, arRealPoint p_point2,
                   arRealPoint p_point3, arRealPoint p_point4, StyleAttrib p_style);
                
        /**
        * @brief Constructs a CurveModel object with four real points, seed, 
        * roughness, an attribute style for the drawing lines and optional fractal.
        *
        * @param p_point1    The first point of the curve.
        * @param p_point2    The second point of the curve.
        * @param p_point3    The third point of the curve.
        * @param p_point4    The fourth point of the curve.
        * @param p_seed      The seed of the fractal.
        * @param p_roughness The roughness value for the fractal.
        * @param p_style     The style to draw the line of the curve.
        * @param p_fractal   The type of the curve. 
        */
        CurveModel(arRealPoint p_point1, arRealPoint p_point2,
                   arRealPoint p_point3, arRealPoint p_point4, int p_seed, int p_roughness,
                   StyleAttrib p_style, bool p_fractal = false);
        
        /**
         * @brief The default destructor for a CurveModel object.
         */
        virtual ~CurveModel();

       ///////////////////////////////////////////////
       // Inherit virtual methods
       ///////////////////////////////////////////////
       /**
        * @brief Simple comparison to determine if two CurveModel objects
        * are equivalent.
        *
        * @param p_other A pointer to second CurveModel object to compare to.
        * @return A flag whether the two object are equivalent. 
        * @retval true  Yes the two objects are equivalent.
        * @retval false No the two objects are not equivalent.
        */
       virtual bool compare(const ObjectInterface* p_other) const;
       
       /**
        * @brief A copy method, useful for copying one CurveModel into another.
        *
        * @param p_other A pointer to second CurveModel object to copy.
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
};

#endif  // CURVE_MODEL_H
