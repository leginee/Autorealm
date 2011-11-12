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

#include <wx/xrc/xmlres.h>
#include <wx/msgdlg.h>
#include <wx/filedlg.h>

#include "arhelp.h"
#include "MainWin.h"
#include "mmMultiButton.h"

#include "ARDocument.h"
#include "fileutils.h"

IMPLEMENT_DYNAMIC_CLASS(MainWin, wxFrame);

BEGIN_EVENT_TABLE(MainWin, wxFrame)
	EVT_CLOSE(MainWin::OnClose)
	EVT_MENU(XRCID("mnuHelpContents"), MainWin::DisplayHelpContents)
	EVT_MENU(XRCID("mnuFileExit"), MainWin::OnExit)
	EVT_MENU(XRCID("mnuFileSave"), MainWin::OnSave)
	EVT_MENU(XRCID("mnuFileOpen"), MainWin::OnLoad)
	EVT_BUTTON(XRCID("btnToolFileOpen"), MainWin::OnLoad)
	EVT_BUTTON(XRCID("btnToolFileSave"), MainWin::OnSave)
END_EVENT_TABLE()

MainWin::MainWin(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos, const wxSize& size, long style, const wxString& name) :wxFrame(parent, id, title, pos, size, style, name) {
}

bool MainWin::Create(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
	return wxFrame::Create(parent, id, title, pos, size, style, name);
}

void MainWin::DisplayHelpContents(wxCommandEvent& evt) {
	arHelp::Get()->DisplayContents();
}

bool MainWin::ProcessEvent(wxEvent& evt) {
	if (evt.GetEventType() == mmEVT_TOGGLE) {
		long ctrl = evt.GetId();
		mmMultiButton* mm = dynamic_cast<mmMultiButton*>(FindWindowById(ctrl, this));
		if (mm != NULL) {
			struct ctrlpnls {
				wxString button;
				wxString panelname;
				wxPanel* panel;
			};
			wxPanel* pnlToolFile = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolFile")));
			wxPanel* pnlToolLine = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolLine")));
			wxPanel* pnlToolShape = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolShape")));
			wxPanel* pnlToolText = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolText")));
			wxPanel* pnlToolGroup = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolGroup")));
			wxPanel* pnlToolGrid = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolGrid")));
			wxPanel* pnlToolTransform = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolTransform")));
			wxPanel* pnlToolPositional = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolPositional")));
			wxPanel* pnlToolSnap = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolSnap")));
			wxPanel* pnlToolOverlay = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolOverlay")));
			wxPanel* pnlToolColorTranslation = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolColorTranslation")));
			wxPanel* pnlToolMeasure = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolMeasure")));
			wxPanel* pnlToolSymbol = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolSymbol")));
			wxPanel* pnlToolPushpin = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolPushpin")));
			wxPanel* pnlToolClipboard = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolClipboard")));
			wxPanel* pnlToolNull = dynamic_cast<wxPanel*>(FindWindowByName(wxT("pnlToolNull")));
			ctrlpnls ctrlids[] = {
				{wxT("btnTopFile"),	wxT("pnlToolFile"), pnlToolFile},
				{wxT("btnTopSelect"), wxT("pnlToolNull"), pnlToolNull},
				{wxT("btnTopUndo"), wxT("pnlToolNull"), pnlToolNull},
				{wxT("btnTopRedo"), wxT("pnlToolNull"), pnlToolNull},
				{wxT("btnTopLines"), wxT("pnlToolLine"), pnlToolLine},
				{wxT("btnTopShapes"), wxT("pnlToolShape"), pnlToolShape},
				{wxT("btnTopText"), wxT("pnlToolText"), pnlToolText},
				{wxT("btnTopGroup"), wxT("pnlToolGroup"), pnlToolGroup},
				{wxT("btnTopGrid"), wxT("pnlToolGrid"), pnlToolGrid},
				{wxT("btnTopTransform"), wxT("pnlToolTransform"), pnlToolTransform},
				{wxT("btnTopPosition"), wxT("pnlToolPositional"), pnlToolPositional},
				{wxT("btnTopSnap"), wxT("pnlToolSnap"), pnlToolSnap},
				{wxT("btnTopOverlays"), wxT("pnlToolOverlay"), pnlToolOverlay},
				{wxT("btnTopColorTranslation"), wxT("pnlToolColorTranslation"), pnlToolColorTranslation},
				{wxT("btnTopMeasurement"), wxT("pnlToolMeasure"), pnlToolMeasure},
				{wxT("btnTopPan"), wxT("pnlToolNull"), pnlToolNull},
				{wxT("btnTopSymbols"), wxT("pnlToolSymbol"), pnlToolSymbol},
				{wxT("btnTopPushpins"), wxT("pnlToolPushpin"), pnlToolPushpin},
				{wxT("btnTopHyperlink"), wxT("pnlToolNull"), pnlToolNull},
				{wxT("btnTopClipboard"), wxT("pnlToolClipboard"), pnlToolClipboard},
				{wxT("btnTopErase"), wxT("pnlToolNull"), pnlToolNull},
				{wxT("btnTopMakeArray"), wxT("pnlToolNull"), pnlToolNull},
				{wxT("btnTopRepaint"), wxT("pnlToolNull"), pnlToolNull},
				{wxT("NULL"), wxT("NULL"), NULL}
			};
			ctrlpnls* pnls=ctrlids;
			wxSize sz = pnls[0].panel->GetSizer()->GetSize();
			while (pnls->button != wxT("NULL")) {
				mmMultiButton* curr=dynamic_cast<mmMultiButton*>(FindWindowByName(pnls->button, this));
				if (curr != NULL) {
					if (curr == mm) {
						curr->SetToggleDown(true);
						pnls->panel->Show(true);
					} else {
						curr->SetToggleDown(false);
						pnls->panel->Show(false);
					}
				}
				pnls->panel->SetSize(sz);
				pnls++;
			}
			Layout();
			return(true);
		}
	}
	return(wxFrame::ProcessEvent(evt));
}

void MainWin::OnClose(wxCloseEvent& evt) {
	if (evt.CanVeto() == true) {
		if (wxMessageBox(_("Really exit?"), _("Really exit AutoRealm?"), wxYES_NO, this) == wxNO) {
			evt.Veto();
		} else {
			Destroy();
		}
	} else {
		Destroy();
	}
}

void MainWin::OnExit(wxCommandEvent& evt) {
	Close(false);
}

void MainWin::OnLoad(wxCommandEvent& evt) {
	wxString filename = wxFileSelector(_("Select a file to load:"), NULL, NULL, wxT(".arz"),
									   wxString(_("AutoRealm Map (*.arz)|*.arz|")) +
									   wxString(_("AutoRealm Map - XML|*.AuRX|")) +
									   wxString(_("AutoRealm Map - Binary|*.AuR|")) +
									   wxString(_("Any File|*.*")), wxOPEN);
	ARDocument doc;
	try {
		fileLoad(filename, &doc);
	} catch (...) {
	}
	if (fileGetLastErrors().Length() != 0) {
		wxMessageBox(fileGetLastErrors(), _("Errors were encountered"), wxOK|wxCENTRE, this);
	}
}

void MainWin::OnSave(wxCommandEvent& evt) {
	wxString filename = wxFileSelector(_("Select the name of the saved file:"), NULL, NULL, wxT(".arz"),
									   wxString(_("AutoRealm Map (*.arz)|*.arz")), wxSAVE);
	wxMessageBox(filename, wxT("Found file:"));
}
