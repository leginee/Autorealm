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

#include <memory>
#include <wx/palette.h>
#include "Primitives.h"
#include "generic_library.h"
#include "maputils.h"
#include "types.h"

const static wxString className(wxT("Primitives"));

coord LastHandleX, LastHandleY;
///@todo Conflicts with definition in Primitives.h. Which is right? wxPalette FillPalette;

/**
 * Starting at the line segment represented by points at I and I + Step,
 * this routine tries to get the average angle by looking at the previous
 * two and next two line segments if possible.
 *
 * @param i The point index
 * @param start The index of the first point in the list.  For the first
 * side of the "envelope" this should be 0, and for the next side it
 * should be count - 1.
 * @param last The index of the last point in the list.  For the first
 * side of the "envelope" this should be count - 1, and for the next side
 * it should be 0.
 * @param step This should be 1 for the first side of the "envelope" and
 * -1 for the next side.
 * @param closed This shows whether or not the figure is a close figure
 * @param points The list of points which make up the line
 *
 * @return Returns the average angle (which represents the average slope
 * of the line segment) in radians.
 */
double GetAverageAngle(int i, int start, int last, int step, bool closed, VPoints points) {
    int j, i0, i1;
    coord x, y, x1, y1, x2, y2;
    double angle;

    i0 = i - (2 * step);
    if (step > 0) {
        if (closed) {
            if (i0 < start) {
                i0 = last + step - start - 10;
            }
            i1 = i0 + 5 * step;
            if (i1 > last + step) {
                i1 = start + (i1 - (last + step));
            }
        } else {
            if (i0 < start) {
                i0 = start;
            }
            i1 = i0 + 5 * step;
            if (i1 > last + step) {
                i1 = last + step;
            }
        }
    } else {
        if (closed) {
            if (i0 > start) {
                i0 = last + step + (i0 - start);
            }
            i1 = i0 + 5 * step;
            if (i1 < last + step) {
                i1 = start - ((last + step) - i1);
            }
        } else {
            if (i0 > start) {
                i0 = start;
            }
            i1 = i0 + 5 * step;
            if (i1 < last + step) {
                i1 = last + step;
            }
        }
    }
    i = i0;
    angle = x = y = 0;
    while ((i != i1) && (i + step != i1)) {
        j = i + step;
        if (closed && (j = last + step)) {
            j = start;
        }
        x1 = points[i].x;
        y1 = points[i].y;
        x2 = points[j].x;
        y2 = points[j].y;
        x += (x2 - x1);
        y += (y2 - y1);
        i = j;
    }
    if ((x != 0) || (y != 0)) {
        angle = atan2(y, x);
    }
    return (angle);
}

/**
 *
 * For a given point whose index is I, this routine calculates the next
 * appropriate point in the object's "envelope" and adds it to the point list.
 *
 * @param i The point index
 *
 * @param start The index of the first point in the list.  For thefirst side of
 * the "envelope" this should be 0, and for the next side it should be count-1.
 *
 * @param last The index of the last point in the list.  For the first side of
 * the "envelope" this should be count - 1, and for the next side it should be
 * 0.
 *
 * @param step This should be 1 for the first side of the "envelope" and -1 for
 * the next side.
 *
 * @param points The list of points which make up the line
 */
