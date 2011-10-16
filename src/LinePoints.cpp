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

#include "LinePoints.h"

/**
 * @todo Optimization: deal with points outside of the viewable area
 *
 * This implementation is a slightly modified version of the one found on
 * http://graphics.lcs.mit.edu/~mcmillan/comp136/Lecture6/Lines.html
 *
 * Windows has a fun little API function called LineDDA. This function has the
 * following prototype:
 *      void LineDDA(int x1, int y1, int x2, int y2, callback, void* data);
 * 
 * (x1,y1) and (x2,y2) are the endpoints of a line segment.
 * The function calculates every point which should be drawn if a straight line
 * is drawn from one point to the other (excluding the exact point (x2,y2)).
 * The callback function is called for each point which should be drawn. It is
 * up to that function to do the actual drawing of the point.
 * 
 * This setup allows some nifty stuff to be done, such as the glyph lines we
 * draw. Unfortunately, wxWidgets (as far as I can tell) does not offer a
 * similar function. That is why this file exists. To provide us Linux people
 * with a nifty feature.
 *
 * LineDDA, if we can trust the name of the function, uses an algorithm known
 * as Digital Differential Analyzer[1]. According to my research, this is one
 * of the SLOWEST algorithms we could use[2]. Unfortunately, the fastest has a
 * non-free license, so we can't use that. The second-fastest, however, has
 * become a textbook case. It is called Wu's Symmetric Double-Step algorithm.
 * I was unable to find anything that would imply we can't use it here. If
 * anyone really objects to it, we can always step back to Bresenham's
 * algoritm.
 *
 * @param (x0,y0) - the first point on the line
 * @param (x1,y1) - the last point on the line. This point isn't actually drawn (to be consistent with the rest of the wx library).
 * @param setPixel - the function which draws the actual point
 * @param data - pointer to program-defined data object, passed to the callback function
 *
 * LinePoints passes dc and data to the callback function.
 * The callback function must have the following prototype. The name callback is a place holder.
 *
 * void callback(int, int, void*);
 *
 * If you want to draw something, make sure to send it in the void* structure.

 */
