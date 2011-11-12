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

#include "PolyCurveModelTest.h"


void PolyCurveModelTest::setUp(void)
{
    cp1 = new PolyCurveModel;
    con1 = new PolyCurveModel;
    StyleAttrib sa;
    sa.type = -55;
    con2 = new PolyCurveModel(sa);
    con1->setParent(con2);    
    sa.type = 101;
    con3 = new PolyCurveModel(-2, 5, sa, wxColor(0xF1, 0xF2, 0xF3), true);
    con2->setParent(con3);    
}


void PolyCurveModelTest::tearDown(void)
{
    delete cp1;
    delete con3;
}


void PolyCurveModelTest::checkSetGetFillColor(void)
{
    wxColor testColor(0xA1, 0xA2, 0xA3);
    cp1->setFillColor(testColor);
    CPPUNIT_ASSERT(cp1->getFillColor() == testColor);
    testColor = wxColor(0xBF, 0xB6, 0x03);
    cp1->setFillColor(testColor);
    CPPUNIT_ASSERT(cp1->getFillColor() == testColor);
}


void PolyCurveModelTest::checkGetCountAndAddPoint(void)
{
    CPPUNIT_ASSERT(cp1->getCount() == 0);
    arRealPoint point(-1, -2);
    CPPUNIT_ASSERT(cp1->addPoint(point, false) == 1);   
    CPPUNIT_ASSERT(cp1->getCount() == 1);
    CPPUNIT_ASSERT(cp1->getPoint(0) == point);
    point = arRealPoint(5.6789, 100);
    CPPUNIT_ASSERT(cp1->addPoint(point) == 2);   
    CPPUNIT_ASSERT(cp1->getCount() == 2);
    CPPUNIT_ASSERT(cp1->getPoint(0) != point);
    CPPUNIT_ASSERT(cp1->getPoint(1) == point);
}  


void PolyCurveModelTest::checkConstructor(void)
{
    // test the first constructor PolyCurveModel()
    // test of the members from the abstract base class PolyObjectModel
    CPPUNIT_ASSERT(con1->getCount() == 0);
    CPPUNIT_ASSERT(con1->getFillColor() == wxColor(0x00, 0x00, 0x00));
    
    // test the second constructor PolyCurveModel(ObjectInterface* p_parent,
    // StyleAttrib p_style)
    // PolyObjectModel
    CPPUNIT_ASSERT(con2->getCount() == 0);
    CPPUNIT_ASSERT(con2->getFillColor() == wxColor(0x00, 0x00, 0x00));
    
    // test the thrid constructor PolyCurveModel(ObjectInterface* p_parent,
    // int p_seed, int p_roughness, StyleAttrib p_style, wxColor p_fillColor
    // bool p_fractal = false)
    CPPUNIT_ASSERT(con3->getCount() == 0);
    CPPUNIT_ASSERT(con3->getFillColor() == wxColor(0xF1, 0xF2, 0xF3));
}


void PolyCurveModelTest::checkCopyCompare(void)
{
    wxColor testColor(0xB3, 0x0A, 0xA1);
    cp1->setFillColor(testColor);
    arRealPoint point(5, -2.4512);
    CPPUNIT_ASSERT(cp1->addPoint(point) == 1);   
    CPPUNIT_ASSERT(cp1->getCount() == 1);
    point = arRealPoint(-345678.9, 4.812);
    CPPUNIT_ASSERT(cp1->addPoint(point) == 2);   
    CPPUNIT_ASSERT(cp1->getCount() == 2);
    
    PolyCurveModel cp2;
    CPPUNIT_ASSERT(cp2.copy(cp1) == true);
    
    // test the copy method
    CPPUNIT_ASSERT(cp2.getFillColor() == testColor);
    // see test checkGetCountAndAddPoint()
    CPPUNIT_ASSERT(cp2.getCount() == 2);
    CPPUNIT_ASSERT(cp2.getPoint(0) == arRealPoint(5, -2.4512));
    CPPUNIT_ASSERT(cp2.getPoint(1) == arRealPoint(-345678.9, 4.812));
    
    // test the compare method
    CPPUNIT_ASSERT(cp2.compare(cp1) == true);
    CPPUNIT_ASSERT(cp1->compare(&cp2) == true);
    testColor = wxColor(0x0F, 0x06, 0x30);
    cp2.setFillColor(testColor);    
    CPPUNIT_ASSERT(cp2.compare(cp1) == false);
    cp1->setFillColor(testColor);
    CPPUNIT_ASSERT(cp1->compare(&cp2) == true);
    cp1->addPoint(arRealPoint(0.45, -12.23));
    CPPUNIT_ASSERT(cp1->compare(&cp2) == false);
    
    // we can't compare with LineObjectModel and PolyObjectModel because these objects aren't exist.
    // compare with ObjectInterface and DrawnObjectModel objects
    ObjectInterface oi;
    CPPUNIT_ASSERT(con1->compare(&oi) == false);
    DrawnObjectModel dom;
    CPPUNIT_ASSERT(con1->compare(&dom) == false);    
}

