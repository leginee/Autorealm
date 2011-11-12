/*
 * Rewrite of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
 * Used in rpgs and hobbyist GIS applications for mapmaking
 * Copyright 2004-2006 The AutoRealm Team (http://www.autorealm.org/)
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the Lesser GNU General Public License as published by
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
#include "arRealTypes.h"

arRealRect::arRealRect(const arRealPoint& point1, const arRealPoint& point2)
{
  x = point1.x;
  y = point1.y;
  width = point2.x - point1.x;
  height = point2.y - point1.y;

  if (width < 0)
  {
    width = -width;
    x = point2.x;
  }
  width++;

  if (height < 0)
  {
    height = -height;
    y = point2.y;
  }
  height++;
}

arRealRect::arRealRect(const arRealPoint& point, const arRealSize& size)
{
    x = point.x; y = point.y;
    width = size.x; height = size.y;
}

bool arRealRect::operator==(const arRealRect& rect) const
{
  return ((x == rect.x) &&
          (y == rect.y) &&
          (width == rect.width) &&
          (height == rect.height));
}

arRealRect& arRealRect::operator += (const arRealRect& rect)
{
    *this = (*this + rect);
    return ( *this ) ;
}

arRealRect arRealRect::operator + (const arRealRect& rect) const
{
    double x1 = wxMin(this->x, rect.x);
    double y1 = wxMin(this->y, rect.y);
    double y2 = wxMax(y+height, rect.height+rect.y);
    double x2 = wxMax(x+width, rect.width+rect.x);
    return arRealRect(x1, y1, x2-x1, y2-y1);
}

arRealRect& arRealRect::Inflate(double dx, double dy)
{
    x -= dx;
    y -= dy;
    width += 2*dx;
    height += 2*dy;

    // check that we didn't make the rectangle invalid by accident (you almost
    // never want to have negative coords and never want negative size)
    if ( x < 0 )
        x = 0;
    if ( y < 0 )
        y = 0;

    // what else can we do?
    if ( width < 0 )
        width = 0;
    if ( height < 0 )
        height = 0;

    return *this;
}

bool arRealRect::Inside(double cx, double cy) const
{
    return ( (cx >= x) && (cy >= y)
          && ((cy - y) < height)
          && ((cx - x) < width)
          );
}

arRealRect& arRealRect::Intersect(const arRealRect& rect)
{
    double	x2 = GetRight(),
			y2 = GetBottom();

    if ( x < rect.x )
        x = rect.x;
    if ( y < rect.y )
        y = rect.y;
    if ( x2 > rect.GetRight() )
        x2 = rect.GetRight();
    if ( y2 > rect.GetBottom() )
        y2 = rect.GetBottom();

    width = x2 - x + 1;
    height = y2 - y + 1;

    if ( width <= 0 || height <= 0 )
    {
        width =
        height = 0;
    }

    return *this;
}

bool arRealRect::Intersects(const arRealRect& rect) const
{
    arRealRect r = Intersect(rect);

    // if there is no intersection, both width and height are 0
    return r.width != 0;
}

