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

#ifndef LINE_MODEL_H
#define LINE_MODEL_H

#include "LineObjectModel.h"


/**
 * @brief This class is used to represents a line on the map.
 * 
 * @todo A detail description of this class!!
 */
class LineModel : public LineObjectModel
{
    public:
        ///////////////////////////////////////////////    
        // Constructor and Destructor
        ///////////////////////////////////////////////     
        
        /**
         * @brief Default constructor which initialze all members
         * to thier default values.
         */
        LineModel();
        
        /**
         * @brief Constructs a LineModel object with four coordinates and 
         * an attribute style for the drawing lines.
         *
         * @param p_x1 The x value of the first coordinate of the line.
         * @param p_y1 The y value of the first coordinate of the line.
         * @param p_x2 The x value of the second coordinate of the line.
         * @param p_y2 The y value of the secon coordinate of the line.
         * @param p_style  The style to draw the line of the curve.
         */
        LineModel(double p_x1, double p_y1, double p_x2, double p_y2, StyleAttrib p_style);
                
        /**
         * @brief Constructs a LineModel object with four coordinates, seed, 
         * roughness, an attribute style for the drawing lines and optional fractal.
         *
         * @param p_x1 The x value of the first coordinate of the line.
         * @param p_y1 The y value of the first coordinate of the line.
         * @param p_x2 The x value of the second coordinate of the line.
         * @param p_y2 The y value of the secon coordinate of the line.
         * @param p_seed      The seed of the fractal.
         * @param p_roughness The roughness value of the fractal.
         * @param p_style     The style to draw the line of the line.
         * @param p_fractal   The type of the line.
         */
        LineModel(double p_x1, double p_y1, double p_x2, double p_y2, int p_seed,
                  int p_roughness, StyleAttrib p_style, bool p_fractal = false);
        
        /**
         * @brief The default destructor for a LineModel object.
         */
        virtual ~LineModel();

        ///////////////////////////////////////////////
        // Inherit virtual methods
        ///////////////////////////////////////////////
        /**
         * @brief Simple comparison to determine if two LineModel objects
         * are equivalent.
         *
         * @param p_other A pointer to second LineModel object to compare to.
         * @return A flag whether the two object are equivalent. 
         * @retval true  Yes the two objects are equivalent.
         * @retval false No the two objects are not equivalent.
         */
        virtual bool compare(const ObjectInterface* p_other) const;
        
        /**
         * @brief A copy method, useful for copying one LineModel into another.
         *
         * @param p_other A pointer to second LineModel object to copy.
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
         * @brief Sets the first x coordinate of the LineObjectModel object.
         *
         * @param p_x1     The first x coordinate of the line.
         * @param p_recalc A flag whether do a recalculation of extent or not.  
         */
        void setX1(double p_x1, bool p_recalc = true)
        {
            arRealPoint point = getPoint(0);
            point.x = p_x1;
            setPoint(0, point, p_recalc);
        }
               
        /**
         * @brief Sets the second x coordinate of the LineObjectModel object.
         *
         * @param p_x2     The second x coordinate of the line.
         * @param p_recalc A flag whether do a recalculation of extent or not.  
         */
        void setX2(double p_x2, bool p_recalc = true)
        {
            arRealPoint point = getPoint(1);
            point.x = p_x2;
            setPoint(1, point, p_recalc);
        }

        /**
         * @brief Sets the first y coordinate of the LineObjectModel object.
         *
         * @param p_y1     The first y coordinate of the line.
         * @param p_recalc A flag whether do a recalculation of extent or not.  
         */
        void setY1(double p_y1, bool p_recalc = true)
        {
            arRealPoint point = getPoint(0);
            point.y = p_y1;
            setPoint(0, point, p_recalc);
        }

        /**
         * @brief Sets the second y coordinate of the LineObjectModel object.
         *
         * @param p_y2     The second y coordinate of the line.
         * @param p_recalc A flag whether do a recalculation of extent or not.  
         */
        void setY2(double p_y2, bool p_recalc = true)
        {
            arRealPoint point = getPoint(1);
            point.y = p_y2;
            setPoint(1, point, p_recalc);
        }
};

#endif  // LINE_MODEL_H
