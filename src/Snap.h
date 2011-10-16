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
#include "types.h"

enum DirectionalSnap {dst90, dst45};

bool ApplySnaps(bool activateLED, coord& cx, coord& cy, int forcetype = -1, bool allowselected = true);
void ApplyScreenSnaps(bool activateLED, coord& cx, coord& cy, int forcetype = -1, bool allowselected = true);
void ApplyScreenSnapsFloat(bool activateLED, coord& cx, coord& cy, int forcetype = -1, bool allowselected = true);
void ApplyDirectionalSnap(coord cx1, coord cy1, coord& cx2, coord& cy2, DirectionalSnap kind=dst45);
void ApplyProportionalSnap(double aspect, coord cx1, coord cy1, coord& cx2, coord& cy2);
void DrawSnapGrid(bool force);
void SnapLEDsOff();
void AdjustForSelBorder(int cx, int cy, coord& dx1, coord& dy1, coord& dx2, coord& dy2);
void ClearAdjust();
