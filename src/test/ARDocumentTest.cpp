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


#include "ARDocumentTest.h"
#include "ViewPointModel.h"


void ARDocumentTest::setUp(void)
{
	PushpinCollection pins;
	gc.Set(0x63, 0x63, 0xff);
	bg.Set(0xff, 0xff, 0xff);

	doc = new ARDocument;
	doc->setVersion(6);
	doc->setGridColor(gc);
	doc->setBgColor(bg);
	doc->setComments(wxT("Some check comments"));
	doc->addOverlayName(wxT("Political"));
	doc->setLandscape(true);
	doc->setSnapToGrid(true);
	doc->setSnapToPoint(true);
	doc->setSnapAlong(true);
	doc->setRotateSnap(true);
	doc->setDisplayGrid(true);
	doc->setDesignGridUnits(32);
	pins = doc->getPushpins();
	pins.m_waypointsVisible = true;
	pins.m_showNumber = true;
	pins.m_showNote = true;
	doc->setPushpins(pins);
	
	doc3 = new ARDocument;
	doc3->setVersion(6);
	doc3->setGridColor(gc);
	doc3->setBgColor(bg);
	doc3->setComments(wxT("Some check comments"));
	doc3->addOverlayName(wxT("Political"));
	doc3->setLandscape(true);
	doc3->setSnapToGrid(true);
	doc3->setSnapToPoint(true);
	doc3->setSnapAlong(true);
	doc3->setRotateSnap(true);
	doc3->setDisplayGrid(true);
	doc3->setDesignGridUnits(32);
	pins = doc3->getPushpins();
	pins.m_waypointsVisible = true;
	pins.m_showNumber = true;
	pins.m_showNote = true;
	doc3->setPushpins(pins);
	doc3->setParent(doc);
}


void ARDocumentTest::tearDown(void)
{
	delete doc;
}


void ARDocumentTest::checkSetGetBgColor(void)
{
    CPPUNIT_ASSERT(doc->getBgColor().Ok() and (doc->getBgColor() == bg));
    doc->setBgColor(wxColor(0x34, 0x56, 0xa9));
    CPPUNIT_ASSERT(doc->getBgColor() == wxColor(0x34, 0x56, 0xa9));
    doc->setBgColor(wxColor(0x00, 0x00, 0x00));
    CPPUNIT_ASSERT(doc->getBgColor() == wxColor(0x00, 0x00, 0x00));
    doc->setBgColor(bg);
    CPPUNIT_ASSERT(doc->getBgColor() == bg);

    wxColor invalid;
    CPPUNIT_ASSERT(invalid.Ok() == false);
    CPPUNIT_ASSERT_THROW(doc->setBgColor(invalid), ARBadColorException);   
}


void ARDocumentTest::checkSetGetComments(void)
{
    doc->setComments(wxT("Some Test"));
    CPPUNIT_ASSERT(doc->getComments() == wxT("Some Test"));
    doc->setComments(wxT(""));
    CPPUNIT_ASSERT(doc->getComments() == wxT(""));
    doc->setComments(wxT("A Second Comment"));
    CPPUNIT_ASSERT(doc->getComments() == wxT("A Second Comment"));
}


void ARDocumentTest::checkSetGetDesignGridUnits(void)
{
    doc->setDesignGridUnits(16);
    CPPUNIT_ASSERT(doc->getDesignGridUnits() == 16);
    doc->setDesignGridUnits(0);
    CPPUNIT_ASSERT(doc->getDesignGridUnits() == 0);
    doc->setDesignGridUnits(1);
    CPPUNIT_ASSERT(doc->getDesignGridUnits() == 1);
    doc->setDesignGridUnits(1234);
    CPPUNIT_ASSERT(doc->getDesignGridUnits() == 1234);
}


void ARDocumentTest::checkSetGetDisplayGrid(void)
{
    doc->setDisplayGrid(true);
    CPPUNIT_ASSERT(doc->getDisplayGrid() == true);
    doc->setDisplayGrid(false);
    CPPUNIT_ASSERT(doc->getDisplayGrid() == false);
    doc->setDisplayGrid(true);
    CPPUNIT_ASSERT(doc->getDisplayGrid() == true);
}


void ARDocumentTest::checkSetGetGridColor(void)
{
    CPPUNIT_ASSERT(doc->getGridColor().Ok() and (doc->getGridColor() == gc));
    doc->setGridColor(wxColor(0xff, 0xff, 0xff));
    CPPUNIT_ASSERT(doc->getGridColor() == wxColor(0xff, 0xff, 0xff));
    doc->setGridColor(wxColor(0x00, 0x00, 0x00));
    CPPUNIT_ASSERT(doc->getGridColor() == wxColor(0x00, 0x00, 0x00));
    doc->setGridColor(gc);
    CPPUNIT_ASSERT(doc->getGridColor() == gc);

    wxColor invalid;
    CPPUNIT_ASSERT(invalid.Ok() == false);
    CPPUNIT_ASSERT_THROW(doc->setGridColor(invalid), ARBadColorException);   
}


