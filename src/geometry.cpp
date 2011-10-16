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
#include <algorithm>

#include "geometry.h"
#include "generic_library.h"

const int ArrayInc=20;

/**
 * @brief something to do with arrays
 * @todo Figure out what this does. Should it be a different value?
 */
const long ArrayIncrement = 20;

/**
 * Enlarges the arRealRect to include the point p
 */
void encompass(arRealRect& r, const arRealPoint& p) {
    if(p.x < r.GetX()) { // need to expand to the left
        r.SetWidth(r.GetWidth() + r.GetX() - p.x);
        r.SetX(p.x);
    } else if(p.x > (r.GetX() + r.GetWidth())) { // need to expand to the right
        r.SetWidth(p.x - r.GetX());
    }

    if(p.y < r.GetY()) { // need to expand to the left
        r.SetHeight(r.GetHeight() + r.GetX() - p.x);
        r.SetY(p.y);
    } else if(p.y > (r.GetY() + r.GetHeight())) { // need to expand to the right
        r.SetHeight(p.x - r.GetX());
    }
}

void encompass(arRealRect& r, double x, double y) {
    encompass(r, arRealPoint(x, y));
}

/**
 * This function returns the square of the distance. If all you're doing is
 * comparing the distances between points, this function is faster than 
 * distarce() because it doesn't compute the square root
 * @param (x1,y1) - point 1
 * @param (x2,y2) - point 2
 * @return square of the distance between the two points
 */
double distance2(double x1, double y1, double x2, double y2) {
    return (x1-x2)*(x1-x2) + (y1-y2)*(y1-y2);
}

/**
 * @param p1 - point 1
 * @param p2 - point 2
 * @return square of the distance between the two points
 */
double distance2(const arRealPoint &p1, const arRealPoint &p2) {
    return distance2(p1.x, p1.y, p2.x, p2.y);
}

/**
 * @param p1 - point 1
 * @param p2 - point 2
 * @return distance between the two points
 */
double distance(const arRealPoint &p1, const arRealPoint &p2) {
    return sqrt(distance2(p1,p2));
}

/**
 * @param (x1,y1) - point 1
 * @param (x2,y2) - point 2
 * @return the distance between the two points
 */
double distance(double x1, double y1, double x2, double y2) {
    return sqrt(distance2(x1,y1,x2,y2));
}

/**
 * Ok, there's these two points. They are colinear (as any two paints must be).
 * This function finds the slope of the line as an angle between that line and
 * the positive X axis. Then it returns that angle measured in Radians
 * @param (x1,y1),(x2,y2) - the end points of a line segment
 * @return the angle the line segment makes with the positive x axis
 */
double angle(double x1, double y1, double x2, double y2) {
    double denominator = x2 - x1;

    if(denominator == 0.0) return 0.0;

    return 100.0 * atan2(y1-y2, denominator) / M_PI;
}

/**
 * @param p1,p2 - the endpoints of a line segment
 * @return the angle the line segment makes with the positive x axis
 */
double angle(const arRealPoint& p1, const arRealPoint& p2) {
    return angle(p1.x, p1.y, p2.x, p2.y);
}

/**
 * Ok, there's these two points. Together, they describe the direction and
 * magnitude of a vector. Now this function returns a point representing the
 * unit vector with the same directional component as the original vector.
 * @param (x1,y1),(x2,y2) - the end points of the line segment representing a vector
 * @return the unit vector with the same directional component as the original vector
 */
arRealPoint unitvector(double x1, double y1, double x2, double y2) {
    double dist = distance(x1, y1, x2, y2);

    if(dist == 0.0) return arRealPoint(0.0,0.0);

    return arRealPoint((x2-x1)/dist, (y2-y1)/dist);
}

/**
 * @param p1,p2 - the endpoints of a line segment representing a vector
 * @return the unit vector with the same directional component as the line segment
 */
arRealPoint unitvector(const arRealPoint &p1, const arRealPoint &p2) {
    return unitvector(p1.x, p1.y, p2.x, p2.y);
}

/**
 * Ok, this is just the same as the unitvector, but perpendicular instead of 
 * parallel.
 * @param x1,y1 - one endpoint of a line segment
 * @param x2,y2 - the other endpoint of a line segment
 * @return a point representing the unit perpendicular vector to the line segment
 */
