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

#include "TextPrimitive.h"

static wxString className=wxT("TextCurvePrimitive");

/**
 * Constructor
 *
 * @todo Complete the implementation
 */
TextPrimitive::TextPrimitive() {
    wxLogTrace(className, wxT("Entering TextPrimitive"));
    wxLogTrace(className, wxT("Exiting TextPrimitive"));
}

/**
 * Copy constructor
 *
 * @todo Complete the implementation
 */
TextPrimitive::TextPrimitive(const ViewPoint& view, coord ix, coord iy, wxString itext, wxFont ifont, int iformatflags, wxColour outline) {
    wxLogTrace(className, wxT("Entering TextPrimitive"));
    wxLogTrace(className, wxT("Exiting TextPrimitive"));
}

/**
 * Creates a copy of the object
 *
 * @return The copy
 *
 * @todo Complete the implementation
 */
DrawPrimitive* TextPrimitive::Copy() {
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
void TextPrimitive::CopyFromBase(bool AliasOnly) {
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
void TextPrimitive::Draw(ViewPoint view) {
    wxLogTrace(className, wxT("Entering Draw"));
    wxLogTrace(className, wxT("Exiting Draw"));
}

/**
 * Updates the object's internal Extent, the surrounding rectangle
 * that is used for quick in/out calculations.
 *
 * @todo Complete the implementation
 */
void TextPrimitive::ComputeExtent() {
    wxLogTrace(className, wxT("Entering ComputeExtent"));
    wxLogTrace(className, wxT("Exiting ComputeExtent"));
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
bool TextPrimitive::ApplyMatrix(Matrix3& mat) {
    wxLogTrace(className, wxT("Entering ApplyMatrix"));
    wxLogTrace(className, wxT("Exiting ApplyMatrix"));
}

/**
 * Returns identifier not for this object, but for this type of object.
 *
 * @return Single character identifier
 *
 * @todo Complete the implementation
 */
wxString TextPrimitive::GetId() {
    wxLogTrace(className, wxT("Entering GetId"));
    wxLogTrace(className, wxT("Exiting GetId"));
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
bool TextPrimitive::SetTextAttrib(const ViewPoint& view, const TextAttrib attrib) {
    wxLogTrace(className, wxT("Entering SetTextAttrib"));
    wxLogTrace(className, wxT("Exiting SetTextAttrib"));
}

/**
 * Gets the object's text attributes (font, bold, size, etc.)
 *
 * @return Object's current text attributes
 *
 * @todo Complete the implementation
 */
TextAttrib TextPrimitive::GetTextAttrib() {
    wxLogTrace(className, wxT("Entering GetTextAttrib"));
    wxLogTrace(className, wxT("Exiting GetTextAttrib"));
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
bool TextPrimitive::IsSimilarTo(DrawPrimitive D) {
    wxLogTrace(className, wxT("Entering IsSimilarTo"));
    wxLogTrace(className, wxT("Exiting IsSimilarTo"));
}


void TextPrimitive::DoRead(wxFileInputStream& ins, int version, bool Full, bool UseAliasInfo) {
    wxLogTrace(className, wxT("Entering DoRead"));
    wxLogTrace(className, wxT("Exiting DoRead"));
}

void TextPrimitive::ReadFromDOMElement(wxXmlNode e, int version) {
    wxLogTrace(className, wxT("Entering ReadFromDOMElement"));
    wxLogTrace(className, wxT("Exiting ReadFromDOMElement"));
}

wxXmlNode TextPrimitive::GetAsDOMElement(wxXmlDocument D, bool undo) {
    wxLogTrace(className, wxT("Entering GetAsDOMElement"));
    wxLogTrace(className, wxT("Exiting GetAsDOMElement"));
}