void ARDocumentTest::checkSetGetLandscape(void)
{
    doc->setLandscape(true);
    CPPUNIT_ASSERT(doc->getLandscape() == true);
    doc->setLandscape(false);
    CPPUNIT_ASSERT(doc->getLandscape() == false);
    doc->setLandscape(true);
    CPPUNIT_ASSERT(doc->getLandscape() == true);
}


void ARDocumentTest::checkSetGetOverlays(void)
{
    CPPUNIT_ASSERT(doc->getOverlayCount() == 1);    
    int overlaynum = doc->addOverlayName(wxT("")) - 1;
    CPPUNIT_ASSERT(doc->getOverlayCount() == 2);    
    CPPUNIT_ASSERT(doc->getOverlayName(overlaynum) == wxT(""));

    doc->setOverlayName(overlaynum, wxT("Political"));
    CPPUNIT_ASSERT(doc->getOverlayName(overlaynum) == wxT("Political"));
    
    overlaynum = doc->addOverlayName(wxT("Test Name")) - 1;
    CPPUNIT_ASSERT(doc->getOverlayCount() == 3);    
    CPPUNIT_ASSERT(doc->getOverlayName(overlaynum) == wxT("Test Name"));
    
    CPPUNIT_ASSERT_THROW(doc->getOverlayName(3), ARMissingOverlayException);
}


void ARDocumentTest::checkSetGetPushpins(void)
{
    CPPUNIT_ASSERT(doc->getPushpins().m_pins.size() == MAX_PUSHPINS);
    Pushpin pin, pin2;
    pin.m_checked = true;
    
    doc->setPushpin(0, pin);
    pin2 = doc->getPushpin(0);
    CPPUNIT_ASSERT(pin.m_checked == pin2.m_checked);

    PushpinCollection pins;
    pins.m_showNumber = pins.m_showNote = pins.m_waypointsVisible = true;
    doc->setPushpins(pins);
    CPPUNIT_ASSERT(doc->getPushpins() == pins);

    CPPUNIT_ASSERT_THROW(doc->getPushpin(MAX_PUSHPINS), ARInvalidPushpin);
    CPPUNIT_ASSERT_THROW(doc->getPushpin(MAX_PUSHPINS + 1), ARInvalidPushpin);
    CPPUNIT_ASSERT_NO_THROW(doc->getPushpin(MAX_PUSHPINS - 1));

    CPPUNIT_ASSERT_THROW(doc->setPushpin(MAX_PUSHPINS, pin2), ARInvalidPushpin);
    CPPUNIT_ASSERT_THROW(doc->setPushpin(MAX_PUSHPINS + 1, pin2), ARInvalidPushpin);
    CPPUNIT_ASSERT_NO_THROW(doc->setPushpin(MAX_PUSHPINS - 1, pin2));
}


void ARDocumentTest::checkSetGetRotateSnap(void)
{
    doc->setRotateSnap(true);
    CPPUNIT_ASSERT(doc->getRotateSnap() == true);
    doc->setRotateSnap(false);
    CPPUNIT_ASSERT(doc->getRotateSnap() == false);
    doc->setRotateSnap(true);
    CPPUNIT_ASSERT(doc->getRotateSnap() == true);
}


void ARDocumentTest::checkSetGetSnapAlong(void)
{
    doc->setSnapAlong(true);
    CPPUNIT_ASSERT(doc->getSnapAlong() == true);
    doc->setSnapAlong(false);
    CPPUNIT_ASSERT(doc->getSnapAlong() == false);
    doc->setSnapAlong(true);
    CPPUNIT_ASSERT(doc->getSnapAlong() == true);
}


void ARDocumentTest::checkSetGetSnapToGrid(void)
{
    doc->setSnapToGrid(true);
    CPPUNIT_ASSERT(doc->getSnapToGrid() == true);
    doc->setSnapToGrid(false);
    CPPUNIT_ASSERT(doc->getSnapToGrid() == false);
    doc->setSnapToGrid(true);
    CPPUNIT_ASSERT(doc->getSnapToGrid() == true);
}


void ARDocumentTest::checkSetGetSnapToPoint(void)
{
    doc->setSnapToPoint(true);
    CPPUNIT_ASSERT(doc->getSnapToPoint() == true);
    doc->setSnapToPoint(false);
    CPPUNIT_ASSERT(doc->getSnapToPoint() == false);
    doc->setSnapToPoint(true);
    CPPUNIT_ASSERT(doc->getSnapToPoint() == true);
}


void ARDocumentTest::checkSetGetVersion(void)
{
    doc->setVersion(0);
	CPPUNIT_ASSERT(doc->getVersion() == 0);
    doc->setVersion(1);
    CPPUNIT_ASSERT(doc->getVersion() == 1);
    doc->setVersion(6);
    CPPUNIT_ASSERT(doc->getVersion() == 6);
}