void Calc(int& i, int start, int last, int step, const VPoints& points,
        double& angle1, double& angle2, double& angle4, double& xofs1,
        double& xofs2, double& yofs1, double& yofs2, coord& x1, coord& y1,
        coord& x2, coord& y2, coord& x3, coord& y3, bool GetAverageSlope,
        bool ThickEnds, bool Closed, int& k, VPoints& ThickPoints,
        double& Thickness) {
    double scale1, scale2;
    x1 = points[i].x;
    y1 = points[i].y;
    if (i != last) {
        x2 = points[i+step].x;
        y2 = points[i+step].y;
        angle1 = atan2(y2-y1, x2-x1);
    } else {
        x2 = x1;
        y2 = y1;
        angle1 = 0;
    }
    if ((i != last) && (i + step != last)) {
        x3 = points[i+step*2].x;
        y3 = points[i+step*2].y;
        angle2 = atan2(y3-y2, x3-x2);
    } else {
        x3 = x2;
        y3 = y2;
        angle2 = angle1;
    }

    if (GetAverageSlope) {
        angle1 = GetAverageAngle(i, start, last, step, Closed, points);
        angle2 = GetAverageAngle(i+step, start, last, step, Closed, points);
    }

    if (ThickEnds) {
        if (Closed) {
            xofs1 = Thickness * cos(angle1-3*(M_PI / 4)) * sqrt(2);
            yofs1 = Thickness * sin(angle1-3*(M_PI / 4)) * sqrt(2);
            xofs2 = Thickness * cos(angle2-  (M_PI / 4)) * sqrt(2);
            yofs2 = Thickness * sin(angle2-  (M_PI / 4)) * sqrt(2);
        } else {
            xofs1 = Thickness * cos(angle1-3*(M_PI / 4)) * sqrt(2);
            yofs1 = Thickness * sin(angle1-3*(M_PI / 4)) * sqrt(2);
            xofs2 = Thickness * cos(angle1-  (M_PI / 4)) * sqrt(2);
            yofs2 = Thickness * sin(angle1-  (M_PI / 4)) * sqrt(2);
        }
    } else {
        if (Closed) {
            xofs1 = Thickness * cos(angle1 - (M_PI/2));
            yofs1 = Thickness * sin(angle1 - (M_PI/2));
            xofs1 = Thickness * cos(angle2 - (M_PI/2));
            yofs1 = Thickness * sin(angle2 - (M_PI/2));
        } else {
            xofs1 = Thickness * cos(angle1 - (M_PI/2));
            yofs1 = Thickness * sin(angle1 - (M_PI/2));
            xofs1 = Thickness * cos(angle1 - (M_PI/2));
            yofs1 = Thickness * sin(angle1 - (M_PI/2));
        }
    }

    // Handle the very first point

    if (i == start) {
        ThickPoints[k].x = x1+xofs1;
        ThickPoints[k].y = y1+yofs1;
        k++;
    }

    // The last point is a special case
    if ((i==last) || (i == last-step)) {
        ThickPoints[k].x = x2+xofs2;
        ThickPoints[k].y = y2+yofs2;
        k++;
        i = last+step; // we're done: push the point index past the end;
    } else {
        // important to force the angles positive or the averaging doesn't work right

        while (angle1 < 0) {angle1 += 2*M_PI;};
        while (angle2 < 0) {angle2 += 2*M_PI;};

        // We form the envelope by first getting the average angle between
        // the two segments (note that their angles might in fact be the average
        // angle in their local area).

        angle4 = (angle1 + angle2) / 2;

        // because the angles will differ, we have to rescale the thickness to
        // keep the overall thickness constant

        scale1 = cos(angle4 - angle1);
        scale2 = cos(angle4 - angle2);
        
        if (scale2 < scale1) { scale1 = scale2; }
        scale1 = scale1 != 0 ? 1/scale1 : 1;

        // calculate the envelope point and add it to the list
        
        ThickPoints[k].x = x2 + Thickness * cos(angle4 - (M_PI/2)) * scale1;
        ThickPoints[k].y = y2 + Thickness * sin(angle4 - (M_PI/2)) * scale1;
        k++;
        i+=step;
    }
}

VPoints GetThickLines(const VPoints points, int& count,
        const StyleAttrib style, bool GetAverageSlope, bool ThickEnds,
        bool closed) {

    int total, i, k;
    VPoints ThickPoints;
    coord x1, y1, x2, y2, x3, y3;
    double angle1, angle2, angle4, thickness, xofs1, yofs1, xofs2, yofs2;
    VPoints newpoints;

    // It's more efficient to pre-allocate the maximum possible number of points
    // and then shrink the vector to the actual number of points once we're done

    total = (count-2)*4+4;
    ThickPoints.reserve(count);
    thickness = style.FullStyle.SThickness / 2;
    k = 0;

    // Form one half of the polygon by traversing the points
    i=0;
    while (i < count) {
        Calc(i, 0, count-1, 1, points, angle1, angle2, angle4, xofs1, xofs2,
                yofs1, yofs2, x1, y1, x2, y2, x3, y3, GetAverageSlope,
                ThickEnds, closed, k, ThickPoints, thickness);
    }

    // Now traverse in reverse order to finish the polygon
    i=count-1;
    while (i >= 0) {
        Calc(i, count-1, 0, -1, points, angle1, angle2, angle4, xofs1, xofs2,
                yofs1, yofs2, x1, y1, x2, y2, x3, y3, GetAverageSlope,
                ThickEnds, closed, k, ThickPoints, thickness);
    }

    // Make the output array, shrinking it to the number of points actually
    // created
    newpoints.reserve(k);
    for (i=0; i<k; i++) {
        newpoints[i] = ThickPoints[i];
    }

    // Cleanup
    ThickPoints.clear();
    count = k;
    return(newpoints);
}

