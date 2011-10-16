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

#include "BitmapPrimitive.h"

static const wxString className=wxT("BitmapPrimitive");

/**
 * Constructor
 *
 * @todo Complete the implementation
 */
BitmapPrimitive::BitmapPrimitive() {
    wxLogTrace(className, wxT("Entering BitmapPrimitive"));
    wxLogTrace(className, wxT("Exiting BitmapPrimitive"));
}

/**
 * Copy constructor
 *
 * @todo Complete the implementation
 */
BitmapPrimitive::BitmapPrimitive(const wxBitmap start, arRealRect InitialRect) {
    wxLogTrace(className, wxT("Entering BitmapPrimitive"));
    wxLogTrace(className, wxT("Exiting BitmapPrimitive"));
}

/**
 * Creates a copy of the object
 *
 * @return The copy
 *
 * @todo Complete the implementation
 */
DrawPrimitive* BitmapPrimitive::Copy() {
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
void BitmapPrimitive::CopyFromBase(bool AliasOnly) {
    wxLogTrace(className, wxT("Entering CopyFromBase"));
    wxLogTrace(className, wxT("Exiting CopyFromBase"));
}


/**
 * Clears the object
 *
 * @param Deallocate Frees the object and any resources it has allocated
 *
 * @todo Complete the implementation
 */
void BitmapPrimitive::ClearThis(bool Deallocate) {
    wxLogTrace(className, wxT("Entering ClearThis"));
    wxLogTrace(className, wxT("Exiting ClearThis"));
}

/**
 * Draws the object
 *
 * @param view The viewpoint that the object is drawn with.
 * 
 * @todo Complete the implementation
 */
void BitmapPrimitive::Draw(ViewPoint view) {
    wxLogTrace(className, wxT("Entering Draw"));
    wxLogTrace(className, wxT("Exiting Draw"));
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
bool BitmapPrimitive::ApplyMatrix(Matrix3& mat) {
    wxLogTrace(className, wxT("Entering ApplyMatrix"));
    wxLogTrace(className, wxT("Exiting ApplyMatrix"));
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
bool BitmapPrimitive::MoveHandle(const ViewPoint& view, HandleMode& mode, coord origx, coord origy, coord dx, coord dy) {
    wxLogTrace(className, wxT("Entering MoveHandle"));
    wxLogTrace(className, wxT("Exiting MoveHandle"));
}

/**
 * Moves an object.
 *
 * @param dx Delta x coordinate to be added to entire object
 * @param dy Delta y coordinate to be added to entire object
 * 
 * @todo Complete the implementation
 */
void BitmapPrimitive::Move(coord dx, coord dy) {
    wxLogTrace(className, wxT("Entering Move"));
    wxLogTrace(className, wxT("Exiting Move"));
}

/**
 * Updates the object's internal Extent, the surrounding rectangle
 * that is used for quick in/out calculations.
 *
 * @todo Complete the implementation
 */
void BitmapPrimitive::ComputeExtent() {
    wxLogTrace(className, wxT("Entering ComputeExtent"));
    wxLogTrace(className, wxT("Exiting ComputeExtent"));
}

/**
 * Sets this object as selected if the click was a mouse select by the user.
 * Closed objects require a click inside the object; segmented lines require
 * a click within the specified distance of the line.
 *
 * @param within Distance that click can be away from line and still register
 * @param p Click test point
 * 
 * @return true if object is selected as result of click
 *
 * @todo Complete the implementation
 */
bool BitmapPrimitive::SelectClick(const double within, arRealPoint p) {
    wxLogTrace(className, wxT("Entering SelectClick"));
    wxLogTrace(className, wxT("Exiting SelectClick"));
}

/**
 * Sets a closed object's fill color.
 *
 * @param color Fill color to set
 * 
 * @return True if the object was set
 *
 * @todo Complete the implementation
 */
bool BitmapPrimitive::SetFillColor(wxColour color) {
    wxLogTrace(className, wxT("Entering SetFillColor"));
    wxLogTrace(className, wxT("Exiting SetFillColor"));
}

/**
 * Returns an object's fill color
 *
 * @return Fill color of the object
 *
 * @todo Complete the implementation
 */
wxColour BitmapPrimitive::GetFillColor() {
    wxLogTrace(className, wxT("Entering GetFillColor"));
    wxLogTrace(className, wxT("Exiting GetFillColor"));
}

/**
 * Returns identifier not for this object, but for this type of object.
 *
 * @return Single character identifier
 *
 * @todo Complete the implementation
 */
wxString BitmapPrimitive::GetId() {
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
bool BitmapPrimitive::IsSimilarTo(DrawPrimitive D) {
    wxLogTrace(className, wxT("Entering IsSimilarTo"));
    wxLogTrace(className, wxT("Exiting IsSimilarTo"));
}

void BitmapPrimitive::DoRead(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo) {
    wxLogTrace(className, wxT("Entering DoRead"));
    wxLogTrace(className, wxT("Exiting DoRead"));
}

void BitmapPrimitive::ReadFromDOMElement(wxXmlNode e, int version) {
    wxLogTrace(className, wxT("Entering ReadFromDOMElement"));
    wxLogTrace(className, wxT("Exiting ReadFromDOMElement"));
}

wxXmlNode BitmapPrimitive::GetAsDOMElement(wxXmlDocument D, bool undo) {
    wxLogTrace(className, wxT("Entering GetAsDOMElement"));
    wxLogTrace(className, wxT("Exiting GetAsDOMElement"));
}
