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

#define GRAPHGRID_CPP

#include <cmath>
#include <algorithm>

#include "generic_library.h"
#include "globals.h"
#include "GraphGrid.h"
#include "ViewPoint.h"
#include "xmlutils.h"

static wxString className=wxT("GridObject");

/**
 * The scaling of a single cell in the grid.
 */
struct unittype {
    /**
     * The name of this scaling
     */
    wxString name;
    /**
     * The factor for this scaling, relative to one inch (ie: this many
     * cells equals 1 inch in this scaling)
     */
    double factor;
};

/**
 * How many entries are in the UnitTable. If any are to be added, they
 * must be added at the end, and this number incremented accordingly
 */
const int UnitTableLen = 27;
/**
 * The listing of unit scales. Uses unittype and UnitTableLen to get
 * itself laid out correctly.
 */
const unittype UnitTable[UnitTableLen] = {
    {_("Centimeters"),                              0.393700787402},
    {_("Inches"),                                   1.0},
    {_("Feet"),                                     12.0},
    {_("Cubits"),                                   20.6},
    {_("Yards"),                                    36},
    {_("Meters"),                                   39.3700787402},
    {_("Fathoms"),                                  72},
    {_("Rods"),                                     198},
    {_("Chains"),                                   792},
    {_("Furlongs"),                                 7920},
    {_("Kilometers"),                               39370.0787402},
    {_("Stadia"),                                   58291.2},
    {_("Miles"),                                    63360},
    {_("Nautical Miles"),                           72913.3858268},
    {_("Leagues"),                                  190080},
    {_("Days by foot on rugged terrain, burdened"), 316800},
    {_("Days by foot, burdened"),                   633600},
    {_("Days by foot on rugged terrain"),           950400},
    {_("Days by wagon"),                            1267200},
    {_("Days by foot"),                             1584000},
    {_("Days by war horse"),                        1900800},
    {_("Days by oared galley"),                     2217600},
    {_("Days by horse"),                            3168000},
    {_("Days by sailed galley"),                    4118400},
    {_("AU"),                                       5.88968110236E12},
    {_("Light Years"),                              3.72461748224E17},
    {_("Parsecs"),                                  1.21483393144E18},
};

/**
 * The color of the grid. Defaults to Cyan
 */
wxColour CurrentGridColor(wxT("Cyan"));

GridObject::GridObject() {
    wxLogTrace(className, wxT("Entering GridObject"));
    GraphScale = 1.0;
    CurrentGraphUnits = -1;
    CurrentGridSize = 1;
    GraphUnits = wxT("");
    GridType = gtNone;
    GridBoldUnits = 0;
    GridFlags = 0;
    PrimaryGridStyle = gpsDefault;
    SecondaryGridStyle = gpsDefault;
    wxLogTrace(className, wxT("Exiting GridObject"));
}

GridObject::GridObject(GridObject& oldgrid) {
    wxLogTrace(className, wxT("Entering GridObject"));
    GraphScale = oldgrid.GraphScale;
    CurrentGraphUnits = oldgrid.CurrentGraphUnits;
    CurrentGridSize = oldgrid.CurrentGridSize;
    GraphUnits = oldgrid.GraphUnits;
    GridType = oldgrid.GridType;
    GridBoldUnits = oldgrid.GridBoldUnits;
    GridFlags = oldgrid.GridFlags;
    PrimaryGridStyle = oldgrid.PrimaryGridStyle;
    SecondaryGridStyle = oldgrid.SecondaryGridStyle;
    wxLogTrace(className, wxT("Exiting GridObject"));
}

void GridObject::SetMeasurementUnits(int index) {
    wxLogTrace(className, wxT("Entering SetMeasurementUnits"));
	if (index != CurrentGraphUnits) {
        wxLogTrace(className, wxT("GridObject::SetMeasurementUnits: Updating undo records"));
		///@todo Map.SetModified(modUnitType);
        wxLogTrace(className, wxT("GridObject::SetMeasurementUnits: Updating graph units"));
		SetGraphUnits(index, CurrentGridSize);
	}
    wxLogTrace(className, wxT("Exiting SetMeasurementUnits"));
}

void GridObject::SquareGrid(ViewPoint view, wxRect clip, coord left, coord right, coord top, coord bottom, coord width, coord height, int num) {
    wxLogTrace(className, wxT("Entering SquareGrid"));
    int sx, sy;
    coord ox, oy;
	int i;
	coord size;

	size = CurrentGridSize * num;
	wxASSERT(size != 0.0);
	ox = (int)(left/size) * size;
	oy = (int)(top/size) * size;

	for (i=0; i<(int)((width+size)/size)+1; i++) {
		view.CoordToScreen(ox+i*size,0,sx,sy);
        wxLogTrace(className, wxT("GridObject::SquareGrid: DrawLine %d, %d, %d, %d"), sx, clip.GetTop(), sx, clip.GetBottom());
		view.canvas->DrawLine(sx, clip.GetTop(), sx, clip.GetBottom());
	}
	for (i=0; i<(int)((height+size)/size)+1; i++) {
		view.CoordToScreen(0, oy+i*size,sx,sy);
        wxLogTrace(className, wxT("GridObject::SquareGrid: DrawLine %d, %d, %d, %d"), clip.GetLeft(), sy, clip.GetRight(), sy);
		view.canvas->DrawLine(clip.GetLeft(), sy, clip.GetRight(), sy);
	}
    wxLogTrace(className, wxT("Exiting SquareGrid"));
}

