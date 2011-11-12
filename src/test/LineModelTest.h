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


#ifndef LINE_MODEL_TEST_H
#define LINE_MODEL_TEST_H

#include "test/runner.h"
#include "LineModel.h"


/**
 * @brief This is the unit test class for the class LineModel.
 * 
 * @todo Test all extreme values for the 'Set' methods.
 */
class LineModelTest : public CppUnit::TestFixture 
{
        /**
         * @brief For setting up the test suite for LineModelTest
         */
        CPPUNIT_TEST_SUITE(LineModelTest);
        // first test set and get methods, because the other tests based on correct set and get methods
        CPPUNIT_TEST(checkSetX1);
        CPPUNIT_TEST(checkSetX2);
        CPPUNIT_TEST(checkSetY1);
        CPPUNIT_TEST(checkSetY2);
        CPPUNIT_TEST(checkSetGetRoughness);
        CPPUNIT_TEST(checkSetGetSeed);
        CPPUNIT_TEST(checkSetGetSthickness);
        CPPUNIT_TEST(checkSetGetThickness);
        CPPUNIT_TEST(checkSetGetStyle);
        CPPUNIT_TEST(checkSetIsFractal);
        // second test the constructors
        CPPUNIT_TEST(checkConstructor);
        // third test copy and compare
        CPPUNIT_TEST(checkCopyCompare);
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
         * @brief Test the basics of the setX1 method to set the x value
         * of the first coordinate.
         */
        void checkSetX1(void);
        
        /**
         * @brief Test the basics of the setY1 method to set the y value
         * of the first coordinate.
         */
        void checkSetY1(void);

        /**
         * @brief Test the basics of the setX2 method to set the x value
         * of the second coordinate.
         */
        void checkSetX2(void);

        /**
         * @brief Test the basics of the setY2 method to set the y value
         * of the second coordinate.
         */
        void checkSetY2(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_roughness of abstract class LineObjectModel.
         */
        void checkSetGetRoughness(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_seed of abstract class LineObjectModel.
         */
        void checkSetGetSeed(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_sthickness of abstract class LineObjectModel.
         */
        void checkSetGetSthickness(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_style of abstract class LineObjectModel.
         */
        void checkSetGetStyle(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_thickness of abstract class LineObjectModel.
         */
        void checkSetGetThickness(void);

        /**
         * @brief Test the basics of the set and is methods for the
         * member m_fractal of abstract class LineObjectModel.
         */
        void checkSetIsFractal(void);
        
        /**
         * @brief Test all constructors of the class LineModel.
         */
        void checkConstructor(void);
        
        /**
         * @brief Test the methods copy and compare.
         */
        void checkCopyCompare(void);
        
                
    private:
        /**
         * First test object for read and write access.
         */ 
        LineModel *cp1;
        /**
         * First object for contructor test - only read no change of it's data.
         */
        LineModel *con1;
        /**
         * Second object for contructor test - only read no change of it's data.
         */
        LineModel *con2;
        /**
         * Third object for contructor test - only read no change of it's data.
         */
        LineModel *con3;
        
};


/**
 * @brief Register this test to the Runner object.
 */
RUNNERADD(LineModelTest);


#endif  // LINE_MODEL_TEST_H
