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
#include "test/runner.h"

#include "FileManager.h"
#include "FileManagerFactory.h"
#include "ObjectBuilder.h"
#include "ObjectWriter.h"
#include "Tracer.h"

TRACEFLAG(wxT("XMLParserTest"));

/** 
 * @brief Used to test the FileManager.
 */
class XMLParserTest : public CppUnit::TestFixture {
	private:
		FileManagerFactory fmFactory;
		ObjectBuilder*     objectBuilder;
		ObjectWriter*      objectWriter;
		ARDocument*        doc;

	public:
		/** 
		 * @brief Required by TestFixture, does nothing yet. Will do
		 * something when the test cases begin being written
		 */
		void setUp() {
			doc           = new ARDocument();
			objectBuilder = new ObjectBuilder(doc);
			objectWriter  = new ObjectWriter(doc);
		}

		/** 
		 * @brief Required by TestFixture, does nothing yet. Will do
		 * something when the test cases begin being written
		 */
		void tearDown() {
		}

		/*
		 * Tests to implement:
		 * 1. small file (Map1.AuRX) (DONE)
		 * 2. large file (>1Mb) (LargeMap.AuRX and LargePolys.AuRX) (DONE)
		 * 3. large file with deep nesting
		 * 4. file with every type of object 
		 * 5. file with lots of large polys (LargePolys.AuRX) (DONE)
		 * 6. file with lots of symbols (LargeMap.AuRX and GroupMap.AuRX) (DONE)
		 * 7. several files consecutively
		 * 8. malformed file (not-well-formed XML) (Map1.malformedXML.AuRX) (DONE)
		 * 9. very large number of objects (Huge400KObjects.AuRX) (DONE)
		 * 10. ???
		 *
		 */

		/** 
		 * @brief parses a small map file
		 */
		void testXMLParseSmallFile() {
			TRACER(wxT("XMLParserTest::testXMLParseSmallFile"));
			wxString fileName(wxT("test/Map1.AuRX"));
			bool parseResult = false;
			FileManager* fileManager = fmFactory.getFileManager(fileName, 
									    *objectBuilder, *objectWriter);
			parseResult = fileManager->load();

			CPPUNIT_ASSERT(parseResult == true);
		}

		/** 
		 * @brief parses a large map file (>1Mb)
		 */
		void testXMLParseLargeFile() {
			wxString fileName(wxT("test/LargeMap.AuRX"));
			bool parseResult = false;
			FileManager* fileManager = fmFactory.getFileManager(fileName, 
									    *objectBuilder, *objectWriter);
			parseResult = fileManager->load();

			CPPUNIT_ASSERT(parseResult == true);
	}

		/** 
		 * @brief parses a large file with lots of symbols and several groups
		 */
		void testXMLParseGroupFile() {
			wxString fileName(wxT("test/GroupMap.AuRX"));
			bool parseResult = false;
			FileManager* fileManager = fmFactory.getFileManager(fileName, 
									    *objectBuilder, *objectWriter);
			parseResult = fileManager->load();

			CPPUNIT_ASSERT(parseResult == true);
		}

		/** 
		 * @brief parses a malformed map file (missing </COMMENTS> tag)
		 */
		void testXMLParseMalformedXMLFile() {
			wxString fileName(wxT("test/Map1.malformedXML.AuRX"));
			bool parseResult = false;
			FileManager* fileManager = fmFactory.getFileManager(fileName, 
									    *objectBuilder, *objectWriter);
			parseResult = fileManager->load();

			CPPUNIT_ASSERT(parseResult == false);
		}
//
// This section is commented out because the tests take about 8
// minutes to run. Until we get the Makefile fixed to make running
// these tests optional and split these tests out into another file,
// they'll stay that way :-). They work fine - just take to long.
//
//
//		/** 
//		 * @brief parses a map containing several VERY large polys
//		 */
//		void testXMLParseLargePolysFile() {
//			wxString fileName(wxT("test/LargePolys.AURX"));
//			bool parseResult = false;
//			FileManager* fileManager = fmFactory.getFileManager(fileName, 
//									    *objectBuilder);
//			parseResult = fileManager->load();
//
//			CPPUNIT_ASSERT(parseResult == true);
//		}
//		/** 
//		 * @brief parses a map containing 400K objects (68Mb file)
//		 */
//		void testXMLParse400KObjectsFile() {
//			wxString fileName(wxT("test/Huge400KObjects.AuRX"));
//			bool parseResult = false;
//			FileManager* fileManager = fmFactory.getFileManager(fileName, 
//									    *objectBuilder);
//			parseResult = fileManager->load();
//
//			CPPUNIT_ASSERT(parseResult == true);
//		}
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST_SUITE(XMLParserTest);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST(testXMLParseSmallFile);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST(testXMLParseLargeFile);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST(testXMLParseGroupFile);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST(testXMLParseMalformedXMLFile);
//
// Commented out as mentioned above
// due to length of time tests take to run
//
//		/**
//		 * Used for TestSuite
//		 */
//		CPPUNIT_TEST(testXMLParseLargePolysFile);
//		/**
//		 * Used for TestSuite
//		 */
//		CPPUNIT_TEST(testXMLParse400KObjectsFile);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST_SUITE_END();
};

RUNNERADD(XMLParserTest);