arRealPoint unitperpendicular(double x1, double y1, double x2, double y2) {
    double dist = distance(x1, y1, x2, y2);

    if(dist == 0.0) return arRealPoint(0.0,0.0);

    return arRealPoint((y1-y2)/dist, (x2-x1)/dist);
}

/**
 * @param p1,p2 - a line segment representing the vector (p1 to p2)
 * @return a point representing the unitperpendicular to that line segment
 */
arRealPoint unitperpendicular(const arRealPoint &p1, const arRealPoint &p2) {
    return unitperpendicular(p1.x, p1.y, p2.x, p2.y);
}

/**
 * @param x1,y1 - one end point of the line segment
 * @param x2,y2 - the other point of the line segment
 * @return the midpoint of the line segment
 */
arRealPoint midpoint(double x1, double y1, double x2, double y2) {
    return arRealPoint((x1+x2)*0.5, (y1+y2)*0.5);
}

/**
 * @param p1,p2 - endpoints of the line segment
 * @return the midpoint of the line segment
 */
arRealPoint midpoint(const arRealPoint& p1, const arRealPoint& p2) {
    return midpoint(p1.x, p1.y, p2.x, p2.y);
}

/**
 * @param vp - view port
 * @param r - rectangle
 * @return Is r visible within vp?
 */
bool visiblewithin(const arRealRect& vp, const arRealRect& r) {
    // Caching values needed more than once
    double vpx = vp.GetX(); double rx  =  r.GetX();
    double vpy = vp.GetY(); double ry  =  r.GetY();
    
    if(vpx > (rx + r.GetWidth()))   return false; // r is left of vp
    if((vpx + vp.GetWidth()) < rx)  return false; // r is right of vp
    if(vpy > (ry + r.GetHeight()))  return false; // r is above vp
    if((vpy + vp.GetHeight()) < ry) return false; // r is below vp

    return true;
}

/**
 * @param vp - view port
 * @param r - rectangle
 * @return Is r visible within vp?
 */
bool visiblewithin(const wxRect& vp, const wxRect& r) {
    // Caching values needed more than once
    double vpx = vp.GetX(); double rx  =  r.GetX();
    double vpy = vp.GetY(); double ry  =  r.GetY();
    
    if(vpx > (rx + r.GetWidth()))   return false; // r is left of vp
    if((vpx + vp.GetWidth()) < rx)  return false; // r is right of vp
    if(vpy > (ry + r.GetHeight()))  return false; // r is above vp
    if((vpy + vp.GetHeight()) < ry) return false; // r is below vp

    return true;
}

/**
 * @param p - point to measure from
 * @param ep1,ep2 - end points of the line segment
 * @return distance from the point to the line segment
 */
double distancetosegment(const arRealPoint& p, const arRealPoint& ep1, const arRealPoint& ep2) {
    bool vert = (ep1.x == ep2.x); // line segment is a vertical line
    bool horz = (ep1.y == ep2.y); // line segment is a horizontal line
    double b,m;
    double ib,im;
    double ix,iy; // coordinates of the intersection point

    // line segment is actually a single point
    if(horz && vert) return (distance(p.x, p.y, ep1.x, ep1.y));

    // find the point of intersection
    // If you drew a line perpendicular to the line ep1,ep2 through p, it would
    // pass through this point on the line. The length of this segment is the
    // shortest distance from the point to the line. The point of intersection
    // may not be on the line segment, however, so we'll check for that later.
    if(horz) {
        ix = p.x;
        iy = ep1.y;
    } else if(vert) {
        ix = ep1.x;
        iy = p.y;
    } else {
        // y = m * x + b
        m = (ep2.y - ep1.y) / (ep2.x - ep1.y);
        b = ep1.y - m * ep1.x;
        im = -1.0 / m;
        ib = p.y - im * p.x;
        ix = (ib - b) / (m - im);
        iy = im * ix + ib;
    }

    // Ok, now we have the point of intersection
    // The point we want to measure from is in the middle of the three.
    // If the intersection is on the line segment, it will be between ep1 & ep2
    // If not, ep1 or ep2 will be between the intersection and the other ep
    return distance(p.x, p.y, std::max(std::min(ep1.x, ix), ep2.x),
                std::max(std::min(ep1.y, iy), ep2.y));
}

