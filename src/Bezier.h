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
#ifndef BEZIER_H
#define BEZIER_H
#include "globals.h"
#include <wx/xrc/xmlres.h>
#include <vector>

#include "arRealTypes.h"
#include "types.h"

/**
 * Portions of this file adapted from:
 *
 * Solving the Nearest Point-on-Curve Problem
 * and
 * A Bezier Curve-Based Root-Finder
 * by Philip J. Schneider
 * from "Graphics Gems", Academic Press, 1990
 * http://www.graphicsgems.org
 */

/**
 * The original definitions provided two types: PDouble (as a pointer to
 * a double), and CPoint (as a record containing an x and a y, both of them
 * being doubles). The PDouble was used to index into an array. It is being
 * replaced with a std::vector<double>. The CPoint is being dropped, and
 * replaced with arRealPoint.
 */

typedef std::vector<double> VDouble;

arRealPoint FindNearestPoint(arRealPoint P, VPoints V, double& Root);
double FindAngleAt(VPoints V, double Root);
int SolveCubic(double A, double B, double C, double D, VDouble& V);
void SplitAndGetHandles(VDouble V, double T, double& H1, double& X1, double& X, double& X2, double& H2);
int SliceAlongLine(VDouble X, VDouble Y, double S1X, double S1Y, double S2X, double S2Y, VDouble& XN, VDouble& YN);

#endif //BEZIER_H