void LinePoints(int x0, int y0, int x1, int y1, void(*setPixel)(int,int,void*), void* data) {
    int dy = y1 - y0;
    int dx = x1 - x0;
    int stepx, stepy;

    if(dy < 0) {
        dy =  -dy;
        stepy = -1;
    } else {
        stepy = 1;
    }
    if(dx < 0) { 
        dx =  -dx;
        stepx = -1;
    } else {
        stepx = 1;
    }

    (*setPixel)(x0, y0, data);
    // reference draws (x1,y1) here
    if(dx > dy) {
        int length = (dx - 1) >> 2;
        int extras = (dx - 1) & 3;
        int incr2 = (dy << 2) - (dx << 1);
        if(incr2 < 0) {
            int c = dy << 1;
            int incr1 = c << 1;
            int d = incr1 - dx;
            for (int i = 0; i < length; i++) {
                x0 += stepx;
                x1 -= stepx;
                if(d < 0) {
                    // Pattern:
                    // x o o
                    (*setPixel)(x0, y0, data);
                    (*setPixel)(x0 += stepx, y0, data);
                    (*setPixel)(x1, y1, data);
                    (*setPixel)(x1 -= stepx, y1, data);
                    d += incr1;
                } else {
                    if(d < c) {
                        // Pattern:
                        //     o
                        // x o 
                        (*setPixel)(x0, y0, data);
                        (*setPixel)(x0, y0 += stepy, data);
                        (*setPixel)(x1, y1, data);
                        (*setPixel)(x1 -= stepx, y1 -= stepy, data);
                    } else {
                        // Pattern:
                        //   o o
                        // x
                        (*setPixel)(x0, y0 += stepy, data);
                        (*setPixel)(x0 += stepx, y0, data);
                        (*setPixel)(x1, y1 -= stepy, data);
                        (*setPixel)(x1 -= stepx, y1, data);
                    }
                    d += incr2;
                }
            } // end for
            if(extras > 0) {
                if(d < 0) {
                    (*setPixel)(x0 += stepx, y0, data);
                    if(extras > 1) (*setPixel)(x0 += stepx, y0, data);
                    if(extras > 2) (*setPixel)(x1 -= stepx, y1, data);
                } else if(d < c) {
                    (*setPixel)(x0 += stepx, y0, data);
                    if(extras > 1) (*setPixel)(x0 += stepx, y0 += stepy, data);
                    if(extras > 2) (*setPixel)(x1 -= stepx, y1, data);
                } else {
                    (*setPixel)(x0 += stepx, y0 += stepy, data);
                    if(extras > 1) (*setPixel)(x0 += stepx, y0, data);
                    if(extras > 2) (*setPixel)(x1 -= stepx, y1 -= stepy, data);
                }
            } // if(extras > 0)
        } else { // if(incr2 < 0)
            int c = (dy - dx) << 1;
            int incr1 = c << 1;
            int d = incr1 + dx;
            for(int i = 0; i < length; i++) {
                x0 += stepx;
                x1 -= stepx;
                if(d > 0) {
                    // Pattern:
                    //     o
                    //   o
                    // x
                    (*setPixel)(x0, y0 += stepy, data);
                    (*setPixel)(x0 += stepx, y0 += stepy, data);
                    (*setPixel)(x1, y1 -= stepy, data);
                    (*setPixel)(x1 -= stepy, y1 -= stepy, data);
                } else {
                    if(d < c) {
                        // Pattern:
                        //     o
                        // x o
                        (*setPixel)(x0, y0, data);
                        (*setPixel)(x0 += stepx, y0 += stepy, data);
                        (*setPixel)(x1, y1, data);
                        (*setPixel)(x1 -= stepx, y1 -= stepy, data);
                    } else {
                        // Pattern:
                        //   o o
                        // x
                        (*setPixel)(x0, y0 += stepy, data);
                        (*setPixel)(x0 += stepx, y0, data);
                        (*setPixel)(x1, y1 -= stepy, data);
                        (*setPixel)(x1 -= stepx, y1, data);
                    }
                    d += incr2;
                }
            }
            if(extras > 0) {
                if(d > 0) {
                    (*setPixel)(x0 += stepx, y0 += stepy, data);
                    if(extras > 1) (*setPixel)(x0 += stepx, y0 += stepy, data);
                    if(extras > 2) (*setPixel)(x1 -= stepx, y1 -= stepy, data);
                } else if(d < c) {
                    (*setPixel)(x0 += stepx, y0, data);
                    if(extras > 1) (*setPixel)(x0 += stepx, y0 += stepy, data);
                    if(extras > 2) (*setPixel)(x1 -= stepx, y1, data);
                } else {
                    (*setPixel)(x0 += stepx, y0 += stepy, data);
                    if(extras > 1) (*setPixel)(x0 += stepx, y0, data);
                    if(extras > 2) {
                        if(d > c) {
                            (*setPixel)(x1 -= stepx, y1 -= stepy, data);
                        } else { // d == c
                            (*setPixel)(x1 -= stepx, y1, data);
                        }
                    } // extras > 2
                }
            } // extras > 0
        } // if(incr2 < 0) else
    } else { // if(dx > dy)
        int length = (dy - 1) >> 2;
        int extras = (dy - 1) & 3;
        int incr2 = (dx << 2) - (dy << 1);
        if(incr2 < 0) {
            int c = dx << 1;
            int incr1 = c << 1;
            int d = incr1 - dy;
            for(int i = 0; i < length; i++) {
                y0 += stepy;
                y1 -= stepy;
                if(d < 0) {
                    (*setPixel)(x0, y0, data);
                    (*setPixel)(x0, y0 += stepy, data);
                    (*setPixel)(x1, y1, data);
                    (*setPixel)(x1, y1 -= stepy, data);
                    d += incr1;
                } else {
                    if(d < c) {
                        (*setPixel)(x0, y0, data);
                        (*setPixel)(x0 += stepx, y0 += stepy, data);
                        (*setPixel)(x1, y1, data);
                        (*setPixel)(x1 -= stepx, y1 -= stepy, data);
                    } else {
                        (*setPixel)(x0 += stepx, y0, data);
                        (*setPixel)(x0, y0 += stepy, data);
                        (*setPixel)(x1 -= stepx, y1, data);
                        (*setPixel)(x1, y1 -= stepy, data);
                    }
                    d += incr2;
                } // if(d < 0) else
            } // for loop
        } else { // if(incr2 < 0)
            int c = (dx - dy) << 1;
            int incr1 = c << 1;
            int d = incr1 + dy;
            for(int i = 0; i < length; i++) {
                y0 += stepy;
                y1 -= stepy;
                if(d > 0) {
                    (*setPixel)(x0 += stepx, y0, data);
                    (*setPixel)(x0 += stepx, y0 += stepy, data);
                    (*setPixel)(x1 -= stepx, y1, data);
                    (*setPixel)(x1 -= stepx, y1 -= stepy, data);
                } else {
                    if(d < c) {
                        (*setPixel)(x0, y0, data);
                        (*setPixel)(x0 += stepx, y0 += stepy, data);
                        (*setPixel)(x1, y1, data);
                        (*setPixel)(x1 -= stepx, y1 -= stepy, data);
                    } else {
                        (*setPixel)(x0 += stepx, y0, data);
                        (*setPixel)(x0, y0 -= stepy, data);
                        (*setPixel)(x1 -= stepx, y1, data);
                        (*setPixel)(x1, y1 -= stepy, data);
                    }
                    d += incr2;
                } // if(d > 0) else
            } // for
            if(extras > 0) {
                if(d > 0) {
                    (*setPixel)(x0 += stepx, y0 += stepy, data);
                    if(extras > 1) (*setPixel)(x0 += stepx, y0 += stepy, data);
                    if(extras > 2) (*setPixel)(x1 -= stepx, y1 -= stepy, data);
                } else if(d < c) {
                    (*setPixel)(x0, y0 += stepy, data);
                    if(extras > 1) (*setPixel)(x0 += stepx, y0 += stepy, data);
                    if(extras > 2) (*setPixel)(x1, y1 -= stepy, data);
                } else {
                    (*setPixel)(x0 += stepx, y0 += stepy, data);
                    if(extras > 1) (*setPixel)(x0, y0 += stepy, data);
                    if(extras > 2) {
                        if(d > c) {
                            (*setPixel)(x1 -= stepx, y1 -= stepy, data);
                        } else {
                            (*setPixel)(x1, y1 -= stepy, data);
                        }
                    }
                }
            } // if(extras > 0)
        } // if(incr2 < 0) else
    } // if(dx > dy) else 
} //  LinePoints