/**
 * Compares the slope of line p1,p2 and p3,p4 to see if they intersect.
 * They intersect if the slopes are not equal
 * @param p1,p2 - two points on line 1
 * @param p3,p4 - two points on line 2
 * @return true if the lines are not parallel
 */
bool intersection(const arRealPoint& p1, const arRealPoint& p2, const arRealPoint& p3, const arRealPoint& p4) {
    return ((p1.y-p2.y)*(p3.x-p4.x)) !=
           ((p3.y-p4.y)*(p1.x-p2.x));
}

/**
 * Finds the point of intersection (if one exists) and returns whether the
 * point of intersection is on or off of the segments
 * @param p1,p2 - endpoints of one line segment
 * @param p3,p4 - endpoints of the other line segment
 * @param ip - the point of intersection
 * @return the type of intersection
 */
IntersectType intersection(const arRealPoint& p1, const arRealPoint& p2, const arRealPoint& p3, const arRealPoint& p4, arRealPoint& ip) {
    bool line1vert, line2vert; // whether each line is vertical
    double m1, m2; // line slopes
    double b1, b2; // y-intercepts
    double ta, tb; // temporary variables

    line1vert = (p1.x == p2.x) ? true : false;;
    line2vert = (p3.x == p4.x) ? true : false;;

    if(line1vert && line2vert) return NoIntersect;

    if(line1vert) {
        m2 = (p4.y - p3.y) / (p4.x - p3.y);
        b2 = p4.y - m2 * p4.x;

        ip.x = p1.x;
        ip.y = m2 * ip.x + b2;
    } else if(line2vert) {
        m1 = (p2.y - p1.y) / (p2.x - p1.x);
        b1 = p2.y - m1 * p2.x;

        ip.x = p3.x;
        ip.y = m1 * ip.x + b1;
    } else {
        m1 = (p2.y - p1.y) / (p2.x - p1.x);
        m2 = (p4.y - p3.y) / (p4.x - p3.y);

        if(m1 == m2) return NoIntersect;
        
        b1 = p2.y - m1 * p2.x;
        b2 = p4.y - m2 * p4.x;

        ip.x = (b2 - b1) / (m1 - m2);
        ip.y = m1 * ip.x + b1;
    }

    // Ok, at this point, we have the intersection (ip)
    // We need to figure out if it's on the line, off the line, etc
    
    // this is taken directly from the old AutoRealm function, I'll look into
    // possibly optimizing it later (if it's not already at peak optimization)
    
    if(p2.x != p1.x) 
        ta = (ip.x - p1.x) / (p2.x - p1.x);
    else if(p2.y != p1.y)
        ta = (ip.y - p1.y) / (p2.y - p1.y);
    else
        ta = 0.0;

    if(p4.x != p3.x) 
        ta = (ip.x - p3.x) / (p4.x - p3.x);
    else if(p4.y != p3.y)
        ta = (ip.y - p3.y) / (p4.y - p3.y);
    else
        ta = 0.0;

    if((ta >= 0.0) and (ta <= 1.0) and (tb >= 0.0) and (tb <= 1.0)) {
        return IntersectOnLine;
    } else {
        if(ta < 0.0)
            return IntersectOffLineBegin;
        else if(ta > 1.0)
            return IntersectOffLineEnd;
        else
            return IntersectOffLine;
    }
}


/**
 * @param p1,p2 - the endpoints of the line segment
 * @param r - the rectangle to clip the line segment to
 * @return true if the line segment was altered, else false
 */
