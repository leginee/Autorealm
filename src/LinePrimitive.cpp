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

#include "LinePrimitive.h"

static wxString className=wxT("LinePrimitive");

/**
 * Constructor
 *
 * @todo Complete the implementation
 */
LinePrimitive::LinePrimitive(bool frac) {
    wxLogTrace(className, wxT("Entering LinePrimitive"));
    wxLogTrace(className, wxT("Exiting LinePrimitive"));
}

/**
 * Copy constructor
 *
 * @todo Complete the implementation
 */
LinePrimitive::LinePrimitive(coord ix1, coord iy1, coord ix2, coord iy2, StyleAttrib istyle) {
    wxLogTrace(className, wxT("Entering LinePrimitive"));
    wxLogTrace(className, wxT("Exiting LinePrimitive"));
}

/**
 * Copy constructor
 *
 * @todo Complete the implementation
 */
LinePrimitive::LinePrimitive(coord ix1, coord iy1, coord ix2, coord iy2, int iseed, int irough, StyleAttrib istyle) {
    wxLogTrace(className, wxT("Entering LinePrimitive"));
    wxLogTrace(className, wxT("Exiting LinePrimitive"));
}

/**
 * Copy constructor
 *
 * @todo Complete the implementation
 */
LinePrimitive::LinePrimitive(coord ix1, coord iy1, coord ix2, coord iy2, int iseed, int irough, StyleAttrib istyle, bool frac) {
    wxLogTrace(className, wxT("Entering LinePrimitive"));
    wxLogTrace(className, wxT("Exiting LinePrimitive"));
}

/**
 * Creates a copy of the object
 *
 * @return The copy
 *
 * @todo Complete the implementation
 */
DrawPrimitive* LinePrimitive::Copy() {
    wxLogTrace(className, wxT("Entering Copy"));
    wxLogTrace(className, wxT("Exiting Copy"));
}

/**
 * Makes an aliased copy from this object's Base object,
 * without copying anything specific to this one (like
 * its position).
 *
 * @param AliasOnly Creates an alias without copying the whole object.
 * 
 * @return Copy of the object
 *
 * @todo Complete the implementation
 */
void LinePrimitive::CopyFromBase(bool AliasOnly) {
    wxLogTrace(className, wxT("Entering CopyFromBase"));
    wxLogTrace(className, wxT("Exiting CopyFromBase"));
}

/**
 * Draws the object
 *
 * @param view The viewpoint that the object is drawn with.
 * 
 * @todo Complete the implementation
 */
void LinePrimitive::Draw(ViewPoint& view) {
    wxLogTrace(className, wxT("Entering Draw"));
    wxLogTrace(className, wxT("Exiting Draw"));
}

/**
 * Draws object handles
 *
 * @param view Viewpoint to use for display
 *
 * @todo Complete the implementation
 */
void LinePrimitive::DrawHandles(const ViewPoint& view) {
    wxLogTrace(className, wxT("Entering DrawHandles"));
    wxLogTrace(className, wxT("Exiting DrawHandles"));
}

/**
 * Displays overlay handles
 *
 * @param view View to use for the display
 *
 * @todo Complete the implementation
 */
void LinePrimitive::DrawOverlayHandles(const ViewPoint& view) {
    wxLogTrace(className, wxT("Entering DrawOverlayHandles"));
    wxLogTrace(className, wxT("Exiting DrawOverlayHandles"));
}

/**
 * Multiplies the object by the given matrix to perform transform operations
 *
 * @param mat Matrix to be multiplied.
 *
 * @return True if the matrix was applied
 *
 * @todo Complete the implementation
 */
bool LinePrimitive::ApplyMatrix(Matrix3& mat) {
    wxLogTrace(className, wxT("Entering ApplyMatrix"));
    wxLogTrace(className, wxT("Exiting ApplyMatrix"));
}

/**
 * Finds a handle of the object
 *
 * @param view View to use for the object
 * @param x X coordinate of the handle
 * @param y Y coordinate of the handle
 *
 * @return True if the handle was matched
 *
 * @todo Complete the implementation
 */
