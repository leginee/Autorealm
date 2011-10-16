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
#include "Bezier.h"

#include "Map.xpm"

static wxString className=wxT("Bezier");

arRealPoint FindNearestPoint(arRealPoint P, VPoints V, double& Root) {
	wxLogTrace(className, wxT("FindNearestPoint(arRealPoint P, VPoints V, double& Root): beginning"));
	wxLogTrace(className, wxT("FindNearestPoint(arRealPoint P, VPoints V, double& Root): ending"));
}

double FindAngleAt(VPoints V, double Root) {
	wxLogTrace(className, wxT("FindAngleAt(VPoints V, double Root): beginning"));
	wxLogTrace(className, wxT("FindAngleAt(VPoints V, double Root): ending"));
}

int SolveCubic(double A, double B, double C, double D, VDouble& V) {
	wxLogTrace(className, wxT("SolveCubic(double A, double B, double C, double D, VDouble& V): beginning"));
	wxLogTrace(className, wxT("SolveCubic(double A, double B, double C, double D, VDouble& V): ending"));
}

void SplitAndGetHandles(VDouble V, double T, double& H1, double& X1, double& X, double& X2, double& H2) {
	wxLogTrace(className, wxT("SplitAndGetHandles(VDouble V, double T, double& H1, double& X1, double& X, double& X2, double& H2): beginning"));
	wxLogTrace(className, wxT("SplitAndGetHandles(VDouble V, double T, double& H1, double& X1, double& X, double& X2, double& H2): ending"));
}

int SliceAlongLine(VDouble X, VDouble Y, double S1X, double S1Y, double S2X, double S2Y, VDouble& XN, VDouble& YN) {
	wxLogTrace(className, wxT("SliceAlongLine(VDouble X, VDouble Y, double S1X, double S1Y, double S2X, double S2Y, VDouble& XN, VDouble& YN): beginning"));
	wxLogTrace(className, wxT("SliceAlongLine(VDouble X, VDouble Y, double S1X, double S1Y, double S2X, double S2Y, VDouble& XN, VDouble& YN): ending"));
}