void GridObject::HexGrid(ViewPoint view, wxRect clip, coord left, coord right, coord top, coord bottom, coord width, coord height, int num) {
    wxLogTrace(className, wxT("Entering HexGrid"));
    //Draws hex grid with evenly spaced multiples of below pattern:
    //           |              A
    //        .:' ':.         BB FF
    //       |          ==>  C      
    //       |               C      
    //        ':. .:'         DD HH
    //           |              E
    int sx, sy;
    coord ox, oy;
	coord w, h, x, y, size;
	int i, j, w2, hs, s, s2, iw, ih;

	size = CurrentGridSize;
	w = size*sqrt(3);
	h = size*3;
	w *= num;
	h *= num;
    wxASSERT(w!=0);
    wxASSERT(h!=0);
	ox = (int)(left/w)*w;
	oy = (int)(top/h)*h;

    wxASSERT(num!=0);
	view.DeltaCoordToScreen(w/2, size/2*num, w2, hs);
	view.DeltaCoordToScreen(size*num, size*2*num, s, s2);
	view.DeltaCoordToScreen(w, h, iw, ih);
	iw++;

	for (i = -1; i<(int)((width+w)/w)+1; i++) {
		x = i*w + ox;
		for (j = -1; j<(int)((height+h)/h)+1; j++) {
			y = j*h + oy;
			view.CoordToScreen(x,y,sx,sy);
            wxLogTrace(className, wxT("GridObject::HexGrid: DrawLine A: %d, %d, %d, %d"), sx+w2, sy,       sx+w2, sy+hs);
			view.canvas->DrawLine(sx+w2, sy,       sx+w2, sy+hs);		//A
            wxLogTrace(className, wxT("GridObject::HexGrid: DrawLine B: %d, %d, %d, %d"), sx+w2, sy+hs,    sx,    sy+s);
			view.canvas->DrawLine(sx+w2, sy+hs,    sx,    sy+s );		//B
            wxLogTrace(className, wxT("GridObject::HexGrid: DrawLine C: %d, %d, %d, %d"), sx,    sy+s,     sx,    sy+s2);
			view.canvas->DrawLine(sx,    sy+s,     sx,    sy+s2);		//C
            wxLogTrace(className, wxT("GridObject::HexGrid: DrawLine D: %d, %d, %d, %d"), sx,    sy+s2,    sx+w2, sy+ih-hs);
			view.canvas->DrawLine(sx,    sy+s2,    sx+w2, sy+ih-hs);	//D
            wxLogTrace(className, wxT("GridObject::HexGrid: DrawLine E: %d, %d, %d, %d"), sx+w2, sy+ih-hs, sx+w2, sy+ih+1);
			view.canvas->DrawLine(sx+w2, sy+ih-hs, sx+w2, sy+ih+1);		//E
            wxLogTrace(className, wxT("GridObject::HexGrid: DrawLine F: %d, %d, %d, %d"), sx+w2, sy+hs,    sx+iw, sy+s);
			view.canvas->DrawLine(sx+w2, sy+hs,    sx+iw, sy+s);        //F
            wxLogTrace(className, wxT("GridObject::HexGrid: DrawLine H: %d, %d, %d, %d"), sx+iw, sy+s2,    sx+w2, sy+ih-hs);
			view.canvas->DrawLine(sx+iw, sy+s2,    sx+w2, sy+ih-hs);    //H
		}
	}
    wxLogTrace(className, wxT("Exiting HexGrid"));
}

void GridObject::TriangleGrid(ViewPoint view, wxRect clip, coord left, coord right, coord top, coord bottom, coord width, coord height, int num) {
    wxLogTrace(className, wxT("Entering TriangleGrid"));
    // Draws triangular grid with evenly spaced multiples of below pattern:
    //
    //        \  /         B  A
    //        _\/_    ==>   BA
    //         /\          DABD
    //        /  \         A  B
    //        ¯¯¯¯         CCCC
    int sx, sy;
    coord ox, oy;
	coord w, h, x, y, size;
	int i, j, iw, ih;

	w = size = CurrentGridSize;
	h = w * sqrt(3);
	w *= num;
	h *= num;
    wxASSERT(w!=0);
    wxASSERT(h!=0);
	ox = (int)(left/w)*w;
	oy = (int)(top/h)*h;

	view.DeltaCoordToScreen(w, h, iw, ih);

	for (i = -1; i<(int)((width+w)/w)+1; i++) {
		x = i*w+ox;
		for (j = -1; j<(int)((height+h)/h)+1; j++) {
			y = j*h+oy;
			view.CoordToScreen(x,y,sx,sy);

            wxLogTrace(className, wxT("GridObject::TriangleGrid: DrawLine A: %d, %d, %d, %d"), sx+iw, sy,    sx,    sy+ih);
			view.canvas->DrawLine(sx+iw, sy,    sx,    sy+ih); //A
            wxLogTrace(className, wxT("GridObject::TriangleGrid: DrawLine C: %d, %d, %d, %d"), sx,    sy+ih, sx+iw, sy+ih);
			view.canvas->DrawLine(sx,    sy+ih, sx+iw, sy+ih); //C
            wxLogTrace(className, wxT("GridObject::TriangleGrid: DrawLine B: %d, %d, %d, %d"), sx+iw, sy+ih, sx,    sy);
			view.canvas->DrawLine(sx+iw, sy+ih, sx,    sy   ); //B
            wxLogTrace(className, wxT("GridObject::TriangleGrid: DrawLine D: %d, %d, %d, %d"), sx,    (int)(sy+ih)/2, sx+iw, (int)(sy+ih)/2);
			view.canvas->DrawLine(sx,    (int)(sy+ih)/2, sx+iw, (int)(sy+ih)/2); //D
		}
	}
    wxLogTrace(className, wxT("Exiting TriangleGrid"));
}

