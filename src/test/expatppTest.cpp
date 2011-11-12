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

#include <iostream>

#include "test/runner.h"

class expatppTest : public CppUnit::TestFixture {
	public:
		/** 
		 * @brief Required by the TestFixture class, this method simply
		 * creates the objects necessary to complete all tests.
		 */
		void setUp() {}

		/** 
		 * @brief Required by the TestFixture class, this method simply
		 * cleans up after each test.
		 */
		void tearDown() {}

		void infoMessage() {
			///@todo Implement expatppTest
		}

		CPPUNIT_TEST_SUITE(expatppTest);
		CPPUNIT_TEST(infoMessage);
		CPPUNIT_TEST_SUITE_END();
};

RUNNERADD(expatppTest);
