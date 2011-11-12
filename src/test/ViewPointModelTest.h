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


#ifndef VIEW_POINT_MODEL_TEST_H
#define VIEW_POINT_MODEL_TEST_H

#include "test/runner.h"
#include "ViewPointModel.h"
#include "GridObjectModel.h"



/**
 * @brief This is the unit test class for the class ViewPointModel.
 */
class ViewPointModelTest : public CppUnit::TestFixture 
{
        /**
         * @brief For setting up the test suite for ViewPointModelTest
         */
        CPPUNIT_TEST_SUITE(ViewPointModelTest);
        // test constructor and inherit methods
        CPPUNIT_TEST(checkConstructor);
        CPPUNIT_TEST(checkIsValidFails);
        CPPUNIT_TEST(checkIsValidPasses);
        CPPUNIT_TEST(checkCopy);
        CPPUNIT_TEST(checkCompare);
        // test set and get methods        
        CPPUNIT_TEST(checkName);
        CPPUNIT_TEST(checkZoom);
        CPPUNIT_TEST(checkArea);
        CPPUNIT_TEST(checkHeight);
        CPPUNIT_TEST(checkWidth);
        CPPUNIT_TEST(checkOverlays);
        
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
         * @brief Test all constructors of the class ViewPointModel.
         */
        void checkConstructor(void);
        
        /**
         * @brief Test the method isValid to fail.
         */
        void checkIsValidFails(void);

        /**
         * @brief Test the method isValid to pass.
         */
        void checkIsValidPasses(void);

        /**
         * @brief Test the method copy.
         */
        void checkCopy(void);

        /**
         * @brief Test the method compare.
         */
        void checkCompare(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_name.
         */
        void checkName(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_zoom.
         */
        void checkZoom(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_area.
         */
        void checkArea(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_height.
         */
        void checkHeight(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_width.
         */
        void checkWidth(void);

        /**
         * @brief Test the basics of the set and is methods for the
         * member m_activeOverlays and m_visibleOverlays.
         */
        void checkOverlays(void);
                
    private:
        /**
         * First test object for read and write access.
         */ 
        ViewPointModel *vp1;
        /**
         * Second test object with name (a valid one).
         */ 
        ViewPointModel *vp2;
        /**
         * Test object to use as a child.
         */
        GridObjectModel *grid;
};


/**
 * @brief Register this test to the Runner object.
 */
RUNNERADD(ViewPointModelTest);

#endif  // VIEW_POINT_MODEL_TEST_H
