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
#ifndef GRAPHGRID_H
#define GRAPHGRID_H

#include "globals.h"
#include <wx/xml/xml.h>
#include <wx/wfstream.h>

#include "types.h"

class ViewPoint;

/**
 * DefaultUnit
 * Sets the default scale for new maps and grids. By default, we choose
 * value 12 which equals "miles" in the UnitTable
 */
const int DefaultUnit = 12;

/**
 * gfGridOnTop
 * To be honest, I'm not entirely sure how this variable works. It's been
 * copied from the pascal sources.
 * @todo determine proper documentation for gfGridOnTop
 */
const int gfGridOnTop = 1;

/**
 * NumberGridStyles
 * This is the number of grid styles where a grid will actually be drawn.
 * In other words, gtNone doesn't count, which is why there are only
 * 7 styles.
 */
const int NumberGridStyles = 7;

/**
 * TGraphGrid
 * This enum lists the various styles of grid which are available to the
 * user. Any new styles must be appended at the end of the listing. If
 * any more types are added, you MUST change GetAsDOMElement() and
 * LoadFromDOMElement() !!! 
 */
enum TGraphGrid {
    gtNone,         /**< No grid displayed                              */
    gtSquare,       /**< Square grid displayed                          */
    gtHex,          /**< Hexagonal grid displayed                       */
    gtTriangle,     /**< Triangular grid displayed                      */
    gtRotatedHex,   /**< Rotated hex grid displayed                     */
    gtDiamond,      /**< Same as square, but rotated 45 degrees         */
    gtHalfDiamond,  /**< Same as diamond, but grid cells are half width */
    gtPolar         /**< Polar grid displayed                           */
};

/**
 * GridObject
 * This enum lists the various types of pen styles which can be used when
 * drawing on the screen. Any further styles which are devised must be
 * placed at the end of this listing. If any more types are added, you
 * MUST change GetAsDOMElement() and LoadFromDOMElement() !!!
 */
enum GridPenStyle {
    gpsDefault,     /**< Default pen style                          */
    gpsSingle,      /**< Single width pen                           */
    gpsDot,         /**< Regularly spaced dots                      */
    gpsDash,        /**< Regularly spaced dashes                    */
    gpsDashDot,     /**< Regularly spaced dashes and dots           */
    gpsDashDotDot,  /**< Regularly spaced dashes and dot-dot pairs  */
    gpsBold         /**< Bold pen                                   */
};

/**
 * @class GridObject
 * @brief This class is responsible for manipulating the grids which are
 * shown to the user.
 *
 * @todo Provide better documentation for this when it's relationship to
 * other classes is more clearly understood.
 * @todo Make the member variables into protected variables as soon as
 * possible, providing get/set methods.
 */
class GridObject {
    public:
        /**
         * Used to determine the distance each cell of the grid can show,
         * calculated as 1 cell equals this many inches.
         */
        double GraphScale;
        /**
         * The inverse of the GraphScale, used to give a distance in inches.
         * Calculated as 1 inch equals this many cells.
         */
        double GraphUnitConvert;
        /**
         * The name of the scale (for instance, inches, centimeters,
         * miles, etc)
         */
        wxString GraphUnits;
        /**
         * The index into the UnitTable for the current graph units
         */
        int CurrentGraphUnits;
        /**
         * The current size of a given cell on the grid
         */
        int CurrentGridSize;
        /**
         * The type of grid to be displayed
         */
        TGraphGrid GridType;
        /**
         * @todo Unsure of the meaning of this variable. Fix
         */
        int GridBoldUnits;
        /**
         * @todo Unsure of the meaning of this variable. Fix
         */
        unsigned int GridPosition;
        /**
         * @todo Unsure of the meaning of this variable. Fix
         */
        unsigned short GridFlags;
        /**
         * Each grid can have cells. Each cell can contain a secondary
         * grid, which also has a style. The Primary Grid Style holds the
         * style of the main grid, while the Secondary Grid Style holds
         * the style of the secondary grid,
         */
        GridPenStyle PrimaryGridStyle;
        /**
         * Each grid can have cells. Each cell can contain a secondary
         * grid, which also has a style. The Primary Grid Style holds the
         * style of the main grid, while the Secondary Grid Style holds
         * the style of the secondary grid,
         */
        GridPenStyle SecondaryGridStyle;

