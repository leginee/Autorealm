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

#include <iostream>
#include "test/runner.h"

#include <wx/filefn.h>
#include <wx/colour.h>
#include <wx/wfstream.h>
#include "FileManagerFactory.h"
#include "ObjectWriter.h"
#include "ObjectBuilder.h"
#include "ARDocument.h"
#include "ViewPointModel.h"
#include "GridObjectModel.h"
#include "GroupModel.h"
#include "CurveModel.h"
#include "LineModel.h"
#include "PolyCurveModel.h"
#include "PolyLineModel.h"


/** 
 * This class acts as a testing harness for the ARDocument class.
 */
class ObjectWriterTest : public CppUnit::TestFixture
{
	private:
		FileManagerFactory fm;
		ARDocument* doc, *doc3;
		wxColor gc;
		wxColor bg;

	public:
		/** 
		 * @brief Required by the TestFixture class, this method simply
		 * creates the objects necessary to complete all tests.
		 */
		void setUp()
        {
			gc.Set(0x63, 0x63, 0xff);
			bg.Set(0xff, 0xff, 0xff);

			doc = new ARDocument;
			doc->setVersion(6);
			doc->setGridColor(wxColor(0x63, 0x63, 0xff));
			doc->setBgColor(wxColor(0xff, 0xff, 0xff));
			doc->setComments(wxT("This is a sample comment.\x0D\x0A""This is yet another sample comment.\x0D\x0A""The quick brown fox jumped over the lazy dog.\x0D\x0A"));
			doc->addOverlayName(wxT("Geographic"));
			
			OverlayVector over;
			for (int i = 0; i < 10; i++)
            {
			    over.at(i) = true;
			}

			ViewPointModel *vp = new ViewPointModel();
			vp->setName(wxT(""));
			vp->setWidth(1280);
			vp->setHeight(800);
			vp->setArea(arRealRect(0.0000, -115.5000, 1289.0000, 806.0000));
			vp->setActiveOverlays(over);
			vp->setVisibleOverlays(over);
            vp->setParent(doc);

			GridObjectModel* grid = new GridObjectModel();
			grid->setGraphScale(1.0000);
			grid->setGraphUnitConvert(0.0415);
			grid->setGraphUnits(wxT("Miles"));
			grid->setCurrentGraphUnits(12);
			grid->setCurrentGridSize(24.1100);
			grid->setType(GridObjectModel::gtSquare);
			grid->setBoldUnits(0);
			grid->setFlags(0);
			grid->setPosition(0);
			grid->setPrimaryStyle(GridObjectModel::gpsDefault);
			grid->setSecondaryStyle(GridObjectModel::gpsDefault);
			grid->setParent(vp);

			PushpinCollection pins = doc->getPushpins();
			pins.m_waypointsVisible = true;
			pins.m_showNumber = true;
			pins.m_showNote = true;
			doc->setPushpins(pins);

			VPoints points;
			points.push_back(arRealPoint(10.0, 11.0));
			points.push_back(arRealPoint(12.0, 13.0));
			GroupModel* grp = new GroupModel;
			grp->setColor(wxColor(0x63, 0x63, 0xff));
			grp->setOverlay(1, true);
			grp->setPoints(points);
			grp->setSelected(true);
            grp->setParent(doc);
            
            // add CurveModel as a child
            StyleAttrib style = { 1 };
            // @todo change style if the StyleAtrrib class is implemented
            CurveModel* curve = new CurveModel(arRealPoint(1.0, 2.0), arRealPoint(-3.45, -4.6),
                arRealPoint(13.78, -34.2), arRealPoint(23.87, 2.6), 6, 7, style, false);
            curve->setThickness(8);
            curve->setSthickness(-5321);
            curve->setColor(wxColor(0x23, 0x34, 0xF4));
            curve->setOverlay(2, true);
            curve->setSelected(false);
            curve->setParent(grp);

            // add LineModel as a child
            LineModel* line = new LineModel(-1.1, -2.2, 3.3, 4.4, -6, -7, style, true);
            line->setThickness(-8);
            line->setSthickness(5321);
            line->setColor(wxColor(0xF4, 0x34, 0x23));
            line->setOverlay(3, true);
            line->setSelected(true);
            line->setParent(grp);
            
            // add PolyCurveModel as a child
            PolyCurveModel* pcurve = new PolyCurveModel(0, 65234, style, wxColor(0x00, 0x00, 0x00), false);
            pcurve->setThickness(-1);
            pcurve->setSthickness(-1);
            pcurve->setColor(wxColor(0xFF, 0xFF, 0xFF));
            pcurve->setOverlay(0, true);
            pcurve->setSelected(false);
            pcurve->addPoint(arRealPoint(0,0), false);
            pcurve->addPoint(arRealPoint(1.1,1.1), false);
            pcurve->addPoint(arRealPoint(-1.1,-1.1), true);
            pcurve->setParent(grp);

            // add PolyLineModel as a child
            PolyLineModel* pline = new PolyLineModel(-6543212, -652340, style, wxColor(0x10, 0x10, 0x01), false);
            pline->setThickness(13);
            pline->setSthickness(-13);
            pline->setColor(wxColor(0x0F, 0xF0, 0x0F));
            pline->setOverlay(5, true);
            pline->setSelected(true);
            pline->addPoint(arRealPoint(0,0), false);
            pline->addPoint(arRealPoint(1.1,1.1), false);
            pline->addPoint(arRealPoint(0.5,-0.3), false);
            pline->addPoint(arRealPoint(2.1,-3.1), false);
            pline->addPoint(arRealPoint(120,-10.9), false);
            pline->addPoint(arRealPoint(3.4,0), false);            
            pline->addPoint(arRealPoint(-1.1,-1.1), true);
            pline->setParent(grp);


			doc3 = new ARDocument;
		}

		/** 
		 * @brief Required by the TestFixture class, this method simply
		 * cleans up after each test.
		 */
		void tearDown()
        {
			delete doc;
			delete doc3;
		}

		/**
		 * @brief Test file save routines
		 * 
		 * Simply put, save the test document, load it, and compare it. If
		 * it checks out, delete the saved file
		 */
		void testSave()
        {
			bool result;
			wxString outfile(wxT("outfiletest.AuRX"));
			ObjectBuilder in(doc);
			ObjectWriter out(doc);
			FileManager* xmlout = fm.getFileManager(outfile, in, out, false);
			wxFileOutputStream fos(outfile);
			xmlout->save(fos);
			fos.Close();
			ObjectBuilder validin(doc3);
			FileManager* xmlin = fm.getFileManager(outfile, validin, out);
			xmlin->load();
			result = doc->compare(doc3);
			CPPUNIT_ASSERT(result == true);
			if (result)
            {
				wxRemoveFile(outfile);
			}
		}

		/**
		 * For setting up the test suite for ObjectWriterTest
		 */
		CPPUNIT_TEST_SUITE(ObjectWriterTest);
		/**
		 * For setting up the test suite for ObjectWriterTest
		 */
		CPPUNIT_TEST(testSave);
		/**
		 * For setting up the test suite for ObjectWriterTest
		 */
		CPPUNIT_TEST_SUITE_END();
};

RUNNERADD(ObjectWriterTest);