void GridObject::RotatedHexGrid(ViewPoint view, wxRect clip, coord left, coord right, coord top, coord bottom, coord width, coord height, int num) {
    wxLogTrace(className, wxT("Entering RotatedHexGrid"));
    // Draws hex grid with evenly spaced multiples of below pattern:
    //            ___               BBB
    //           /   \             A   C
    //          /     \___ ==>    A     CDDD
    //          \     /           F     E
    //           \   /             F   E
    int sx, sy;
    coord ox, oy;
	coord w, h, x, y, size;
	int i, j, w2, hs, s, s2, iw, ih;

	size=CurrentGridSize;
	w=size*3;
	h=size*sqrt(3);
	w *= num;
	h *= num;
    wxASSERT(w!=0);
    wxASSERT(h!=0);
	ox = (int)(left/w)*w;
	oy = (int)(top/h)*h;

	view.DeltaCoordToScreen(w/2, h/2, w2, hs);
	view.DeltaCoordToScreen(size*num, (size*num)/2, s, s2);
	view.DeltaCoordToScreen(w, h, iw, ih);
	iw++;

	for (i = -1; i<(int)((width+w)/w)+1; i++) {
		x = i*w + ox;
		for (j = -1; j<(int)((height+h)/h)+1; j++) {
			y = j*h - (h/2) + oy;
			view.CoordToScreen(x, y, sx, sy);
            wxLogTrace(className, wxT("GridObject::RotatedHexGrid: DrawLine A: %d, %d, %d, %d"), sx,       sy+hs, sx+s2,    sy);
			view.canvas->DrawLine(sx,       sy+hs, sx+s2,    sy);   	//A
            wxLogTrace(className, wxT("GridObject::RotatedHexGrid: DrawLine B: %d, %d, %d, %d"), sx+s2,    sy,    sx+w2,    sy);
			view.canvas->DrawLine(sx+s2,    sy,    sx+w2,    sy);		//B
            wxLogTrace(className, wxT("GridObject::RotatedHexGrid: DrawLine C: %d, %d, %d, %d"), sx+w2,    sy,    sx+w2+s2, sy+hs);
			view.canvas->DrawLine(sx+w2,    sy,    sx+w2+s2, sy+hs);	//C
            wxLogTrace(className, wxT("GridObject::RotatedHexGrid: DrawLine D: %d, %d, %d, %d"), sx+w2+s2, sy+hs, sx+iw,    sy+hs);
			view.canvas->DrawLine(sx+w2+s2, sy+hs, sx+iw,    sy+hs);	//D
            wxLogTrace(className, wxT("GridObject::RotatedHexGrid: DrawLine E: %d, %d, %d, %d"), sx+w2+s2, sy+hs, sx+w2,    sy+ih);
			view.canvas->DrawLine(sx+w2+s2, sy+hs, sx+w2,    sy+ih);	//E
            wxLogTrace(className, wxT("GridObject::RotatedHexGrid: DrawLine F: %d, %d, %d, %d"), sx,       sy+hs, sx+s2,    sy+ih);
			view.canvas->DrawLine(sx,       sy+hs, sx+s2,    sy+ih);    //F
		}
	}
    wxLogTrace(className, wxT("Exiting RotatedHexGrid"));
}

