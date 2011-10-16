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
#ifndef DRAWLINES_H
#define DRAWLINES_H

#include "globals.h"
#include "types.h"

/**
 * Misunderstood struct
 *
 * @todo Clarify the documentation on this struct
 */
struct TFullStyle {
    /**
     * Not understood.
     *
     * @todo document later
     */
    unsigned int Bits;
    /**
     * Not understood.
     *
     * @todo document later
     */
    coord Thickness;
    /**
     * Not understood.
     *
     * @todo document later
     */
    coord SThickness; // Never saved to disk: calculated on the fly
};

/**
 * StyleAttrib is the line style. We use four sections at a byte a piece
 * to specify the style of the Line, the Fill style (it if it closed),
 * and the styles of the line tips on either end.
 */
struct StyleAttrib {
    /**
     * The type of the union below (LineStyleUnion)
     */
    int type;
	/**
 	* This union represents a number of possibilities for styles.
 	*/
	union {
    	/**
     	* unknown what this is for or how it is used
     	*
     	* @todo clarify the documentation
     	*/
    	TFullStyle FullStyle;
    	/**
     	* Line style, fill style, line tip (beginning), line tip (ending)
     	*/
    	struct {
        	/**
         	* The style number of the line
         	*/
        	unsigned short Line;
        	/**
         	* The fill pattern number of the line
         	*/
        	unsigned short Fill;
        	/**
         	* The beginning line tip number of the line
         	*/
        	unsigned short First;
        	/**
         	* The ending line tip number of the line
         	*/
        	unsigned short Last;
    	} bytes;
    	/**
     	* unknown what this is for or how it is used
     	*
     	* @todo clarify the documentation
     	*/
    	unsigned int bits;
	};
};

// Structure used for drawing lines.  One of these must be filled out
// before drawing the line by calling GetLineStyleStart.
struct TLineContinue {
    wxDC* canvas;
    StyleAttrib style;
    VPoints points;
    int count;
    int allocated;
    int bitmask;

    bool first;
    arRealPoint p1, p2;

    int dx, dy;
    int start, width;
    int slice, numslices;
    bool noPutPixel;
    int invertLine;
};

void Marquis(wxDC& canvas, int x1, int y1, int x2, int y2);
void GetFractalBox(coord x1, coord y1, coord x2, coord y2, double rfact, arRealRect& b);
void FractalLine(wxDC& canvas, coord x1, coord y1, coord x2, coord y2, double rfact, TLineContinue& cont);
void FractalSetSeed(int n);
int GetNumberLineStyles();
int GetNumberLineEndStyles();
TLineContinue GetLineStyleStart(StyleAttrib style);
void DrawLineContinue(wxDC& canvas, coord x1, coord y1, coord x2, coord y2, TLineContinue& cont);
VPoints GetLineEnd(TLineContinue& cont, int& count);
void DrawLineStyle(wxDC& canvas, int x1, int y1, int x2, int y2, StyleAttrib style);
void DrawBezier(wxDC& canvas, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, TLineContinue& cont);
void DrawFractalBezier(wxDC& canvas, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, double rfact, TLineContinue& cont);
void DrawArc(wxDC& canvas, arRealPoint p1, arRealPoint p2, arRealPoint p3, TLineContinue& cont);
void GetArcCenter(arRealPoint p1, arRealPoint p2, arRealPoint p3, coord& x1, coord& y1);
void GetBezierBox(arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, arRealRect& b);
void GetFractalBezierBox(arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, double rfact, arRealRect& b);
int GetLineThickness(StyleAttrib style);
bool IsAComplexLine(StyleAttrib style);
int FixedRandom(int n);
StyleAttrib InvertLineStyle(StyleAttrib style);
bool IsLineStyleInverted(StyleAttrib style);

const StyleAttrib SEGMENT_STYLE={0,{0xFFFFFFFF, -1, 0}};
const int MaxRand = 256*1024;

// Lines styles are all hardcoded: these are the number of each type.
//
// NOTE: If you want to add lines, you must create a new group and
// add those lines to the end.  If you don't do this, you'll end up
// making your files incompatible with other AutoREALM users.  Sorry.
const int number_thick_styles             =  6;
const int number_dithered_styles          =  9;
const int number_glyph_styles             = 41;
const int number_caligraphy_styles        = 12;
const int number_random_styles            = 60;
const int number_numeric_thickness_styles =  1;
const int number_lineends                 = 20;

// start of each style type in the total list.
const int start_thick_style             = 1;
const int start_dithered_style          = start_thick_style      + number_thick_styles;
const int start_glyph_style             = start_dithered_style   + number_dithered_styles;
const int start_caligraphy_style        = start_glyph_style      + number_glyph_styles;
const int start_random_style            = start_caligraphy_style + number_caligraphy_styles;
const int start_numeric_thickness_style = start_random_style     + number_random_styles;

#endif // DRAWLINES_H
