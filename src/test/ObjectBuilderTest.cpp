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

#include <wx/wx.h>
#include "ObjectBuilder.h"
#include "ARDocument.h"
#include "ViewPointModel.h"
#include "GridObjectModel.h"
#include "ARExcept.h"
#include "Tracer.h"
#include "GroupModel.h"
#include "CurveModel.h"
#include "LineModel.h"
#include "PolyCurveModel.h"
#include "PolyLineModel.h"


TRACEFLAG(wxT("ObjectBuilderTest"));

/** 
 * @brief Used to test the ObjectBuilder.
 */
class ObjectBuilderTest : public CppUnit::TestFixture {
	private:
		ARDocument* doc;
		ObjectBuilder* obj;
		ObjectAttributes attrib;

	public:
		/** 
		 * @brief Required by TestFixture, does nothing yet. Will do
		 * something when the test cases begin being written
		 */
		void setUp() {
			doc = new ARDocument;
			obj = new ObjectBuilder(doc);
			attrib.clear();
		}

		/** 
		 * @brief Required by TestFixture, does nothing yet. Will do
		 * something when the test cases begin being written
		 */
		void tearDown() {
			delete doc;
			delete obj;
		}

		/** 
		 * @brief Test creation of the globals of an ARDocument using
		 * ObjectBuilder, and compare with code which works directly with
		 * the ARDocument
		 */
		void testGlobals() {
			TRACER(wxT("ObjectBuilderTest::testGlobals"));
			
			obj->startNewObject(wxT("DOCUMENT"), attrib);
			obj->startNewObject(wxT("MAP"), attrib);
			obj->startNewObject(wxT("GLOBALS"), attrib);
			obj->startNewObject(wxT("VERSION"), attrib);
			obj->appendData(wxT("6"));
			obj->endObject(); //VERSION
			CPPUNIT_ASSERT(doc->getVersion() == 6);

			obj->startNewObject(wxT("CURRENT_GRID_COLOR"), attrib);
			obj->appendData(wxT("6513663"));
			obj->endObject(); //CURRENT_GRID_COLOR
			CPPUNIT_ASSERT(doc->getGridColor() == wxColor(0x63, 0x63, 0xff));

			obj->startNewObject(wxT("BACKGROUND_COLOR"), attrib);
			obj->appendData(wxT("16777215"));
			obj->endObject(); //BACKGROUND_COLOR
			CPPUNIT_ASSERT(doc->getBgColor() == wxColor(0xff, 0xff, 0xff));

			obj->endObject(); //GLOBALS

			obj->startNewObject(wxT("COMMENTSET"), attrib);
			obj->startNewObject(wxT("COMMENTS"), attrib);
			obj->appendData(wxT("VGhpcyBpcyBhIHNhbXBsZSBjb21tZW50Lg0KVGhpcyBpcyB5ZXQgYW5vdGhlciBzYW1wbGUgY29t\x0D\x0A""bWVudC4NClRoZSBxdWljayBicm93biBmb3gganVtcGVkIG92ZXIgdGhlIGxhenkgZG9nLg0K"));
			obj->endObject(); //COMMENTS
			obj->endObject(); //COMMENTSET
			wxString comments(wxT("This is a sample comment.\x0D\x0A""This is yet another sample comment.\x0D\x0A""The quick brown fox jumped over the lazy dog.\x0D\x0A"));
			CPPUNIT_ASSERT(doc->getComments() == comments);

			obj->startNewObject(wxT("OVERLAYS"), attrib);
			obj->startNewObject(wxT("COUNT"), attrib);
			obj->appendData(wxT("1"));
			obj->endObject(); //COUNT
			obj->startNewObject(wxT("OVERLAY_0"), attrib);
			obj->startNewObject(wxT("NAME"), attrib);
			obj->appendData(wxT("R2VvZ3JhcGhpYw=="));
			obj->endObject(); //NAME
			obj->endObject(); //OVERLAY_0
			obj->endObject(); //OVERLAYS
			CPPUNIT_ASSERT(doc->getOverlayName(0) == wxT("Geographic"));

			obj->startNewObject(wxT("LANDSCAPESET"), attrib);
			obj->startNewObject(wxT("LANDSCAPE"), attrib);
			obj->appendData(wxT("0"));
			obj->endObject(); //LANDSCAPE
			obj->endObject(); //LANDSCAPESET
			CPPUNIT_ASSERT(doc->getLandscape() == false);

			obj->startNewObject(wxT("GRID"), attrib);
			obj->startNewObject(wxT("SNAPTOGRID"), attrib);
			obj->appendData(wxT("0"));
			obj->endObject(); //SNAPTOGRID
			CPPUNIT_ASSERT(doc->getSnapToGrid() == false);

			obj->startNewObject(wxT("SNAPTOPOINT"), attrib);
			obj->appendData(wxT("0"));
			obj->endObject(); //SNAPTOPOINT
			CPPUNIT_ASSERT(doc->getSnapToPoint() == false);

			obj->startNewObject(wxT("SNAPALONG"), attrib);
			obj->appendData(wxT("0"));
			obj->endObject(); //SNAPALONG
			CPPUNIT_ASSERT(doc->getSnapAlong() == false);

			obj->startNewObject(wxT("ROTATESNAP"), attrib);
			obj->appendData(wxT("0"));
			obj->endObject(); //ROTATESNAP
			CPPUNIT_ASSERT(doc->getRotateSnap() == false);

			obj->startNewObject(wxT("DISPLAYGRID"), attrib);
			obj->appendData(wxT("0"));
			obj->endObject(); //DISPLAYGRID
			CPPUNIT_ASSERT(doc->getDisplayGrid() == false);

			obj->startNewObject(wxT("DESIGNGRIDUNITS"), attrib);
			obj->appendData(wxT("16"));
			obj->endObject(); //DESIGNGRIDUNITS
			CPPUNIT_ASSERT(doc->getDesignGridUnits() == 16);

			obj->endObject(); //GRID

			obj->startNewObject(wxT("VIEWPOINTS"), attrib);
			obj->startNewObject(wxT("COUNT"), attrib);
			obj->appendData(wxT("1"));
			obj->endObject(); //COUNT

			obj->startNewObject(wxT("ID"), attrib);
			obj->appendData(wxT("0"));
			obj->endObject(); // ID

			obj->startNewObject(wxT("VIEWPOINT"), attrib);
			obj->startNewObject(wxT("NAME"), attrib);
			obj->endObject(); //NAME
			obj->startNewObject(wxT("CLIENTWIDTH"), attrib);
			obj->appendData(wxT("1280"));
			obj->endObject(); // CLIENTWIDTH
			obj->startNewObject(wxT("CLIENTHEIGHT"), attrib);
			obj->appendData(wxT("800"));
			obj->endObject(); // CLIENTHEIGHT

			obj->startNewObject(wxT("AREA"), attrib);
			obj->appendData(wxT("0.0000,-115.5000,1288.0000,689.5000"));
			obj->endObject(); // AREA

			obj->startNewObject(wxT("VISIBLE_OVERLAYS"), attrib);
			obj->appendData(wxT("0,1,2,3,4,5,6,7,8,9"));
			obj->endObject(); // VISIBLE_OVERLAYS
			obj->startNewObject(wxT("ACTIVE_OVERLAYS"), attrib);
			obj->appendData(wxT("0"));
			obj->endObject(); // ACTIVE_OVERLAYS

			obj->startNewObject(wxT("GRIDOBJECT"), attrib);
			obj->startNewObject(wxT("GRAPH_SCALE"), attrib);
			obj->appendData(wxT("1.0000"));
			obj->endObject(); // GRAPH_SCALE
			obj->startNewObject(wxT("GRAPH_UNIT_CONVERT"), attrib);
			obj->appendData(wxT("0.0415"));
			obj->endObject(); // GRAPH_UNIT_CONVERT
			obj->startNewObject(wxT("GRAPH_UNITS"), attrib);
			obj->appendData(wxT("Miles"));
			obj->endObject(); // GRAPH_UNITS
			obj->startNewObject(wxT("CURRENT_GRAPH_UNITS"), attrib);
			obj->appendData(wxT("12"));
			obj->endObject(); // CURRENT_GRAPH_UNITS
			obj->startNewObject(wxT("CURRENT_SIZE"), attrib);
			obj->appendData(wxT("24.1100"));
			obj->endObject(); // CURRENT_SIZE
			obj->startNewObject(wxT("TYPE"), attrib);
			obj->appendData(wxT("SQUARE"));
			obj->endObject(); // TYPE
			obj->startNewObject(wxT("BOLD_UNITS"), attrib);
			obj->appendData(wxT("0"));
			obj->endObject(); // BOLD_UNITS
			obj->startNewObject(wxT("FLAGS"), attrib);
			obj->appendData(wxT("0"));
			obj->endObject(); // FLAGS
			obj->startNewObject(wxT("POSITION"), attrib);
			obj->appendData(wxT("0"));
			obj->endObject(); // POSITION
			obj->startNewObject(wxT("PRIMARY_STYLE"), attrib);
			obj->appendData(wxT("DEFAULT"));
			obj->endObject(); // PRIMARY_STYLE
			obj->startNewObject(wxT("SECONDARY_STYLE"), attrib);
			obj->appendData(wxT("DEFAULT"));
			obj->endObject(); // SECONDARY_STYLE
			obj->endObject(); // GRIDOBJECT

			obj->endObject(); // VIEWPOINT
					   
			obj->endObject(); // VIEWPOINTS

			obj->startNewObject(wxT("PUSHPIN_HISTORY"), attrib);
			obj->startNewObject(wxT("WAYPOINTS_VISIBLE"), attrib);
			obj->appendData(wxT("1"));
			obj->endObject(); // WAYPOINTS_VISIBLE
			obj->startNewObject(wxT("SHOW_NUMBER"), attrib);
			obj->appendData(wxT("1"));
			obj->endObject(); // SHOW_NUMBER
			obj->startNewObject(wxT("SHOW_NOTE"), attrib);
			obj->appendData(wxT("1"));
			obj->endObject(); // SHOW_NOTE

			obj->startNewObject(wxT("PIN_HISTORY_0"), attrib);
			obj->startNewObject(wxT("NAME"), attrib);
			obj->appendData(wxT("cG9pbnQgbmFtZQo=")); // "point name" in base64
			obj->endObject(); // NAME

			obj->startNewObject(wxT("HIST_1"), attrib);
			obj->startNewObject(wxT("POINT"), attrib);
			obj->appendData(wxT("10.0,15.0"));
			obj->endObject(); // POINT
			obj->startNewObject(wxT("NOTE"), attrib);
			obj->appendData(wxT("aGlzdG9yaWNhbCBub3RlIDEK")); // "historical note 1" in base64
			obj->endObject(); // NOTE
			obj->endObject(); // HIST_1
			obj->endObject(); // PIN_HISTORY_0
			obj->endObject(); // PUSHPIN_HISTORY

			obj->startNewObject(wxT("PUSHPINS"), attrib);
			obj->startNewObject(wxT("PIN_0"), attrib);
			obj->startNewObject(wxT("CHECKED"), attrib);
			obj->appendData(wxT("1"));
			obj->endObject(); // CHECKED
			obj->startNewObject(wxT("PLACED"), attrib);
			obj->appendData(wxT("1"));
			obj->endObject(); // PLACED
			obj->startNewObject(wxT("POINT"), attrib);
			obj->appendData(wxT("100.0,150.0"));
			obj->endObject(); // POINT
			obj->endObject(); // PIN_0
			obj->endObject(); // PUSHPINS
			
			obj->startNewObject(wxT("MAP_CONTENTS"), attrib);
			obj->startNewObject(wxT("DRAWCHAIN"), attrib); // main document

			obj->startNewObject(wxT("DRAWCHAIN"), attrib); // first group
			obj->startNewObject(wxT("COLOR"), attrib);
			obj->appendData(wxT("6513663"));
			obj->endObject(); // COLOR
			obj->startNewObject(wxT("OVERLAY_ID"), attrib);
			obj->appendData(wxT("1"));
			obj->endObject(); // OVERLAY_ID
			obj->startNewObject(wxT("EXTENT"), attrib);
			obj->appendData(wxT("10.0, 11.0, 12.0, 13.0"));
			obj->endObject(); // EXTENT
			obj->startNewObject(wxT("SELECTED"), attrib);
			obj->appendData(wxT("1"));
			obj->endObject(); // SELECTED

            // Curve Model Test
            obj->startNewObject(wxT("CURVE"), attrib);
            obj->startNewObject(wxT("COLOR"), attrib);
            obj->appendData(wxT("6513662"));
            obj->endObject(); // COLOR
            obj->startNewObject(wxT("OVERLAY_ID"), attrib);
            obj->appendData(wxT("2"));
            obj->endObject(); // OVERLAY_ID
            obj->startNewObject(wxT("EXTENT"), attrib);
            obj->appendData(wxT("0.0, 0.7, 13.2, 10.8"));
            obj->endObject(); // EXTENT
            obj->startNewObject(wxT("SELECTED"), attrib);
            obj->appendData(wxT("0"));
            obj->endObject(); // SELECTED
            obj->startNewObject(wxT("P1"), attrib);
            obj->appendData(wxT("1.0, 1.5"));
            obj->endObject(); // P1
            obj->startNewObject(wxT("P2"), attrib);
            obj->appendData(wxT("0.0, 11.5"));
            obj->endObject(); // P2
            obj->startNewObject(wxT("P3"), attrib);
            obj->appendData(wxT("1.1, 2.5"));
            obj->endObject(); // P3
            obj->startNewObject(wxT("P4"), attrib);
            obj->appendData(wxT("13.2, 0.7"));
            obj->endObject(); // P4
            obj->startNewObject(wxT("STYLE"), attrib);
            obj->appendData(wxT("1"));
            obj->endObject(); // STYLE
            obj->startNewObject(wxT("THICKNESS"), attrib);
            obj->appendData(wxT("5"));
            obj->endObject(); // THICKNESS
            obj->startNewObject(wxT("FRACTAL"), attrib);
            obj->appendData(wxT("1"));
            obj->endObject(); // FRACTAL
            obj->startNewObject(wxT("STHICKNESS"), attrib);
            obj->appendData(wxT("37"));
            obj->endObject(); // STHICKNESS
            obj->startNewObject(wxT("SEED"), attrib);
            obj->appendData(wxT("38123"));
            obj->endObject(); // SEED
            obj->startNewObject(wxT("ROUGHNESS"), attrib);
            obj->appendData(wxT("2078"));
            obj->endObject(); // ROUGHNESS            
            obj->endObject(); // CURVE

            // Line Model Test
            obj->startNewObject(wxT("LINE"), attrib);
            obj->startNewObject(wxT("COLOR"), attrib);
            obj->appendData(wxT("6513661"));
            obj->endObject(); // COLOR
            obj->startNewObject(wxT("OVERLAY_ID"), attrib);
            obj->appendData(wxT("3"));
            obj->endObject(); // OVERLAY_ID
            obj->startNewObject(wxT("EXTENT"), attrib);
            obj->appendData(wxT("-3.3, -4.4, 4.4, 6.6"));
            obj->endObject(); // EXTENT
            obj->startNewObject(wxT("SELECTED"), attrib);
            obj->appendData(wxT("1"));
            obj->endObject(); // SELECTED
            obj->startNewObject(wxT("X1"), attrib);
            obj->appendData(wxT("1.1"));
            obj->endObject(); // X1
            obj->startNewObject(wxT("Y1"), attrib);
            obj->appendData(wxT("2.2"));
            obj->endObject(); // Y1
            obj->startNewObject(wxT("X2"), attrib);
            obj->appendData(wxT("-3.3"));
            obj->endObject(); // X2
            obj->startNewObject(wxT("Y2"), attrib);
            obj->appendData(wxT("-4.4"));
            obj->endObject(); // Y2
            obj->startNewObject(wxT("STYLE"), attrib);
            obj->appendData(wxT("1"));
            obj->endObject(); // STYLE
            obj->startNewObject(wxT("THICKNESS"), attrib);
            obj->appendData(wxT("-5"));
            obj->endObject(); // THICKNESS
            obj->startNewObject(wxT("FRACTAL"), attrib);
            obj->appendData(wxT("0"));
            obj->endObject(); // FRACTAL
            obj->startNewObject(wxT("STHICKNESS"), attrib);
            obj->appendData(wxT("-37"));
            obj->endObject(); // STHICKNESS
            obj->startNewObject(wxT("SEED"), attrib);
            obj->appendData(wxT("-38123"));
            obj->endObject(); // SEED
            obj->startNewObject(wxT("ROUGHNESS"), attrib);
            obj->appendData(wxT("-2078"));
            obj->endObject(); // ROUGHNESS            
            obj->endObject(); // CURVE

            // PolyCurveModel Test
            obj->startNewObject(wxT("POLYCURVE"), attrib);
            obj->startNewObject(wxT("COLOR"), attrib);
            obj->appendData(wxT("65280"));
            obj->endObject(); // COLOR
            obj->startNewObject(wxT("OVERLAY_ID"), attrib);
            obj->appendData(wxT("4"));
            obj->endObject(); // OVERLAY_ID
            obj->startNewObject(wxT("EXTENT"), attrib);
            obj->appendData(wxT("1.1, -5.1, 4.0, 4.0"));
            obj->endObject(); // EXTENT
            obj->startNewObject(wxT("SELECTED"), attrib);
            obj->appendData(wxT("0"));
            obj->endObject(); // SELECTED
            obj->startNewObject(wxT("FILLCOLOR"), attrib);
            obj->appendData(wxT("1122884"));
            obj->endObject(); // FILLCOLOR
            obj->startNewObject(wxT("COUNT"), attrib);
            obj->appendData(wxT("5"));
            obj->endObject(); // COUNT
            obj->startNewObject(wxT("POINTS"), attrib);
            obj->appendData(wxT("1.1,-1.1:2.1,-2.1:3.1,-3.1:4.1,-4.1:5.1,-5.1"));
            obj->endObject(); // POINTS
            obj->startNewObject(wxT("STYLE"), attrib);
            obj->appendData(wxT("1"));
            obj->endObject(); // STYLE
            obj->startNewObject(wxT("THICKNESS"), attrib);
            obj->appendData(wxT("-1"));
            obj->endObject(); // THICKNESS
            obj->startNewObject(wxT("FRACTAL"), attrib);
            obj->appendData(wxT("1"));
            obj->endObject(); // FRACTAL
            obj->startNewObject(wxT("STHICKNESS"), attrib);
            obj->appendData(wxT("1"));
            obj->endObject(); // STHICKNESS
            obj->startNewObject(wxT("SEED"), attrib);
            obj->appendData(wxT("-12"));
            obj->endObject(); // SEED
            obj->startNewObject(wxT("ROUGHNESS"), attrib);
            obj->appendData(wxT("0"));
            obj->endObject(); // ROUGHNESS            
            obj->endObject(); // POLYCURVE

            // PolyLineModel Test
            obj->startNewObject(wxT("POLYLINE"), attrib);
            obj->startNewObject(wxT("COLOR"), attrib);
            obj->appendData(wxT("8961050"));
            obj->endObject(); // COLOR
            obj->startNewObject(wxT("OVERLAY_ID"), attrib);
            obj->appendData(wxT("0"));
            obj->endObject(); // OVERLAY_ID
            obj->startNewObject(wxT("EXTENT"), attrib);
            obj->appendData(wxT("10.1, -50.1, 40.0, 40.0"));
            obj->endObject(); // EXTENT
            obj->startNewObject(wxT("SELECTED"), attrib);
            obj->appendData(wxT("1"));
            obj->endObject(); // SELECTED
            obj->startNewObject(wxT("FILLCOLOR"), attrib);
            obj->appendData(wxT("15728655"));
            obj->endObject(); // FILLCOLOR
            obj->startNewObject(wxT("COUNT"), attrib);
            obj->appendData(wxT("5"));
            obj->endObject(); // COUNT
            obj->startNewObject(wxT("POINTS"), attrib);
            obj->appendData(wxT("10.1,-10.1:20.1,-20.1:30.1,-30.1:40.1,-40.1:50.1,-50.1"));
            obj->endObject(); // POINTS
            obj->startNewObject(wxT("STYLE"), attrib);
            obj->appendData(wxT("1"));
            obj->endObject(); // STYLE
            obj->startNewObject(wxT("THICKNESS"), attrib);
            obj->appendData(wxT("1290"));
            obj->endObject(); // THICKNESS
            obj->startNewObject(wxT("FRACTAL"), attrib);
            obj->appendData(wxT("0"));
            obj->endObject(); // FRACTAL
            obj->startNewObject(wxT("STHICKNESS"), attrib);
            obj->appendData(wxT("5912"));
            obj->endObject(); // STHICKNESS
            obj->startNewObject(wxT("SEED"), attrib);
            obj->appendData(wxT("23"));
            obj->endObject(); // SEED
            obj->startNewObject(wxT("ROUGHNESS"), attrib);
            obj->appendData(wxT("-7"));
            obj->endObject(); // ROUGHNESS            
            obj->endObject(); // POLYLINE
            
            
            obj->endObject(); // DRAWCHAIN - first group
            
			obj->endObject(); // DRAWCHAIN - main document            
			obj->endObject(); // MAP_CONTENTS
			obj->endObject(); //MAP
			obj->endObject(); //DOCUMENT

			ARDocument* doc2 = new ARDocument;
			doc2->setVersion(6);
			doc2->setGridColor(wxColor(0x63, 0x63, 0xff));
			doc2->setBgColor(wxColor(0xff, 0xff, 0xff));
			doc2->setComments(comments);
			doc2->addOverlayName(wxT("Geographic"));

			PushpinHistory hst;
			hst.m_point = arRealPoint(10.0, 15.0);
			hst.m_note = wxT("historical note 1");

			Pushpin pin;
			pin.m_checked = true;
			pin.m_placed = true;
			pin.m_point = arRealPoint(100.0, 150.0);
			pin.m_name = wxT("point name");
			pin.addHist(hst);

			PushpinCollection pins;
			pins.m_waypointsVisible = true;
			pins.m_showNote = true;
			pins.m_showNumber = true;
			pins.m_pins.at(0) = pin;
			
			doc2->setPushpins(pins);
			
			OverlayVector over;
			for (int i=0; i<10; i++) {
			    over.at(i) = true;
			}
			OverlayVector aover;
			aover.at(0)=true;

			ViewPointModel *vp = new ViewPointModel();
			vp->setName(wxT(""));
			vp->setWidth(1280);
			vp->setHeight(800);
			vp->setArea(arRealRect(0.0000, -115.5000, 1289.0000, 806.0000));
			vp->setActiveOverlays(over);
			vp->setVisibleOverlays(aover);
            vp->setParent(doc2);

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

			VPoints points;
			points.push_back(arRealPoint(10.0, 11.0));
			points.push_back(arRealPoint(12.0, 13.0));
			GroupModel* grp = new GroupModel;
			grp->setColor(wxColor(0x63, 0x63, 0xff));
			grp->setOverlay(1, true);
			grp->setPoints(points);
			grp->setSelected(true);
            
            // Test CurveModel
            StyleAttrib style = { 1 };
            CurveModel* curve = new CurveModel(arRealPoint(1.0, 1.5), arRealPoint(0.0, 11.5), 
                arRealPoint(1.1, 2.5), arRealPoint(13.2, 0.7), 38123, 2078, style, true);
            curve->setColor(wxColor(0x63, 0x63, 0xfe));
            curve->setOverlay(2, true);
            curve->setSelected(false);
            curve->setThickness(5);
            curve->setSthickness(37);
            curve->setParent(grp);

            // Test LineModel
            // style;  // @todo change style if class StyleAttrib is done. Now it must be 1!
            LineModel* line = new LineModel(1.1, 2.2, -3.3, -4.4, -38123, -2078, style, false);
            line->setColor(wxColor(0x63, 0x63, 0xfd));
            line->setOverlay(3, true);
            line->setSelected(true);
            line->setThickness(-5);
            line->setSthickness(-37);
            line->setParent(grp);

            // Test PolyCurveModel
            PolyCurveModel* pcurve = new PolyCurveModel(-12, 0, style, wxColor(0x11, 0x22, 0x44), true);
            pcurve->setColor(wxColor(0x00, 0xFF, 0x00));
            pcurve->setOverlay(4, true);
            pcurve->setSelected(false);
            pcurve->setThickness(-1);
            pcurve->setSthickness(1);
            pcurve->addPoint(arRealPoint(1.1,-1.1));
            pcurve->addPoint(arRealPoint(2.1,-2.1));
            pcurve->addPoint(arRealPoint(3.1,-3.1));
            pcurve->addPoint(arRealPoint(4.1,-4.1));
            pcurve->addPoint(arRealPoint(5.1,-5.1));
            pcurve->setParent(grp);

            // Test PolyLineModel
            PolyLineModel* pline = new PolyLineModel(23, -7, style, wxColor(0xF0, 0x00, 0x0F), false);
            pline->setColor(wxColor(0x88, 0xBC, 0x1A));
            pline->setOverlay(0, true);
            pline->setSelected(true);
            pline->setThickness(1290);
            pline->setSthickness(5912);
            pline->addPoint(arRealPoint(10.1,-10.1));
            pline->addPoint(arRealPoint(20.1,-20.1));
            pline->addPoint(arRealPoint(30.1,-30.1));
            pline->addPoint(arRealPoint(40.1,-40.1));
            pline->addPoint(arRealPoint(50.1,-50.1));
            pline->setParent(grp);

            GroupModel* grpb = new GroupModel;
            grp->setParent(grpb);
            
            grpb->setParent(doc2);
            
			CPPUNIT_ASSERT(doc->compare(doc2) == true);

			delete doc2;
		}