void GridObject::DiamondGrid(ViewPoint view, wxRect clip, coord left, coord right, coord top, coord bottom, coord width, coord height, int num, float squash) {
    wxLogTrace(className, wxT("Entering DiamondGrid"));
	/* Draws diamond grid (rotated square grid).  Squash is the height
     * factor: 1.0 draws a square grid (albeit rotated 45 degrees),
     * where 0.5 draws a grid where the vertical diagonal is half the
     * horizontal diagonal.
     */
    int sx, sy, vx, vy, vx2, vy2;
    coord ox, oy;
	coord size, w, h;
	int i, nw, nh;

	if (top != bottom) {
		size = CurrentGridSize*num;
		w = size * sqrt(2);
		h = size * sqrt(2) * squash;
	
		// Get us coordinates one square over each edge,
		// snapped to the underlying grid.
        wxASSERT(w!=0);
        wxASSERT(h!=0);
		ox = (int)((left-w)/w)*w;
		oy = (int)((top-h)/h)*h;
	
		// Using +1 over width/height of clip rectangle is good enough,
		// for a full screen, but use +2 for cases when our clip rectangle
		// is an odd small size, and we need just a little extra overdraw
		nw = (int)((width+w)/w)+2;
		nh = (int)((height+h)/h)+2;
	
		// Horizontally:
		// Do "inverted V" lines from the bottom right to the middle top,
		// to the bottom left.
		//          +------+
		// I.e.     |/xxx\ |
		//          |//x\\\|
		//          |// \\\|
		//          +------+
		for (i=0; i<nw+2; i++) {
			view.CoordToScreen(ox+(i+nh)*w, oy+nh*h, sx, sy);
			view.CoordToScreen(ox+i*w, oy, vx, vy);
			view.CoordToScreen(ox, oy+i*h, vx2, vy2);
            wxLogTrace(className, wxT("GridObject::DiamondGrid: DrawLine A: %d, %d, %d, %d"), sx, sy, vx, vy);
			view.canvas->DrawLine(sx, sy, vx, vy);
            wxLogTrace(className, wxT("GridObject::DiamondGrid: DrawLine B: %d, %d, %d, %d"), vx, vy, vx2, vy2);
			view.canvas->DrawLine(vx, vy, vx2, vy2);
		}
	
		// Vertically:
		// Do lines from the left edge to the bottom to fill in the remaining
		// grid lines on the left
		//          +------+
		// I.e.     |\     |
		//          |\\    |
		//          |\\\   |
		//          +------+
		for (i=1; i<nh+1; i++) {
			view.CoordToScreen(ox, oy+i*h, sx, sy);
			view.CoordToScreen(ox+(nw+1)*w, oy+(nw+i+1)*h, vx, vy);
            wxLogTrace(className, wxT("GridObject::DiamondGrid: DrawLine C: %d, %d, %d, %d"), sx, sy, vx, vy);
			view.canvas->DrawLine(sx, sy, vx, vy);
		}

		// Vertically:
		// Do lines from the right edge to the bottom to fill in the remaining
		// grid lines on the right
		//          +------+
		// I.e.     |     /|
		//          |    //|
		//          |   ///|
		//          +------+
		for (i=2; i<nh+1; i++) {
			view.CoordToScreen(ox+(nw+1)*w, oy+i*h, sx, sy);
			view.CoordToScreen(ox+(nw+1-nh+i)*w, oy+nh*h, vx, vy);
            wxLogTrace(className, wxT("GridObject::DiamondGrid: DrawLine D: %d, %d, %d, %d"), sx, sy, vx, vy);
			view.canvas->DrawLine(sx, sy, vx, vy);
		}
	}
    wxLogTrace(className, wxT("Exiting DiamondGrid"));
}

void GridObject::PolarGrid(ViewPoint view, wxRect clip, coord left, coord right, coord top, coord bottom, coord width, coord height, int num) {
    wxLogTrace(className, wxT("Entering PolarGrid"));
	const int sectors=256;
    int sx, sy;
	int cx, cy;
    coord ox, oy;
	coord size, x, y, radius;
	int ix, iy, innerring, i;

	size = CurrentGridSize*num;

	cx = (int)(left + (width/2));
	cy = (int)(top + (height/2));

	// Figure out how far we need to draw outwards
	radius = std::max(std::abs(top), std::abs(bottom));
	radius = std::max(radius, std::abs(left));
	radius = std::max(radius, std::abs(right));

	// Include a little fudge factor to account for screen diagonal
	radius *= 1.5;
    wxLogTrace(className, wxT("GridObject::PolarGrid: radius=%d, cx=%d, cy=%d"), (int)radius, cx, cy);

	view.canvas->SetBrush(*wxTRANSPARENT_BRUSH);

	for (i=0; i<(int)((radius+size)/size)+1; i++) {
        wxLogTrace(className, wxT("GridObject::PolarGrid: %d, %d, %d"), cx, cy, (int)radius);
		view.canvas->DrawCircle(cx, cy, (int)radius);
	}

	for (i=0; i<sectors; i++) {
		// The inner edge depends on which part of the line
		// it is: we let some of the lines go all the way
		// to the center, whereas others get stopped on the
		// way out.  Basically, we let 4 into the center ring,
		// and 4* as many for each nextmost ring.
		if ((i % (sectors / 4)) == 0) {
			innerring = 0;
		} else if ((i % (sectors / 16)) == 0) {
			innerring = 1;
		} else if ((i % (sectors / 64)) == 0) {
			innerring = 2;
		} else if ((i % (sectors / 128)) == 0) {
			innerring = 3;
		} else {
			innerring = 4;
		}
		x = (size * innerring) * cos(2*M_PI*(i/sectors));
		y = (size * innerring) * sin(2*M_PI*(i/sectors));
		view.CoordToScreen(x, y, sx, sy);

		// This is the outer edge
		x = radius * cos(2*M_PI*(i/sectors));
		y = radius * sin(2*M_PI*(i/sectors));
		view.CoordToScreen(x, y, ix, iy);
        wxLogTrace(className, wxT("GridObject::PolarGrid: innerring=%d, DrawLine #%d: %d, %d, %d, %d"), innerring, i, sx, sy, ix, iy);
		view.canvas->DrawLine(sx, sy, ix, iy);
	}
    wxLogTrace(className, wxT("Exiting PolarGrid"));
}