bool CropLineOutsideRect(arRealPoint& p1, arRealPoint& p2, const arRealRect& r) {
    arRealPoint isect; // where line hits boundry
    bool retval = false;
    double x,y,w,h; // corners/sizes of the rect
    
    // if there's no rectangle, the entire line is cropped away
    if((r.GetHeight() == 0) || (r.GetWidth()==0)) return false;

    // if the line isn't in the rectangle, it is cropped away
    if(!visiblewithin(arRealRect(p1.x, p1.y, p2.x, p2.y),r))
        return false;

    // if the line is completely within the rectangle, nothing is cropped
    if(r.Inside(p1) && r.Inside(p2)) return true;

    // Cache rect stats
    x = r.GetX(); w = r.GetWidth();
    y = r.GetY(); h = r.GetHeight();
    
    // crop along top
    if(intersection(p1,p2, arRealPoint(x, y), arRealPoint(x + w, y), isect) == IntersectOnLine) {
        if(p1.y < p2.y) {
            p1 = isect;
        } else {
            p2 = isect;
        }
    }

    // crop along left
    if(intersection(p1,p2, arRealPoint(x, y), arRealPoint(x, y + h), isect) == IntersectOnLine) {
        if(p1.x < p2.x) {
            p1 = isect;
        } else {
            p2 = isect;
        }
    }

    // crop along right
    if(intersection(p1,p2, arRealPoint(x + w, y), arRealPoint(x + w, y + h), isect) == IntersectOnLine) {
        if(p1.x < p2.x) {
            p2 = isect;
        } else {
            p1 = isect;
        }
    }

    // crop along bottom
    if(intersection(p1,p2, arRealPoint(x, y + h), arRealPoint(x + w, y + h), isect) == IntersectOnLine) {
        if(p1.y < p2.y) {
            p2 = isect;
        } else {
            p1 = isect;
        }
    }

    return true;
}

/**
 * @param p1,p2 - the endpoints of the line segment
 * @param r - the rectangle the line segment is extended to
 * @returns true if some extending was done
 */
bool ExtendLineToRect(arRealPoint& p1, arRealPoint& p2, const arRealRect& r) {
    double rl = r.GetX();           // left
    double rr = rl + r.GetWidth();  // right
    double rt = r.GetY();           // top
    double rb = rt + r.GetHeight(); // bottom
    arRealPoint isect;
    IntersectType it;
    bool retval;
    
    if((rl == rr) || (rt == rb)) return false;
    
    // Top edge
    it = intersection(p1,p2, arRealPoint(rl,rt), arRealPoint(rr,rt), isect);
    if(it == IntersectOffLineBegin) {
        p1 = isect;
        retval = true;
    } else if(it == IntersectOffLineEnd) {
        p2 = isect;
        retval = true;
    }
    
    // Left edge
    it = intersection(p1,p2, arRealPoint(rl,rt), arRealPoint(rl,rb), isect);
    if(it == IntersectOffLineBegin) {
        p1 = isect;
        retval = true;
    } else if(it == IntersectOffLineEnd) {
        p2 = isect;
        retval = true;
    }
    
    // Right edge
    it = intersection(p1,p2, arRealPoint(rr,rt), arRealPoint(rr,rb), isect);
    if(it == IntersectOffLineBegin) {
        p1 = isect;
        retval = true;
    } else if(it == IntersectOffLineEnd) {
        p2 = isect;
        retval = true;
    }

    // Bottom edge
    it = intersection(p1,p2, arRealPoint(rl,rb), arRealPoint(rr,rb), isect);
    if(it == IntersectOffLineBegin) {
        p1 = isect;
        retval = true;
    } else if(it == IntersectOffLineEnd) {
        p2 = isect;
        retval = true;
    }

    return retval;
}

/**
 * Returns true if the point is in the polygon
 * @param p - the point to test
 * @param polyextent - a rectangle enclosing the polygon, used to short-circuit
 *      the test
 * @param poly - the points that make up the vertices of the polygon
 * 
 * What we do (after checking for the simple no cases), is create a line from p
 * to a point we know is outside the polygon. Then we count how many times that
 * line intersects with one of the sides of the polygon. If the count is even 
 * (including 0), then the point is outside of the polygon. If the count is odd,
 * then the point is inside the polygon.
 */
bool PointInPolygon(const arRealPoint& p, const arRealRect& polyextent, const VPoints& poly) {
    int npoints = poly.size();
    arRealPoint p2;
    int i;
    int intersections = 0;

    // not enough points for even a line
    if(npoints < 2) return false;
    // check to see if it's inside the boundary box
    if(!polyextent.Inside(p)) return false;

    // set up the line
    p2 = p;
    p2.x = polyextent.GetX() - 1000;

    for(i = 0; i < npoints -1; i++) {
        if(intersection(p,p2, poly[i],poly[i+1])) intersections++;
    }

    return intersections % 2 > 0;
}

