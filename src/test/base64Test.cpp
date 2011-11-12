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
#include <string>
#include "test/runner.h"

#include <wx/strconv.h>
#include "base64.h"


/** 
 * This class acts as a testing harness for the ARDocument class.
 */
class base64Test : public CppUnit::TestFixture {
	private:
		wxString input, output, decode;
		std::string hold;
		wxInt8* data;
		int len;

	public:
		/** 
		 * @brief Required by the TestFixture class, this method simply
		 * creates the objects necessary to complete all tests.
		 */
		void setUp() {
			data = NULL;
		}

		/** 
		 * @brief Required by the TestFixture class, this method simply
		 * cleans up after each test.
		 */
		void tearDown() {
			if (data) {
				delete data;
			}
		}

		/**
		 * base64 encoding turns 3 bytes into 4 characters. First, turn 3
		 * characters into 4.
		 */
		void test3to4() {
			input = wxT("ABC");
    		output = base64encode(input);
    		data = (wxInt8*)base64decode(output, len);
			data[len] = '\0';
			hold = (char*)data;
    		decode = wxString(hold.c_str(), *wxConvCurrent);

			CPPUNIT_ASSERT(output == wxT("QUJD"));
			CPPUNIT_ASSERT(input == decode);
		}

		/**
		 * base64 turns 3 bytes into 4 characters, and uses padding when
		 * needed. This makes sure the padding works as expected
		 */
		void test4to8() {
    		input = wxT("ABCD");
    		output = base64encode(input);
    		data = (wxInt8*)base64decode(output, len);
			data[len] = '\0';
			hold = (char*)data;
    		decode = wxString(hold.c_str(), *wxConvCurrent);

			CPPUNIT_ASSERT(output == wxT("QUJDRA=="));
			CPPUNIT_ASSERT(input == decode);
		}

		/**
		 * Test 5 character encoding, to make sure we get the right amount
		 * of padding
		 */
		void test5to8() {
    		input = wxT("ABCDE");
    		output = base64encode(input);
    		data = (wxInt8*)base64decode(output, len);
			data[len] = '\0';
			hold = (char*)data;
    		decode = wxString(hold.c_str(), *wxConvCurrent);

			CPPUNIT_ASSERT(output == wxT("QUJDREU="));
			CPPUNIT_ASSERT(input = decode);
		}

		/**
		 * Finally, we have rules on how long output lines can be. This
		 * test is to compare, and make sure we don't overflow the lines)
		 */
		void testLongEncodeDecode() {
    		input = wxT("ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ");
    		output = base64encode(input);
    		data = (wxInt8*)base64decode(output, len);
			data[len] = '\0';
			hold = (char*)data;
    		decode = wxString(hold.c_str(), *wxConvCurrent);

			CPPUNIT_ASSERT(output == wxT("QUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVpBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWkFC\x0D\x0AQ0RFRkdISUpLTE1OT1BRUlNUVVZXWFlaQUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVo="));
			CPPUNIT_ASSERT(input == decode);
		}

		/** 
		 * @brief Tests the convenience methods from base64.cpp
		 */
		void testConvenience() {
			wxString input1, input2, input3, input4;
			wxString output1, output2, output3, output4;
			wxString decode1, decode2, decode3, decode4;

    		input1 = wxT("ABC");
    		input2 = wxT("ABCD");
    		input3 = wxT("ABCDE");
    		input4 = wxT("ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ");

			output1 = base64encode(input1);
			output2 = base64encode(input2);
			output3 = base64encode(input3);
			output4 = base64encode(input4);

			decode1 = base64decode(output1);
			decode2 = base64decode(output2);
			decode3 = base64decode(output3);
			decode4 = base64decode(output4);

			CPPUNIT_ASSERT(output1 == wxT("QUJD"));
			CPPUNIT_ASSERT(output2 == wxT("QUJDRA=="));
			CPPUNIT_ASSERT(output3 == wxT("QUJDREU="));
			CPPUNIT_ASSERT(output4 == wxT("QUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVpBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWkFC\x0D\x0AQ0RFRkdISUpLTE1OT1BRUlNUVVZXWFlaQUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVo="));

			CPPUNIT_ASSERT(input1 == decode1);
			CPPUNIT_ASSERT(input2 == decode2);
			CPPUNIT_ASSERT(input3 == decode3);
			CPPUNIT_ASSERT(input4 == decode4);
		}

		/**
		 * For setting up the test suite for ARDocumentTest
		 */
		CPPUNIT_TEST_SUITE(base64Test);
		/**
		 * For setting up the test suite for ARDocumentTest
		 */
		CPPUNIT_TEST(test3to4);
		/**
		 * For setting up the test suite for ARDocumentTest
		 */
		CPPUNIT_TEST(test4to8);
		/**
		 * For setting up the test suite for ARDocumentTest
		 */
		CPPUNIT_TEST(test5to8);
		/**
		 * For setting up the test suite for ARDocumentTest
		 */
		CPPUNIT_TEST(testLongEncodeDecode);
		/**
		 * For setting up the test suite for ARDocumentTest
		 */
		CPPUNIT_TEST(testConvenience);
		/**
		 * For setting up the test suite for ARDocumentTest
		 */
		CPPUNIT_TEST_SUITE_END();
};

RUNNERADD(base64Test);
