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

#include "PolyLineModelTest.h"


void PolyLineModelTest::setUp(void)
{
    cp1 = new PolyLineModel;
    con1 = new PolyLineModel;
    StyleAttrib sa;
    sa.type = 5;
    con2 = new PolyLineModel(sa);
    con1->setParent(con2);    
    sa.type = 1000;
    con3 = new PolyLineModel(0, 1115, sa, wxColor(0x01, 0x02, 0x03), true);
    con2->setParent(con3);    
}


void PolyLineModelTest::tearDown(void)
{
    delete cp1;
    // con1, con2 will be deleted by con3
    delete con3;
}


void PolyLineModelTest::checkSetGetFillColor(void)
{
    wxColor testColor(0x11, 0x22, 0x33);
    cp1->setFillColor(testColor);
    CPPUNIT_ASSERT(cp1->getFillColor() == testColor);
    testColor = wxColor(0xFF, 0x66, 0x33);
    cp1->setFillColor(testColor);
    CPPUNIT_ASSERT(cp1->getFillColor() == testColor);
}


void PolyLineModelTest::checkGetCountAndAddPoint(void)
{
    CPPUNIT_ASSERT(cp1->getCount() == 0);
    arRealPoint point(1, 2);
    CPPUNIT_ASSERT(cp1->addPoint(point) == 1);   
    CPPUNIT_ASSERT(cp1->getCount() == 1);
    CPPUNIT_ASSERT(cp1->getPoint(0) == point);
    point = arRealPoint(-3, -100);
    CPPUNIT_ASSERT(cp1->addPoint(point) == 2);   
    CPPUNIT_ASSERT(cp1->getCount() == 2);
    CPPUNIT_ASSERT(cp1->getPoint(0) != point);
    CPPUNIT_ASSERT(cp1->getPoint(1) == point);
}  


void PolyLineModelTest::checkConstructor(void)
{
    // test the first constructor PolyLineModel()
    // test of the members from the abstract base class PolyObjectModel
    CPPUNIT_ASSERT(con1->getCount() == 0);
    CPPUNIT_ASSERT(con1->getFillColor() == wxColor(0x00, 0x00, 0x00));

    // test the second constructor PolyLineModel(ObjectInterface* p_parent,
    // StyleAttrib p_style)
    // PolyObjectModel
    CPPUNIT_ASSERT(con2->getCount() == 0);
    CPPUNIT_ASSERT(con2->getFillColor() == wxColor(0x00, 0x00, 0x00));
    
    // test the thrid constructor PolyLineModel(ObjectInterface* p_parent,
    // int p_seed, int p_roughness, StyleAttrib p_style, wxColor p_fillColor
    // bool p_fractal = false)
    CPPUNIT_ASSERT(con3->getCount() == 0);
    CPPUNIT_ASSERT(con3->getFillColor() == wxColor(0x01, 0x02, 0x03));
}


void PolyLineModelTest::checkCopyCompare(void)
{
    wxColor testColor(0x33, 0xFA, 0xAF);
    cp1->setFillColor(testColor);
    arRealPoint point(1, 2);
    CPPUNIT_ASSERT(cp1->addPoint(point) == 1);   
    CPPUNIT_ASSERT(cp1->getCount() == 1);
    point = arRealPoint(-3, -100);
    CPPUNIT_ASSERT(cp1->addPoint(point) == 2);   
    CPPUNIT_ASSERT(cp1->getCount() == 2);
    
    PolyLineModel cp2;
    CPPUNIT_ASSERT(cp2.copy(cp1) == true);

    // test the copy method
    CPPUNIT_ASSERT(cp2.getFillColor() == testColor);
    // see test checkGetCountAndAddPoint()
    CPPUNIT_ASSERT(cp2.getCount() == 2);
    CPPUNIT_ASSERT(cp2.getPoint(0) == arRealPoint(1, 2));
    CPPUNIT_ASSERT(cp2.getPoint(1) == arRealPoint(-3, -100));

    // test the compare method
    CPPUNIT_ASSERT(cp2.compare(cp1) == true);
    CPPUNIT_ASSERT(cp1->compare(&cp2) == true);
    testColor = wxColor(0xFF, 0x66, 0x33);
    cp2.setFillColor(testColor);    
    CPPUNIT_ASSERT(cp2.compare(cp1) == false);
    cp1->setFillColor(testColor);
    CPPUNIT_ASSERT(cp1->compare(&cp2) == true);
    cp1->addPoint(arRealPoint(0, -12));
    CPPUNIT_ASSERT(cp1->compare(&cp2) == false);

    // we can't compare with LineObjectModel and PolyObjectModel because these objects aren't exist.
    // compare with ObjectInterface and DrawnObjectModel objects
    ObjectInterface oi;
    CPPUNIT_ASSERT(con1->compare(&oi) == false);
    DrawnObjectModel dom;
    CPPUNIT_ASSERT(con1->compare(&dom) == false);    
}