/**
 * Finds the point closest to p in points
 * @param p - the point we're trying to find the closest point to
 * @param points - the points we're going to search through
 * @param closest - (output parameter) the closest point to p
 * @return true if a point was found, otherwise false
 *
 * This function scans through every point in the points vector. The Delphi 
 * version was optimized, but I couldn't understand it and so couldn't 
 * reproduce it.
 */
bool NearestPoint(const arRealPoint& p, const std::vector<arRealPoint>& points, arRealPoint& closest) {
    double  mindist,    // smallest distance found so far
            dist;       // distance for current point
    long    numpoints,  // the number of points in the vector
            i;          // loop index
    const arRealPoint *retval; // the current closest point, using a pointer for speed
                                // this is a pointer to a constant object
    
    numpoints = points.size();
    if(numpoints < 1) return false;
    
    // initialize the return values
    mindist = distance2(p,points[0]);
    retval = &points[0];
    
    for(i = 1; i < numpoints; i++) {
        dist = distance2(p,points[i]);
        if(dist < mindist) { // this point is closer than the rest so far
            mindist = dist;
            retval = &points[i];
        }
    }

    closest = *retval;
    return true;
}

arRealPoint avepoints(const arRealPoint& a, const arRealPoint& b) {
    return(arRealPoint((a.x+b.x)*0.5, (a.y+b.y)*0.5));
}

bool ptInRealRectDelta(const arRealRect& r, const arRealPoint& p, const coord delta) {
    return ((p.y >= r.y-delta) && (p.y <= r.y+r.height+delta) &&
            (p.x >= r.x-delta) && (p.x <= r.x+r.width -delta));
}

double distanceToSegment(const arRealPoint& p, const arRealPoint& p1, const arRealPoint& p2) {
    double m, b, im, ib, t;
    coord ix, iy;
    bool horz, vert;
    double retval;

    horz = (p1.y == p2.y);
    vert = (p1.x == p2.x);

    if (horz && vert) { // A point. Fractal can generate these
        return(distance(p.x, p.y, p1.x, p1.y));
    } else {
        if (vert) { // A vertical line
            ix = p1.x;
            iy = p.y;
        } else if (horz) { // A horizontal line
            ix = p.x;
            iy = p1.y;
        } else { // A normal line
            m = (p2.y-p1.y)/(p2.x-p1.x);
            b = p1.y - m*p1.x;
            im = -1/m;
            ib = p.y - im*p.x;
            ix = (ib-b)/(m-im);
            iy = im*ix + ib;
        }
        // We now have the intersect point on the line.
        // See if it's off the end.  If so, we use the distance
        // to the endpoint.  If not, we use the distance from
        // the intersection to the point.    
        if (p2.x != p1.x) {
            t = (ix - p1.x)/(p2.x-p1.x);
        } else {
            t = (iy - p1.y)/(p2.y-p1.y);
        }

        if (t < 0.0) {
            retval = distance(p.x, p.y, p1.x, p1.y);
        } else if (t > 1.0) {
            retval = distance(p.x, p.y, p2.x, p2.y);
        } else {
            retval = distance(p.x, p.y, ix, iy);
        }
    }
    return(retval);
}

/**
 * Returns true if the lines intersect; false if the lines are parallel
 */
