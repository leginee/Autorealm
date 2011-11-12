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

#include "ARExcept.h"

/** 
 * @brief The testing suite for the AutoRealm exception classes
 */
class ARExceptionTest : public CppUnit::TestFixture {
	public:
		/** 
		 * @brief Empty, but required by the TestFixture class
		 */
		void setUp() {
		}

		/** 
		 * @brief Empty, but required by the TestFixture class
		 */
		void tearDown() {
		}

		/** 
		 * @brief Tests the EXCEPT macro
		 *
		 * Makes sure the EXCEPT macro still works, and will throw an
		 * ARException correctly.
		 */
		void testExceptMacro() throw (ARException) {
			EXCEPT(ARException, wxT("Bad message"));
		}

		/** 
		 * @brief Tests the ARBadNumberFormat
		 */
		void testExceptNumberFormat() throw (ARBadNumberFormat) {
			EXCEPT(ARBadNumberFormat, wxT("Bad Number Format"));
		}

		/**
		 * @brief Tests the ARMissingOverlayException
		 */
		void testExceptColor() throw (ARBadColorException) {
			EXCEPT(ARBadColorException, wxT("Bad color"));
		}

		/**
		 * @brief Tests the ARMissingOverlayException
		 */
		void testExceptOverlay() throw (ARMissingOverlayException) {
			EXCEPT(ARMissingOverlayException, wxT("Bad overlay"));
		}

		/** 
		 * @brief Tests the ARInvalidChildException
		 */
		void testExceptBadChild() throw (ARInvalidChildException) {
			EXCEPT(ARInvalidChildException, wxT("Invalid child"));
		}

		/**
		 * @brief Tests the ARInvalidTagException
		 */
		void testExceptInvalidTag() throw (ARInvalidTagException) {
			EXCEPT(ARInvalidTagException, wxT("Invalid tag"));
		}

		/**
		 * @brief Tests teh ARInvalidBoolString exception
		 */
		void testExceptInvalidBool() throw (ARInvalidBoolString) {
			EXCEPT(ARInvalidBoolString, wxT("Invalid boolean"));
		}

		/**
		 * Required for removal of doxygen errors that are bogus.,
		 */
		CPPUNIT_TEST_SUITE(ARExceptionTest);
		/**
		 * Required for removal of doxygen errors that are bogus.,
		 */
		CPPUNIT_TEST_EXCEPTION(testExceptMacro, ARException);
		/**
		 * Required for removal of doxygen errors that are bogus.,
		 */
		CPPUNIT_TEST_EXCEPTION(testExceptColor, ARBadColorException);
		/**
		 * Required for removal of doxygen errors that are bogus.,
		 */
		CPPUNIT_TEST_EXCEPTION(testExceptNumberFormat, ARBadNumberFormat);
		/**
		 * Required for removal of doxygen errors that are bogus.,
		 */
		CPPUNIT_TEST_EXCEPTION(testExceptOverlay, ARMissingOverlayException);
		/**
		 * Required for removal of doxygen errors that are bogus.,
		 */
		CPPUNIT_TEST_EXCEPTION(testExceptBadChild, ARInvalidChildException);
		/**
		 * Required for removal of doxygen errors that are bogus.,
		 */
		CPPUNIT_TEST_EXCEPTION(testExceptInvalidBool, ARInvalidBoolString);
		/**
		 * Required for removal of doxygen errors that are bogus.,
		 */
		CPPUNIT_TEST_EXCEPTION(testExceptInvalidTag, ARInvalidTagException);
		/**
		 * Required for removal of doxygen errors that are bogus.,
		 */
		CPPUNIT_TEST_SUITE_END();
};

RUNNERADD(ARExceptionTest);