        /**
         * @brief Default constructor
         *
         * Creates a new grid object, and initializes it with sensible
         * defaults
         */
        GridObject();
        /**
         * @brief Secondary constructor
         *
         * Creates a new grid object, using the defaults from the parameter
         * oldgrid.
         *
         * @param oldgrid the GridObject from which to copy the settings.
         */
        GridObject(GridObject& oldgrid);

        /**
         * @brief returns the length of a given unit on this graph
         */
        double GetUnitLength();
        /**
         * @brief Sets the default unit of measure
         *
         * Set the default unit of measure to the unit listed in the
         * UnitTable.
         *
         * @param index The index entry of the unit of measure listen
         * in the UnitTable.
         */
        void SetMeasurementUnits(int index);
        /**
         * @brief Draws a square grid on the screen
         *
         * @param view The ViewPoint on which to draw this graph
         * @param clip The clipping region on screen for this viewpoint
         * @param left The left edge of the map
         * @param right The right edge of the map
         * @param top The top edge of the map
         * @param bottom The bottom edge of the map
         * @param width The width of the map
         * @param height The height of the map
         * @param num How many squares to go be drawn at a time, used for
         * drawing the secondary grid in boldface
         */
        void SquareGrid(ViewPoint view, wxRect clip, coord left,
                coord right, coord top, coord bottom, coord width,
                coord height, int num);
        /**
         * @brief Draws a hex grid on the screen
         *
         * @param view The ViewPoint on which to draw this graph
         * @param clip The clipping region on screen for this viewpoint
         * @param left The left edge of the map
         * @param right The right edge of the map
         * @param top The top edge of the map
         * @param bottom The bottom edge of the map
         * @param width The width of the map
         * @param height The height of the map
         * @param num How many squares to go be drawn at a time, used for
         * drawing the secondary grid in boldface
         */
        void HexGrid(ViewPoint view, wxRect clip, coord left,
                coord right, coord top, coord bottom, coord width,
                coord height, int num);
        /**
         * @brief Draws a triangular grid on the screen
         *
         * @param view The ViewPoint on which to draw this graph
         * @param clip The clipping region on screen for this viewpoint
         * @param left The left edge of the map
         * @param right The right edge of the map
         * @param top The top edge of the map
         * @param bottom The bottom edge of the map
         * @param width The width of the map
         * @param height The height of the map
         * @param num How many squares to go be drawn at a time, used for
         * drawing the secondary grid in boldface
         */
        void TriangleGrid(ViewPoint view, wxRect clip, coord left,
                coord right, coord top, coord bottom, coord width,
                coord height, int num);
        /**
         * @brief Draws a rotatex hex grid on the screen
         *
         * @param view The ViewPoint on which to draw this graph
         * @param clip The clipping region on screen for this viewpoint
         * @param left The left edge of the map
         * @param right The right edge of the map
         * @param top The top edge of the map
         * @param bottom The bottom edge of the map
         * @param width The width of the map
         * @param height The height of the map
         * @param num How many squares to go be drawn at a time, used for
         * drawing the secondary grid in boldface
         */
        void RotatedHexGrid(ViewPoint view, wxRect clip, coord left,
                coord right, coord top, coord bottom, coord width,
                coord height, int num);
        /**
         * @brief Draws a diamond grid on the screen
         *
         * @param view The ViewPoint on which to draw this graph
         * @param clip The clipping region on screen for this viewpoint
         * @param left The left edge of the map
         * @param right The right edge of the map
         * @param top The top edge of the map
         * @param bottom The bottom edge of the map
         * @param width The width of the map
         * @param height The height of the map
         * @param num How many squares to go be drawn at a time, used for
         * drawing the secondary grid in boldface
         * @param squash How much to squash the grid. Used to draw the
         * half-height diamond grid
         */
        void DiamondGrid(ViewPoint view, wxRect clip, coord left,
                coord right, coord top, coord bottom, coord width,
                coord height, int num, float squash);
        /**
         * @brief Draws a polar grid on the screen
         *
         * @param view The ViewPoint on which to draw this graph
         * @param clip The clipping region on screen for this viewpoint
         * @param left The left edge of the map
         * @param right The right edge of the map
         * @param top The top edge of the map
         * @param bottom The bottom edge of the map
         * @param width The width of the map
         * @param height The height of the map
         * @param num How many cells to go be drawn at a time, used for
         * drawing the secondary grid in boldface
         */
        void PolarGrid(ViewPoint view, wxRect clip, coord left,
                coord right, coord top, coord bottom, coord width,
                coord height, int num);
        /**
         * @brief Responsible for drawing the grid on a wxDC.
         *
         * @todo Need to document this after coding it up.
         */
        void DrawGrid(ViewPoint& v);
        /**
         * @brief Responsible for determing the size of the cells, and
         * how much territory those cells cover.
         *
         * @todo Document this better once it's better understood.
         */
        void SetGraphUnits(int index, int gridSize);
        wxXmlNode GetAsDOMElement(wxXmlDocument& D);
        void LoadFromDOMElement(const wxXmlNode& e);
        ///@todo must add stream and version parameters here. Original function call:
        ///procedure LoadFromStream(stream:TStream; version:integer);
        void LoadFromStream(wxFileInputStream& ins, int version);
        /**
         * @brief Builds the popup menu showing the different units of measure
         *
         * Fills the menu (which must already be constructed and valid)
         * with the entries listed in the UnitTable.
         *
         * @param Menu The menu to be filled
         *
         * @param action The event handler to call when these items are
         * clicked
         */
        void FillPopupMenu(wxMenu& Menu, wxCommandEventFunction* action);
        /**
         * @brief Checks off the current unit of measure, and unchecks the
         * rest
         *
         * This routine cycles through the listing of items on the
         * measurements menu, and makes sure that only the current unit
         * of measure is checked off.
         *
         * @param Menu the menu to cycle through
         */
        void SetMeasurementUnitChecks(wxMenu& Menu);
        /**
         * @brief Puts the units of measure into a combobox.
         *
         * This routine clears the contents of a combobox, and then puts
         * the units of measure into the list attached to the combobox.
         *
         * @param UnitComboBox The combobox which will accept all the
         * units of measure. It must be ready to accept them.
         */
        void FillComboList(wxComboBox& UnitComboBox);
        /**
         * @brief Converts distances from one scale to another
         *
         * This routine takes a distance between two points, and
         * converts and scales them to be a distance between two points
         * on a new grid scale.
         *
         * @param dist The distance to be converted
         *
         * @param unitindex The new scale's index in the UnitTable.
         */
        double Convert(double dist, int unitindex);
        /**
         * @brief Set the pen style for the grid
         *
         * This routine sets the pen style to any of the styles in
         * GridPenStyle. Note that the pen style is only set for the wxDC
         * which is passed in.
         *
         * @param canvas The wxDC which is to have the penstyle updated.
         *
         * @param style The style of grid which is desired
         *
         * @param defaultstyle The default style of the grid, if none is specified using style
         */
        void SetGridPenStyle(wxDC* canvas, GridPenStyle style, GridPenStyle defaultstyle);
        /**
         * Move the grid up one layer
         */
        void bringGridForward();
        /**
         * Move the grid down one layer
         */
        void sendGridBackward();
        /**
         * Get the current grid's layer number
         *
         * @return An int containing the layer number of the grid
         */
        int getGridPosition();
};

#ifndef GRAPHGRID_CPP
extern wxColour CurrentGridColor;
#endif

#endif // GRAPHGRID_H