IntersectType intersectLine(const arRealPoint& p1, const arRealPoint& p2, const arRealPoint& p3, const arRealPoint& p4, arRealPoint& isect) {
    double m1, b1, m2, b2, ta, tb;
    bool p1p2vertical, p3p4vertical, p1p2horizontal, p3p4horizontal;
    IntersectType retval=NoIntersect;

    try {
        p1p2vertical = (p1.x == p2.x);
        p3p4vertical = (p3.x == p4.x);
        p1p2horizontal = (p1.y == p2.y);
        p3p4horizontal = (p3.y == p4.y);
     
        // If both lines are vertical or horizontal, they won't intersect
        // @bug Technically, the above comment is wrong. There is one
        // possibility that is not accounted for: that they are the same line.
        // I don't know how much of a problem this is, so need to examine it in
        // more detail, but wanted to note it here.
        if (!(p1p2vertical && p3p4vertical) && !(p1p2horizontal && p3p4horizontal)) {
            if (p1p2vertical) {
                m2 = (p4.y-p3.y)/(p4.x-p3.x);
                b2 = p4.y - m2*p4.x;
                m1 = -m2;
                isect.x = p1.x;
                isect.y = m2*isect.x+b2;
            } else if (p3p4vertical) {
                m1 = (p2.y-p1.y)/(p2.x-p1.x);
                b1 = p2.y - m1*p2.x;
                m2 = -m1;
                isect.x = p3.x;
                isect.y = m1*isect.x + b1;
            } else {
                m1 = (p2.y-p1.y)/(p2.x-p1.x);
                b1 = p2.y - m1*p2.x;
                m2 = (p4.y-p3.y)/(p4.x-p3.x);
                b2 = p4.y - m2*p4.x;
            }
            if (m1 != m2) {
                isect.x = (b2-b1)/(m1-m2);
                isect.y = m1*isect.x + b1;
    
                // Figure out if the intersection is on the lines, or is off the end of either of the lines
                if (p2.x != p1.x) {
                    ta = (isect.x-p1.x)/(p2.x-p1.x);
                } else if (p2.y != p1.y) {
                    ta = (isect.y-p1.y)/(p2.y-p1.y);
                } else {
                    ta = 0;
                }
    
                if (p3.x != p4.x) {
                    tb = (isect.x-p3.x)/(p4.x-p3.x);
                } else if (p3.y != p4.y) {
                    tb = (isect.y-p3.y)/(p4.y-p3.y);
                } else {
                    tb = 0;
                }
    
                if ((ta >= 0.0) && (ta <= 1.0) && (tb >= 0.0) && (tb <= 1.0)) {
                    retval = IntersectOnLine;
                } else {
                    if (ta < 0.0) {
                        retval = IntersectOffLineBegin;
                    } else if (ta > 1.0) {
                        retval = IntersectOffLineEnd;
                    } else {
                        retval = IntersectOffLine;
                    }
                }
            }
        }
    }
    catch (std::exception e) {
        retval = NoIntersect;
    }
    return(retval);
}

/**
 * Returns if the point is inside the polygon.  Uses the classic method of
 * hit testing by making a horizontal ray from the point, and counting the
 * intersections.  An even count is outside, and odd count is inside.
 */
bool PointInPolygon(const arRealPoint& p, const arRealRect& polyextent, const VPoints& poly, int polycount) {
	arRealPoint p2;
	int i, intersections;
	bool retval = false;

	if (polycount >= 2) {
		if (polyextent.Inside(p)) {
			p2 = p;
			p2.x = polyextent.GetRight()+1000; ///@todo why 1000? what's the significance?
			intersections = 0;

			for (i=0; i<polycount-2; i++) {
				if (intersection(p, p2, poly[i], poly[i+1])) {
					intersections++;
				}
			}

			retval = ((intersections % 2) == 1);
		}
	}
	return(retval);
}

class TLineBin;

class TLineBin {
	public:
		TLineBin();
		void Add(const VPoints& SourcePoints, int StartIndex, int EndIndex);
		void AddSegment(coord x1, coord y1, coord x2, coord y2, bool New);
		void Remove(int StartIndex, int EndIndex);
		void Split();
		bool GetClosestIntersection(arRealPoint& p);

		int PointCount;
		int NumCount;
		VPoints Points;
		IntVec IStart;
		IntVec IEnd;
		std::auto_ptr<TLineBin> Child;
};

TLineBin::TLineBin() {
	PointCount = NumCount = 0;
}

void TLineBin::Add(const VPoints& SourcePoints, int StartIndex, int EndIndex) {
	int i, j;

	j = PointCount;
	for (i=StartIndex; i<EndIndex; i++) {
		if (j >= Points.size()) {
			Points.resize(Points.size() + ArrayInc);
			Points[j++] = SourcePoints[i];
		}
		if (NumCount >= IStart.size()) {
			IStart.resize(IStart.size() + ArrayInc + 1);
			IEnd.resize(IEnd.size() + ArrayInc + 1);
		}
		IStart[NumCount] = PointCount;
		IEnd[NumCount] = IStart[NumCount] + (EndIndex-StartIndex);
		PointCount+=EndIndex-StartIndex+1;
		NumCount++;
	}
}

