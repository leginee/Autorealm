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

#include "CurveModelTest.h"


void CurveModelTest::setUp(void)
{
    cp1 = new CurveModel;
    aRP1 = new arRealPoint(1, 2);
    aRP2 = new arRealPoint(10, 20);
    aRP3 = new arRealPoint(100, 200);
    aRP4 = new arRealPoint(1000, 2000);
    con1 = new CurveModel;
    StyleAttrib sa;
    sa.type = 111;
    con2 = new CurveModel(*aRP1, *aRP2, *aRP3, *aRP4, sa);
    sa.type = 666;
    con1->setParent(con2);
    con3 = new CurveModel(*aRP4, *aRP3, *aRP2, *aRP1, 33, 44, sa, true);
    con2->setParent(con3);
}


void CurveModelTest::tearDown(void)
{
    delete cp1;
    delete con3;
    delete aRP1;
    delete aRP2;
    delete aRP3;
    delete aRP4;
}


void CurveModelTest::checkSetGetRoughness(void)
{
    cp1->setRoughness(10);
    CPPUNIT_ASSERT(cp1->getRoughness() == 10);
}


void CurveModelTest::checkSetGetSeed(void)
{
    cp1->setSeed(50);
    CPPUNIT_ASSERT(cp1->getSeed() == 50);
}


void CurveModelTest::checkSetGetSthickness(void)
{
    cp1->setSthickness(42);
    CPPUNIT_ASSERT(cp1->getSthickness() == 42);
}


void CurveModelTest::checkSetGetStyle(void)
{
    StyleAttrib testStyle;
    testStyle.type = 234;
    cp1->setStyle(testStyle);
    CPPUNIT_ASSERT(cp1->getStyle().type == testStyle.type);
}


void CurveModelTest::checkSetGetThickness(void)
{
    cp1->setThickness(63);
    CPPUNIT_ASSERT(cp1->getThickness() == 63);
}


void CurveModelTest::checkSetIsFractal(void)
{
    cp1->setFractal(false);
    CPPUNIT_ASSERT(cp1->isFractal() == false);
    cp1->setFractal(true);
    CPPUNIT_ASSERT(cp1->isFractal() == true);
    cp1->setFractal(false);
    CPPUNIT_ASSERT(cp1->isFractal() == false);
}


void CurveModelTest::checkConstructor(void)
{
    // test the first constructor CurveModel()
    CPPUNIT_ASSERT(con1->getRoughness() == 0);
    CPPUNIT_ASSERT(con1->getSeed() == 0);
    CPPUNIT_ASSERT(con1->getSthickness() == 0);
    StyleAttrib sa;
    sa.type = 0;
    CPPUNIT_ASSERT(con1->getStyle().type == sa.type);
    CPPUNIT_ASSERT(con1->getThickness() == 0);
    CPPUNIT_ASSERT(con1->isFractal() == false);
    // now test the member of the base class DrawnObjectModel()
    CPPUNIT_ASSERT(con1->getOverlays() == OverlayVector());
    CPPUNIT_ASSERT(con1->getColor() == wxColor(0x00, 0x00, 0x00));
    CPPUNIT_ASSERT(con1->getSelected() == false);
    CPPUNIT_ASSERT(con1->getExtent() == arRealRect(0, 0, 0, 0));
    CPPUNIT_ASSERT(con1->getLocation() == arRealPoint(0, 0));
    CPPUNIT_ASSERT(con1->getPoints() == VPoints());
    
    // test the second constructor CurveModel(
    // arRealPoint p_point1, arRealPoint p_point2, arRealPoint p_point3,
    // arRealPoint p_point4, StyleAttrib p_style)
    CPPUNIT_ASSERT(con2->getRoughness() == 0);
    CPPUNIT_ASSERT(con2->getSeed() == 0);
    CPPUNIT_ASSERT(con2->getSthickness() == 0);
    sa.type = 111;
    CPPUNIT_ASSERT(con2->getStyle().type == sa.type);
    CPPUNIT_ASSERT(con2->getThickness() == 0);
    CPPUNIT_ASSERT(con2->isFractal() == false);
    // now test the member of the base class
    CPPUNIT_ASSERT(con2->getOverlays() == OverlayVector());
    CPPUNIT_ASSERT(con2->getColor() == wxColor(0x00, 0x00, 0x00));
    CPPUNIT_ASSERT(con2->getSelected() == false);
    //CPPUNIT_ASSERT(con2->getExtent() == arRealRect(1111, 2222, 0, 0));
    CPPUNIT_ASSERT(con2->getLocation() == arRealPoint(0, 0));
    VPoints points;
    points.resize(4);
    points.at(0) = *aRP1;
    points.at(1) = *aRP2;
    points.at(2) = *aRP3;
    points.at(3) = *aRP4;
    CPPUNIT_ASSERT(con2->getPoints() == points);
    
    // test the third constructor CurveModel(
    // arRealPoint p_point1, arRealPoint p_point2, arRealPoint p_point3,
    // arRealPoint p_point4, int p_seed, int p_roughness, StyleAttrib p_style,
    // bool p_fractal = false)
    CPPUNIT_ASSERT(con3->getRoughness() == 44);
    CPPUNIT_ASSERT(con3->getSeed() == 33);
    CPPUNIT_ASSERT(con3->getSthickness() == 0);
    sa.type = 666;
    CPPUNIT_ASSERT(con3->getStyle().type == sa.type);
    CPPUNIT_ASSERT(con3->getThickness() == 0);
    CPPUNIT_ASSERT(con3->isFractal() == true);
}


void CurveModelTest::checkCopyCompare(void)
{
    cp1->setRoughness(2);
    cp1->setSeed(3);
    cp1->setSthickness(4);
    StyleAttrib testStyle;
    testStyle.type = 5;
    cp1->setStyle(testStyle);
    cp1->setThickness(6);
    cp1->setFractal(true);
  
    CurveModel cp2;
    cp2.copy(cp1);
    
    // test the copy method
    CPPUNIT_ASSERT(cp2.getRoughness() == 2);
    CPPUNIT_ASSERT(cp2.getSeed() == 3);
    CPPUNIT_ASSERT(cp2.getSthickness() == 4);
    CPPUNIT_ASSERT(cp2.getStyle().type == testStyle.type);
    CPPUNIT_ASSERT(cp2.getThickness() == 6);
    CPPUNIT_ASSERT(cp2.isFractal() == true);
    
    // test the compare method
    CPPUNIT_ASSERT(cp2.compare(cp1) == true);
    CPPUNIT_ASSERT(cp1->compare(&cp2) == true);
    cp2.setSeed(2);
    CPPUNIT_ASSERT(cp2.compare(cp1) == false);
    cp1->setSeed(2);
    CPPUNIT_ASSERT(cp1->compare(&cp2) == true);
    cp1->setRoughness(100);
    CPPUNIT_ASSERT(cp1->compare(&cp2) == false);
    
    // we can't compare with a LineObjectModel object. It's abstract.
    // compare with ObjectInterface and DrawnObjectModel objects
    ObjectInterface oi;
    CPPUNIT_ASSERT(con1->compare(&oi) == false);
    DrawnObjectModel dom;
    CPPUNIT_ASSERT(con1->compare(&dom) == false);
}