void ARDocumentTest::checkConstructor(void)
{
    ARDocument doc2; 
    CPPUNIT_ASSERT(doc2.getBgColor() == wxColor(0xff, 0xff, 0xff));
    CPPUNIT_ASSERT(doc2.getComments() == wxT(""));
    CPPUNIT_ASSERT(doc2.getDesignGridUnits() == 16);
    CPPUNIT_ASSERT(doc2.getDisplayGrid() == false);
    CPPUNIT_ASSERT(doc2.getGridColor() == wxColor(0x00, 0xff, 0xff));
    CPPUNIT_ASSERT(doc2.getLandscape() == false);
    CPPUNIT_ASSERT(doc2.getOverlayCount() == 0);
    CPPUNIT_ASSERT(doc2.getPushpins() == PushpinCollection());
    CPPUNIT_ASSERT(doc2.getRotateSnap() == false);
    CPPUNIT_ASSERT(doc2.getSnapAlong() == false);
    CPPUNIT_ASSERT(doc2.getSnapToGrid() == false);
    CPPUNIT_ASSERT(doc2.getSnapToPoint() == false);
    CPPUNIT_ASSERT(doc2.getVersion() == 0);    
}


void ARDocumentTest::checkIsValid(void)
{
	ARDocument *check = new ARDocument;
	CPPUNIT_ASSERT(check->isValid() == false);
	delete check;
	CPPUNIT_ASSERT(doc->isValid() == true);
}


void ARDocumentTest::checkCompare(void)
{
	ARDocument* doc2 = new ARDocument;;
	ARDocument* doc4 = new ARDocument;;
	ViewPointModel* vp = new ViewPointModel;

	doc4->setBgColor(bg);
	doc4->setComments(wxT("Some check comments"));
    doc4->setDesignGridUnits(32);
    doc4->setDisplayGrid(true);
    doc4->setGridColor(gc);
    doc4->setLandscape(true);
	doc4->addOverlayName(wxT("Political"));
    doc4->setPushpins(doc->getPushpins());
    doc4->setRotateSnap(true);
	doc4->setSnapToGrid(true);
	doc4->setSnapToPoint(true);
	doc4->setSnapAlong(true);
    doc4->setVersion(6);
    CPPUNIT_ASSERT(doc3->compare(doc4) == true);
    CPPUNIT_ASSERT(doc2->compare(doc4) == false);
    CPPUNIT_ASSERT(doc->compare(doc4) == false);

	CPPUNIT_ASSERT(doc->compare(vp) == false);
    CPPUNIT_ASSERT(doc->compare(doc2) == false);
    doc2->setBgColor(bg);
    CPPUNIT_ASSERT(doc->compare(doc2) == false);
    doc2->setComments(wxT("Some check comments"));
    CPPUNIT_ASSERT(doc->compare(doc2) == false);
    doc2->setDesignGridUnits(32);
	CPPUNIT_ASSERT(doc->compare(doc2) == false);
    doc2->setDisplayGrid(true);
	CPPUNIT_ASSERT(doc->compare(doc2) == false);
	doc2->setGridColor(gc);
	CPPUNIT_ASSERT(doc->compare(doc2) == false);
    doc2->setLandscape(true);
    CPPUNIT_ASSERT(doc->compare(doc2) == false);
	doc2->addOverlayName(wxT("Political"));
	CPPUNIT_ASSERT(doc->compare(doc2) == false);
    doc2->setPushpins(doc->getPushpins());
    CPPUNIT_ASSERT(doc->compare(doc2) == false);
    doc2->setRotateSnap(true);
    CPPUNIT_ASSERT(doc->compare(doc2) == false);
    doc2->setSnapAlong(true);
    CPPUNIT_ASSERT(doc->compare(doc2) == false);    
	doc2->setSnapToGrid(true);
	CPPUNIT_ASSERT(doc->compare(doc2) == false);
	doc2->setSnapToPoint(true);
	CPPUNIT_ASSERT(doc->compare(doc2) == false);
    doc2->setVersion(6);
    CPPUNIT_ASSERT(doc->compare(doc2) == false);

	doc4->setParent(doc2);
	CPPUNIT_ASSERT(doc->compare(doc2) == true);
 
	delete vp;
	delete doc2;
}


void ARDocumentTest::checkCopy(void)
{
	ViewPointModel* vp = new ViewPointModel;
	ARDocument* doc2 = new ARDocument;
	ARDocument* doc4 = new ARDocument;
    
	doc4->setVersion(6);
	doc4->setGridColor(gc);
	doc4->setBgColor(bg);
	doc4->setComments(wxT("Some check comments"));
	doc4->addOverlayName(wxT("Political"));
	doc4->setLandscape(true);
	doc4->setSnapToGrid(true);
	doc4->setSnapToPoint(true);
	doc4->setSnapAlong(true);
	doc4->setRotateSnap(true);
	doc4->setDisplayGrid(true);
	doc4->setDesignGridUnits(32);
	doc4->setPushpins(doc->getPushpins());

	CPPUNIT_ASSERT(doc2->copy(vp) == false);
	CPPUNIT_ASSERT(doc2->copy(doc) == true);
    // this is false because the children will not be copy!
    CPPUNIT_ASSERT(doc2->compare(doc) == false);

    CPPUNIT_ASSERT(doc4->compare(doc) == false);
	doc4->setParent(doc2);
	CPPUNIT_ASSERT(doc2->compare(doc) == true);

	delete vp;
	delete doc2;
}
