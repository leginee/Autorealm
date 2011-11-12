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

#include "LineModelTest.h"


void LineModelTest::setUp(void)
{
    cp1 = new LineModel;
    con1 = new LineModel;
    StyleAttrib sa;
    sa.type = -111;
    con2 = new LineModel(-1.0, -2.0, -10.8, -20.5, sa);
    con1->setParent(con2);
    sa.type = -666;
    con3 = new LineModel(-20.5, -10.8, -2.0, -1.0, -33, -44, sa, true);
    con2->setParent(con3);
}


void LineModelTest::tearDown(void)
{
    delete cp1;
    delete con3;
}


void LineModelTest::checkSetX1(void)
{
    cp1->setX1(5.1, false);
    arRealPoint point = cp1->getPoint(0);
    CPPUNIT_ASSERT(point.x == 5.1);
    cp1->setX1(0.0, false);
    point = cp1->getPoint(0);
    CPPUNIT_ASSERT(point.x == 0.0);
}


void LineModelTest::checkSetY1(void)
{
    cp1->setY1(-2.9, false);
    arRealPoint point = cp1->getPoint(0);
    CPPUNIT_ASSERT(point.y == -2.9);
    cp1->setY1(0.0, false);
    point = cp1->getPoint(0);
    CPPUNIT_ASSERT(point.y == 0.0);
}


void LineModelTest::checkSetX2(void)
{
    cp1->setX2(-27.93, false);
    arRealPoint point = cp1->getPoint(1);
    CPPUNIT_ASSERT(point.x == -27.93);
    cp1->setX2(0.0, false);
    point = cp1->getPoint(1);
    CPPUNIT_ASSERT(point.x == 0.0);            
}


void LineModelTest::checkSetY2(void)
{
    cp1->setY2(1.23, false);
    arRealPoint point = cp1->getPoint(1);
    CPPUNIT_ASSERT(point.y == 1.23);
    cp1->setY2(0.0, true);
    point = cp1->getPoint(1);
    CPPUNIT_ASSERT(point.y == 0.0);            
}


void LineModelTest::checkSetGetRoughness(void)
{
    cp1->setRoughness(-10);
    CPPUNIT_ASSERT(cp1->getRoughness() == -10);
}


void LineModelTest::checkSetGetSeed(void)
{
    cp1->setSeed(-50);
    CPPUNIT_ASSERT(cp1->getSeed() == -50);
}


void LineModelTest::checkSetGetSthickness(void)
{
    cp1->setSthickness(-42);
    CPPUNIT_ASSERT(cp1->getSthickness() == -42);
}


void LineModelTest::checkSetGetStyle(void)
{
    StyleAttrib testStyle;
    testStyle.type = -234;
    cp1->setStyle(testStyle);
    CPPUNIT_ASSERT(cp1->getStyle().type == testStyle.type);
}


void LineModelTest::checkSetGetThickness(void)
{
    cp1->setThickness(-63);
    CPPUNIT_ASSERT(cp1->getThickness() == -63);
}


void LineModelTest::checkSetIsFractal(void)
{
    cp1->setFractal(false);
    CPPUNIT_ASSERT(cp1->isFractal() == false);
    cp1->setFractal(true);
    CPPUNIT_ASSERT(cp1->isFractal() == true);
    cp1->setFractal(false);
    CPPUNIT_ASSERT(cp1->isFractal() == false);
}


