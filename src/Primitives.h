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
 *
 * @todo document all constants, typedefs, and other information in this file
 */
#ifndef PRIMITIVES_H
#define PRIMITIVES_H

#include <set>

#include "globals.h"
#include "DrawLines.h"
#include "MainWin.h"
// Normally, I would include ViewPoint.h here. However, due to some
// circular references (that are not yet cleaned up), I can't. I must
// include it at the end of the file, right before the function prototypes.

#include <wx/dcprint.h>

const wxString IconFontName(wxT("AutoREALMSymbols"));
const int    QuickDraw_Fills = 0x00000001;
const int    QuickDraw_Lines = 0x00000002;
const int    QuickDraw_All   = 0xFFFFFFFF;
const int    QuickDraw_None  = 0x00000000;
const int    SelectDistance  = 2;
const double VeryClose       = 1e-3; // Used in IsSimilarTo() and is
                                     // intended to handle roundoff error

typedef std::set<bool> OverlaySet;
enum HandleMode {hmAll=0, hmOne, hmFoundFirst};
enum HyperlinkFlagValues {hyperExecute, hyperHidden};
typedef std::set<HyperlinkFlagValues> HyperlinkFlags;
enum TextAttribType {tatText, tatFontName, tatFontSize, tatFontBold,
        tatFontItalic, tatFontUnderline, tatAlignment,
        tatIconSize, tatOutlineColor, tatHyperlinkText,
        tatHyperlinkFlags};
typedef std::set<TextAttribType> TextAttribSet;

struct TextAttrib {
        wxString Text;
        wxString FontName;
        int FontSize;
        wxColour FontFillColor;
        wxColour FontOutlineColor;
        bool FontBold, FontItalic, FontUnderline;
        int Alignment;
        TextAttribSet Valid;
        int IconSize;
        wxString HyperlinkText;
        HyperlinkFlags LinkFlags;
};

enum FractalState {
	fsUnchanged,
	fsSetFractal,
	fsSetNormal,
	fsFlipFractal
};

/**
 * This is an array of colors which was defined by the ColorButton unit
 * used in Delphi. It has been converted for use here, in case it is
 * necessary for load/save of old maps.
 */
