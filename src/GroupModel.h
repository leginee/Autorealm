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


#ifndef GROUP_MODEL_H
#define GROUP_MODEL_H


#include "DrawnObjectModel.h"


/**
 * @brief This class group some objects together.
 * 
 * This class will, quite likely, generate a significant amount of controversy
 * when it is seen. However, the class has a very valid use in distinguishing
 * from a simple DrawnObjectModel and an actual group to be placed on the map.
 *
 * However, due to the functionality that is present in DrawnObjectModel (and
 * needed for other classes to be placed in DrawnObjectModel), this particular
 * class has nothing in it except constructor and destructor.
 */
class GroupModel : public DrawnObjectModel
{
	public:
        /**
         * @brief Default constructor which initialze all members
         * to their default values.
         */
		GroupModel();

		/**
		 * @brief Destructor. Cleans up all owned memory.
         */
		virtual ~GroupModel();

        /**
         * @brief Simple comparison to determine if two GroupModels
         * are equivalent.
         *
         * @param p_other A pointer to second GroupModel to compare to.
         * @return A flag whether the two object are equivalent. 
         * @retval true  Yes the two objects are equivalent.
         * @retval false No the two objects are not equivalent.
         */
		virtual bool compare(const ObjectInterface* p_other) const;
};


#endif  // GROUP_MODEL_H