void LineModelTest::checkConstructor(void)
{
    // test the first constructor LineModel()
    // test of the members from the abstract base class LineObjectModel
    CPPUNIT_ASSERT(con1->getRoughness() == 0);
    CPPUNIT_ASSERT(con1->getSeed() == 0);
    CPPUNIT_ASSERT(con1->getSthickness() == 0);
    StyleAttrib sa;
    sa.type = 0;
    CPPUNIT_ASSERT(con1->getStyle().type == sa.type);
    CPPUNIT_ASSERT(con1->getThickness() == 0);
    CPPUNIT_ASSERT(con1->isFractal() == false);
    // now test the member of the base class DrawnObjectModel()
    // @todo This test have to move into the DrawnObjectModelTest class, later.
    CPPUNIT_ASSERT(con1->getOverlays() == OverlayVector());
    CPPUNIT_ASSERT(con1->getColor() == wxColor(0x00, 0x00, 0x00));
    CPPUNIT_ASSERT(con1->getSelected() == false);
    CPPUNIT_ASSERT(con1->getExtent() == arRealRect(0.0, 0.0, 1.0, 1.0));    // why?
    CPPUNIT_ASSERT(con1->getLocation() == arRealPoint(0, 0));
    VPoints points;
    points.resize(2);
    points.at(0) = arRealPoint(0.0, 0.0);
    points.at(1) = arRealPoint(0.0, 0.0);
    CPPUNIT_ASSERT(con1->getPoints() == points);
    
    // test the second constructor LineModel(ObjectInterface* p_parent,
    // double p_x1, double p_y1, double p_x2, double p_y2, StyleAttrib p_style)
    // LineObjectModel
    CPPUNIT_ASSERT(con2->getRoughness() == 0);
    CPPUNIT_ASSERT(con2->getSeed() == 0);
    CPPUNIT_ASSERT(con2->getSthickness() == 0);
    sa.type = -111;
    CPPUNIT_ASSERT(con2->getStyle().type == sa.type);
    CPPUNIT_ASSERT(con2->getThickness() == 0);
    CPPUNIT_ASSERT(con2->isFractal() == false);
    // now test the member of the base class
    CPPUNIT_ASSERT(con2->getOverlays() == OverlayVector());
    CPPUNIT_ASSERT(con2->getColor() == wxColor(0x00, 0x00, 0x00));
    CPPUNIT_ASSERT(con2->getSelected() == false);
    // @todo a test for the extent method - this test have be implemented in DrawnObjectModel!
    //CPPUNIT_ASSERT(con2->getExtent() == arRealRect(1111, 2222, 0, 0));
    CPPUNIT_ASSERT(con2->getLocation() == arRealPoint(0, 0));
    points.at(0) = arRealPoint(-1, -2);
    points.at(1) = arRealPoint(-10.8, -20.5);
    CPPUNIT_ASSERT(con2->getPoints() == points);
    
    // test the third constructor LineModel(ObjectInterface* p_parent,
    // double p_x1, double p_y1, double p_x2, double p_y2, int p_seed, 
    // int p_roughness, StyleAttrib p_style, bool p_fractal = false)
    CPPUNIT_ASSERT(con3->getRoughness() == -44);
    CPPUNIT_ASSERT(con3->getSeed() == -33);
    CPPUNIT_ASSERT(con3->getSthickness() == 0);
    sa.type = -666;
    CPPUNIT_ASSERT(con3->getStyle().type == sa.type);
    CPPUNIT_ASSERT(con3->getThickness() == 0);
    CPPUNIT_ASSERT(con3->isFractal() == true);
}


void LineModelTest::checkCopyCompare(void)
{
    cp1->setRoughness(-2);
    cp1->setSeed(-3);
    cp1->setSthickness(-4);
    StyleAttrib testStyle;
    testStyle.type = -5;
    cp1->setStyle(testStyle);
    cp1->setThickness(-6);
    cp1->setFractal(true);
  
    LineModel cp2;
    cp2.copy(cp1);
    
    // test the copy method
    CPPUNIT_ASSERT(cp2.getRoughness() == -2);
    CPPUNIT_ASSERT(cp2.getSeed() == -3);
    CPPUNIT_ASSERT(cp2.getSthickness() == -4);
    CPPUNIT_ASSERT(cp2.getStyle().type == testStyle.type);
    CPPUNIT_ASSERT(cp2.getThickness() == -6);
    CPPUNIT_ASSERT(cp2.isFractal() == true);
    
    // test the compare method
    CPPUNIT_ASSERT(cp2.compare(cp1) == true);
    CPPUNIT_ASSERT(cp1->compare(&cp2) == true);
    cp2.setSeed(2);
    CPPUNIT_ASSERT(cp2.compare(cp1) == false);
    cp1->setSeed(2);
    CPPUNIT_ASSERT(cp1->compare(&cp2) == true);
    cp1->setRoughness(-100);
    CPPUNIT_ASSERT(cp1->compare(&cp2) == false);
    
    // we can't compare with LineObjectModel because these objects aren't exist.
    // compare with ObjectInterface and DrawnObjectModel objects
    ObjectInterface oi;
    CPPUNIT_ASSERT(con1->compare(&oi) == false);
    DrawnObjectModel dom;
    CPPUNIT_ASSERT(con1->compare(&dom) == false);    
}
