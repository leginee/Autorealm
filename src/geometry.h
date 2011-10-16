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

#ifndef GEOMETRY_H
#define GEOMETRY_H

#include <wx/gdicmn.h>

#include "globals.h"
#include "types.h"

/**
 * @brief Indicates the result of an intersection test
 * When a point/line is tested for intersection, one of these values is the
 * result.
 */
enum IntersectType {
    NoIntersect = 0,
    IntersectOnLine,
    IntersectOffLine,
    IntersectOffLineBegin,
    IntersectOffLineEnd
};

// Miscellaneous functions

/**
 * @brief Extend the wxRect to encompass the point
 * @todo possibly make this a member function of arRealRect?
 *
 * @param r A arRealRect to be extended
 * @param p a arRealPoint which is to be put into the arRealRect
 */
void encompass(arRealRect& r, const arRealPoint& p);
/**
 * @brief Extend the wxRect to encompass the point
 * @todo possibly make this a member function of arRealRect?
 *
 * @param r A arRealRect to be extended
 * @param x The x coordinate of the point to be added to the arRealRect
 * @param y The y coordinate of the point to be added to the arRealRect
 */
void encompass(arRealRect& r, double x, double y);

/**
 * @brief Returns the distance between the two points
 *
 * @param x1 The x coordinate of the first point
 * @param y1 The y coordinate of the first point
 * @param x2 The x coordinate of the second point
 * @param y2 The y coordinate of the second point
 * @return The distance between the two points
 */
double distance(double x1, double y1, double x2, double y2);
/**
 * @brief Returns the distance between the two points
 *
 * @param p1 The first point
 * @param p2 The second point
 * @return The distance between the two points
 */
double distance(const arRealPoint &p1, const arRealPoint &p2);

/**
 * @brief returns the square of the distance between the two points. It's
 * faster than distance for figuring out which one is closer.
 *
 * @param x1 The x coordinate of the first point
 * @param y1 The y coordinate of the first point
 * @param x2 The x coordinate of the second point
 * @param y2 The y coordinate of the second point
 * @return The square of the distance between the two points
 */
double distance2(double x1, double y1, double x2, double y2);
/**
 * @brief returns the square of the distance between the two points. It's
 * faster than distance for figuring out which one is closer.
 *
 * @param p1 The first point
 * @param p2 The second point
 * @return The square of the distance between the two points
 */
double distance2(const arRealPoint &p1, const arRealPoint &p2);

/**
 * @brief Returns the angle?
 * @todo Verify
 *
 * @param x1 The x coordinate of the first point
 * @param y1 The y coordinate of the first point
 * @param x2 The x coordinate of the second point
 * @param y2 The y coordinate of the second point
 * @return The angle of the points
 */
double angle(double x1, double y1, double x2, double y2);
/**
 * @brief Returns the angle?
 * @todo Verify
 *
 * @param p1 The first point
 * @param p2 The second point
 * @return The angle of the points
 */
double angle(const arRealPoint& p1, const arRealPoint& p2);

/**
 * @brief Returns the unit vector corresponding to the two points
 *
 * @param x1 The x coordinate of the first point
 * @param y1 The y coordinate of the first point
 * @param x2 The x coordinate of the second point
 * @param y2 The y coordinate of the second point
 * @return The unit vector corresponding to the two points
 */
arRealPoint unitvector(double x1, double y1, double x2, double y2);
/**
 * @brief Returns the unit vector corresponding to the two points
 *
 * @param p1 The first point
 * @param p2 The second point
 * @return The unit vector corresponding to the two points
 */
arRealPoint unitvector(const arRealPoint& p1, const arRealPoint& p2);

/**
 * @brief Returns a unit vector perpendicular to the vector represented by the two points
 *
 * @param x1 The x coordinate of the first point
 * @param y1 The y coordinate of the first point
 * @param x2 The x coordinate of the second point
 * @param y2 The y coordinate of the second point
 * @return The unit vector perpendicular to the vector represented by the two points
 */
arRealPoint unitperpendicular(double x1, double y1, double x2, double y2);
/**
 * @brief Returns a unit vector perpendicular to the vector represented by the two points
 *
 * @param p1 The first point
 * @param p2 The second point
 * @return The unit vector perpendicular to the vector represented by the two points
 */
arRealPoint unitperpendicular(const arRealPoint& p1, const arRealPoint& p2);

/**
 * @brief Returns the midpoint of the line segment described by two points.
 *
 * @param x1 The x coordinate of the first point
 * @param y1 The y coordinate of the first point
 * @param x2 The x coordinate of the second point
 * @param y2 The y coordinate of the second point
 * @return The midpoint of the line segment described by these two points
 */
arRealPoint midpoint(double x1, double y1, double x2, double y2);
/**
 * @brief Returns the midpoint of the line segment described by two points.
 *
 * @param p1 The first point
 * @param p2 The second point
 * @return The midpoint of the line segment described by these two points
 */
