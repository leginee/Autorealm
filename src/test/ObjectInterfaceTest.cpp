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

#include "ObjectInterfaceTest.h"


void ObjectInterfaceTest::setUp(void)
{
    con1 = new ObjectInterface;
    con2 = new ObjectInterface;
    con1->setParent(con2);
    con3 = new ObjectInterface;
    con2->setParent(con3);
}


void ObjectInterfaceTest::tearDown(void)
{
    // be careful the destructor deletes the children, too.
    delete con3;
}


void ObjectInterfaceTest::checkChildren(void)
{
    CPPUNIT_ASSERT(con1->countChildren() == 0);
    CPPUNIT_ASSERT(con2->countChildren() == 1);
    CPPUNIT_ASSERT(con2->getChild(0) == con1);
    CPPUNIT_ASSERT_THROW(con2->getChild(1), ARInvalidChildException);
    CPPUNIT_ASSERT_THROW(con2->getChild(2), ARInvalidChildException);
    
    ObjectInterface* child = new ObjectInterface;
    CPPUNIT_ASSERT(child->getParent() == NULL);
    child->setParent(con2);
    CPPUNIT_ASSERT(con2->countChildren() == 2);
    CPPUNIT_ASSERT(con2->getChild(0) == con1);
    CPPUNIT_ASSERT(con2->getChild(1) == child);
    CPPUNIT_ASSERT_THROW(con2->getChild(2), ARInvalidChildException);

    CPPUNIT_ASSERT(con1->getParent() == con2);
    CPPUNIT_ASSERT(child->getParent() == con2);

	child->setParent(con2);
    CPPUNIT_ASSERT(child->getParent() == con2);
    CPPUNIT_ASSERT(con2->getChild(1) == child);
    CPPUNIT_ASSERT_THROW(con2->getChild(2), ARInvalidChildException);

	child->setParent(0);	// remove child from parent con2
    CPPUNIT_ASSERT(con2->countChildren() == 1);
    CPPUNIT_ASSERT(child->getParent() == NULL);
	child->setParent(0);	// remove child from parent con2
    CPPUNIT_ASSERT(child->getParent() == NULL);
    
    // check private remove() method
    ObjectInterface top(0);
    child->setParent(&top);
    ObjectInterface* child2 = new ObjectInterface(&top);
    ObjectInterface* child3 = new ObjectInterface(&top);
    ObjectInterface* child4 = new ObjectInterface(&top);
    CPPUNIT_ASSERT(top.countChildren() == 4);
    
    child4->setParent(0);
    CPPUNIT_ASSERT(top.countChildren() == 3);
    CPPUNIT_ASSERT(child4->getParent() == 0);
	delete child4;

    child->setParent(0);
    CPPUNIT_ASSERT(top.countChildren() == 2);
    CPPUNIT_ASSERT(child->getParent() == 0);
    delete child;
    
    delete child2;
    CPPUNIT_ASSERT(top.countChildren() == 1);
    CPPUNIT_ASSERT(top.getChild(0) == child3);
}


void ObjectInterfaceTest::checkConstructor(void)
{
    // test the constructor ObjectInterface()
    CPPUNIT_ASSERT(con1->getParent() == con2);
    CPPUNIT_ASSERT(con1->countChildren() == 0);
    CPPUNIT_ASSERT(con1->m_extraData.size() == 0);

    CPPUNIT_ASSERT(con2->getParent() == con3);
    CPPUNIT_ASSERT(con2->countChildren() == 1);
    CPPUNIT_ASSERT(con2->m_extraData.size() == 0);

    CPPUNIT_ASSERT(con3->getParent() == NULL);
    CPPUNIT_ASSERT(con3->countChildren() == 1);
    CPPUNIT_ASSERT(con3->m_extraData.size() == 0);
    
    // parent constructor
    ObjectInterface* child = new ObjectInterface(con3);
	CPPUNIT_ASSERT(con3->getParent() == NULL);
    CPPUNIT_ASSERT(con3->countChildren() == 2);
	CPPUNIT_ASSERT(child->getParent() == con3);
	
	// check assignment operator
	ObjectInterface assign1(0);
	child->setParent(&assign1);
	CPPUNIT_ASSERT(assign1.getParent() == NULL);
    CPPUNIT_ASSERT(assign1.countChildren() == 1);
	CPPUNIT_ASSERT(child->getParent() == &assign1);
	ObjectInterface assign2 = assign1;
	CPPUNIT_ASSERT(assign2.getParent() == NULL);
    CPPUNIT_ASSERT(assign2.countChildren() == 1);
}


void ObjectInterfaceTest::checkCopyCompare(void)
{
    ObjectInterface copyOI;
    copyOI.copy(con3);
    
    CPPUNIT_ASSERT(con3->compare(&copyOI) == true);    
    CPPUNIT_ASSERT(con3->compare(NULL) == false);    
}


void ObjectInterfaceTest::checkParent(void)
{	
    ObjectInterface* child1 = new ObjectInterface;
    CPPUNIT_ASSERT(child1->getParent() == NULL);
	CPPUNIT_ASSERT(con3->getParent() == NULL);
    CPPUNIT_ASSERT(con3->countChildren() == 1);

    child1->setParent(con3);
    CPPUNIT_ASSERT(child1->getParent() == con3);
	CPPUNIT_ASSERT(con3->getParent() == NULL);
    CPPUNIT_ASSERT(con3->countChildren() == 2);
    
    child1->setParent(con3);
    CPPUNIT_ASSERT(child1->getParent() == con3);
	CPPUNIT_ASSERT(con3->getParent() == NULL);
    CPPUNIT_ASSERT(con3->countChildren() == 2);

	CPPUNIT_ASSERT(con1->getParent() == con2);
    CPPUNIT_ASSERT(con1->countChildren() == 0);
    child1->setParent(con1);
    CPPUNIT_ASSERT(child1->getParent() == con1);
	CPPUNIT_ASSERT(con1->getParent() == con2);
    CPPUNIT_ASSERT(con1->countChildren() == 1);
	CPPUNIT_ASSERT(con3->getParent() == NULL);
    CPPUNIT_ASSERT(con3->countChildren() == 1);

    child1->setParent(0);
    CPPUNIT_ASSERT(child1->getParent() == 0);
	CPPUNIT_ASSERT(con1->getParent() == con2);
    CPPUNIT_ASSERT(con1->countChildren() == 0);
	
	delete child1;
}


void ObjectInterfaceTest::checkClone(void)
{
	ObjectInterface* cloneObject1 = con1->clone();
	CPPUNIT_ASSERT(cloneObject1->countChildren() == 0);
	CPPUNIT_ASSERT(cloneObject1->getParent() == 0);
    CPPUNIT_ASSERT(cloneObject1->compare(con1) == true);    

	ObjectInterface* cloneObject2 = con2->clone();
	CPPUNIT_ASSERT(cloneObject2->countChildren() == 1);
	CPPUNIT_ASSERT(cloneObject2->getParent() == 0);
    CPPUNIT_ASSERT(cloneObject2->compare(con2) == true);
    CPPUNIT_ASSERT(cloneObject2->getChild(0)->countChildren() == 0);

	ObjectInterface* cloneObject3 = con3->clone();
	CPPUNIT_ASSERT(cloneObject3->countChildren() == 1);
	CPPUNIT_ASSERT(cloneObject3->getParent() == 0);
    CPPUNIT_ASSERT(cloneObject3->compare(con3) == true);    
    CPPUNIT_ASSERT(cloneObject3->getChild(0)->countChildren() == 1);

	delete cloneObject1;	
	delete cloneObject2;
	delete cloneObject3;
}
