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


#ifndef GRID_OBJECT_MODEL_TEST_H
#define GRID_OBJECT_MODEL_TEST_H

#include "test/runner.h"
#include "GridObjectModel.h"


/**
 * @brief This is the unit test class for the class GridObjectModel.
 */
class GridObjectModelTest : public CppUnit::TestFixture 
{
        /**
         * @brief For setting up the test suite for GridObjectModelTest
         */
        CPPUNIT_TEST_SUITE(GridObjectModelTest);
        // test basis types
        CPPUNIT_TEST(checkForGridTypes);
        CPPUNIT_TEST(checkForPenTypes);
        // test set and get methods, because the other tests based on correct set and get methods
        CPPUNIT_TEST(checkSetGetBoldUnits);
        CPPUNIT_TEST(checkSetGetCurrentGraphUnits);
        CPPUNIT_TEST(checkSetGetCurrentGridSize);
        CPPUNIT_TEST(checkSetGetFlags);
        CPPUNIT_TEST(checkSetGetGraphScale);
        CPPUNIT_TEST(checkSetGetGraphUnitConvert);
        CPPUNIT_TEST(checkSetGetGraphUnits);
        CPPUNIT_TEST(checkSetGetPosition);
        CPPUNIT_TEST(checkSetGetPrimaryStyle);
        CPPUNIT_TEST(checkSetGetSecondaryStyle);
        CPPUNIT_TEST(checkSetGetType);
        // test the constructors
        CPPUNIT_TEST(checkConstructor);
        // test copy, compare and isValid
        CPPUNIT_TEST(checkCopyAndCompare);
        CPPUNIT_TEST(checkIsValid);
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
         * @brief Check for all the valid grid types, and make sure they're
         * available.
         */
        void checkForGridTypes(void);
        
        /**
         * @brief Check for all the valid pen types, and make sure they're
         * available.
         */
        void checkForPenTypes(void);
        
        ///////////////////////////////////////////////
        // Getter and Setter Methods
        ///////////////////////////////////////////////

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_boldUnits.
         */
        void checkSetGetBoldUnits(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_currentGraphUnits.
         */
        void checkSetGetCurrentGraphUnits(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_currentGridSize.
         */
        void checkSetGetCurrentGridSize(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_flags.
         */
        void checkSetGetFlags(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_graphScale.
         */
        void checkSetGetGraphScale(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_GraphUnitConvert.
         */
        void checkSetGetGraphUnitConvert(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_graphUnits.
         */
        void checkSetGetGraphUnits(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_position.
         */
        void checkSetGetPosition(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_primaryStyle.
         */
        void checkSetGetPrimaryStyle(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_secondaryStyle.
         */
        void checkSetGetSecondaryStyle(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_type.
         */
        void checkSetGetType(void);
        
        /**
         * @brief Test all constructors of the class GridObjectModel.
         */
        void checkConstructor(void);

        /**
         * @brief Test the methods copy and compare.
         */
        void checkCopyAndCompare(void);
                
        /**
         * @brief Test the method isValid.
         */
        void checkIsValid(void);
                
    private:
        /**
         * @brief Pointer to the first grid object to be verified
         */
        GridObjectModel* grid;
        /**
         * @brief Pointer to the second grid object to be verified
         */
        GridObjectModel* grid2;
};


/**
 * @brief Register this test to the Runner object.
 */
RUNNERADD(GridObjectModelTest);

#endif  // GRID_OBJECT_MODEL_TEST_H
