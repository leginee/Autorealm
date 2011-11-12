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


#include "ViewPointModelTest.h"


void ViewPointModelTest::setUp()
{
	vp1 = new ViewPointModel;
	vp2 = new ViewPointModel;
	vp2->setName(wxT("ViewPoint 2"));
	vp2->setZoom(100.0);
	vp2->setArea(arRealRect(0.0, 0.0, 100.0, 100.0));
	grid = new GridObjectModel;
	grid->setParent(vp2);
}


void ViewPointModelTest::tearDown()
{
	delete vp1;
	delete vp2;
}


// this test check the constructor, but the main problem that a member variable
// is not initialized can not be checked by this test.
// If someone add a new member variable to this class the test of the constructor
// have to be extended.
void ViewPointModelTest::checkConstructor()
{
	CPPUNIT_ASSERT(vp1->getArea() == arRealRect(0.0, 0.0, 0.0, 0.0));
	CPPUNIT_ASSERT(vp1->getName() == wxString());
	CPPUNIT_ASSERT(vp1->getZoom() == 0.0);
	CPPUNIT_ASSERT(vp1->getWidth() == 0.0);
	CPPUNIT_ASSERT(vp1->getHeight() == 0.0);
	CPPUNIT_ASSERT(vp1->getVisibleOverlays() == OverlayVector());
	CPPUNIT_ASSERT(vp1->getActiveOverlays() == OverlayVector());
}


void ViewPointModelTest::checkIsValidFails()
{
	CPPUNIT_ASSERT(vp1->isValid() == false);
}


void ViewPointModelTest::checkIsValidPasses()
{
	CPPUNIT_ASSERT(vp2->isValid() == true);
}


void ViewPointModelTest::checkCopy()
{
    vp1->copy(vp2);
    CPPUNIT_ASSERT(vp1->getName() == vp2->getName());
    CPPUNIT_ASSERT(vp1->getZoom() == vp2->getZoom());
    CPPUNIT_ASSERT(vp1->getArea() == vp2->getArea());
}


void ViewPointModelTest::checkCompare()
{
    vp1->copy(vp2);
    CPPUNIT_ASSERT(vp1->compare(vp2) == true);
    GridObjectModel* gom = new GridObjectModel;
    gom->setParent(vp1);
    CPPUNIT_ASSERT(vp1->compare(vp2) == true);
    vp1->setZoom(55.5);
    CPPUNIT_ASSERT(vp1->compare(vp2) == false);
}


void ViewPointModelTest::checkName()
{
	vp1->setName(wxT("ViewPoint"));
	CPPUNIT_ASSERT(vp1->getName() == wxString(wxT("ViewPoint")));
}


void ViewPointModelTest::checkZoom()
{
	vp1->setZoom(100.0);
	CPPUNIT_ASSERT(vp1->getZoom() == 100.0);
}


void ViewPointModelTest::checkArea()
{
	arRealRect area(0.0, 0.0, 25.0, 25.0);
	vp1->setArea(area);
	CPPUNIT_ASSERT(vp1->getArea() == area);
}


void ViewPointModelTest::checkHeight()
{
    vp1->setHeight(0.5);
    CPPUNIT_ASSERT(vp1->getHeight() == 0.5);
}


void ViewPointModelTest::checkWidth()
{
    vp1->setWidth(0.5);
    CPPUNIT_ASSERT(vp1->getWidth() == 0.5);
}


void ViewPointModelTest::checkOverlays()
{
    OverlayVector active, visible;
    for (unsigned int i = 0; i < MAX_OVERLAYS; ++i)
    {
	   active.at(i) = (i%2) ? true : false;
	   visible.at(i) = (i%2) ? false : true;
    }
    
    vp1->setActiveOverlays(active);
    CPPUNIT_ASSERT(vp1->getActiveOverlays() == active);
    vp1->setVisibleOverlays(visible);
    CPPUNIT_ASSERT(vp1->getVisibleOverlays() == visible);

    vp1->setOverlayActive(0);
    CPPUNIT_ASSERT(vp1->getOverlayActive(0) == true);
    vp1->setOverlayInactive(0);
    CPPUNIT_ASSERT(vp1->getOverlayActive(0) == false);

    vp1->setOverlayVisible(0);
    CPPUNIT_ASSERT(vp1->getOverlayVisible(0) == true);
    vp1->setOverlayInvisible(0);
    CPPUNIT_ASSERT(vp1->getOverlayVisible(0) == false);
}

