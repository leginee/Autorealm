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

#ifndef POLY_CURVE_MODEL_BUILDER_H
#define POLY_CURVE_MODEL_BUILDER_H


#include "subbuilder/SubBuilder.h"


namespace subbuilderComponents
{

    /**
     * @brief A SubBuilder for building PolyCurveModel objects.
     */
    class PolyCurveModelBuilder : public SubBuilder
    {
        public:
            /**
             * @brief A simple constructor to initialize the m_pointCounter variable.
             */        
            PolyCurveModelBuilder() : m_pointCounter(0) {};
        
            /**
             * This is used to make gcc happy, by adding a virtual destructor.
             * While it doesn't need to do anything, this does remove one
             * warning from the list of warnings when the build is run in
             * DEBUG=1 mode.
             */
            virtual ~PolyCurveModelBuilder() {};
        
            /**
             * @brief Perform any startup actions for any relevant tags.
             */
            virtual void startObject(BuilderStackEntry &p_tag);
            
            /**
             * @brief Perform any closing actions that are appropriate for the
             * various tags.
             * 
             * Usually, this means converting the tag information into the
             * appropriate in memory representation for the object.
             * 
             * @param p_tag The BuilderStack entry for the tag being closed.
             */
            virtual void endObject(const BuilderStackEntry &p_tag);
        
        protected:
            /**
             * @brief The count of points of the PolyCurveModel.
             */
            unsigned int m_pointCounter;
    };
   
}   // namespace subbuilderComponents

#endif  // POLY_CURVE_MODEL_BUILDER_H