arRealPoint midpoint(const arRealPoint& p1, const arRealPoint& p2);

/**
 * @brief Returns true if any part of r is inside (or on) vp (viewport)
 *
 * @param vp The viewport which is being examined to see if r is visible from it
 * @param r The area we wish to know if any part of is visible from vp
 * @return true if r is visible from vp, false if not
 */
bool visiblewithin(const arRealRect& vp, const arRealRect& r);

/**
 * @brief Returns true if any part of r is inside (or on) vp (viewport)
 *
 * @param vp The viewport which is being examined to see if r is visible from it
 * @param r The area we wish to know if any part of is visible from vp
 * @return true if r is visible from vp, false if not
 */
bool visiblewithin(const wxRect& vp, const wxRect& r);

/**
 * @brief returns the distance from the point to the segment
 *
 * @param p The point which is not on the segment
 * @param ep1 The begin point of the segment
 * @param ep2 The end point of the segment
 * @return The distance from the point to the segment
 */
double distancetosegment(const arRealPoint& p, const arRealPoint& ep1, const arRealPoint& ep2);

/**
 * @brief do the lines intersect?
 *
 * @param p1 beginning point of line 1
 * @param p2 ending point of line 1
 * @param p3 beginning point of line 2
 * @param p4 ending point of line 2
 * @return true if the lines intersect, false otherwise
 */
bool intersection(const arRealPoint& p1, const arRealPoint& p2, const arRealPoint& p3, const arRealPoint& p4);

/**
 * @brief In what way do the line segments intersect?
 *
 * @param p1 beginning point of line 1
 * @param p2 ending point of line 1
 * @param p3 beginning point of line 2
 * @param p4 ending point of line 2
 * @param ip (output) The location of the intersection, if there is one
 * @return The type of intersection which was found
 */
IntersectType intersection(const arRealPoint& p1, const arRealPoint& p2, const arRealPoint& p3, const arRealPoint& p4, arRealPoint& ip);

/**
 * @brief Clips the portion of the line segment outside of the arRealRect
 *
 * @param p1 The beginning point of the line
 * @param p2 The ending point of the line
 * @param r The clipping rectangle
 * @return Returns true if any portion of the line remains. Returns false if the entire line was outside of the rect
 */
bool CropLineOutsideRect(const arRealPoint& p1, const arRealPoint& p2, const arRealRect& r);

/**
 * @brief Extends the line segment until it intersects with the arRealRect
 *
 * @param p1 The beginning point of the line
 * @param p2 The ending point of the line
 * @param r The rectangle we wish to have (p1,p2) intersect with
 * @return true if the line was changed, else false
 */
bool ExtendLineToRect(arRealPoint& p1, arRealPoint& p2, const arRealRect& r);

/**
 * @brief Is this point in the polygon?
 *
 * @param p The point to be examined
 * @param polyextent The clipping rectangle of the polygon
 * @param poly The points which make up the polygon
 * @return true if the point is in the polygon, false otherwise
 */
bool PointInPolygon(const arRealPoint& p, const arRealRect& polyextent, const VPoints& poly);

/**
 * @brief Locates the closest intersection in the polygon to the point
 *
 * @todo document numsegments vector
 * @todo document what true/false means for the return value
 *
 * @param segments the segments which make up the polygon
 * @param numsegments Unknown
 * @param isect (output)The nearest point of intersection to the polygon for the point
 * @return true/false
 */
bool NearestIntersection(const std::vector<arRealPoint>& segments, const std::vector<int> numsegments, arRealPoint& isect);

/**
 * @brief Averages two map coordinate points
 */
arRealPoint avepoints(const arRealPoint& a, const arRealPoint& b);

/**
 * @brief Checks to see if a point is in a arRealRect with a delta
 */
bool ptInRealRectDelta(const arRealRect& r, const arRealPoint& p, const coord delta);

double distanceToSegment(const arRealPoint& p, const arRealPoint& p1, const arRealPoint& p2);
bool intersection(const arRealPoint& p1, const arRealPoint& p2, const arRealPoint& p3, const arRealPoint& p4);
IntersectType intersectLine(const arRealPoint& p1, const arRealPoint& p2, const arRealPoint& p3, const arRealPoint& p4, arRealPoint& isect);
bool CropLineOutsideRect(arRealPoint& p1, arRealPoint& p2, const arRealRect& r);
bool ExtendLineToRect(arRealPoint& p1, arRealPoint& p2, const arRealRect& r);
bool PointInPolygon(const arRealPoint& p, const arRealRect& polyextent, const VPoints& poly, int polycount);
bool NearestIntersection(const VPoints& segments, int* numsegments, arRealPoint& isect);
arRealRect MakeCoordRect(coord left, coord top, coord right, coord bottom);
void CorrectCoordRect(arRealRect& r);

#endif // GEOMETRY_H