		/**                                 
		 * 
		 * Test to make sure invalid grid color will fail
		 */
		void testGlobalsInvalidGrid() throw (ARBadColorException) {
			obj->startNewObject(wxT("DOCUMENT"), attrib);
			obj->startNewObject(wxT("MAP"), attrib);
			obj->startNewObject(wxT("GLOBALS"), attrib);
			obj->startNewObject(wxT("CURRENT_GRID_COLOR"), attrib);
			obj->appendData(wxT("6a"));
			obj->endObject();
			obj->endObject();
			obj->endObject();
			obj->endObject();
		}

		/**
		 * Test to make sure invalid background color will fail
		 */
		void testGlobalsInvalidBg() throw (ARBadColorException) {
			obj->startNewObject(wxT("DOCUMENT"), attrib);
			obj->startNewObject(wxT("MAP"), attrib);
			obj->startNewObject(wxT("GLOBALS"), attrib);
			obj->startNewObject(wxT("BACKGROUND_COLOR"), attrib);
			obj->appendData(wxT("6a"));
			obj->endObject();
			obj->endObject();
			obj->endObject();
			obj->endObject();
		}

		/**
		 * Test to make sure invalid version will fail
		 */
		void testGlobalsInvalidVersion() throw (ARBadNumberFormat) {
			obj->startNewObject(wxT("DOCUMENT"), attrib);
			obj->startNewObject(wxT("MAP"), attrib);
			obj->startNewObject(wxT("GLOBALS"), attrib);
			obj->startNewObject(wxT("VERSION"), attrib);
			obj->appendData(wxT("6a"));
			obj->endObject();
			obj->endObject();
			obj->endObject();
			obj->endObject();
		}

		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST_SUITE(ObjectBuilderTest);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST(testGlobals);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST_EXCEPTION(testGlobalsInvalidGrid, ARBadColorException);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST_EXCEPTION(testGlobalsInvalidBg, ARBadColorException);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST_EXCEPTION(testGlobalsInvalidVersion, ARBadNumberFormat);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST_SUITE_END();
};

RUNNERADD(ObjectBuilderTest);