void GridObject::DrawGrid(ViewPoint& v) {
    wxLogTrace(className, wxT("Entering DrawGrid"));
    wxColour oldcolor;
    int sx, sy;
    coord ox, oy;
    coord left, top, right, bottom, width, height;
    wxPen pen;
    wxRect clip;
    
    if (GridType != gtNone) {
        wxASSERT(v.canvas != NULL);
        pen = v.canvas->GetPen();
        oldcolor = pen.GetColour();
        pen.SetColour(CurrentGridColor);
        v.canvas->SetPen(pen);
        v.canvas->GetClippingBox(clip);
        v.ScreenToCoord(clip.GetLeft(), clip.GetTop(), left, top);
        v.ScreenToCoord(clip.GetRight(), clip.GetBottom(), right, bottom);
        width = right-left+1;
        height = bottom-top+1;
        wxLogTrace(className, wxT("GridObject::DrawGrid: left=%f, right=%f, top=%f, bottom=%f, width=%f, height=%f"),
                left, right, top, bottom, width, height);
        
        SetGridPenStyle(v.canvas, PrimaryGridStyle, gpsSingle);

        switch (GridType) {
            case gtSquare:
                SquareGrid(v, clip, left, right, top, bottom, width, height, 1);
                break;
            case gtHex:
                HexGrid(v, clip, left, right, top, bottom, width, height, 1);
                break;
            case gtTriangle:
                TriangleGrid(v, clip, left, right, top, bottom, width, height, 1);
                break;
            case gtRotatedHex:
                RotatedHexGrid(v, clip, left, right, top, bottom, width, height, 1);
                break;
            case gtDiamond:
                DiamondGrid(v, clip, left, right, top, bottom, width, height, 1, 1.0);
                break;
            case gtHalfDiamond:
                DiamondGrid(v, clip, left, right, top, bottom, width, height, 1, 0.5);
                break;
            case gtPolar:
                PolarGrid(v, clip, left, right, top, bottom, width, height, 1);
                break;
        }

        if (GridBoldUnits != 0) {
            SetGridPenStyle(v.canvas, SecondaryGridStyle, gpsBold);

            switch (GridType) {
                case gtSquare:
                    SquareGrid(v, clip, left, right, top, bottom, width, height, GridBoldUnits);
                    break;
                case gtHex:
                    HexGrid(v, clip, left, right, top, bottom, width, height, GridBoldUnits);
                    break;
                case gtTriangle:
                    TriangleGrid(v, clip, left, right, top, bottom, width, height, GridBoldUnits);
                    break;
                case gtRotatedHex:
                    RotatedHexGrid(v, clip, left, right, top, bottom, width, height, GridBoldUnits);
                    break;
                case gtDiamond:
                    DiamondGrid(v, clip, left, right, top, bottom, width, height, GridBoldUnits, 1.0);
                    break;
                case gtHalfDiamond:
                    DiamondGrid(v, clip, left, right, top, bottom, width, height, GridBoldUnits, 0.5);
                    break;
                case gtPolar:
                    PolarGrid(v, clip, left, right, top, bottom, width, height, GridBoldUnits);
                    break;
            }
        }
        pen.SetWidth(1);
        pen.SetColour(oldcolor);
        v.canvas->SetPen(pen);
    }
    wxLogTrace(className, wxT("Exiting DrawGrid"));
}

void GridObject::SetGraphUnits(int index, int gridSize) {
    wxLogTrace(className, wxT("Entering SetGraphUnits"));
	wxASSERT(gridSize > 0);
	wxASSERT((CurrentGraphUnits < UnitTableLen) && (CurrentGraphUnits >= -1));
	wxASSERT((index < UnitTableLen) && (index >= 0));
	wxASSERT(UnitTable[index].factor > 0.0);

	// index == -1 lets us reset the scale for a different base unit
	if (index != -1) {
        wxLogTrace(className, wxT("GridObject::SetGraphUnits: index = %d"), index);
		if (CurrentGraphUnits != -1) {
            wxLogTrace(className, wxT("GridObject::SetGraphUnits: CurrentGraphUnits = %d, inverting"), CurrentGraphUnits);
			GraphUnitConvert = 1/gridSize;
		} else {
            wxLogTrace(className, wxT("GridObject::SetGraphUnits: CurrentGraphUnits = %d, re-scaling"), CurrentGraphUnits);
			GraphUnitConvert *= (CurrentGridSize * UnitTable[CurrentGraphUnits].factor);
			GraphUnitConvert /= (gridSize * UnitTable[index].factor);
		}
		
		GraphUnits = UnitTable[index].name;
	}

	CurrentGraphUnits = index;
	CurrentGridSize   = gridSize;

	wxASSERT((CurrentGraphUnits < UnitTableLen) && (CurrentGraphUnits >= -1));
	wxASSERT(CurrentGridSize > 0);
    wxLogTrace(className, wxT("Exiting SetGraphUnits"));
}

