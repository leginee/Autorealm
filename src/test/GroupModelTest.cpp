/*
 * Rewrite of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
 * Used in rpgs and hobbyist GIS applications for mapmaking
 * Copyright (C) 2004 Michael J. Pedersen <m.pedersen@icelus.org>,
 *                    Michael D. Condon <mcondon@austin.rr.com>
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

#include "GroupModelTest.h"


void GroupModelTest::setUp(void)
{
	grpa = new GroupModel;
	grpb = new GroupModel;
	vp1 = new ViewPointModel;
}


void GroupModelTest::tearDown(void)
{
	delete vp1;
	delete grpb;
	delete grpa;
}


void GroupModelTest::testBasics(void)
{
	CPPUNIT_ASSERT(grpa->compare(grpb) == true);

	GroupModel* c1 = new GroupModel;
	GroupModel* c2 = new GroupModel;
	c1->setParent(grpa);
	CPPUNIT_ASSERT(grpa->countChildren() == 1);

	CPPUNIT_ASSERT(grpa->compare(grpb) == true);
	c2->setParent(grpb);
	CPPUNIT_ASSERT(grpa->compare(grpb) == true);

	grpa->setColor(wxColor(0x88, 0x88, 0x88));
	CPPUNIT_ASSERT(grpa->compare(grpb) == false);
	grpb->copy(grpa);
	CPPUNIT_ASSERT(grpa->compare(grpb) == true);

	CPPUNIT_ASSERT(grpa->compare(vp1)  == false);
}
