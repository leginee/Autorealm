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

#include <wx/wx.h>
#include "FileManagerFactory.h"
#include "ObjectBuilder.h"
#include "ObjectWriter.h"
#include "ObjectInterface.h"
#include "Tracer.h"

TRACEFLAG(wxT("FileManagerFactoryTest"));

/** 
 * @brief Used to test the FileManagerFactory.
 */
class FileManagerFactoryTest : public CppUnit::TestFixture {
	private:
		FileManagerFactory fmFactory;
		ARDocument* doc;
		ObjectBuilder* objectBuilder;
		ObjectWriter* objectWriter;

	public:
		/** 
		 * @brief sets up an ARDocument and an ObjectBuilder
		 */
		void setUp() {
			doc           = new ARDocument();
			objectBuilder = new ObjectBuilder(doc);
			objectWriter  = new ObjectWriter(doc);
		}

		/** 
		 * @brief deletes objects created in setUp
		 */
		void tearDown() {
			delete doc;
			delete objectBuilder;
			delete objectWriter;
		}

		/** 
		 * @brief Tests detection of .AuRX XML map file
		 */
		void testFilemanagerFactoryXML() {
			TRACER(wxT("FileManagerFactoryTest::testFilemanagerFactoryXML"));
			wxString xmlFileName(wxT("test/Map1.AuRX"));
			FileManager* fileManager = fmFactory.getFileManager(xmlFileName, 
									    *objectBuilder, *objectWriter);
			CPPUNIT_ASSERT(dynamic_cast<XMLFileManager*>(fileManager) != NULL);
			fileManager = fmFactory.getFileManager(xmlFileName, 
									    *objectBuilder, *objectWriter);
			CPPUNIT_ASSERT(dynamic_cast<XMLFileManager*>(fileManager) != NULL);
		}

		/** 
		 * @brief Tests detection of .AuR binary map file
		 */
		void testFilemanagerFactoryBinary() {
			wxString binaryFileName(wxT("test/Map1.AuR"));
			FileManager* fileManager = fmFactory.getFileManager(binaryFileName, 
									    *objectBuilder, *objectWriter);
			CPPUNIT_ASSERT(fmFactory.getType() == FileManagerFactory::binary);
			fileManager = fmFactory.getFileManager(binaryFileName, 
									    *objectBuilder, *objectWriter);
			CPPUNIT_ASSERT(fmFactory.getType() == FileManagerFactory::binary);
		}

		/** 
		 * @brief Tests detection of invalid map file; i.e. a file that
		 *        exists and is long enough to detect the file type but
		 *        which doesn't have a header that we can decipher.
		 */
		void testFilemanagerFactoryInvalid() throw(ARInvalidFileType) {
			wxString invalidFileName(wxT("test/Map1.invalid"));

			fmFactory.getFileManager(invalidFileName, *objectBuilder, *objectWriter);
		}

		/** 
		 * @brief Tests detection of unexpected EOF reading map file
		 */
		void testFilemanagerFactoryEOF() throw(IOException) {
			wxString shortfileFileName(wxT("test/Map1.eof"));

			fmFactory.getFileManager(shortfileFileName, *objectBuilder, *objectWriter);
		}

		/** 
		 * @brief Tests file not found exception
		 */
		void testFilemanagerFactoryFileNotFound() throw(IOException) {
			wxString missingFileName(wxT("test/Map1.notthere"));

			fmFactory.getFileManager(missingFileName, *objectBuilder, *objectWriter);
		}

		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST_SUITE(FileManagerFactoryTest);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST(testFilemanagerFactoryXML);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST(testFilemanagerFactoryBinary);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST_EXCEPTION(testFilemanagerFactoryInvalid, ARInvalidFileType);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST_EXCEPTION(testFilemanagerFactoryEOF, IOException);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST_EXCEPTION(testFilemanagerFactoryFileNotFound, IOException);
		/**
		 * Used for TestSuite
		 */
		CPPUNIT_TEST_SUITE_END();
};

RUNNERADD(FileManagerFactoryTest);
