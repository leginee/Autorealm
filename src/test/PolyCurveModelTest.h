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


#ifndef POLY_CURVE_MODEL_TEST_H
#define POLY_CURVE_MODEL_TEST_H

#include "test/runner.h"
#include "PolyCurveModel.h"


/**
 * @brief This is the unit test class for the class PolyCurveModel.
 * 
 * @todo Test all extreme values for the 'Set' methods.
 */
class PolyCurveModelTest : public CppUnit::TestFixture 
{
        /**
         * @brief For setting up the test suite for PolyCurveModelTest
         */
        CPPUNIT_TEST_SUITE(PolyCurveModelTest);
        // first test set and get methods, because the other tests based on correct set and get methods
        CPPUNIT_TEST(checkSetGetFillColor);
        CPPUNIT_TEST(checkGetCountAndAddPoint);
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
         * @brief Test the basics of the set and get methods for the
         * member m_fillcolor.
         */
        void checkSetGetFillColor(void);

        /**
         * @brief Test the basics of the get method for the count of points
         * in member m_points from DrawnObjectModel. Also checks the addPoint methods
         * to adds new points to the PolyCurveModel. 
         */
        void checkGetCountAndAddPoint(void);

        /**
         * @brief Test all constructors of the class PolyCurveModel.
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
        PolyCurveModel *cp1;
        /**
         * First object for contructor test - only read no change of it's data.
         */
        PolyCurveModel *con1;
        /**
         * Second object for contructor test - only read no change of it's data.
         */
        PolyCurveModel *con2;
        /**
         * Third object for contructor test - only read no change of it's data.
         */
        PolyCurveModel *con3;
        
};


/**
 * @brief Register this test to the Runner object.
 */
RUNNERADD(PolyCurveModelTest);


#endif  // POLY_CURVE_MODEL_TEST_H