void SaveGridStyle(const wxString& name, const GridPenStyle& gps, wxXmlNode& e) {
    switch (gps) {
        case gpsDefault   : e.AddChild(newElWithChild(name, wxT("DEFAULT")));
                            break;
        case gpsSingle    : e.AddChild(newElWithChild(name, wxT("SINGLE")));
                            break;
        case gpsDot       : e.AddChild(newElWithChild(name, wxT("DOT")));
                            break;
        case gpsDash      : e.AddChild(newElWithChild(name, wxT("DASH")));
                            break;
        case gpsDashDot   : e.AddChild(newElWithChild(name, wxT("DASHDOT")));
                            break;
        case gpsDashDotDot: e.AddChild(newElWithChild(name, wxT("DASHDOTDOT")));
                            break;
        case gpsBold      : e.AddChild(newElWithChild(name, wxT("BOLD")));
                            break;
        default           : e.AddChild(newElWithChild(name, wxT("DEFAULT")));
                            break;
    }
}

wxXmlNode GridObject::GetAsDOMElement(wxXmlDocument& D) {
    wxLogTrace(className, wxT("Entering GetAsDOMElement"));
    wxString val;
    wxXmlNode E(wxXML_ELEMENT_NODE, wxT("GRIDOBJECT"));

    val.Printf(wxT("%f"), GraphScale);
    E.AddChild(newElWithChild(wxT("GRAPH_SCALE"), val));

    val.Printf(wxT("%f"), GraphUnitConvert);
    E.AddChild(newElWithChild(wxT("GRAPH_UNIT_CONVERT"), val));

    switch (GridType) {
        case gtNone        : val=wxT("NONE");        break;
        case gtSquare      : val=wxT("SQUARE");      break;
        case gtHex         : val=wxT("HEX");         break;
        case gtTriangle    : val=wxT("TRIANGLE");    break;
        case gtRotatedHex  : val=wxT("ROTATEDHEX");  break;
        case gtDiamond     : val=wxT("DIAMOND");     break;
        case gtHalfDiamond : val=wxT("HALFDIAMOND"); break;
        case gtPolar       : val=wxT("POLAR");       break;
        default            : val=wxT("NONE");        break;
    }
    E.AddChild(newElWithChild(wxT("TYPE"), val));

    val.Printf(wxT("%d"), CurrentGridSize);
    E.AddChild(newElWithChild(wxT("CURRENT_SIZE"), val));

    val.Printf(wxT("%d"), GridBoldUnits);
    E.AddChild(newElWithChild(wxT("BOLD_UNITS"), val));

    val.Printf(wxT("%d"), GridFlags);
    E.AddChild(newElWithChild(wxT("FLAGS"), val));

    val.Printf(wxT("%d"), GridPosition);
    E.AddChild(newElWithChild(wxT("POSITION"), val));

    val.Printf(wxT("%d"), CurrentGraphUnits);
    E.AddChild(newElWithChild(wxT("CURRENT_GRAPH_UNITS"), val));

    E.AddChild(newElWithChild(wxT("GRAPH_UNITS"), GraphUnits));

    SaveGridStyle(wxT("PRIMARY_STYLE"), PrimaryGridStyle, E);
    SaveGridStyle(wxT("SECONDARY_STYLE"), SecondaryGridStyle, E);
    wxLogTrace(className, wxT("Exiting GetAsDOMElement"));

    return(E);
}

GridPenStyle LoadGridStyle(const wxString& name) {
    GridPenStyle style;
    wxString s = name;
    s = s.MakeUpper().Trim(true).Trim(false);
    if (s.CompareTo(wxT("DEFAULT")) == 0) {
        style = gpsDefault;
    } else if (s.CompareTo(wxT("SINGLE")) == 0) {
        style = gpsSingle;
    } else if (s.CompareTo(wxT("DOT")) == 0) {
        style = gpsDot;
    } else if (s.CompareTo(wxT("DASH")) == 0) {
        style = gpsDash;
    } else if (s.CompareTo(wxT("DASHDOT")) == 0) {
        style = gpsDashDot;
    } else if (s.CompareTo(wxT("DASHDOTDOT")) == 0) {
        style = gpsDashDotDot;
    } else if (s.CompareTo(wxT("BOLD")) == 0) {
        style = gpsBold;
    } else {
        style = gpsDefault;
    }
    return(style);
}