const wxColour FillPalette[12][10] = {
    // Colour: 808080
    // Red: 128, Green: 128, Blue: 128
    {wxColour( 255, 255, 255), wxColour( 230, 230, 230), 
        wxColour( 204, 204, 204), wxColour( 179, 179, 179), 
        wxColour( 153, 153, 153), wxColour( 128, 128, 128), 
        wxColour( 102, 102, 102), wxColour(  76,  76,  76), 
        wxColour(  51,  51,  51), wxColour(   0,   0,   0)},
    // Colour: ff9f81
    // Red: 255, Green: 159, Blue: 129
    {wxColour( 255, 255, 212), wxColour( 255, 249, 202), 
        wxColour( 255, 221, 179), wxColour( 255, 192, 156), 
        wxColour( 255, 159, 129), wxColour( 224, 139, 113), 
        wxColour( 193, 120,  98), wxColour( 163, 101,  82), 
        wxColour( 132,  82,  67), wxColour( 102,  63,  51)},
    // Colour: b68549
    // Red: 182, Green: 133, Blue: 73
    {wxColour( 255, 219, 120), wxColour( 255, 208, 114), 
        wxColour( 252, 184, 101), wxColour( 220, 160,  88), 
        wxColour( 182, 133,  73), wxColour( 160, 117,  64), 
        wxColour( 138, 101,  55), wxColour( 116,  85,  46), 
        wxColour(  94,  69,  37), wxColour(  72,  53,  29)},
    // Colour: ff0000
    // Red: 255, Green: 0, Blue: 0
    {wxColour( 255, 165, 165), wxColour( 255, 145, 145), 
        wxColour( 255,  99,  99), wxColour( 255,  53,  53), 
        wxColour( 255,   0,   0), wxColour( 224,   0,   0), 
        wxColour( 193,   0,   0), wxColour( 163,   0,   0), 
        wxColour( 132,   0,   0), wxColour( 102,   0,   0)},
    // Colour: ff0080
    // Red: 255, Green: 0, Blue: 128
    {wxColour( 255, 165, 211), wxColour( 255, 145, 200), 
        wxColour( 255,  99, 177), wxColour( 255,  53, 154), 
        wxColour( 255,   0, 128), wxColour( 224,   0, 112), 
        wxColour( 193,   0,  97), wxColour( 163,   0,  81), 
        wxColour( 132,   0,  66), wxColour( 102,   0,  51)},
    // Colour: ff00ff
    // Red: 255, Green: 0, Blue: 255
    {wxColour( 255, 165, 255), wxColour( 255, 145, 255), 
        wxColour( 255,  99, 255), wxColour( 255,  53, 255), 
        wxColour( 255,   0, 255), wxColour( 224,   0, 224), 
        wxColour( 193,   0, 193), wxColour( 163,   0, 163), 
        wxColour( 132,   0, 132), wxColour( 102,   0, 102)},
    // Colour: ff8000
    // Red: 255, Green: 128, Blue: 0
    {wxColour( 255, 211, 165), wxColour( 255, 200, 145), 
        wxColour( 255, 177,  99), wxColour( 255, 154,  53), 
        wxColour( 255, 128,   0), wxColour( 224, 112,   0), 
        wxColour( 193,  97,   0), wxColour( 163,  81,   0), 
        wxColour( 132,  66,   0), wxColour( 102,  51,   0)},
    // Colour: ffff00
    // Red: 255, Green: 255, Blue: 0
    {wxColour( 255, 255, 165), wxColour( 255, 255, 145), 
        wxColour( 255, 255,  99), wxColour( 255, 255,  53), 
        wxColour( 255, 255,   0), wxColour( 224, 224,   0), 
        wxColour( 193, 193,   0), wxColour( 163, 163,   0), 
        wxColour( 132, 132,   0), wxColour( 102, 102,   0)},
    // Colour:   ff00
    // Red: 0, Green: 255, Blue: 0
    {wxColour( 165, 255, 165), wxColour( 145, 255, 145), 
        wxColour(  99, 255,  99), wxColour(  53, 255,  53), 
        wxColour(   0, 255,   0), wxColour(   0, 224,   0), 
        wxColour(   0, 193,   0), wxColour(   0, 163,   0), 
        wxColour(   0, 132,   0), wxColour(   0, 102,   0)},
    // Colour:   ffff
    // Red: 0, Green: 255, Blue: 255
    {wxColour( 165, 255, 255), wxColour( 145, 255, 255), 
        wxColour(  99, 255, 255), wxColour(  53, 255, 255), 
        wxColour(   0, 255, 255), wxColour(   0, 224, 224), 
        wxColour(   0, 193, 193), wxColour(   0, 163, 163), 
        wxColour(   0, 132, 132), wxColour(   0, 102, 102)},
    // Colour: 8000ff
    // Red: 128, Green: 0, Blue: 255
    {wxColour( 211, 165, 255), wxColour( 200, 145, 255), 
        wxColour( 177,  99, 255), wxColour( 154,  53, 255), 
        wxColour( 128,   0, 255), wxColour( 112,   0, 224), 
        wxColour(  97,   0, 193), wxColour(  81,   0, 163), 
        wxColour(  66,   0, 132), wxColour(  51,   0, 102)},
    // Colour:     ff
    // Red: 0, Green: 0, Blue: 255
    {wxColour( 165, 165, 255), wxColour( 145, 145, 255), 
        wxColour(  99,  99, 255), wxColour(  53,  53, 255), 
        wxColour(   0,   0, 255), wxColour(   0,   0, 224), 
        wxColour(   0,   0, 193), wxColour(   0,   0, 163), 
        wxColour(   0,   0, 132), wxColour(   0,   0, 102)}
};

#include "ViewPoint.h"

void StartNewHandleDraw();
void ReadOverlayColors();
arRealRect AdjustToPrinterPage(arRealRect ViewRect);

/**
 * For an array of coordinates, this routine calculates a new set of
 * coordinates that form an "envelope" around the original coordinates.
 * The purpose of this routine is to allow rendering lines and curves
 * where the width is a fixed amount (in map coordinates).  Such objects
 * always maintain a constant width relative to their size.
 *
 * @param points The original point list
 * @param style The object's style (this now contains the optional numeric
 * line width as well)
 * @param GetAverageSlope Used for curves and polycurves, this makes sure
 * that the resulting "envelope" is smooth
 * @param ThickEnds Not used for now, this extends the endpoints by half
 * the line width
 * @param closed If the polycurve is closed, this allows the original
 * points to "wrap", and is necessary for GetAverageAngle to get the
 * correct slope at the ends of the closed polycurve.
 * @param count (input) Contains the number of points in the original list
 * (output) Returns the number of points in the new list
 *
 * @return Returns a list of points that form an "envelope" around the
 * original object, with the specified numerical line width.  This
 * represents a single polygon to be filled.
 */
VPoints GetThickLines(const VPoints points, int& count,
        const StyleAttrib style, bool GetAverageSlope, bool ThickEnds,
        bool closed);

void DrawEnclosedFigure(wxDC* canvas, const VPoints& points, int count, bool closed,
        StyleAttrib& style, wxColour edgeColor, wxColour fillColor, ViewPoint view,
        bool GetAverageSlope);

wxString XMLIdFromCharId(wxChar c);
wxChar CharIdFromXMLId(wxString s, bool fractal);
void ReadOverlayColors(MainWin* main);
arRealRect AdjustToPrinterPage(arRealRect viewRect);

bool SetFractalState(bool current, FractalState state);

const int maxOverlayColors=30;
#endif //PRIMITIVES_H
