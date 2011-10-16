/*
 * Port of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
 * Used in rpgs and hobbyist GIS applications for mapmaking
 * Copyright (C) 2004 Michael J. Pedersen <m.pedersen@icelus.org>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
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
#include "CustomHint.h"

static wxString className=wxT("CustomHint");

///@todo Document this method
CustomHint::CustomHint(wxDC* canvas) {
    wxLogTrace(className, wxT("CustomHint(wxDC* canvas): Entering"));
    wxLogTrace(className, wxT("CustomHint(wxDC* canvas): Exiting"));
}

///@todo Document this method
CustomHint::~CustomHint() {
    wxLogTrace(className, wxT("~CustomHint(): Entering"));
    wxLogTrace(className, wxT("~CustomHint(): Exiting"));
}

///@todo Document this method
bool CustomHint::getVisible() {
    wxLogTrace(className, wxT("getVisible(): Entering"));
    wxLogTrace(className, wxT("getVisible(): Exiting"));
}

///@todo Document this method
void CustomHint::SetVisible(bool b) {
    wxLogTrace(className, wxT("SetVisible(bool b): Entering"));
    wxLogTrace(className, wxT("SetVisible(bool b): Exiting"));
}

///@todo Document this method
wxString CustomHint::getText() {
    wxLogTrace(className, wxT("getText(): Entering"));
    wxLogTrace(className, wxT("getText(): Exiting"));
}

///@todo Document this method
void CustomHint::SetText(wxString s) {
    wxLogTrace(className, wxT("SetText(wxString s): Entering"));
    wxLogTrace(className, wxT("SetText(wxString s): Exiting"));
}

///@todo Document this method
int CustomHint::getEndX() {
    wxLogTrace(className, wxT("getEndX(): Entering"));
    wxLogTrace(className, wxT("getEndX(): Exiting"));
}

///@todo Document this method
void CustomHint::SetEndX(int a) {
    wxLogTrace(className, wxT("SetEndX(int a): Entering"));
    wxLogTrace(className, wxT("SetEndX(int a): Exiting"));
}

///@todo Document this method
int CustomHint::getEndY() {
    wxLogTrace(className, wxT("getEndY(): Entering"));
    wxLogTrace(className, wxT("getEndY(): Exiting"));
}

///@todo Document this method
void CustomHint::SetEndY(int a) {
    wxLogTrace(className, wxT("SetEndY(int a): Entering"));
    wxLogTrace(className, wxT("SetEndY(int a): Exiting"));
}

///@todo Document this method
void ShowPopupBox(wxDC* canvas, int x, int y, wxString s) {
    wxLogTrace(className, wxT("ShowPopupBox(wxDC* canvas, int x, int y, wxString s): Entering"));
    wxLogTrace(className, wxT("ShowPopupBox(wxDC* canvas, int x, int y, wxString s): Exiting"));
}

///@todo Document this method
void GetPopupSize(wxDC* canvas, wxString sText, int& w, int& h) {
    wxLogTrace(className, wxT("GetPopupSize(wxDC* canvas, wxString sText, int& w, int& h): Entering"));
    wxLogTrace(className, wxT("GetPopupSize(wxDC* canvas, wxString sText, int& w, int& h): Exiting"));
}
