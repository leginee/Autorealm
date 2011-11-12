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


#ifndef DRAWN_OBJECT_MODEL_TEST_H
#define DRAWN_OBJECT_MODEL_TEST_H

#include "test/runner.h"
#include "DrawnObjectModel.h"


/**
 * @brief This is the unit test class for the class DrawnObjectModel.
 */
class DrawnObjectModelTest : public CppUnit::TestFixture 
{
        /**
         * @brief For setting up the test suite for DrawnObjectModelTest
         */
        CPPUNIT_TEST_SUITE(DrawnObjectModelTest);
        // getter and setter methods
        CPPUNIT_TEST(checkSetGetColor);
        CPPUNIT_TEST(checkSetGetLocation);
        CPPUNIT_TEST(checkSetGetOverlay);
        CPPUNIT_TEST(checkSetGetPoints);
        CPPUNIT_TEST(checkSetGetSelected);
        // calculation
        CPPUNIT_TEST(checkExtents);
        CPPUNIT_TEST(checkExtentsChildren);
        // constructor
        CPPUNIT_TEST(checkConstructor);
        // inherit methods
        CPPUNIT_TEST(checkCopyAndCompare);
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
         * @brief Test the basics of the set and get methods for the
         * member m_color.
         */
        void checkSetGetColor(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_location.
         */
        void checkSetGetLocation(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_overlay.
         */
        void checkSetGetOverlay(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_points.
         */
        void checkSetGetPoints(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_selected.
         */
        void checkSetGetSelected(void);
        
        /**
         * @brief Test the methods getExtent and reCalcExtent.
         */
        void checkExtents(void);

        /**
         * @brief Test the methods getExtent and reCalcChildExtents.
         */
        void checkExtentsChildren(void);

        /**
         * @brief Test all constructors of the class DrawnObjectModel.
         */        
        void checkConstructor(void);

        /**
         * @brief Test the methods copy and compare.
         */
        void checkCopyAndCompare(void);

    private:
        /**
         * Test objects for read and write access.
         */ 
        DrawnObjectModel* pd1, *pd2;
};


/**
 * @brief Register this test to the Runner object.
 */
RUNNERADD(DrawnObjectModelTest);

#endif  // DRAWN_OBJECT_MODEL_TEST_H
