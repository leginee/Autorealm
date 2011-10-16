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
#include "Snap.h"

static wxString traceName=wxT("SnapUtil");

///@todo Document this method
bool ApplySnaps(bool activateLED, coord& cx, coord& cy, int forcetype, bool allowselected) {
    wxLogTrace(traceName, wxT("ApplySnaps(bool activateLED, coord& cx, coord& cy, int forcetype = -1, bool allowselected = true): Entering"));
    wxLogTrace(traceName, wxT("ApplySnaps(bool activateLED, coord& cx, coord& cy, int forcetype = -1, bool allowselected = true): Exiting"));
}

///@todo Document this method
void ApplyScreenSnaps(bool activateLED, coord& cx, coord& cy, int forcetype, bool allowselected) {
    wxLogTrace(traceName, wxT("ApplyScreenSnaps(bool activateLED, coord& cx, coord& cy, int forcetype = -1, bool allowselected = true): Entering"));
    wxLogTrace(traceName, wxT("ApplyScreenSnaps(bool activateLED, coord& cx, coord& cy, int forcetype = -1, bool allowselected = true): Exiting"));
}

///@todo Document this method
void ApplyScreenSnapsFloat(bool activateLED, coord& cx, coord& cy, int forcetype, bool allowselected) {
    wxLogTrace(traceName, wxT("ApplyScreenSnapsFloat(bool activateLED, coord& cx, coord& cy, int forcetype = -1, bool allowselected = true): Entering"));
    wxLogTrace(traceName, wxT("ApplyScreenSnapsFloat(bool activateLED, coord& cx, coord& cy, int forcetype = -1, bool allowselected = true): Exiting"));
}

///@todo Document this method
void ApplyDirectionalSnap(coord cx1, coord cy1, coord& cx2, coord& cy2, DirectionalSnap kind) {
    wxLogTrace(traceName, wxT("ApplyDirectionalSnap(coord cx1, coord cy1, coord& cx2, coord& cy2, DirectionalSnap kind=dst45): Entering"));
    wxLogTrace(traceName, wxT("ApplyDirectionalSnap(coord cx1, coord cy1, coord& cx2, coord& cy2, DirectionalSnap kind=dst45): Exiting"));
}

///@todo Document this method
void ApplyProportionalSnap(double aspect, coord cx1, coord cy1, coord& cx2, coord& cy2) {
    wxLogTrace(traceName, wxT("ApplyProportionalSnap(double aspect, coord cx1, coord cy1, coord& cx2, coord& cy2): Entering"));
    wxLogTrace(traceName, wxT("ApplyProportionalSnap(double aspect, coord cx1, coord cy1, coord& cx2, coord& cy2): Exiting"));
}

///@todo Document this method
void DrawSnapGrid(bool force) {
    wxLogTrace(traceName, wxT("DrawSnapGrid(bool force): Entering"));
    wxLogTrace(traceName, wxT("DrawSnapGrid(bool force): Exiting"));
}

///@todo Document this method
void SnapLEDsOff() {
    wxLogTrace(traceName, wxT("SnapLEDsOff(): Entering"));
    wxLogTrace(traceName, wxT("SnapLEDsOff(): Exiting"));
}

///@todo Document this method
void AdjustForSelBorder(int cx, int cy, coord& dx1, coord& dy1, coord& dx2, coord& dy2) {
    wxLogTrace(traceName, wxT("AdjustForSelBorder(int cx, int cy, coord& dx1, coord& dy1, coord& dx2, coord& dy2): Entering"));
    wxLogTrace(traceName, wxT("AdjustForSelBorder(int cx, int cy, coord& dx1, coord& dy1, coord& dx2, coord& dy2): Exiting"));
}

///@todo Document this method
void ClearAdjust() {
    wxLogTrace(traceName, wxT("ClearAdjust(): Entering"));
    wxLogTrace(traceName, wxT("ClearAdjust(): Exiting"));
}

coord ApplyScreenSnapsDX1;
coord ApplyScreenSnapsDY1;
coord ApplyScreenSnapsDX2;
coord ApplyScreenSnapsDY2;
coord ApplyScreenSnapsEX1;
coord ApplyScreenSnapsEY1;
coord ApplyScreenSnapsEX2;
coord ApplyScreenSnapsEY2;
coord LastSnapKind;
coord LastSnapAngle;