/**
 * @todo The pascal sources for this included a routine named
 * "CreatePaletteBrush" and "CreateHiresBrush". These functions look to create
 * a simple brush of a given color for drawing, judging by the code. For now,
 * that's what will be assumed, though it should be reviewed later to make sure
 * this is what was intended.
 */
void DrawEnclosedFigure(wxDC* canvas, const VPoints& points, int count, bool closed,
        StyleAttrib& style, wxColour edgeColor, wxColour fillColor, ViewPoint view,
        bool GetAverageSlope) {
    int sx1, sy1, sx2, sy2;
    int i, k;
    wxColour oldcolor, oldbrushcolor;
    TLineContinue cont;
    wxPoint* poly;
    wxBitmap brushbitmap;
    wxObject* BrushHandle;
    bool IsPrinter;
    wxPen pen;
    wxBrush brush;

    coord t1, t2;
    VSPoints ThickPoints;
    VPoints newpoints;
    int oldbrushstyle, oldpenwidth, total;
    StyleAttrib newstyle;

    if (count != 0) {
        poly = new wxPoint[count];
        for (i=0; i<count; i++) {
            poly[i].x = (int)points[i].x;
            poly[i].y = (int)points[i].y;
        }
        oldcolor = canvas->GetPen().GetColour();
        if ((fillColor != wxNullColour) && closed) {
			///@todo The following line of code does not compile, though docs say it should. This must be fixed.
            //IsPrinter = canvas->IsKindOf(CLASSINFO(wxPrinterDC));
			IsPrinter = false;
            pen = canvas->GetPen();
            pen.SetStyle(wxTRANSPARENT);
            canvas->SetPen(pen);
            if (IsPrinter and (style.bytes.Fill == 0)) {
                brush = canvas->GetBrush();
                oldbrushcolor = brush.GetColour();
                brush.SetColour(fillColor);
                canvas->SetBrush(brush);
                canvas->DrawPolygon(count, poly);
                brush.SetColour(oldbrushcolor);
                canvas->SetBrush(brush);
            } else {
                /// @todo Original code: brushbitmap:=MainForm.FillPattern.GetMonochromeBitmap(Style.Fill);
                /// @todo Here we run into some stickiness. We have a
                //chunk of code in the original source which uses
                //"IsPaletteDevice" to determine the type of device. For
                //now, I'll ignore it, but this will need to be addressed
                //before release
                brush = canvas->GetBrush();
                ///@todo modify brush info here
                canvas->SetBrush(brush);
                canvas->DrawPolygon(count, poly);
            }
            pen.SetStyle(wxSOLID);
            canvas->SetPen(pen);
        }

        pen = canvas->GetPen();
        pen.SetColour(edgeColor);
        canvas->SetPen(pen);

        sx1 = poly[0].x;
        sy1 = poly[0].y;

		if (style.bytes.Line != start_numeric_thickness_style) {
			newstyle = view.FixStyle(style);
			cont = GetLineStyleStart(newstyle); 
			for (i=1; i<count; i++) {
				sx2 = poly[i].x;
				sy2 = poly[i].y;
				DrawLineContinue(*canvas, sx1, sy1, sx2, sy2, cont);
				sx1 = sx2;
				sy1 = sy2;
			}
			GetLineEnd(cont, i);
		} else {
			// This style lets us specify a hard numeric value for a line
			// thickness. This is useful for drawing things like roads, where
			// we want the lines to grow when we zoom in and shrink when we
			// zoom out.  The way to accomplish this is to render the line as a
			// polygon, filling the entire polygon with our line color.
			oldpenwidth = canvas->GetPen().GetWidth();
			oldbrushcolor = canvas->GetBrush().GetColour();
			oldbrushstyle = canvas->GetBrush().GetStyle();
			pen = canvas->GetPen();
			brush = canvas->GetBrush();
			pen.SetWidth(0);
			brush.SetStyle(wxSOLID);
			brush.SetColour(pen.GetColour());
			
			// It's more efficient to pre-allocate the maximum possible number of points
			// and then shrink the array to the actual number of points once we're done

			total = (count-2) * 4 + 4;
			ThickPoints.resize(total);
			t1 = style.FullStyle.Thickness;
			t1 = view.grid.GraphUnitConvert * view.grid.GraphScale;
			if (t2 != 0) {
				t1 = t1 / t2;
			}
			view.DeltaCoordToScreen(t1,0,t1,t2);
			style.FullStyle.SThickness = t1;

			k = count;
			newpoints = GetThickLines(points, k, style, GetAverageSlope, false, closed);
			ThickPoints.resize(k);
			for (i=0; i<k; i++) {
				ThickPoints[i].x = (int) round(newpoints[i].x, 0);
				ThickPoints[i].y = (int) round(newpoints[i].y, 0);
			}
			newpoints.clear();

            std::auto_ptr<wxPoint> drawme(VSPointsToArray(ThickPoints));
			canvas->DrawPolygon(k, drawme.get(), 0, 0, wxWINDING_RULE);

			pen = canvas->GetPen();
			brush = canvas->GetBrush();
			pen.SetWidth(oldpenwidth);
			brush.SetColour(oldbrushcolor);
			brush.SetStyle(oldbrushstyle);
			canvas->SetPen(pen);
			canvas->SetBrush(brush);
			ThickPoints.clear();
		}

		pen = canvas->GetPen();
		pen.SetColour(oldcolor);
		canvas->SetPen(pen);
        delete poly;
    }
}

