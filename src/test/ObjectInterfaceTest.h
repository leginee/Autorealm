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


#ifndef OBJECT_INTERFACE_TEST_H
#define OBJECT_INTERFACE_TEST_H

#include "test/runner.h"
#include "ObjectInterface.h"


/**
 * @brief This is the unit test class for the class ObjectInterface.
 */
class ObjectInterfaceTest : public CppUnit::TestFixture 
{
        /**
         * @brief For setting up the test suite for PolyLineModelTest
         */
        CPPUNIT_TEST_SUITE(ObjectInterfaceTest);
        // first test the children methods
        CPPUNIT_TEST(checkChildren);
        // second test the constructors
        CPPUNIT_TEST(checkConstructor);
        // third test copy and compare
        CPPUNIT_TEST(checkCopyCompare);
        // test the setParent, addChild, removeChild methods
        CPPUNIT_TEST(checkParent);
        // this test is for the clone feature
        CPPUNIT_TEST(checkClone);
        // further tests, like calculations and other methods
        CPPUNIT_TEST_SUITE_END();

    public:
        /** 
         * @brief Required by the TestFixture class, this method simply
         * creates the objects necessary to complete all tests.
         */
        void setUp(void);

        /** 
         * @brief Required by the TestFixture class, this method simply
         * cleans up after each test.
         */
        void tearDown(void);
       
        /**
         * @brief Test the basics of all children methods and the parent member.
         */
        void checkChildren(void);

        /**
         * @brief Test constructor of the class ObjectInterface.
         */
        void checkConstructor(void);

        /**
         * @brief Test the methods copy and compare.
         */
        void checkCopyCompare(void);

        /**
         * @brief Test the methods setParent, addChild and removeChild.
         */
        void checkParent(void);

        /**
         * @brief Test the method clone.
         */
        void checkClone(void);

    private:
        /**
         * First object for contructor test - only read no change of it's data.
         */
        ObjectInterface* con1;
        /**
         * Second object for contructor test - read and write.
         */
        ObjectInterface* con2;
        /**
         * Third object for contructor test - only read no change of it's data.
         */
        ObjectInterface* con3;
};


/**
 * @brief Register this test to the Runner object.
 */
RUNNERADD(ObjectInterfaceTest);

#endif
