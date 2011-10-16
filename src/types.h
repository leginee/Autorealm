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
#ifndef AR_TYPES_H
#define AR_TYPES_H
#include "globals.h"
#include <vector>
#include <math.h>

/**
 * @var const double rad
 * The value of one radian, one 180th of one half of a circle
 */
const double rad = 3.1415927 / 180;

/**
 * @typedef double coord
 * This was found to be a more useful way to handle the coord type from
 * AutoREALM_Delphi. By doing it this way, we can switch it to pretty
 * well anything we need at a later point.
 */
typedef double coord;

/**
 * @typedef std::vector<arRealPoint> VPoints
 * This is the accepted way of defining a list of coordinate points
 * (ie: map points, not onscreen points) to be used by AutoREALM
 */
typedef std::vector<arRealPoint> VPoints;

/**
 * @typedef std::vector<wxPoint> VSPoints
 * This is the accepted way of defining a list of screen points
 * (ie: onscreen points, not map points) to be used by AutoREALM
 */
typedef std::vector<wxPoint> VSPoints;

/**
 * @typedef std::vector<int> IntVec
 * This is the accepted way of defining a list of integers to be used
 * by AutoREALM
 */
typedef std::vector<int> IntVec;
#endif // AR_TYPES_H