wxString XMLIdFromCharId(wxChar c) {
    wxString retval;
    if ((c == wxT('C')) || (c == wxT('c'))) {
            retval = wxT("CURVE");
    } else if ((c == wxT('L')) || (c == wxT('l'))) {
            retval = wxT("LINE");
    } else if ((c == wxT('P')) || (c == wxT('p'))) {
            retval = wxT("POLYLINE");
    } else if ((c == wxT('K')) || (c == wxT('k'))) {
            retval = wxT("POLYCURVE");
    } else if (c == wxT('S')) {
            retval = wxT("SYMBOL");
    } else if (c == wxT('T')) {
            retval = wxT("TEXT");
    } else if (c == wxT('t')) {
            retval = wxT("TEXTCURVE");
    } else if (c == wxT('G')) {
            retval = wxT("GROUP");
    } else if (c == wxT('B')) {
            retval = wxT("BITMAP");
    } else if (c == wxT('H')) {
            retval = wxT("HYPERLINK");
    } else {
        retval = wxT("UNKNOWN");
    }
    return(retval);
}

wxChar CharIdFromXMLId(wxString s, bool fractal) {
    wxChar c;

    if (s == wxT("LINE")) {
        c = wxT('L');
    } else if (s == wxT("CURVE")) {
        c = wxT('C');
    } else if (s == wxT("POLYLINE")) {
        c = wxT('P');
    } else if (s == wxT("POLYCURVE")) {
        c = wxT('K');
    } else if (s == wxT("SYMBOL")) {
        c = wxT('S');
    } else if (s == wxT("TEXT")) {
        c = wxT('T');
    } else if (s == wxT("TEXTCURVE")) {
        c = wxT('t');
    } else if (s == wxT("GROUP")) {
        c = wxT('G');
    } else if (s == wxT("BITMAP")) {
        c = wxT('B');
    } else if (s == wxT("HYPERLINK")) {
        c = wxT('H');
    } else {
        c = wxT('\0');
    }
    if (fractal) {
        if (c == wxT('L')) {
            c = wxT('l');
        } else if (c == wxT('C')) {
            c = wxT('c');
        } else if (c == wxT('P')) {
            c = wxT('p');
        } else if (c == wxT('K')) {
            c = wxT('k');
        }
    }
    return (c);
}

void ReadOverlayColors(MainWin* win) {
    ///@todo Code this
}

arRealRect AdjustToPrinterPage(arRealRect viewRect) {
    ///@todo Code this
}

bool SetFractalState(bool current, FractalState state) {
	wxLogTrace(className, wxT("Entering SetFractalState"));
	bool retval = false;
	switch (state) {
		case fsUnchanged:   retval = current;  break;
		case fsSetFractal:  retval = true;     break;
		case fsSetNormal:   retval = false;    break;
		case fsFlipFractal: retval = !current; break;
		default: retval = false; break;
	}
	return(retval);
	wxLogTrace(className, wxT("Exiting SetFractalState"));
}

wxColour OverlayMainColor[maxOverlayColors];
wxColour OverlayFillColor[maxOverlayColors];
wxBitmap* HyperlinkBullet=NULL;
