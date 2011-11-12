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

#include "DrawnObjectModelTest.h"


void DrawnObjectModelTest::setUp(void)
{
	pd1 	= new DrawnObjectModel;
	pd2		= new DrawnObjectModel;
}


void DrawnObjectModelTest::tearDown(void)
{
	delete pd1;
	delete pd2;
}


void DrawnObjectModelTest::checkSetGetColor(void)
{
    pd1->setColor(wxColor(0xff, 0xff, 0xff));
    CPPUNIT_ASSERT(pd1->getColor() == wxColor(0xff, 0xff, 0xff));
    pd1->setColor(wxColor(0x00, 0x00, 0x00));
    CPPUNIT_ASSERT(pd1->getColor() == wxColor(0x00, 0x00, 0x00));
    pd1->setColor(wxColor(0xf0, 0x10, 0x00));
    CPPUNIT_ASSERT(pd1->getColor() == wxColor(0xf0, 0x10, 0x00));
    
    wxColor invalid;
    CPPUNIT_ASSERT(invalid.Ok() == false);
    CPPUNIT_ASSERT_THROW(pd1->setColor(invalid), ARBadColorException);   
}


void DrawnObjectModelTest::checkSetGetLocation(void)
{
    arRealPoint pt1(10.0, 15.0);
    arRealPoint pt2(0, 0);
    arRealPoint pt3(-1.5, 75.320);

    pd1->setLocation(pt1);
    CPPUNIT_ASSERT(pd1->getLocation() == pt1);
    pd1->setLocation(pt2);
    CPPUNIT_ASSERT(pd1->getLocation() == pt2);
    pd1->setLocation(pt3);
    CPPUNIT_ASSERT(pd1->getLocation() == pt3);
}


void DrawnObjectModelTest::checkSetGetOverlay(void)
{
    pd1->setOverlay(0, true);
    pd1->setOverlay(2, true);
    CPPUNIT_ASSERT(pd1->getOverlay(0) == true);
    CPPUNIT_ASSERT(pd1->getOverlay(1) == false);
    CPPUNIT_ASSERT(pd1->getOverlay(2) == true);
    
    pd1->setOverlay(0, false);
    pd1->setOverlay(1, true);
    pd1->setOverlay(2, true);
    CPPUNIT_ASSERT(pd1->getOverlay(0) == false);
    CPPUNIT_ASSERT(pd1->getOverlay(1) == true);
    CPPUNIT_ASSERT(pd1->getOverlay(2) == true);
    
    OverlayVector ov1;
    ov1.at(3) = true;
    ov1.at(4) = true;
    
    pd1->setOverlays(ov1);
    CPPUNIT_ASSERT(pd1->getOverlays() == ov1);
    ov1.at(0) = true;
    CPPUNIT_ASSERT(pd1->getOverlays() != ov1);
    pd1->setOverlay(0, true);
    CPPUNIT_ASSERT(pd1->getOverlays() == ov1);

    CPPUNIT_ASSERT_THROW(pd1->getOverlay(MAX_OVERLAYS), ARMissingOverlayException);   
    CPPUNIT_ASSERT_THROW(pd1->getOverlay(MAX_OVERLAYS + 1), ARMissingOverlayException);   
    CPPUNIT_ASSERT_NO_THROW(pd1->getOverlay(MAX_OVERLAYS - 1));   
}


void DrawnObjectModelTest::checkSetGetPoints(void)
{
    arRealPoint pt1(10, 10), pt2(20, 20), pt3(30, 30);
    arRealPoint cmp;

    // First, we check to make sure that everything is empty
    VPoints points, pdpoints;
    CPPUNIT_ASSERT(points == pdpoints);

    pdpoints = pd1->getPoints();
    CPPUNIT_ASSERT(points == pdpoints);
    
    // Add some points to our main check point vector
    points.push_back(pt1);
    points.push_back(pt2);

    // Set the points in pd1 to our main vector, and check both
    // getPoints/setPoints
    pd1->setPoints(points);
    pdpoints = pd1->getPoints();
    CPPUNIT_ASSERT(points == pdpoints);

    // check getPoint()
    cmp = pd1->getPoint(1);
    CPPUNIT_ASSERT(pt2 == cmp);

    // check setPoint()
    pd1->setPoint(2, pt3);
    cmp = pd1->getPoint(2);
    CPPUNIT_ASSERT(pt3 == cmp);

    // Add a point way after the end, and verify that we can get the
    // same point back
    pd1->setPoint(9, pt3);
    cmp = pd1->getPoint(9);
    CPPUNIT_ASSERT(pt3 == cmp);

    // Finally, check on the size of the points vector in the object
    // Since we added in slot 9, and the vector is 0 based, there
    // should now be 10 objects. Make sure of that.
    pdpoints = pd1->getPoints();
    CPPUNIT_ASSERT(10 == pdpoints.size()); 
}


