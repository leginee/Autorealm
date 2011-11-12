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


#ifndef AR_DOCUMENT_TEST_H
#define AR_DOCUMENT_TEST_H

#include "test/runner.h"
#include "ARDocument.h"


/**
 * @brief This is the unit test class for the class ARDocument.
 */
class ARDocumentTest : public CppUnit::TestFixture 
{
        /**
         * @brief For setting up the test suite for ARDocumentTest
         */
        CPPUNIT_TEST_SUITE(ARDocumentTest);
        // getter and setter methods
        CPPUNIT_TEST(checkSetGetBgColor);
        CPPUNIT_TEST(checkSetGetComments);
        CPPUNIT_TEST(checkSetGetDesignGridUnits);
        CPPUNIT_TEST(checkSetGetDisplayGrid);
        CPPUNIT_TEST(checkSetGetGridColor);
        CPPUNIT_TEST(checkSetGetLandscape);
        CPPUNIT_TEST(checkSetGetOverlays);
        CPPUNIT_TEST(checkSetGetPushpins);
        CPPUNIT_TEST(checkSetGetRotateSnap);
        CPPUNIT_TEST(checkSetGetSnapAlong);
        CPPUNIT_TEST(checkSetGetSnapToGrid);
        CPPUNIT_TEST(checkSetGetSnapToPoint);
        CPPUNIT_TEST(checkSetGetVersion);
        // constructor
        CPPUNIT_TEST(checkConstructor);
        // inherit methods
        CPPUNIT_TEST(checkIsValid);
        CPPUNIT_TEST(checkCompare);
        CPPUNIT_TEST(checkCopy);
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
         * member m_bgColor.
         */
        void checkSetGetBgColor(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_comments.
         */
        void checkSetGetComments(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_designGridUnits.
         */
        void checkSetGetDesignGridUnits(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_displayGrid.
         */
        void checkSetGetDisplayGrid(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_gridColor.
         */
        void checkSetGetGridColor(void);
        
        /**
         * @brief Test the basics of the set and get methods for the
         * member m_landscape.
         */
        void checkSetGetLandscape(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_overlays.
         */
        void checkSetGetOverlays(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_pins.
         */
        void checkSetGetPushpins(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_rotateSnap.
         */
        void checkSetGetRotateSnap(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_snapAlong.
         */
        void checkSetGetSnapAlong(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_snapToGrid.
         */
        void checkSetGetSnapToGrid(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_snapToPoint.
         */
        void checkSetGetSnapToPoint(void);

        /**
         * @brief Test the basics of the set and get methods for the
         * member m_version.
         */
        void checkSetGetVersion(void);

        /**
         * @brief Test all constructors of the class ARDocumentTest.
         */        
        void checkConstructor(void);

        /**
         * @brief Test the method isValid.
         */
        void checkIsValid(void);

        /** 
         * @brief Test the comparison routine behaviors, and make sure
         * they work as advertised
         *
         * This check creates a ViewPointModel which may not be compared
         * to an ARDocument, to check for that failure.
         *
         * Afterwards, it constructs an ARDocument (doc2) step by step,
         * verifying at each point that compare fails until such time as
         * all steps are completed.
         */
        void checkCompare(void);

        /**
         * @brief Test out the copy methods, and ensure that they work.
         *
         * An effect of this which is not immediately apparent is that
         * doc2 needs a single child which is identical to the single
         * child of doc. I've done this manually, but this might not be
         * the best way to do it.
         */
        void checkCopy(void);

    private:
        /**
         * Test objects for read and write access.
         */ 
        ARDocument* doc, *doc3;
        /**
         * Color test objects.
         */
        wxColor gc, bg;
};


/**
 * @brief Register this test to the Runner object.
 */
RUNNERADD(ARDocumentTest);

#endif  // AR_DOCUMENT_TEST_H
