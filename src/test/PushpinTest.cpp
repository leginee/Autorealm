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
#include "Pushpin.h"

/**
 * Used to test the pushpin classes
 */
class PushpinTest : public CppUnit::TestFixture {
	private:
		Pushpin* pin;
		PushpinCollection* coll;
	public:
		/**
		 * Configure the runtime conditions
		 */
		void setUp() {
			pin = new Pushpin;
			coll = new PushpinCollection;
			coll->m_pins.at(0) = *pin;
		}

		/**
		 * Deconfigure the runtime conditions
		 */
		void tearDown() {
			delete pin;
			delete coll;
		}

		/**
		 * Simple tests on the collection, to ensure the constructor
		 * behaves as expected
		 */
		void testCollection() {
			CPPUNIT_ASSERT(coll->m_waypointsVisible == false);
			CPPUNIT_ASSERT(coll->m_showNumber == false);
			CPPUNIT_ASSERT(coll->m_showNote == false);
			CPPUNIT_ASSERT(coll->m_pins.size() == MAX_PUSHPINS);
		}

		/**
		 * Simple tests on the pin, to ensure the constructor
		 * behaves as expected
		 */
		void testPinInitialization() {
			CPPUNIT_ASSERT(pin->m_checked == false);
			CPPUNIT_ASSERT(pin->m_placed  == false);
			CPPUNIT_ASSERT(pin->m_point   == arRealPoint(0.0, 0.0));
			CPPUNIT_ASSERT(pin->m_name == wxT(""));
			CPPUNIT_ASSERT(pin->m_history.size() == 0);
		}

		/**
		 * Simple tests on collection comparison
		 */
		void testCollectionEquality() {
			PushpinCollection pins1, pins2;

			CPPUNIT_ASSERT(pins1 == pins2);
		}

		/**
		 * Simple tests on collection assignment
		 */
		void testCollectionAssignment() {
			PushpinCollection pins1, pins2;
			pins1.m_waypointsVisible = true;

			pins2 = pins1;
			CPPUNIT_ASSERT(pins1 == pins2);
		}

		/**
		 * Simple tests on the pin history functions
		 */
		void testHistory() {
			PushpinHistory hist(arRealPoint(1.0, 1.0), wxT("test note"));
			PushpinHistory hist2(arRealPoint(2.0, 2.0), wxT("test note 2"));
			PushpinHistory hist3;
			coll->m_pins.at(0).addHist(hist);
			CPPUNIT_ASSERT(coll->m_pins.at(0).m_history.size() == 1);

			hist3 = coll->m_pins.at(0).getHist(0);
			CPPUNIT_ASSERT(hist.m_point == hist3.m_point);
			CPPUNIT_ASSERT(hist.m_note  == hist3.m_note);

			coll->m_pins.at(0).addHist(hist2);

			hist3 = coll->m_pins.at(0).getHist(0);
			CPPUNIT_ASSERT(hist3.m_point == hist2.m_point);
			CPPUNIT_ASSERT(hist3.m_note  == hist2.m_note);

			hist3 = coll->m_pins.at(0).getHist(1);
			CPPUNIT_ASSERT(hist.m_point == hist3.m_point);
			CPPUNIT_ASSERT(hist.m_note  == hist3.m_note);

			CPPUNIT_ASSERT(coll->m_pins.at(0).m_history.size() == 2);
		}

		/**
		 * Test comparison operator on pins
		 */
		void testEquality() {
			Pushpin pin2;
			CPPUNIT_ASSERT(*pin == pin2);
		}

		/**
		 * Test comparison operator on pin histories
		 */
		void testHistoryEquality() {
			PushpinHistory hist1;
			PushpinHistory hist2;

			CPPUNIT_ASSERT(hist1 == hist2);
		}

		/**
		 * For setting up the test suite for PushpinTest
		 */
		CPPUNIT_TEST_SUITE(PushpinTest);
		/**
		 * For setting up the test suite for PushpinTest
		 */
		CPPUNIT_TEST(testCollection);
		/**
		 * For setting up the test suite for PushpinTest
		 */
		CPPUNIT_TEST(testCollectionEquality);
		/**
		 * For setting up the test suite for PushpinTest
		 */
		CPPUNIT_TEST(testCollectionAssignment);
		/**
		 * For setting up the test suite for PushpinTest
		 */
		CPPUNIT_TEST(testPinInitialization);
		/**
		 * For setting up the test suite for PushpinTest
		 */
		CPPUNIT_TEST(testHistory);
		/**
		 * For setting up the test suite for PushpinTest
		 */
		CPPUNIT_TEST(testEquality);
		/**
		 * For setting up the test suite for PushpinTest
		 */
		CPPUNIT_TEST(testHistoryEquality);
		/**
		 * For setting up the test suite for PushpinTest
		 */
		CPPUNIT_TEST_SUITE_END();
};

/**
 * Used to add this class to the suite of tests to be run
 */
RUNNERADD(PushpinTest);
