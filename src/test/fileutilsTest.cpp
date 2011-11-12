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

#include "ARExcept.h"
#include "fileutils.h"
#include "ARDocument.h"

/**
 * Needed tests:
 * attempt to load a non-existant file, and fail
 * attempt to load an invalid, existing file, and fail
 * attempt to load an existing file, and succeed
 * 
 * attempt to write to a non-existing file, and succeed
 * attempt to overwrite an existing file, and fail
 * attempt to overwrite an existing file, and succeed
 */
class fileutilsTest : public CppUnit::TestFixture {
private:
	ARDocument* doc;

public:
	void setUp() {
		doc = new ARDocument;
	}

	void tearDown() {
		delete doc;
	}

	void testFileLoadNonExistant() {
		fileLoad(wxT("invalid mapname.aurx-bad"), doc);
	}

	void testFileLoadInvalid() {
		fileLoad(wxT("test/Map1.invalid"), doc);
	}

	void testFileLoadSucceed() {
		fileLoad(wxT("test/Map1.AuRX"), doc);
	}

	void testFileSaveSucceed() {
		fileSave(wxT("savefile.AuRX"), doc);
		wxRemoveFile(wxT("savefile.AuRX"));
	}

	void testFileSaveOverwriteFail() {
		fileSave(wxT("savefile.AuRX"), doc);
		fileSave(wxT("savefile.AuRX"), doc);
		wxRemoveFile(wxT("savefile.AuRX"));
	}

	void testFileSaveOverwriteSucceed() {
		fileSave(wxT("savefile.AuRX"), doc, true);
		wxRemoveFile(wxT("savefile.AuRX"));
	}

	void testFileSaveInvalidType() {
		fileSave(wxT("invalidtype.invalid"), doc);
	}

	CPPUNIT_TEST_SUITE(fileutilsTest);
	CPPUNIT_TEST_EXCEPTION(testFileLoadNonExistant, IOException);
	CPPUNIT_TEST_EXCEPTION(testFileLoadInvalid, ARInvalidFileType);
	CPPUNIT_TEST(testFileLoadSucceed);
	CPPUNIT_TEST(testFileSaveSucceed);
	CPPUNIT_TEST_EXCEPTION(testFileSaveOverwriteFail, FileExistsException);
	CPPUNIT_TEST(testFileSaveOverwriteSucceed);
	CPPUNIT_TEST_EXCEPTION(testFileSaveInvalidType, ARInvalidFileType);
	CPPUNIT_TEST_SUITE_END();
};

RUNNERADD(fileutilsTest);
