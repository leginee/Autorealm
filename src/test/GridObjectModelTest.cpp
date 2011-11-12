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

#include "GridObjectModelTest.h"


void GridObjectModelTest::setUp(void)
{
	grid = new GridObjectModel;
	grid2 = new GridObjectModel;
}


void GridObjectModelTest::tearDown(void)
{
	delete grid;
    delete grid2;
}


void GridObjectModelTest::checkForGridTypes(void)
{
	GridObjectModel::GridType gt = GridObjectModel::gtNone;
	CPPUNIT_ASSERT(gt != 0);
	gt = GridObjectModel::gtSquare;
	CPPUNIT_ASSERT(gt != 0);
	gt = GridObjectModel::gtHex;
	CPPUNIT_ASSERT(gt != 0);
	gt = GridObjectModel::gtTriangle;
	CPPUNIT_ASSERT(gt != 0);
	gt = GridObjectModel::gtRotatedHex;
	CPPUNIT_ASSERT(gt != 0);
	gt = GridObjectModel::gtDiamond;
	CPPUNIT_ASSERT(gt != 0);
	gt = GridObjectModel::gtHalfDiamond;
	CPPUNIT_ASSERT(gt != 0);
	gt = GridObjectModel::gtPolar;
	CPPUNIT_ASSERT(gt != 0);
}



void GridObjectModelTest::checkForPenTypes(void)
{
	GridObjectModel::GridPenStyle gps;
	gps = GridObjectModel::gpsDefault;
	CPPUNIT_ASSERT(gps != 0);
	gps = GridObjectModel::gpsSingle;
	CPPUNIT_ASSERT(gps != 0);
	gps = GridObjectModel::gpsDot;
	CPPUNIT_ASSERT(gps != 0);
	gps = GridObjectModel::gpsDash;
	CPPUNIT_ASSERT(gps != 0);
	gps = GridObjectModel::gpsDashDot;
	CPPUNIT_ASSERT(gps != 0);
	gps = GridObjectModel::gpsDashDotDot;
	CPPUNIT_ASSERT(gps != 0);
	gps = GridObjectModel::gpsBold;
	CPPUNIT_ASSERT(gps != 0);
}


///////////////////////////////////////////////
// Getter and Setter Methods
///////////////////////////////////////////////

void GridObjectModelTest::checkSetGetBoldUnits(void)
{
    grid->setBoldUnits(73564623);
    CPPUNIT_ASSERT(grid->getBoldUnits() == 73564623);
    grid->setBoldUnits(0);
    CPPUNIT_ASSERT(grid->getBoldUnits() == 0);
    grid->setBoldUnits(32);
    CPPUNIT_ASSERT(grid->getBoldUnits() == 32);
}


void GridObjectModelTest::checkSetGetCurrentGraphUnits(void)
{
    grid->setCurrentGraphUnits(0);
    CPPUNIT_ASSERT(grid->getCurrentGraphUnits() == 0);
    grid->setCurrentGraphUnits(1);
    CPPUNIT_ASSERT(grid->getCurrentGraphUnits() == 1);
    grid->setCurrentGraphUnits(283474);
    CPPUNIT_ASSERT(grid->getCurrentGraphUnits() == 283474);
}


void GridObjectModelTest::checkSetGetCurrentGridSize(void)
{
    grid->setCurrentGridSize(0);
    CPPUNIT_ASSERT(grid->getCurrentGridSize() == 0);
    grid->setCurrentGridSize(1);
    CPPUNIT_ASSERT(grid->getCurrentGridSize() == 1);
    grid->setCurrentGridSize(982);
    CPPUNIT_ASSERT(grid->getCurrentGridSize() == 982);
}


void GridObjectModelTest::checkSetGetFlags(void)
{
    grid->setFlags(0xF8F8F8F8);
    CPPUNIT_ASSERT(grid->getFlags() == 0xF8F8F8F8);
    grid->setFlags(0x0);
    CPPUNIT_ASSERT(grid->getFlags() == 0x0);
    grid->setFlags(1);
    CPPUNIT_ASSERT(grid->getFlags() == 1);
}


void GridObjectModelTest::checkSetGetGraphScale(void)
{
	grid->setGraphScale(1.1);
	CPPUNIT_ASSERT(grid->getGraphScale() == 1.1);
    grid->setGraphScale(0);
    CPPUNIT_ASSERT(grid->getGraphScale() == 0);
    grid->setGraphScale(-123.345);
    CPPUNIT_ASSERT(grid->getGraphScale() == -123.345);
    grid->setGraphScale(26);
    CPPUNIT_ASSERT(grid->getGraphScale() == 26);
}


void GridObjectModelTest::checkSetGetGraphUnitConvert(void)
{
	grid->setGraphUnitConvert(1.1);
	CPPUNIT_ASSERT(grid->getGraphUnitConvert() == 1.1);
    grid->setGraphUnitConvert(-234);
    CPPUNIT_ASSERT(grid->getGraphUnitConvert() == -234);
    grid->setGraphUnitConvert(0);
    CPPUNIT_ASSERT(grid->getGraphUnitConvert() == 0);
    grid->setGraphUnitConvert(9374.23784);
    CPPUNIT_ASSERT(grid->getGraphUnitConvert() == 9374.23784);
}


