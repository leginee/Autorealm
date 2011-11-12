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

#ifndef RUNNER_H
#define RUNNER_H
#include <cppunit/TestCase.h>
#include <cppunit/ui/text/TestRunner.h>
#include <cppunit/extensions/HelperMacros.h>

/**
 * This is a singleton class, and is used to make writing of new
 * test cases easier.
 *
 * In reality, few people will ever call this class directly. Instead,
 * they will use RUNNERADD() macro, defined below.
 *
 * If need be, it is possible to get at the TestRunner class itself by
 * calling Runner::Get(), and using it directly.
 */
class Runner {
	public:
		/**
		 * Singleton factory method. Used to get the TestRunner instance
		 * that is maintained globally.
		 */
		static CppUnit::TextUi::TestRunner* Get() {
			if (m_runner == NULL) {
				m_runner = new CppUnit::TextUi::TestRunner;
			}
			return(m_runner);
		}
	private:
		static CppUnit::TextUi::TestRunner* m_runner;
};

/**
 * Used to add a test suite. Assuming that the rest of the code has been
 * written to standards, you may use this code by placing the following
 * line at the beginning of your file:
 *
 * 		#include "test/runner.h"
 *
 * And then placing the following line as the last line of your .cpp file:
 *
 * 		RUNNERADD(MyTestSuiteClassName);
 * 
 * And you're done. Your testing suite will now be added to the list of
 * tests, and called automatically.
 */
#define RUNNERADD(TESTSUITE) namespace {\
	class TestBuilder {\
		public:\
			   TestBuilder() {\
				   Runner::Get()->addTest(TESTSUITE::suite());\
			   }\
	};\
	TestBuilder test;\
}

#endif //RUNNER_H