bool LinePrimitive::FindHandle(const ViewPoint& view, coord x, coord y) {
    wxLogTrace(className, wxT("Entering FindHandle"));
    wxLogTrace(className, wxT("Exiting FindHandle"));
}

/**
 * Returns true if the object has a line endpoint close enough to the
 * given x,y point
 *
 * @param view View to use for the display
 * @param x X point
 * @param y Y point
 *
 * @return True if the object has a line point close enough
 *
 * @todo Complete the implementation
 */
bool LinePrimitive::FindEndPoint(const ViewPoint& view, coord& x, coord& y) {
    wxLogTrace(className, wxT("Entering FindEndPoint"));
    wxLogTrace(className, wxT("Exiting FindEndPoint"));
}

/**
 * Finds a point on the object's lines closest to the given point.
 *
 * @param view View to use for the object
 * @param x X coordinate passed in; modified with closest found
 * @param y Y coordinate passed in; modified with closest found
 * @param angle Angle between the passed in point and the line
 *
 * @return true if the point is close enough to be considered "on" the line
 *
 * @todo Complete the implementation
 */
bool LinePrimitive::FindPointOn(const ViewPoint& view, coord& x, coord& y, coord& angle) {
    wxLogTrace(className, wxT("Entering FindPointOn"));
    wxLogTrace(className, wxT("Exiting FindPointOn"));
}

/**
 * Moves a single point inside an object; used in handle drag operations
 *
 * @param view Viewpoint used to manipulate the object
 * @param mode Either hmAll to move all handles or hmOne to move the first handle
 * @param origx X Origin of the handle drag operation (within one screen handle's number of pixels in this view)
 * @param origy Y Origin of the handle drag operation (within one screen handle's number of pixels in this view)
 * @param dx Delta x coordinate to be added to handle point
 * @param dy Delta y coordinate to be added to handle point
 * 
 * @return True if the handle was moved
 *
 * @todo Complete the implementation
 */
bool LinePrimitive::MoveHandle(const ViewPoint& view, HandleMode& mode, coord origx, coord origy, coord dx, coord dy) {
    wxLogTrace(className, wxT("Entering MoveHandle"));
    wxLogTrace(className, wxT("Exiting MoveHandle"));
}

/**
 * Sets the style (line style and line endpoint styles) of the object
 *
 * @param new_style New style for object.
 *
 * @return True if the style was set
 *
 * @todo Complete the implementation
 */
bool LinePrimitive::SetStyle(StyleAttrib new_style) {
    wxLogTrace(className, wxT("Entering SetStyle"));
    wxLogTrace(className, wxT("Exiting SetStyle"));
}

/**
 * Gets the object's style (line style and line endpoint styles)
 *
 * @return The object's style
 *
 * @todo Complete the implementation
 */
StyleAttrib LinePrimitive::GetStyle() {
    wxLogTrace(className, wxT("Entering GetStyle"));
    wxLogTrace(className, wxT("Exiting GetStyle"));
}

/**
 * Moves an object.
 *
 * @param dx Delta x coordinate to be added to entire object
 * @param dy Delta y coordinate to be added to entire object
 * 
 * @todo Complete the implementation
 */
void LinePrimitive::Move(coord dx, coord dy) {
    wxLogTrace(className, wxT("Entering Move"));
    wxLogTrace(className, wxT("Exiting Move"));
}

/**
 * Updates the object's internal Extent, the surrounding rectangle
 * that is used for quick in/out calculations.
 *
 * @todo Complete the implementation
 */
void LinePrimitive::ComputeExtent() {
    wxLogTrace(className, wxT("Entering ComputeExtent"));
    wxLogTrace(className, wxT("Exiting ComputeExtent"));
}

/**
 * Returns the point in the object closest to the given point.
 *
 * @param x X coordinate of test point
 * @param y Y coordinate of test point
 * @param px X result coordinate that is closest in the object
 * @param py Y result coordinate that is closest in the object
 *
 * @todo Complete the implementation
 */