void GridObjectModelTest::checkSetGetGraphUnits(void)
{
	grid->setGraphUnits(wxT("Furlongs"));
	CPPUNIT_ASSERT(grid->getGraphUnits() == wxT("Furlongs"));
    grid->setGraphUnits(wxT(""));
    CPPUNIT_ASSERT(grid->getGraphUnits() == wxT(""));
    grid->setGraphUnits(wxT("MoreNames"));
    CPPUNIT_ASSERT(grid->getGraphUnits() == wxT("MoreNames"));
}


void GridObjectModelTest::checkSetGetPosition(void)
{
	grid->setPosition(0xA9A9A9A9);
	CPPUNIT_ASSERT(grid->getPosition() == 0xA9A9A9A9);
    grid->setPosition(0);
    CPPUNIT_ASSERT(grid->getPosition() == 0);
    grid->setPosition(35);
    CPPUNIT_ASSERT(grid->getPosition() == 35);
}


void GridObjectModelTest::checkSetGetPrimaryStyle(void)
{
	grid->setPrimaryStyle(GridObjectModel::gpsDash);
	CPPUNIT_ASSERT(grid->getPrimaryStyle() == GridObjectModel::gpsDash);
    grid->setPrimaryStyle(GridObjectModel::gpsDefault);
    CPPUNIT_ASSERT(grid->getPrimaryStyle() == GridObjectModel::gpsDefault);
    grid->setPrimaryStyle(GridObjectModel::gpsBold);
    CPPUNIT_ASSERT(grid->getPrimaryStyle() == GridObjectModel::gpsBold);
}


void GridObjectModelTest::checkSetGetSecondaryStyle(void)
{
	grid->setSecondaryStyle(GridObjectModel::gpsDot);
	CPPUNIT_ASSERT(grid->getSecondaryStyle() == GridObjectModel::gpsDot);
    grid->setSecondaryStyle(GridObjectModel::gpsBold);
    CPPUNIT_ASSERT(grid->getSecondaryStyle() == GridObjectModel::gpsBold);
    grid->setSecondaryStyle(GridObjectModel::gpsDefault);
    CPPUNIT_ASSERT(grid->getSecondaryStyle() == GridObjectModel::gpsDefault);
}


void GridObjectModelTest::checkSetGetType(void)
{
    grid->setType(GridObjectModel::gtSquare);
    CPPUNIT_ASSERT(grid->getType() == GridObjectModel::gtSquare);
    grid->setType(GridObjectModel::gtPolar);
    CPPUNIT_ASSERT(grid->getType() == GridObjectModel::gtPolar);
    grid->setType(GridObjectModel::gtNone);
    CPPUNIT_ASSERT(grid->getType() == GridObjectModel::gtNone);
}


void GridObjectModelTest::checkConstructor(void)
{
    CPPUNIT_ASSERT(grid2->getBoldUnits() == 5);
    CPPUNIT_ASSERT(grid2->getCurrentGraphUnits() == 1);
    CPPUNIT_ASSERT(grid2->getCurrentGridSize() == 1);
    CPPUNIT_ASSERT(grid2->getFlags() == 0);
    CPPUNIT_ASSERT(grid2->getGraphScale() == 1.0);
    CPPUNIT_ASSERT(grid2->getGraphUnitConvert() == 1.0);
    CPPUNIT_ASSERT(grid2->getGraphUnits() == wxT("Feet"));
    CPPUNIT_ASSERT(grid2->getPosition() == 0);
    CPPUNIT_ASSERT(grid2->getPrimaryStyle() == GridObjectModel::gpsDefault);
    CPPUNIT_ASSERT(grid2->getSecondaryStyle() == GridObjectModel::gpsDefault);
    CPPUNIT_ASSERT(grid2->getType() == GridObjectModel::gtSquare);
}


void GridObjectModelTest::checkCopyAndCompare(void)
{
	grid2->copy(grid);
	CPPUNIT_ASSERT(grid2->compare(grid) == true);
    grid2->setSecondaryStyle(GridObjectModel::gpsBold);
    CPPUNIT_ASSERT(grid2->compare(grid) == false);
    grid2->setSecondaryStyle(grid->getSecondaryStyle());
    CPPUNIT_ASSERT(grid2->compare(grid) == true);
    grid2->setGraphUnits(wxT("Different Name"));
    CPPUNIT_ASSERT(grid2->compare(grid) == false);
    grid2->setGraphUnits(grid->getGraphUnits());    
    CPPUNIT_ASSERT(grid2->compare(grid) == true);    
}


void GridObjectModelTest::checkIsValid(void)
{
	CPPUNIT_ASSERT(grid->isValid() == true);
}