void GridObject::LoadFromDOMElement(const wxXmlNode& e) {
    wxLogTrace(className, wxT("Entering LoadFromDOMElement"));
    wxXmlNode* el;
    wxString s;

    el = findNamedChild(wxT("GRAPH_SCALE"), e);
    if (el != NULL) { GraphScale = getElContentd(el); }

    el = findNamedChild(wxT("GRAPH_UNIT_CONVERT"), e);
    if (el != NULL) { GraphUnitConvert = getElContentd(el); }

    el = findNamedChild(wxT("TYPE"), e);
    if (el != NULL) {
        s = getElContents(el).MakeUpper().Trim(true).Trim(false);
        if (s.CompareTo(wxT("NONE")) == 0) {
            GridType = gtNone;
        } else if (s.CompareTo(wxT("SQUARE")) == 0) {
            GridType = gtSquare;
        } else if (s.CompareTo(wxT("HEX")) == 0) {
            GridType = gtHex;
        } else if (s.CompareTo(wxT("TRIANGLE")) == 0) {
            GridType = gtTriangle;
        } else if (s.CompareTo(wxT("ROTATEDHEX")) == 0) {
            GridType = gtRotatedHex;
        } else if (s.CompareTo(wxT("DIAMOND")) == 0) {
            GridType = gtDiamond;
        } else if (s.CompareTo(wxT("HALFDIAMOND")) == 0) {
            GridType = gtHalfDiamond;
        } else if (s.CompareTo(wxT("POLAR")) == 0) {
            GridType = gtPolar;
        } else {
            GridType = gtNone;
        }
    }

    el = findNamedChild(wxT("CURRENT_SIZE"), e);
    if (el != NULL) { CurrentGridSize = getElContentl(el); }

    el = findNamedChild(wxT("BOLD_UNITS"), e);
    if (el != NULL) { GridBoldUnits = getElContentl(el); }

    el = findNamedChild(wxT("FLAGS"), e);
    if (el != NULL) { GridFlags = getElContentl(el); }

    el = findNamedChild(wxT("POSITION"), e);
    if (el != NULL) { GridPosition = getElContentl(el); }

    el = findNamedChild(wxT("CURRENT_GRAPH_UNITS"), e);
    if (el != NULL) { CurrentGraphUnits = getElContentl(el); }

    el = findNamedChild(wxT("GRAPH_UNITS"), e);
    if (el != NULL) { GraphUnits = getElContents(el); }

    el = findNamedChild(wxT("PRIMARY_STYLE"), e);
    if (el != NULL) { PrimaryGridStyle = LoadGridStyle(getElContents(el)); }

    el = findNamedChild(wxT("SECONDARY_STYLE"), e);
    if (el != NULL) { SecondaryGridStyle = LoadGridStyle(getElContents(el)); }

    wxLogTrace(className, wxT("Exiting LoadFromDOMElement"));
}

void GridObject::LoadFromStream(wxFileInputStream& ins, int version) {
    wxLogTrace(className, wxT("Entering LoadFromStream"));
    GraphScale = ReadDoubleFromBinaryStream(ins);
    GraphUnitConvert = ReadDoubleFromBinaryStream(ins);
    GraphUnits = ReadStringFromBinaryStream(ins);
    CurrentGraphUnits = ReadIntFromBinaryStream(ins);
    CurrentGridSize = ReadIntFromBinaryStream(ins);
    GridType = (TGraphGrid)ReadByteFromBinaryStream(ins);
    GridBoldUnits = ReadIntFromBinaryStream(ins);

    // GridFlags was a 32-bit integer.  Now it is 16 bits,
    // and we make sure the grid styles are one byte each
    // so we haven't changed the file format.  Note that the
    // flags were also zero in the high two bytes because
    // no flags were defined there, and 0 is also our
    // default.  Happy "coincidence", huh?
    PrimaryGridStyle = gpsDefault;   // Clear these out since we only read in a byte;
    SecondaryGridStyle = gpsDefault; // Don't want the upper 3 bytes filled with garbage
    GridFlags = ReadByteFromBinaryStream(ins);
    // 2003/05/29 - J.Friant
    // Since we still don't need 65k flags (I believe we're
    // only using 1[!]) I'm going to split GridFlags again!
    // Also the grid position should not be affected, since
    // the only flag we've used so far is 0x01
    //
    // 2003/12/08 - J.Friant
    // BUG WORK-AROUND: This function is called by
    // MapSettingsClick in addition to the routines for loading
    // a file, so it can mess up the GridPosition by reseting
    // it to the byte max of 255 when we really want a larger
    // value...  so we'll check to make sure the value is within
    // the expected range for a byte or just leave it alone    
    if (GridPosition <= 255) {
        GridPosition = 0;
        GridPosition = ReadByteFromBinaryStream(ins);
    }
    PrimaryGridStyle = (GridPenStyle)ReadByteFromBinaryStream(ins);
    SecondaryGridStyle = (GridPenStyle)ReadByteFromBinaryStream(ins);
    wxLogTrace(className, wxT("Exiting LoadFromStream"));
}

void GridObject::FillPopupMenu(wxMenu& Menu, wxCommandEventFunction* action) {
    wxLogTrace(className, wxT("Entering FillPopupMenu"));
    int i;
    for (i=0; i<UnitTableLen; i++) {
        wxLogTrace(className, wxT("GridObject::FillPopupMenu: Appending %s"), UnitTable[i].name.c_str());
        Menu.AppendCheckItem(wxID_HIGHEST+i, UnitTable[i].name);
        ///@todo Verify that this Menu.Connect call is correct, it may have
        //a bug in it.
        wxLogTrace(className, wxT("GridObject::FillPopupMenu: Connecting %s"), UnitTable[i].name.c_str());
        Menu.Connect(wxID_HIGHEST+1, wxEVT_COMMAND_MENU_SELECTED, (wxObjectEventFunction) (wxEventFunction) (wxCommandEventFunction) *action);
    }
    wxLogTrace(className, wxT("Exiting FillPopupMenu"));
}

