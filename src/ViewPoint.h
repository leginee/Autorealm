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

#ifndef VIEWPOINT_H
#define VIEWPOINT_H

#include "globals.h"
#include "GraphGrid.h"
#include "DrawLines.h"
#include "Primitives.h"

/**
 * @brief used to describe a particular location's view settings on the map
 * including coordinates, overlays, and zoom factor
 */
class ViewPoint {
    public:
        /**
         * The name of this viewpoint
         */
        wxString Name;
        /**
         * The device context (wxDC) on which to draw the view.
         * @todo Is this a necessary item? Should double-check to see if it
         * can be removed
         */
        wxDC* canvas;
        /**
         * The set of overlays which are to be visible in this viewpoint
         */
        OverlaySet VisibleOverlays;
        /**
         * The set of overlays which are to be marked as active in this
         * viewpoint
         */
        OverlaySet ActiveOverlays;
        /**
         * @todo document QuickDraw, as I have no idea what it is
         */
        unsigned int QuickDraw;
        /**
         * The grid associated with this viewpoint.
         * @todo This doesn't seem useful. The class doesn't reference it
         * at all. Asking for help on why it is here
         */
        GridObject grid;
        /**
         * Should all objects which are offscreen be drawn in full detail?
         */
        bool OffScreenFullDetail;

        /**
         * Default construtor. Uses reasonable defaults for all values.
         */
        ViewPoint();
        /**
         * Used to set up a viewpoint with more defaults. Basically, this
         * allows the specification of the location of the viewpoint as
         * part of the constructor.
         *
         * @param rect The area to be displayed by this viewpoint
         * @param cw The clientwidth (how much space the screen should use
         * for it)
         * @param ch The clientheight (how much space the screen should use
         * for it)
         */
        ViewPoint(arRealRect rect, int cw, int ch);
        /**
         * Used to set up a viewpoint with more defaults. Basically, this
         * allows the specification of the location of the viewpoint as
         * part of the constructor.
         *
         * @param rect The area to be displayed by this viewpoint
         * @param cw The clientwidth (how much space the screen should use
         * for it)
         * @param ch The clientheight (how much space the screen should use
         * for it)
         * @param oldgrid The grid associated with this viewpoint
         */
        ViewPoint(arRealRect rect, int cw, int ch, GridObject oldgrid);
        /**
         * More or less a copy constructor for the viewpoint, but one that
         * also allows to print the viewpoint. As such, it provides a
         * parameter that, if true, reads client settings from the printer,
         * and calculates from there.
         * 
         * @param view The ViewPoint to copy from
         * @param useprinter Whether or not we should use printer settings
         * for client information
         */
        ViewPoint(ViewPoint& view, bool useprinter=false);

        /**
         * Convert map coordinates to screen coordinates
         *
         * @param cx input x coordinate
         * @param cy input y coordinate
         * @param sx output x coordinate
         * @param sy output y coordinate
         */
        void CoordToScreen(coord cx, coord cy, int& sx, int& sy);
        /**
         * Convert map coordinates to screen coordinates
         *
         * @param cx input x coordinate
         * @param cy input y coordinate
         * @param sx output x coordinate
         * @param sy output y coordinate
         */
        void CoordToScreen(coord cx, coord cy, coord& sx, coord& sy);
        /**
         * Convert screen coordinates to map coordinates
         *
         * @param cx input x coordinate
         * @param cy input y coordinate
         * @param sx output x coordinate
         * @param sy output y coordinate
         */
        void ScreenToCoord(coord sx, coord sy, coord& cx, coord& cy);
        /**
         * Convert screen coordinates to map coordinates
         *
         * @param cx input x coordinate
         * @param cy input y coordinate
         * @param sx output x coordinate
         * @param sy output y coordinate
         */
        void ScreenToCoord(int sx, int sy, coord& cx, coord& cy);
        /**
         * Convert screen change into area change. Useful when the screen
         * location has updated, and the viewpoint needs to update to
         * reflect the new location
         *
         * @param dx input x coordinate
         * @param dy input y coordinate
         * @param cx output x coordinate
         * @param cy output y coordinate
         */
        void DeltaScreenToCoord(int dx, int dy, coord& cx, coord& cy);
        /**
         * Convert screen change into area change. Useful when the screen
         * location has updated, and the viewpoint needs to update to
         * reflect the new location
         *
         * @param dx input x coordinate
         * @param dy input y coordinate
         * @param cx output x coordinate
         * @param cy output y coordinate
         */
        void DeltaScreenToCoord(coord dx, coord dy, coord& cx, coord& cy);
        /**
         * Convert area change into screen change. Useful when the area
         * location has updated, and the viewpoint needs to update to
         * reflect the new location
         *
         * @param cx input x coordinate
         * @param cy input y coordinate
         * @param dx output x coordinate
         * @param dy output y coordinate
         */
        void DeltaCoordToScreen(coord cx, coord cy, int& dx, int& dy);
        /**
         * Convert area change into screen change. Useful when the area
         * location has updated, and the viewpoint needs to update to
         * reflect the new location
         *
         * @param cx input x coordinate
         * @param cy input y coordinate
         * @param dx output x coordinate
         * @param dy output y coordinate
         */
        void DeltaCoordToScreen(coord cx, coord cy, coord& dx, coord& dy);

