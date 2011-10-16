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
#ifndef MAPUTILS_H
#define MAPUTILS_H
#include "globals.h"
#include "types.h"

/**
 * Converts a vector of wxPoint to an array, usable by wxDC::DrawPolygon
 *
 * @param points The vector of wxPoint to be converted. Within
 * autorealm_wx, this vector is known as "VSPoints".
 *
 * @return a pointer to a memory area used for holding the converted
 * vector. Note that the caller is responsible for "delete"ing this
 * memory, so it is recommended to use auto_ptr for it.
 */
wxPoint* VSPointsToArray(const VSPoints points);

void swapPoints(arRealPoint& a, arRealPoint& b);

#endif //MAPUTILS_H
