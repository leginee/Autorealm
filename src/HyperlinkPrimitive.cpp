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

#include "HyperlinkPrimitive.h"

static wxString className=wxT("HyperlinkPrimitive");

/**
 * Constructor
 *
 * @todo Complete the implementation
 */
HyperlinkPrimitive::HyperlinkPrimitive() {
    wxLogTrace(className, wxT("Entering HyperlinkPrimitive"));
    wxLogTrace(className, wxT("Exiting HyperlinkPrimitive"));
}

/**
 * Copy constructor
 *
 * @todo Complete the implementation
 */
HyperlinkPrimitive::HyperlinkPrimitive(const coord x, const coord y, wxString str, HyperlinkFlags flag) {
    wxLogTrace(className, wxT("Entering HyperlinkPrimitive"));
    wxLogTrace(className, wxT("Exiting HyperlinkPrimitive"));
}

/**
 * Creates a copy of the object
 *
 * @return The copy
 *
 * @todo Complete the implementation
 */
DrawPrimitive* HyperlinkPrimitive::Copy() {
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
void HyperlinkPrimitive::CopyFromBase(bool AliasOnly) {
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
void HyperlinkPrimitive::Draw(ViewPoint view) {
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
bool HyperlinkPrimitive::ApplyMatrix(Matrix3& mat) {
    wxLogTrace(className, wxT("Entering ApplyMatrix"));
    wxLogTrace(className, wxT("Exiting ApplyMatrix"));
}

/**
 * Moves an object.
 *
 * @param dx Delta x coordinate to be added to entire object
 * @param dy Delta y coordinate to be added to entire object
 * 
 * @todo Complete the implementation
 */
void HyperlinkPrimitive::Move(coord dx, coord dy) {
    wxLogTrace(className, wxT("Entering Move"));
    wxLogTrace(className, wxT("Exiting Move"));
}

/**
 * Updates the object's internal Extent, the surrounding rectangle
 * that is used for quick in/out calculations.
 *
 * @todo Complete the implementation
 */
void HyperlinkPrimitive::ComputeExtent() {
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
bool HyperlinkPrimitive::SelectClick(const double within, arRealPoint p) {
    wxLogTrace(className, wxT("Entering SelectClick"));
    wxLogTrace(className, wxT("Exiting SelectClick"));
}

/**
 * Gets the object's text attributes (font, bold, size, etc.)
 *
 * @return Object's current text attributes
 *
 * @todo Complete the implementation
 */
TextAttrib HyperlinkPrimitive::GetTextAttrib() {
    wxLogTrace(className, wxT("Entering GetTextAttrib"));
    wxLogTrace(className, wxT("Exiting GetTextAttrib"));
}

/**
 * Sets the object's text attributes (font, bold, size, etc.)
 *
 * @param view Viewpoint to use for the text
 * @param attrib New attributes for the text
 *
 * @return True if the text attributes were set
 *
 * @todo Complete the implementation
 */
bool HyperlinkPrimitive::SetTextAttrib(const ViewPoint view, const TextAttrib attrib) {
    wxLogTrace(className, wxT("Entering SetTextAttrib"));
    wxLogTrace(className, wxT("Exiting SetTextAttrib"));
}

/**
 * Returns true if a hyperlink is at the given location
 *
 * @param view View to use for the object
 * @param x X coordinate of the test point
 * @param y Y coordinate of the test point
 * @param hypertext Hyperlink text, returned if there is a match
 * @param hyperflags Flags of the hyperlink text, returned if there is a match
 *
 * @return True if there is a hyperlink at the position
 *
 * @todo Complete the implementation
 */
bool HyperlinkPrimitive::FindHyperlink(const ViewPoint view, coord x, coord y, wxString& hypertext, HyperlinkFlags& hyperflags) {
    wxLogTrace(className, wxT("Entering FindHyperlink"));
    wxLogTrace(className, wxT("Exiting FindHyperlink"));
}

/**
 * Returns identifier not for this object, but for this type of object.
 *
 * @return Single character identifier
 *
 * @todo Complete the implementation
 */
wxString HyperlinkPrimitive::GetId() {
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
bool HyperlinkPrimitive::IsSimilarTo(DrawPrimitive D) {
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
coord HyperlinkPrimitive::GetAdjustedX1() {
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
coord HyperlinkPrimitive::GetAdjustedY1() {
    wxLogTrace(className, wxT("Entering GetAdjustedY1"));
    wxLogTrace(className, wxT("Exiting GetAdjustedY1"));
}


void HyperlinkPrimitive::DoRead(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo) {
    wxLogTrace(className, wxT("Entering DoRead"));
    wxLogTrace(className, wxT("Exiting DoRead"));
}

void HyperlinkPrimitive::ReadFromDOMElement(wxXmlNode e, int version) {
    wxLogTrace(className, wxT("Entering ReadFromDOMElement"));
    wxLogTrace(className, wxT("Exiting ReadFromDOMElement"));
}

wxXmlNode HyperlinkPrimitive::GetAsDOMElement(wxXmlDocument D, bool undo) {
    wxLogTrace(className, wxT("Entering GetAsDOMElement"));
    wxLogTrace(className, wxT("Exiting GetAsDOMElement"));
}