void TLineBin::AddSegment(coord x1, coord y1, coord x2, coord y2, bool New) {
    if (PointCount+1 > Points.size()) {
        Points.resize(Points.size() + ArrayInc + 2);
    }
    Points[PointCount].x = x1;
    Points[PointCount].y = y1;
    Points[PointCount+1].x = x2;
    Points[PointCount+1].y = y2;
    if (New || (NumCount == 0)) {
        if (NumCount > IStart.size()) {
            IStart.resize(IStart.size() + ArrayInc + 1);
            IEnd.resize(IEnd.size() + ArrayInc + 1);
        }
        IStart[NumCount] = PointCount;
        IEnd[NumCount] = IStart[NumCount] + 1;
        NumCount++;
    } else {
        IEnd[NumCount-1] += 2;
        PointCount += 2;
    }
}

void TLineBin::Remove(int StartIndex, int EndIndex) {
    int i, j, k;
    
    k = EndIndex - StartIndex + 1;
    for (i=EndIndex+1; i<PointCount; i++) {
        Points[StartIndex+i-(EndIndex+1)] = Points[i];
    }
    for (i=0; i<NumCount; i++) {
        if (IStart[i] > StartIndex) {
            IStart[i] -= k;
        }
        if (IEnd[i] >= EndIndex) {
            IEnd[i] -= k;
        }
    }
    i=0;
    while (i<NumCount) {
        if (IEnd[i] <= 0) {
            for (j=i; j<NumCount-1; j++) {
                IStart[j] = IStart[j+1];
                IEnd[j] = IEnd[j+1];
            }
            NumCount--;
        }
        i++;
    }
    PointCount -= k;
}

void TLineBin::Split() {
    int i, j, num, last;
    coord x1, y1, x2, y2, c, c1;
    arRealPoint p;

    // Make sure there are at least two segments
    if ((Child.get() == NULL) && (PointCount > 1)) {
        x1 = Points[0].x;
        y1 = Points[0].y;
        x2 = Points[0].x;
        y2 = Points[0].y;
        for (i=1; i<PointCount; i++) {
            if (Points[i].x < x1) { x1 = Points[i].x; }
            if (Points[i].y < y1) { y1 = Points[i].y; }
            if (Points[i].x > x2) { x2 = Points[i].x; }
            if (Points[i].y > y2) { y2 = Points[i].y; }
        }

        // Simple split for now, right down the middle of the longer distance.
        // Find out if we can get rid of any segments, and do the split if so.
        j = 0;
        if ((x2 - x1) > (y2 - y1)) {
            c = (x1 + x2) /2;
            i = 0;
            while (i < PointCount) {
                if ((Points[i].x >= c) && (Points[i+1].x >= c)) { j += 2; }
                i += 2;
            }
            if ((j>0) && (j<PointCount)) {
                std::auto_ptr<TLineBin> achild;
                Child = achild;
                i = 0;
                last = -1;
                num = 0;
                while (i < PointCount) {
                    // Sort
                    if (Points[i].x > Points[i+1].x) {
                        p           = Points[i];
                        Points[i]   = Points[i+1];
                        Points[i+1] = p;
                    }

                    // Move the segment to the child?
                    if ((Points[i].x >= c) && (Points[i+1].x >= c)) {
                        Child->AddSegment(Points[i].x, Points[i].y, Points[i+1].x, Points[i+1].y, i>last);
                        Remove(i, i+1);
                        last -= 2;
                        while ((i>last) && (num<NumCount)) {
                            last = IEnd[num++];
                        }
                    } else if ((Points[i].x < c) && (Points[i+1].x > c)) { // Split the segment?
                        c1 = Points[i].y + (Points[i+1].y - Points[i].y) * (c - Points[i].x) / (Points[i+1].x - Points[i].x);
                        Child->AddSegment(c, c1, Points[i+1].x, Points[i+1].y, i>last);
                        Points[i+1].x = c;
                        Points[i+1].y = c1;
                        while ((i>last) && (num<NumCount)) {
                            last = IEnd[num++];
                        }
                        i += 2;
                    } else {
                        i += 2;
                    }
                }
            }
        } else {
            c = (y1 + y2) / 2;
            i = 0;
            while (i < PointCount) {
                if ((Points[i].y >= c) && (Points[i+1].y >= c)) { j += 2; }
                i += 2;
            }
            if (( j > 0) && (j < PointCount)) {
                std::auto_ptr<TLineBin> achild;
                Child = achild;
                i=0;
                last = -1;
                num = 0;
                while (i < PointCount) {
                    // Sort
                    if (Points[i].y > Points[i+1].y) {
                        p = Points[i];
                        Points[i] = Points[i+1];
                        Points[i+1] = Points[i];
                    }

                    // Move the segment to the child?
                    if ((Points[i].y >= c) && (Points[i+1].y >= c)) {
                        Child->AddSegment(Points[i].x, Points[i].y, Points[i+1].x, Points[i+1].y, i>last);
                        Remove(i, i+1);
                        last -= 2;
                        while ((i > last) && (num < NumCount)) {
                            last = IEnd[num++];
                        }
                    } else if ((Points[i].y < c) && (Points[i+1].y > c)) { // Split the segment?
                        c1 = Points[i].x + (Points[i+1].x - Points[i].x) * (c - Points[i].y) / (Points[i+1].y - Points[i].y);
                        Child->AddSegment(c1, c, Points[i+1].x, Points[i+1].y, i > last);
                        Points[i+1].x = c1;
                        Points[i+1].y = c;
                        while ((i>last) && (num<NumCount)) {
                            last = IEnd[num++];
                        }
                        i += 2;
                    } else {
                        i += 2;
                    }
                }
            }
        }
    }
}

