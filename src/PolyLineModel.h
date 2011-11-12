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

#ifndef POLY_LINE_MODEL_H
#define POLY_LINE_MODEL_H

#include "PolyObjectModel.h"


/**
 * @brief This class is used to represents a polyline on the map.
 * 
 * @todo A detail description of this class!!
 */
class PolyLineModel : public PolyObjectModel
{
    public:
        ///////////////////////////////////////////////    
        // Constructor and Destructor
        ///////////////////////////////////////////////     
        
        /**
         * @brief Default constructor which initialze all members
         * to their default values.
         */
        PolyLineModel();
        
        /**
         * @brief Constructs a PolyLineModel object with a style attribute for the
         * drawing lines.
         *
         * @param p_style The style to draw the line of the PolyLineModel.
         */
        PolyLineModel(StyleAttrib p_style);
                
        /**
         * @brief Constructs a PolyLineModel object with seed, roughness, a style
         * attribute for the drawing lines, fill color and optional fractal.
         *
         * @param p_seed      The seed of the fractal.
         * @param p_roughness The roughness value of the fractal.
         * @param p_style     The style to draw the line of the PolyLineModel.
         * @param p_fillcolor The fill color for a closed shape PolyLineModel.
         * @param p_fractal   The type of the line.
         */
        PolyLineModel(int p_seed, int p_roughness, StyleAttrib p_style, wxColor p_fillcolor,
                      bool p_fractal = false);
        
        /**
         * @brief The default destructor for a PolyLineModel object.
         */
        virtual ~PolyLineModel();

        ///////////////////////////////////////////////
        // Inherit virtual methods
        ///////////////////////////////////////////////
        /**
         * @brief Simple comparison to determine if two PolyLineModel objects
         * are equivalent.
         *
         * @param p_other A pointer to second PolyLineModel object to compare to.
         * @return A flag whether the two object are equivalent. 
         * @retval true  Yes the two objects are equivalent.
         * @retval false No the two objects are not equivalent.
         */
        virtual bool compare(const ObjectInterface* p_other) const;
        
        /**
         * @brief A copy method, useful for copying one PolyLineModel into another.
         *
         * @param p_other A pointer to second PolyLineModel object to copy.
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

    protected:
        /**
         * @brief Perform the actual creation of the PolyLineModel, used in two
         * step creation. Used with the default constructor.
         * 
         * @param p_parent A pointer to a parent object.
         */
        virtual void create(const ObjectInterface* p_parent);

};

#endif  // POLY_LINE_MODEL_H
