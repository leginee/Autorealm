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
#include "Tracer.h"
#include "ARExcept.h"

#include <wx/wx.h>
#include <wx/cmdline.h>
#include <wx/tokenzr.h>
#include <wx/log.h>
#include <wx/arrstr.h>

CppUnit::TextUi::TestRunner* Runner::m_runner=NULL;

extern void sizesTest();
extern void speedTest();

/**
 * Used to print out a header defined by the user.
 *
 * @param szHeading The heading to be printed
 */
void PrintHeader(const char * szHeading) {
	std::cout << szHeading << std::endl;
	std::cout << "===================================================" << std::endl;
}

/**
 * Used to print a footer
 */
void PrintFooter() {
	std::cout << std::endl;
}

/**
 * List of valid command line parameters
 */
static const wxCmdLineEntryDesc cmdLineDesc[] = {
#ifdef __WXDEBUG__
	{ wxCMD_LINE_OPTION, wxT("t"), wxT("trace"),
		wxT("comma separated list of classes to trace. 'ALL' means all classes"),
		wxCMD_LINE_VAL_STRING, wxCMD_LINE_PARAM_OPTIONAL},
#endif // __WXDEBUG__
    { wxCMD_LINE_SWITCH, wxT("h"), wxT("help"),
        wxT("show this help message"),
        wxCMD_LINE_VAL_NONE, wxCMD_LINE_PARAM_OPTIONAL },
	{ wxCMD_LINE_NONE, wxT(""), wxT(""),
		wxT(""),
		wxCMD_LINE_VAL_NONE, wxCMD_LINE_PARAM_OPTIONAL},
};

class TestAutoRealm : public wxApp {
public:
	virtual bool OnInit() {
		wxCmdLineParser cmd(cmdLineDesc, argc, argv);
		wxString trace;

		//AddAllTraces();

		if (cmd.Parse() != 0) {
			return (false);
		}
		if (cmd.Found(wxT("help"))) {
			cmd.Usage();
			return(false);
		}

#ifdef __WXDEBUG__
		if (cmd.Found(wxT("trace"), &trace)) {
			wxStringTokenizer tok(trace, wxT(","));
			while (tok.HasMoreTokens()) {
				wxString currclass = tok.GetNextToken();
				wxLogDebug(wxT("Initialization: Adding trace mask '%s'"), currclass.c_str());
				wxLog::AddTraceMask(currclass);
				if (currclass == wxT("ALL")) {
					tracesvector* v=TracerSingleton::Get();
					for (int i=0; i<v->size(); i++) {
						wxLogDebug(wxT("Initialization: Adding trace mask '%s'"), currclass.c_str());
						wxLog::AddTraceMask(v->at(i));
					}
				}
			}
		}
		const wxArrayString traces = wxLog::GetTraceMasks();
		for (int i=0; i<traces.GetCount(); i++) {
			wxLogDebug(wxT("Initialization: Trace Mask on for '%s'"), traces[i].c_str());
		}
#endif // __WXDEBUG__
		return(true);
	}
	/**
	 * The main driver for the application. Enables whatever tracing is desired,
	 * and then calls all the tests.
	 *
	 * @return true = everything ran fine, false = at least one test failed
	 */
	virtual int OnRun() {

		int iSuccess = 0;
		try {
			sizesTest();
			speedTest();
			iSuccess = (Runner::Get()->run() ? 0 : 1);
		} catch (ARException are) {
			printf("Error: %s", are.what().c_str());
		}
		return iSuccess;
	}
};

IMPLEMENT_APP(TestAutoRealm)