bool TLineBin::GetClosestIntersection(arRealPoint& p) {
    arRealPoint p1, p2;
    int i, j, k, l, imax, jmax;
    double dist=0, d1;
    bool found=false;

    if (NumCount >= 2) {
        imax = NumCount-2;
        jmax = imax+1;
    } else {
        imax = 0;
        jmax = 0;
    }

    for (i=0; i<= imax; i++) {
        for (j=0; j<= jmax; j++) {
            k = IStart[i];
            while (k < IEnd[i]) {
                l = IStart[j];
                while (l < IEnd[j]) {
                    if ((j!=i) || (l > k+2) || (k > l+2)) {
                        if (intersectLine(Points[k], Points[k+1], Points[l], Points[l+1], p2) == IntersectOnLine) {
                            d1 = distance(p.x, p.y, p2.x, p2.y);
                            if (!found) {
                                found = true;
                                dist = d1;
                                p1 = p2;
                            } else {
                                if (d1 < dist) {
                                    dist = d1;
                                    p1 = p2;
                                }
                            }
                        }
                    }
                    l+=2;
                }
                k+=2;
            }
        }
    }

    if (Child.get() != NULL) {
        p2 = p;
        if (Child->GetClosestIntersection(p2)) {
            d1 = distance(p.x, p.y, p2.x, p2.y);
            if (!found) {
                found = true;
                p1 = p2;
            } else {
                if (d1 <= dist) {
                    p1 = p2;
                }
            }
        }
    }

    if (found) {
        p = p1;
    }
    return(found);
}

bool NearestIntersection(const VPoints& segments, IntVec numsegments, arRealPoint& isect) {
    int i, j;
    TLineBin Bin;
    bool retval;
    
    j = 0;
    for (i=0; i<numsegments.size(); i++) {
        Bin.Add(segments, j, j+numsegments[i]-1);
        j += numsegments[i];
    }
    Bin.Split();
    
    retval = Bin.GetClosestIntersection(isect);
    return(retval);
}

void CorrectCoordRect(arRealRect& r) {
	coord t, l, r1;
	
	if (r.GetWidth() < 0) {
		l = r.GetLeft();
		t = r.GetWidth() + l;
		r.SetLeft(t);
		r.SetRight(l);
	}

	if (r.GetHeight() < 0) {
		l = r.GetTop();
		t = r.GetHeight() + l;
		r.SetTop(t);
		r.SetBottom(l);
	}
}

arRealRect MakeCoordRect(coord left, coord top, coord right, coord bottom) {
	arRealRect r(left, top, right-left, bottom-top);
	CorrectCoordRect(r);
	return(r);
}