        /**
         * Convert a map coordinate to a screen coordinate in this
         * ViewPoint.
         *
         * @param p The map coordinate to convert
         *
         * @return The screen coordinate for this map coordinate
         */
        wxPoint CoordToScreenPt(arRealPoint p);
        /**
         * Convert a whole array of screen coordinates into map
         * coordinates.
         *
         * @param p (input/output) the coordinates to be converted (at the
         * beginning of the function call), and the converted coordinates
         * (at the end of the function call)
         * @param count The number of items in p
         */
        void ScreenToCoordPtArray(VPoints p, int count);

        /**
         * Jump to a specific set of map coordinates, zoom in, and offset
         * the viewpoint by a factor (px,py), allowing the center of the
         * viewpoint to not be in the center of the screen.
         *
         * @param center The center of the viewpoint
         * @param factor The zoom level
         * @param px The offset from the upper left corner of the viewable
         * @param py The offset from the upper left corner of the viewable
         * area
         */
        void Zoom(arRealPoint center, float factor, double px=0.5, double py=0.5);
        /**
         * Resets the zoom level to a new value. Note that the percentage
         * is the original number. ie: 1600% should have a value passed in
         * of 1600, not 16. 50% should pass in 50, not 0.5.
         *
         * @param percent The percentage to zoom to
         */
        void SetZoomPercent(double percent);
        /**
         * Get the zoom value as a whole percent. ie: 50% will be returned
         * as 50, not 0.5;
         *
         * @return The current zoom value
         */
        int GetZoomPercent();

        /**
         * Convert map area to screen area.
         *
         * @param CoordRect the area of the map to be converted
         *
         * @return the area on screen for that area of the map
         */
        wxRect CoordToScreenRect(arRealRect CoordRect);
        /**
         * Convert screen area to map area
         *
         * @param CoordRect the area of the screen to be converted
         *
         * @return the area of the map represented by that screen area
         */
        arRealRect ScreenToCoordRect(arRealRect CoordRect);
        /**
         * Convert screen area to map area
         *
         * @param rect the area of the screen to be converted
         *
         * @return the area of the map represented by that screen area
         */
        arRealRect ScreenToCoordRect(wxRect rect);

        /**
         * Set the size of the pixels in the screen.
         *
         * @param width the width of the drawable screen area
         * @param height the height of the drawable screen area
         * @param rescale should the area be rescaled (for instance, due to
         * zooming?)
         *
         * @todo Double-check documentation. This might be the width/height
         * of the ViewPoint, not the drawable area.
         */
        void SetCoordinateSize(int width, int height, bool rescale);
        /**
         * Return the current of the pixels in the drawable screen area
         *
         * @param width (output) the width of the pixels
         * @param height (output) the height of the pixels
         *
         * @todo Double-check documentation. This might be the width/height
         * of the ViewPoint, not the drawable area.
         */
        void GetCoordinateSize(int &width, int& height);
        /**
         * Set the map area of the viewpoint to represent the area defined
         * by cr
         *
         * @param cr The new map area for this ViewPoint
         */
        void SetCoordinateRect(arRealRect cr);
        /**
         * Get the current map area for this ViewPoint
         *
         * @param cr (output) The current map area for this ViewPoint
         */
        void GetCoordinateRect(arRealRect& cr);

        /**
         * Responsible for fixing styles for lines. Currently broken, as
         * necessary functions are not yet defined
         *
         * @param st The style to be fixed
         */
        StyleAttrib FixStyle(StyleAttrib st);

        void LoadFromStream(wxFileInputStream& ins);
        void LoadFromDOMElement(wxXmlNode E);
        wxXmlNode GetAsDOMElement(wxXmlDocument& D);

        /**
         * The area of the map represented by this ViewPoint
         */
        arRealRect Area;
    private:
        /**
         * The drawable width on the screen for this ViewPoint
         */
        int ClientWidth;
        /**
         * The drawable height on the screen for this ViewPoint
         */
        int ClientHeight;
};

#endif //VIEWPOINT_H
