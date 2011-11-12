/*
 * Port of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
 * Used in rpgs and hobbyist GIS applications for mapmaking
 * Copyright (C) 2004 Michael J. Pedersen <m.pedersen@icelus.org>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
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
#include "test/runner.h"
#include "test/randlist.cpp"

#include "rand.h"

/**
 * Test harness for generating random numbers
 */
class randTest : public CppUnit::TestFixture {
	public:
		/**
		 * Set random seed to 0, makes for good starting point
		 */
		void setUp() {
    		setRndSeed(0);
		};

		/**
		 * Nothing to tear down
		 */
		void tearDown() {
		};

		/**
		 * Generate 100,000 numbers, and make sure each one matches. The list
		 * of matches is kept in randlist.cpp, to make it easier to read this
		 * file.
		 */
		void testRandVals() {
			wxUint32 u;
			CPPUNIT_ASSERT(getRndSeed() == 0);
			for (int i=0; i<100000; i++) {
				u = getRndNumber(2147483637);
				CPPUNIT_ASSERT(u == randlist[i]);
			}
			u = getRndSeed();
			CPPUNIT_ASSERT(u == 331400544);
		};

		/**
		 * Set up the test suite
		 */
		CPPUNIT_TEST_SUITE(randTest);
		/**
		 * Set up the test suite
		 */
		CPPUNIT_TEST(testRandVals);
		/**
		 * Set up the test suite
		 */
		CPPUNIT_TEST_SUITE_END();
};

RUNNERADD(randTest);
