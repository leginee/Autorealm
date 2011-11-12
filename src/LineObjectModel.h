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

#ifndef LINE_OBJECT_MODEL_H
#define LINE_OBJECT_MODEL_H

#include "DrawnObjectModel.h"


/**
 * StyleAttrib is the line style. We use four sections at a byte a piece
 * to specify the style of the Line, the Fill style (it if it closed),
 * and the styles of the line tips on either end.
 * 
 * @warning this is only a prototype, not the real implementation of StyleAttrib!
 * @todo Implementation of StyleAttrib
 */
struct StyleAttrib {
    /**
     * The type of a line
     */
    int type;
};


/**
 * @brief This class is used to represents all line objects on the map.
 *
 * This is an abstract class and store the necessary data for all kind of lines.
 * There is the real line (the distance betwenn two points), a curve and the poly
 * objects of a line and a curve.
 */
class LineObjectModel : public DrawnObjectModel
{
    protected:
        ///////////////////////////////////////////////    
        // Constructor Abstract class
        ///////////////////////////////////////////////     
      
        /**
         * @brief Default constructor which initialze all members
         * to their default values.
         */
        LineObjectModel();
        
        /**
         * @brief Constructs a LineObjectModel object with a style attribute 
         * for the drawing lines.
         *
         * @param p_style  The style to draw the line of all line objects.
         */
        LineObjectModel(StyleAttrib p_style);
                
        /**
         * @brief Constructs a LineObjectModel object with seed, roughness, an style
         * attribute for the drawing lines and optional fractal.
         *
         * @param p_seed      The seed of the fractal.
         * @param p_roughness The roughness value for the fractal.
         * @param p_style     The style to draw the line of the curve.
         * @param p_fractal   The type of the curve. 
         */
        LineObjectModel(int p_seed, int p_roughness, StyleAttrib p_style, bool p_fractal = false);
        
    public:
        ///////////////////////////////////////////////    
        // Destructor
        ///////////////////////////////////////////////     
        /**
         * @brief The default destructor for a LineObjectModel.
         */
        virtual ~LineObjectModel();

        ///////////////////////////////////////////////
        // Inherit virtual methods
        ///////////////////////////////////////////////
        /**
         * @brief Simple comparison to determine if two LineObjects
         * are equivalent.
         *
         * @param p_other A pointer to second LineObjectModel to compare to.
         * @return A flag whether the two objects are equivalent. 
         * @retval true  Yes the two objects are equivalent.
         * @retval false No the two objects are not equivalent.
         */
        virtual bool compare(const ObjectInterface* p_other) const;
    
        /**
         * @brief A copy method, useful for copying one LineObjectModel into another.
         *
         * @param p_other A pointer to second LineObjectModel to copy.
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
         * @brief Gets the roughness of the LineObjectModel.
         *  
         * @return The roughness of the fractal.
         */
        int getRoughness(void) const
        {
            return m_roughness;
        }

        /**
         * @brief Gets the seed of the LineObjectModel.
         *  
         * @return The seed of the fractal.
         */
        int getSeed(void) const
        {
            return m_seed;
        }

        /**
         * @brief Gets the sthickness of the LineObjectModel.
         *  
         * @return The sthickness of the line object.
         */
        int getSthickness(void) const
        {
            return m_sthickness;
        }
                
        /**
         * @brief Gets the style attribute of the LineObjectModel.
         *  
         * @return The style attribute of the drawing line.
         */
        StyleAttrib getStyle(void) const
        {
            return m_style;
        }        

        /**
         * @brief Gets the thickness of the LineObjectModel.
         *  
         * @return The thickness of the line object.
         */
        int getThickness(void) const
        {
            return m_thickness;
        }
                
        /**
         * @brief Is the LineObjectModel a fractal?
         *  
         * @return The answer if the object a fractal.
         * @retval true  The LineObjectModel is a fractal.
         * @retval false The LineObjectModel is not a fractal.
         */
        bool isFractal(void) const
        {
            return m_fractal;
        }   
    
        /**
         * @brief Sets the fractal of the LineObjectModel.
         *
         * @param p_fractal Ture if the line is a fractal otherwise false.
         */
        void setFractal(bool p_fractal)
        {
            m_fractal = p_fractal;
        }
        
        /**
         * @brief Sets the roughness of the LineObjectModel.
         *
         * @param p_roughness The new roughness value of fractal.
         */
        void setRoughness(int p_roughness)
        {
            m_roughness = p_roughness;
        }

        /**
         * @brief Sets the seed of the LineObjectModel.
         *
         * @param p_seed The new seed value of fractal.
         */
        void setSeed(int p_seed)
        {
            m_seed = p_seed;
        }
        
        /**
         * @brief Sets the sthickness of the LineObjectModel.
         *
         * @param p_sthickness The new thickness value of the line object.
         */
        void setSthickness(int p_sthickness)
        {
            m_sthickness = p_sthickness;
        }

        /**
         * @brief Sets the style attribute of the LineObjectModel.
         *
         * @param p_style The new style attribute of the drawing line.
         */
        void setStyle(const StyleAttrib& p_style)
        {
            m_style = p_style;
        }

        /**
         * @brief Sets the thickness of the LineObjectModel.
         *
         * @param p_thickness The new thickness value of the line object.
         */
        void setThickness(int p_thickness)
        {
            m_thickness = p_thickness;
        }

    private:
        /////////////////////////////////////////////// 
        //Standard attributes
        ///////////////////////////////////////////////
        /**
         * @brief The style attribute of the line to show who to draw the line object.
         */                
        StyleAttrib m_style;
        /**
         * @brief The sthickness value of the line.
         */        
        int  m_sthickness;
        /**
         * @brief The thickness value of the line.
         */        
        int  m_thickness;
        
        ///////////////////////////////////////////////
        //Fractal attributes
        ///////////////////////////////////////////////
        /**
         * @brief A flag to show if the line have a fractal.
         */        
        bool m_fractal;
        /**
         * @brief The roughness value of the fractal.
         */        
        int  m_roughness;
        /**
         * @brief The seed value of the fractal.
         */           
        int  m_seed;        
};

#endif  // LINE_OBJECT_MODEL_H