void LinePrimitive::PointClosestTo(coord x, coord y, coord& px, coord& py) {
    wxLogTrace(className, wxT("Entering PointClosestTo"));
    wxLogTrace(className, wxT("Exiting PointClosestTo"));
}

/**
 * Divides an object along a slice line into one or more new objects.
 *
 * @param s1 First endpoint of the slice line
 * @param s2 Second endpoint of the slice line
 * @param np New objects as a result of the slice
 *
 * @return True if the object was sliced
 *
 * @todo Complete the implementation
 */
bool LinePrimitive::SliceAlong(arRealPoint s1, arRealPoint s2, DrawPrimitive& np) {
    wxLogTrace(className, wxT("Entering SliceAlong"));
    wxLogTrace(className, wxT("Exiting SliceAlong"));
}

/**
 * Reverses the points within an object (used to alternate the line
 * style direction and line endpoint styles).
 *
 * @todo Complete the implementation
 */
void LinePrimitive::Reverse() {
    wxLogTrace(className, wxT("Entering Reverse"));
    wxLogTrace(className, wxT("Exiting Reverse"));
}

/**
 * Returns the object's boundary converted into a polyline as an
 * array of points based on the selected viewpoint.  Used for curves
 * and fractals to resolve to actual line entities for draw, boundary
 * tests, etc.
 *
 * @param view View to use for the conversion
 * @param polycount Number of points in the line array
 *
 * @return Pointer to the array of points
 *
 * @todo Complete the implementation
 */
VPoints LinePrimitive::GetLines(const ViewPoint& view, int& polycount) {
    wxLogTrace(className, wxT("Entering GetLines"));
    wxLogTrace(className, wxT("Exiting GetLines"));
}

/**
 * Converts an object into its composite parts (fractal gets turned into
 * polyline, text turned into polycurves, etc.) using the current view
 * as the resolution for the decompose.
 *
 * @param view View used for the decompose operation
 * @param NewChain New objects generated by the decompose
 * @param testinside Used during text/symbol decompose to make sure that
 *        internal "hollow" polygons are given special treatment.
 *
 * @return True if the object was decomposed
 *
 * @todo Complete the implementation
 */
bool LinePrimitive::Decompose(const ViewPoint& view, DrawPrimitive& NewChain, bool testinside) {
    wxLogTrace(className, wxT("Entering Decompose"));
    wxLogTrace(className, wxT("Exiting Decompose"));
}

/**
 * Sets the object's fractal seed
 *
 * @param new_seed The new fractal seed
 *
 * @return True if the seed was set
 *
 * @todo Complete the implementation
 */
bool LinePrimitive::SetSeed(int new_seed) {
    wxLogTrace(className, wxT("Entering SetSeed"));
    wxLogTrace(className, wxT("Exiting SetSeed"));
}

/**
 * Gets the object's fractal seed
 *
 * @return The object's fractal seed
 *
 * @todo Complete the implementation
 */
int LinePrimitive::GetSeed() {
    wxLogTrace(className, wxT("Entering GetSeed"));
    wxLogTrace(className, wxT("Exiting GetSeed"));
}

/**
 * Sets the object's roughness
 *
 * @param rough The object's roughness
 *
 * @return True if the roughness was set
 *
 * @todo Complete the implementation
 */
bool LinePrimitive::SetRoughness(int rough) {
    wxLogTrace(className, wxT("Entering SetRoughness"));
    wxLogTrace(className, wxT("Exiting SetRoughness"));
}

/**
 * Returns the object's roughness.
 *
 * @return The object's roughness
 *
 * @todo Complete the implementation
 */
int LinePrimitive::GetRoughness() {
    wxLogTrace(className, wxT("Entering GetRoughness"));
    wxLogTrace(className, wxT("Exiting GetRoughness"));
}

/**
 * Returns the object's fractal roughness "size", which is a measure
 * of the object's size combined with the object's roughness.
 *
 * @return The object's fractal roughness factor
 *
 * @todo Complete the implementation
 */