void GridObject::SetMeasurementUnitChecks(wxMenu& Menu) {
    wxLogTrace(className, wxT("Entering SetMeasurementUnitChecks"));
    int i, numitems;
    numitems = Menu.GetMenuItemCount();
    wxASSERT(numitems == UnitTableLen);
    for (i=0; i<numitems; i++) {
        wxLogTrace(className, wxT("GridObject::SetMeasurementUnitChecks: Checking %s"), UnitTable[i].name.c_str());
        Menu.Check(wxID_HIGHEST+i, i==CurrentGraphUnits ? true : false);
    }
    wxLogTrace(className, wxT("Exiting SetMeasurementUnitChecks"));
}

void GridObject::FillComboList(wxComboBox& UnitComboBox) {
    wxLogTrace(className, wxT("Entering FillComboList"));
    wxLogTrace(className, wxT("GridObject::FillComboList: Clearing combo box"));
    UnitComboBox.Clear();
    for (int i=0; i<UnitTableLen; i++) {
        wxLogTrace(className, wxT("GridObject::FillComboList: Appending %s"), UnitTable[i].name.c_str());
        UnitComboBox.Append(UnitTable[i].name);
    }
    wxLogTrace(className, wxT("Exiting FillComboList"));
}

double GridObject::Convert(double dist, int unitindex) {
    wxLogTrace(className, wxT("Entering Convert"));
    wxASSERT(GraphScale != 0.0);
    wxASSERT((CurrentGraphUnits >= 0) && (CurrentGraphUnits < UnitTableLen));
    wxASSERT(UnitTable[CurrentGraphUnits].factor != 0.0);
    wxASSERT((unitindex >= 0) && (unitindex < UnitTableLen));
    return ((dist / GraphScale) * CurrentGridSize * UnitTable[unitindex].factor/UnitTable[CurrentGraphUnits].factor);
    wxLogTrace(className, wxT("Exiting Convert"));
}

void GridObject::SetGridPenStyle(wxDC* canvas, GridPenStyle style, GridPenStyle defaultstyle) {
    wxLogTrace(className, wxT("Entering SetGridPenStyle"));
    wxPen pen;
    wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Initializing dashes array"));
    wxDash dashes[6] = {3,2,1,2,1,2};
    if (style == gpsDefault) {
        style = defaultstyle;
    }

    switch (style) {
        case gpsDefault: 
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Using gpsDefault"));
            pen=canvas->GetPen();
            pen.SetStyle(wxTRANSPARENT);
            canvas->SetPen(pen);
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Done!"));
            break;
        case gpsSingle:
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Using gpsSingle"));
            pen=canvas->GetPen();
            pen.SetWidth(1);
            pen.SetStyle(wxSOLID);
            canvas->SetPen(pen);
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Done!"));
            break;
        case gpsDot:
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Using gpsDot"));
            pen=canvas->GetPen();
            pen.SetWidth(1);
            pen.SetStyle(wxDOT);
            canvas->SetPen(pen);
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Done!"));
            break;
        case gpsDash:
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Using gpsDash"));
            pen=canvas->GetPen();
            pen.SetWidth(1);
            pen.SetStyle(wxSHORT_DASH);
            canvas->SetPen(pen);
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Done!"));
            break;
        case gpsDashDot:
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Using gpsDashDot"));
            pen=canvas->GetPen();
            pen.SetWidth(1);
            pen.SetStyle(wxDOT_DASH);
            canvas->SetPen(pen);
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Done!"));
            break;
        case gpsDashDotDot:
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Using gpsDashDotDot"));
            pen=canvas->GetPen();
            pen.SetWidth(1);
            pen.SetDashes(6, dashes);
            canvas->SetPen(pen);
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Done!"));
            break;
        case gpsBold:
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Using gpsBold"));
            pen=canvas->GetPen();
            pen.SetWidth(3);
            pen.SetStyle(wxSOLID);
            canvas->SetPen(pen);
            wxLogTrace(className, wxT("GridObject::SetGridPenStyle: Done!"));
            break;
    }
    wxLogTrace(className, wxT("Exiting SetGridPenStyle"));
}

void GridObject::bringGridForward() {
    wxLogTrace(className, wxT("Entering bringGridForward"));
    // an side-effect of GridPosition being typed as unsigned
    // is that if the user tries to send the grid further forward
    // than MAXINT they'll end up at the maximum distance in back.
    // It shouldn't cause any problems though.
    GridPosition++;
    wxLogTrace(className, wxT("Exiting bringGridForward"));
}

void GridObject::sendGridBackward() {
    wxLogTrace(className, wxT("Entering sendGridBackward"));
    // an side-effect of GridPosition being typed as unsigned
    // is that if the user tries to send the grid further back
    // than 0 they'll end up at the maximum distance in front.
    // It shouldn't cause any problems though.
    GridPosition--;
    wxLogTrace(className, wxT("Exiting sendGridBackward"));
}

int GridObject::getGridPosition() {
    wxLogTrace(className, wxT("Entering getGridPosition"));
    wxLogTrace(className, wxT("Exiting getGridPosition"));
    return(GridPosition);
}

double GridObject::GetUnitLength() {
    return(GraphScale*GraphUnitConvert*CurrentGridSize);
}
