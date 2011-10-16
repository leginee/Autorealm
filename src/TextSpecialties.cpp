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

#include "globals.h"
#include "TextSpecialties.h"

#include "Map.xpm"

static wxString className=wxT("TextSpecialties");

void CenterText(wxDC* canvas, int x, int y, wxString text) {
    wxLogTrace(className, wxT("Entering CenterText(wxDC* canvas, int x, int y, wxString text)"));
    wxLogTrace(className, wxT("Exiting CenterText(wxDC* canvas, int x, int y, wxString text)"));
}

void XorDrawText(wxDC* canvas, int x, int y, wxString text, int format, wxColour bg) {
    wxLogTrace(className, wxT("Entering XorDrawText(wxDC* canvas, int x, int y, wxString text, int format, wxColour bg)"));
    wxLogTrace(className, wxT("Exiting XorDrawText(wxDC* canvas, int x, int y, wxString text, int format, wxColour bg)"));
}

void RotatedFont(wxFont* font, int angle) {
    wxLogTrace(className, wxT("Entering RotatedFont(wxFont* font, int angle)"));
    wxLogTrace(className, wxT("Exiting RotatedFont(wxFont* font, int angle)"));
}

void DrawBezierText(wxDC* canvas, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, wxString text) {
    wxLogTrace(className, wxT("Entering DrawBezierText(wxDC* canvas, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, wxString text)"));
    wxLogTrace(className, wxT("Exiting DrawBezierText(wxDC* canvas, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, wxString text)"));
}

int ComputeBezierText(wxDC* canvas, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, wxString text, VPoints PointList, int angle) {
    wxLogTrace(className, wxT("Entering ComputeBezierText(wxDC* canvas, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, wxString text, VPoints PointList, int angle)"));
    wxLogTrace(className, wxT("Exiting ComputeBezierText(wxDC* canvas, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, wxString text, VPoints PointList, int angle)"));
}

