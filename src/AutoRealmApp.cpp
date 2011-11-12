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

#include <wx/spinctrl.h>
#include <wx/cmdline.h>
#include <wx/arrstr.h>
#include <wx/tokenzr.h>

#include "AutoRealmApp.h"
#include "types.h"
#include "versioninfo.h"
#include "Map.xpm"
#include "ARExcept.h"
#include "MainWin.h"
#include "Tracer.h"

TRACEFLAG(wxT("AutoRealmApp"));

// The following is just to show a way to compress XML before saving.
// Makes for nice, compact, portable files.
// #include <wx/wfstream.h>
// #include <wx/zstream.h>
//void saveXml() {
    //wxFileOutputStream fos(wxT("C:\\temp\\file.xml"));
    //wxZlibOutputStream zos(fos, wxZ_BEST_COMPRESSION, wxZLIB_GZIP);
    //wxXmlDocument xml;
    //wxLogNull no;
    //xml.Load(wxT("f:\\src\\autorealm_wx\\prior\\install\\examples\\Angry Marsh.AuRX"));
    //xml.Save(zos);
//}

/**
 * Used to initialize xrc files
 */
extern void InitActionsHandler();
/**
 * Used to initialize xrc files
 */
extern void InitFillHandler();
/**
 * Used to initialize xrc files
 */
extern void InitInfoHandler();
/**
 * Used to initialize xrc files
 */
extern void InitMainHandler();
/**
 * Used to initialize xrc files
 */
extern void InitMenusHandler();
/**
 * Used to initialize xrc files
 */
extern void InitOverlayColorsHandler();
/**
 * Used to initialize xrc files
 */
extern void InitOverlayIconsHandler();
/**
 * Used to initialize xrc files
 */
extern void InitPushPinHandler();
/**
 * Used to initialize xrc files
 */
extern void InitSettingsHandler();
/**
 * Used to initialize xrc files
 */
extern void InitSplashHandler();
/**
 * Used to initialize xrc files
 */
extern void InitCursorsHandler();
/**
 * Used to initialize xrc files
 */
extern void InitAutoNameHandler();

/**
 * The following are all valid options for AutoRealm. Right now, these are
 * rather sparse, since I'm only adding in the options for turning on
 * tracing. More can/will be added later.
 */
static const wxCmdLineEntryDesc cmdLineDesc[] = {
#ifdef __WXDEBUG__
    { wxCMD_LINE_OPTION, wxT("t"), wxT("trace"),
        wxT("comma separated list of classes to trace. 'ALL' means all classes"),
        wxCMD_LINE_VAL_STRING, wxCMD_LINE_PARAM_OPTIONAL },
#endif // __WXDEBUG__
    { wxCMD_LINE_SWITCH, wxT("h"), wxT("help"),
        wxT("show this help message"),
        wxCMD_LINE_VAL_NONE, wxCMD_LINE_PARAM_OPTIONAL },
	{ wxCMD_LINE_NONE, wxT(""), wxT(""),
		wxT(""),
		wxCMD_LINE_VAL_NONE, wxCMD_LINE_PARAM_OPTIONAL },
};

/**
 * Member method from wxApp, overridden for AutoRealmApp, and used
 * to get the application initialization completed. No parameters
 */
bool AutoRealmApp::OnInit() {
	TRACER(wxT("OnInit"));
    wxStaticText *lbl;
    wxFrame win;
    wxCmdLineParser cmd(cmdLineDesc, argc, argv);
    wxString trace;

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
				for (unsigned int i=0; i<v->size(); i++) {
					wxLogDebug(wxT("Initialization: Adding trace mask '%s'"), currclass.c_str());
					wxLog::AddTraceMask(v->at(i));
				}
			}
        }
    }
    const wxArrayString traces = wxLog::GetTraceMasks();
    for (unsigned int i=0; i<traces.GetCount(); i++) {
        wxLogDebug(wxT("Initialization: Trace Mask on for '%s'"), traces[i].c_str());
    }
#endif // __WXDEBUG__

    m_locale.Init();
    //m_locale.AddCatalog(wxT("en_US")); used to show how to add locales at startup

    TRACE(wxT("beginning onInit"));
    wxInitAllImageHandlers();
    wxXmlResource::Get()->InitAllHandlers();

    TRACE(wxT("Getting splash screen"));
    InitSplashHandler();
    wxXmlResource::Get()->LoadFrame(&win, NULL, wxT("frmSplash"));
    win.SetIcon(wxICON(autorealm));
    win.Show();
    Yield();
    lbl = (wxStaticText*)win.FindWindowByName(wxT("lblSplashStatus"), &win);

    TRACE(wxT("Getting actions forms"));
    lbl->SetLabel(_("Status: Initializing Action Forms"));
    Yield();
    InitActionsHandler();

    TRACE(wxT("Getting settings forms"));
    lbl->SetLabel(_("Status: Initializing Settings Forms"));
    Yield();
    InitSettingsHandler();

    TRACE(wxT("Getting information forms"));
    lbl->SetLabel(_("Status: Initializing Information Forms"));
    Yield();
    InitInfoHandler();

    TRACE(wxT("Getting menus"));
    lbl->SetLabel(_("Status: Initializing Menus"));
    Yield();
    InitMenusHandler();

    TRACE(wxT("Getting AutoName form"));
    lbl->SetLabel(_("Status: Initializing AutoName Form"));
    Yield();
    InitAutoNameHandler();

    TRACE(wxT("Getting fill types"));
    lbl->SetLabel(_("Status: Initializing Fill Types"));
    Yield();
    InitFillHandler();

    TRACE(wxT("Getting overlay colors"));
    lbl->SetLabel(_("Status: Initializing Overlay Colors"));
    Yield();
    InitOverlayColorsHandler();

    TRACE(wxT("Getting overlay icons"));
    lbl->SetLabel(_("Status: Initializing Overlay Icons"));
    Yield();
    InitOverlayIconsHandler();

    TRACE(wxT("Getting pushpins"));
    lbl->SetLabel(_("Status: Initializing Pushpins"));
    Yield();
    InitPushPinHandler();

    TRACE(wxT("Getting main form"));
    lbl->SetLabel(_("Status: Initializing Main Form"));
    Yield();
    InitMainHandler();

    TRACE(wxT("Getting cursors"));
    lbl->SetLabel(_("Status: Initializing Cursors"));
    Yield();
    InitCursorsHandler();

    TRACE(wxT("Prepping to show main form"));
    lbl->SetLabel(_("Prepping main screen..."));
    Yield();

    m_mainwin = new MainWin();
	wxXmlResource::Get()->LoadFrame(m_mainwin, NULL, wxT("frmMain"));
    m_mainwin->Show();
    SetTopWindow(m_mainwin);

    TRACE(wxT("Disposing of main window"));
    win.Close();

    return(true);
}

void AutoRealmApp::OnUnhandledException() {
	///@todo Add logging to file of exception information, try to provide stack trace (if possible), etc.
	try {
		throw;
	}
	catch (ARException& e) {
		wxMessageBox(wxT("An error has occured, and the program will now exit. Details:\n") + e.what(), wxT("Program Ending Error"));
	}
	catch (...) {
		wxMessageBox(wxT("An error has occured, and the program will now exit. No details are available"), wxT("Program Ending Error"));
	}
}

IMPLEMENT_APP(AutoRealmApp)