void DrawnObjectModelTest::checkSetGetSelected(void)
{
    pd1->setSelected(false);
    CPPUNIT_ASSERT(pd1->getSelected() == false);
    pd1->setSelected(true);
    CPPUNIT_ASSERT(pd1->getSelected() == true);
    pd1->setSelected(false);
    CPPUNIT_ASSERT(pd1->getSelected() == false);
}


void DrawnObjectModelTest::checkExtents(void)
{
    CPPUNIT_ASSERT(pd1->getExtent() == arRealRect(0, 0, 0, 0));

    VPoints points;
    points.push_back(arRealPoint(10, 10));
    pd1->setPoints(points);
    CPPUNIT_ASSERT(pd1->getExtent() == arRealRect(10, 10, 0, 0));
    
    points.push_back(arRealPoint(-10, -10));
    pd1->setPoints(points);
    CPPUNIT_ASSERT(pd1->getExtent() == arRealRect(10, 10, -19, -19));

    points.push_back(arRealPoint(25, 25));
    pd1->setPoints(points);
    CPPUNIT_ASSERT(pd1->getExtent() == arRealRect(-10, -10, 35, 35));
}


void DrawnObjectModelTest::checkExtentsChildren(void)
{
    DrawnObjectModel* pd3 = new DrawnObjectModel;
    CPPUNIT_ASSERT(pd1->getExtent() == arRealRect(0, 0, 0, 0));

    VPoints points2;
    points2.push_back(arRealPoint(10, 10));
    points2.push_back(arRealPoint(-10, -10));
    pd3->setPoints(points2);
    CPPUNIT_ASSERT(pd3->getExtent() == arRealRect(10, 10, -19, -19));

    pd3->setParent(pd1);
    pd1->reCalcExtent();
    CPPUNIT_ASSERT(pd1->getExtent() == arRealRect(10, 10, -19, -19));

    VPoints points;
    points.push_back(arRealPoint(25, 25));
    pd1->setPoints(points);
    CPPUNIT_ASSERT(pd1->getExtent() == arRealRect(10, 10, 15, 15));
}


void DrawnObjectModelTest::checkConstructor(void)
{
    CPPUNIT_ASSERT(pd2->getColor() == wxColor(0x00, 0x00, 0x00));
    CPPUNIT_ASSERT(pd2->getExtent() == arRealRect(0, 0, 0, 0));
    CPPUNIT_ASSERT(pd2->getLocation() == arRealPoint(0, 0));
    CPPUNIT_ASSERT(pd2->getOverlays() == OverlayVector());
    CPPUNIT_ASSERT(pd2->getPoints() == VPoints());
    CPPUNIT_ASSERT(pd2->getSelected() == false);
}


void DrawnObjectModelTest::checkCopyAndCompare(void)
{
    CPPUNIT_ASSERT(pd1->compare(pd2));
    // check an ObjectInterface because you can put through an ObjectInterface
    ObjectInterface oi;
    CPPUNIT_ASSERT(!pd1->compare(&oi));

	pd2->copy(pd1);	
	CPPUNIT_ASSERT(pd1->compare(pd2));
	
	//selection should not affect equivalence.
	pd2->setSelected(!pd2->getSelected());
	CPPUNIT_ASSERT(pd1->compare(pd2));
	
	pd2->setLocation(arRealPoint(1,2));
	CPPUNIT_ASSERT(!pd1->compare(pd2));
}
