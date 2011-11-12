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


#ifndef GROUP_MODEL_TEST_H
#define GROUP_MODEL_TEST_H

#include "test/runner.h"
#include "GroupModel.h"
#include "ViewPointModel.h"


/**
 * @brief This is the unit test class for the class GroupModel.
 * 
 * So, what does a group need to do? On top of DrawnObjectModel, it also
 * needs to have the ability to add and remove children. Since we can't
 * rely on other objects yet, we will have to create groups with other
 * groups as children.
 *
 * However, we will use ViewPointModel for ensuring that the comparison with
 * invalid types returns false. 
 */
class GroupModelTest : public CppUnit::TestFixture 
{
        /**
         * @brief For setting up the test suite for GroupModelTest
         */
        CPPUNIT_TEST_SUITE(GroupModelTest);
        // test basics
        CPPUNIT_TEST(testBasics);
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
         * @brief Test out basics: copy, compare, and ensure they return
         * expected results.
         */
        void testBasics(void);

    private:
        /**
         * First test object for read and write access.
         */ 
        GroupModel* grpa, *grpb;
        /**
         * Test object as a child for the group.
         */ 
        ViewPointModel* vp1;
};


/**
 * @brief Register this test to the Runner object.
 */
RUNNERADD(GroupModelTest);

#endif  // GROUP_MODEL_TEST_H