double LinePrimitive::RFact() {
    wxLogTrace(className, wxT("Entering RFact"));
    wxLogTrace(className, wxT("Exiting RFact"));
}

/**
 * Sets the object's fractal state
 *
 * @param state Fractal seed and roughness
 *
 * @return True if the object accepted the fractal state set
 *
 * @todo Complete the implementation
 */
bool LinePrimitive::SetFractal(FractalState state) {
    wxLogTrace(className, wxT("Entering SetFractal"));
    wxLogTrace(className, wxT("Exiting SetFractal"));
}

/**
 * Returns identifier not for this object, but for this type of object.
 *
 * @return Single character identifier
 *
 * @todo Complete the implementation
 */
wxString LinePrimitive::GetId() {
    wxLogTrace(className, wxT("Entering GetId"));
    wxLogTrace(className, wxT("Exiting GetId"));
}

/**
 * Returns true if this object is similar (i.e. could be considered
 * as an alias object) to the passed object.  IsSimilarTo doesn't
 * require exact matching, since there is a small delta difference
 * that is allowed.
 *
 * @param D Object to compare to.
 *
 * @return True if the objects are similar
 *
 * @todo Complete the implementation
 */
bool LinePrimitive::IsSimilarTo(DrawPrimitive D) {
    wxLogTrace(className, wxT("Entering IsSimilarTo"));
    wxLogTrace(className, wxT("Exiting IsSimilarTo"));
}

/**
 * Returns the object's x1 point adjusted to be correct for this
 * alias.  Aliased copies of objects are referenced by an offset
 * from the original.
 *
 * @return Point correctly adjusted for this alias
 *
 * @todo Complete the implementation
 */
coord LinePrimitive::GetAdjustedX1() {
    wxLogTrace(className, wxT("Entering GetAdjustedX1"));
    wxLogTrace(className, wxT("Exiting GetAdjustedX1"));
}

/**
 * Returns the object's y1 point adjusted to be correct for this
 * alias.  Aliased copies of objects are referenced by an offset
 * from the original.
 *
 * @return Point correctly adjusted for this alias
 *
 * @todo Complete the implementation
 */
coord LinePrimitive::GetAdjustedY1() {
    wxLogTrace(className, wxT("Entering GetAdjustedY1"));
    wxLogTrace(className, wxT("Exiting GetAdjustedY1"));
}

/**
 * Returns the object's x2 point adjusted to be correct for this
 * alias.  Aliased copies of objects are referenced by an offset
 * from the original.
 *
 * @return Point correctly adjusted for this alias
 *
 * @todo Complete the implementation
 */
coord LinePrimitive::GetAdjustedX2() {
    wxLogTrace(className, wxT("Entering GetAdjustedX2"));
    wxLogTrace(className, wxT("Exiting GetAdjustedX2"));
}

/**
 * Returns the object's y2 point adjusted to be correct for this
 * alias.  Aliased copies of objects are referenced by an offset
 * from the original.
 *
 * @return Point correctly adjusted for this alias
 *
 * @todo Complete the implementation
 */
coord LinePrimitive::GetAdjustedY2() {
    wxLogTrace(className, wxT("Entering GetAdjustedY2"));
    wxLogTrace(className, wxT("Exiting GetAdjustedY2"));
}


void LinePrimitive::DoRead(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo) {
    wxLogTrace(className, wxT("Entering DoRead"));
    wxLogTrace(className, wxT("Exiting DoRead"));
}

void LinePrimitive::ReadFromDOMElement(wxXmlNode e, int version) {
    wxLogTrace(className, wxT("Entering ReadFromDOMElement"));
    wxLogTrace(className, wxT("Exiting ReadFromDOMElement"));
}

wxXmlNode LinePrimitive::GetAsDOMElement(wxXmlDocument D, bool undo) {
    wxLogTrace(className, wxT("Entering GetAsDOMElement"));
    wxLogTrace(className, wxT("Exiting GetAsDOMElement"));
}
