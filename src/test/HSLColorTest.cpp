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

#include "test/runner.h"

#include <wx/colour.h>
#include "HSLColor.h"
#include "ViewPointModel.h"

/** 
 * This class acts as a testing harness for the HSLColor class.
 */
class HSLColorTest : public CppUnit::TestFixture {
	public:
		/** 
		 * @brief Required by the TestFixture class, this method simply
		 * creates the objects necessary to complete all tests.
		 */
		void setUp() {
		}

		/** 
		 * @brief Required by the TestFixture class, this method simply
		 * cleans up after each test.
		 */
		void tearDown() {
		}

		/** 
		 * @brief Test to make sure that HSL color handles black correctly
		 */
		void testBlack() {
			HSLColor pBlack(wxColor(0x00, 0x00, 0x00));
			CPPUNIT_ASSERT_EQUAL(static_cast<int>(pBlack.hue()), 0);
			CPPUNIT_ASSERT_EQUAL(static_cast<int>(pBlack.saturation()), 0);
			CPPUNIT_ASSERT_EQUAL(static_cast<int>(pBlack.luminance()), 0);
		}
		
		/** 
		 * @brief Test to make sure that HSL color handles grey correctly
		 */
		void testGrey() {
			HSLColor pGrey(wxColor(0x80, 0x80, 0x80));
			CPPUNIT_ASSERT_EQUAL(static_cast<int>(pGrey.hue()), 0);
			CPPUNIT_ASSERT_EQUAL(static_cast<int>(pGrey.saturation()), 0);
			CPPUNIT_ASSERT_EQUAL(static_cast<int>(pGrey.luminance()),  0x80);
		}

		/**
		 * For setting up the test suite for HSLColorTest
		 */
		CPPUNIT_TEST_SUITE(HSLColorTest);
		/**
		 * For setting up the test suite for HSLColorTest
		 */
		CPPUNIT_TEST(testBlack);
		/**
		 * For setting up the test suite for HSLColorTest
		 */
		CPPUNIT_TEST(testGrey);
		/**
		 * Required to end a test suite
		 */
		CPPUNIT_TEST_SUITE_END();
};

/**
 * Required to add the test suite to the entire unit test
 */
RUNNERADD(HSLColorTest);
