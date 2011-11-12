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
#ifndef ARREALTYPES_H
#define ARREALTYPES_H
#include <wx/wx.h>

// ---------------------------------------------------------------------------
// arRealSize
// ---------------------------------------------------------------------------

/**
 * @brief Floating point version of wxSize.
 *
 * Basically, this class is a floating point version of wxSize. This means
 * that all members of this class are of type double, take type double,
 * etc.
 */
class arRealSize
{
public:
	/**
	 * @var double x
	 * The width of the arRealSize. Public for compatibility with wxSize,
	 * but should not be used directly.
	 */
	/**
	 * @var double y
	 * The width of the arRealSize. Public for compatibility with wxSize,
	 * but should not be used directly.
	 */
	double x,y;

	// constructors
	/**
	 * @brief Default constructor
	 *
	 * Sets width and height to 0.0
	 */
	arRealSize() : x(0.0), y(0.0) { }
	
	/**
	 * @brief Copy Constructor
	 */
	arRealSize(const arRealSize & rs) : x(rs.x), y(rs.y) { }
	
	/**
	 * @brief Longer constructor
	 *
	 * Allows the user to pass in a width and height for the size.
	 *
	 * @param xx The width of the arRealSize
	 * @param yy The height of the arRealSize
	 */
	arRealSize(double xx, double yy) : x(xx), y(yy) { }

	// no copy ctor or assigment operator - the defaults are ok
	
	/**
	 * @brief Comparison operator
	 *
	 * Ask if the other arRealSize (sz) is equal to this one.
	 *
	 * @param sz The arRealSize to compare this one to
	 * @return true if they are equal, false if not
	 */
	bool operator==(const arRealSize& sz) const { return x == sz.x && y == sz.y; }
	/**
	 * @brief Comparison operator
	 *
	 * Ask if the other arRealSize (sz) is not equal to this one.
	 *
	 * @param sz The arRealSize to compare this one to
	 * @return false if they are equal, true if not
	 */
	bool operator!=(const arRealSize& sz) const { return x != sz.x && y == sz.y; }

	/// @todo are these really useful? If they're, we should have += &c as well
	/**
	 * @brief Add another arRealSize to this one
	 *
	 * @param sz The arRealSize object to add to this one.
	 * @return The resulting arRealSize object
	 */
	arRealSize operator+(const arRealSize& sz) { return arRealSize(x + sz.x, y + sz.y); }
	/**
	 * @brief Subtract another arRealSize from this one
	 *
	 * @param sz The arRealSize object to subtract from this one.
	 * @return The resulting arRealSize object
	 */
	arRealSize operator-(const arRealSize& sz) { return arRealSize(x + sz.x, y + sz.y); }

	/**
	 * @brief Increase the size to another arRealSize
	 *
	 * @note This particular routine does one thing which may seem wrong:
	 * If this->x is already bigger than sz->x, then this->x will not be
	 * affected. The same is true for this->y
	 *
	 * @param sz The arRealSize to make sure this one includes
	 */
	void IncTo(const arRealSize& sz)
        { if ( sz.x > x ) x = sz.x; if ( sz.y > y ) y = sz.y; }
	/**
	 * @brief Decrease the size to another arRealSize
	 *
	 * @note This particular routine does one thing which may seem wrong:
	 * If this->x is already smaller than sz->x, then this->x will not be
	 * affected. The same is true for this->y
	 *
	 * @param sz The arRealSize to make sure this one includes
	 */
	void DecTo(const arRealSize& sz)
        { if ( sz.x < x ) x = sz.x; if ( sz.y < y ) y = sz.y; }

    // accessors
	/**
	 * @brief Reset both width and height of the size
	 *
	 * @param xx New width
	 * @param yy New height
	 */
    void Set(double xx, double yy) { x = xx; y = yy; }
	/**
	 * @brief Reset width of the size
	 *
	 * @param w New width
	 */
    void SetWidth(double w) { x = w; }
	/**
	 * @brief Reset height of the size
	 *
	 * @param h New height
	 */
    void SetHeight(double h) { y = h; }

	/**
	 * @brief Get the width of the size
	 *
	 * @return The width
	 */
    double GetWidth() const { return x; }
	/**
	 * @brief Get the height of the size
	 *
	 * @return The height
	 */
    double GetHeight() const { return y; }

	/**
	 * @brief Check to see if the width and height are both specified
	 *
	 * @return true=yes, false=no
	 */
    bool IsFullySpecified() const { return x != -1 && y != -1; }

	/**
     * combine this size with the other one replacing the default (i.e. equal
     * to -1) components of this object with those of the other
	 *
	 * @param size The size to use for the defaults of this size object
	 */
    void SetDefaults(const arRealSize& size)
    {
        if ( x == -1 )
            x = size.x;
        if ( y == -1 )
            y = size.y;
    }

    // compatibility
	/**
	 * @brief Get the width of the size
	 *
	 * @return The width
	 */
    double GetX() const { return x; }
	/**
	 * @brief Get the height of the size
	 *
	 * @return The height
	 */
    double GetY() const { return y; }
};

// ---------------------------------------------------------------------------
 // Point classes: with real or integer coordinates
 // ---------------------------------------------------------------------------
 
/**
 * @brief A floating point version of the wxPoint class.
 */
 class arRealPoint
 {
 public:
	 /**
	  * @var double x
	  * The x coordinate of the point
	  */
	 /**
	  * @var double y
	  * The y coordinate of the point
	  */
    double x, y;
 
	/**
	 * Default constructor, puts the point at the origin.
	 */
     arRealPoint() : x(0.0), y(0.0) { }
     
     /**
	 * Copy Constructor
	 */
     arRealPoint(const arRealPoint & rp) : x(rp.x), y(rp.y) { }
     
	 /**
	  * Extended constructor. Allows the caller to specify the x and y
	  * coordinates of the point.
	  */
     arRealPoint(double xx, double yy) : x(xx), y(yy) { }
 
	// no copy ctor or assigment operator - the defaults are ok
	
	// comparison
	/**
	 * Comparison method
	 *
	 * @param pt arRealPoint to compare this one to
	 * @return true=they are equal, false=they are not equal
	 */
     bool operator==(const arRealPoint& pt) const { return x == pt.x && y == pt.y; }
	/**
	 * Comparison method
	 *
	 * @param pt arRealPoint to compare this one to
	 * @return true=they are not equal, false=they are equal
	 */
     bool operator!=(const arRealPoint& pt) const { return x != pt.x || y != pt.y; }

	// arithmetic operations (component wise)
	/**
	 * Addition operator, adds a point to this one, vector style
	 *
	 * @param p The point to add to this one
	 * @return A new point with the value p + *this
	 */
    arRealPoint operator+(const arRealPoint& p) const { return arRealPoint(x + p.x, y + p.y); }
	/**
	 * Subtraction operator, subtracts a point from this one, vector style
	 *
	 * @param p The point to subtract from this one
	 * @return A new point with the value p - *this
	 */
    arRealPoint operator-(const arRealPoint& p) const { return arRealPoint(x - p.x, y - p.y); }

	/**
	 * Addition operator, adds a point to this one, vector style
	 *
	 * @param p The point to add to this one
	 * @return This point with the value p + *this
	 */
    arRealPoint& operator+=(const arRealPoint& p) { x += p.x; y += p.y; return *this; }
	/**
	 * Subtraction operator, subtracts a point from this one, vector style
	 *
	 * @param p The point to subtract from this one
	 * @return This point with the value p - *this
	 */
    arRealPoint& operator-=(const arRealPoint& p) { x -= p.x; y -= p.y; return *this; }

	/**
	 * Addition operator, adds a size to this one, vector style
	 *
	 * @param s The size to add to this one
	 * @return This point with the value s + *this
	 */
    arRealPoint& operator+=(const arRealSize& s) { x += s.GetWidth(); y += s.GetHeight(); return *this; }
	/**
	 * Subtraction operator, subtracts a size from this one, vector style
	 *
	 * @param s The size to subtract from this one
	 * @return This point with the value s - *this
	 */
    arRealPoint& operator-=(const arRealSize& s) { x -= s.GetWidth(); y -= s.GetHeight(); return *this; }

	/**
	 * Addition operator, adds a size to this one, vector style
	 *
	 * @param s The size to add to this one
	 * @return A new point with the value s + *this
	 */
    arRealPoint operator+(const arRealSize& s) const { return arRealPoint(x + s.GetWidth(), y + s.GetHeight()); }
	/**
	 * Subtraction operator, subtracts a size from this one, vector style
	 *
	 * @param s The size to subtract from this one
	 * @return A new point with the value s - *this
	 */
    arRealPoint operator-(const arRealSize& s) const { return arRealPoint(x - s.GetWidth(), y - s.GetHeight()); }
 };
 
// ---------------------------------------------------------------------------
// arRealRect
// ---------------------------------------------------------------------------

/** 
 * @brief A floating point parallel to the wxPoint class.
 */
class arRealRect
{
public:
	/** 
	 * @brief Default constructor.
	 *
	 * Puts rect at origin, with 0 height and 0 width.
	 */
    arRealRect()
        : x(0.0), y(0.0), width(0.0), height(0.0)
        { }
        
    /** 
	 * @brief Copy Constructor
	 */
    arRealRect(const arRealRect & rr)
        : x(rr.x), y(rr.y), width(rr.width), height(rr.height)
        { }
	/** 
	 * @brief Extended constructor
	 *
	 * Allows caller to specify location and dimensions.
	 * 
	 * @param xx X coordinate
	 * @param yy Y Coordinate
	 * @param ww width
	 * @param hh height
	 */
    arRealRect(double xx, double yy, double ww, double hh)
        : x(xx), y(yy), width(ww), height(hh)
        { }
	/** 
	 * @brief Extended constructor, using arRealPoints
	 * 
	 * @param topLeft The location of the top left corner
	 * @param bottomRight The location of the bottom right corner
	 */
    arRealRect(const arRealPoint& topLeft, const arRealPoint& bottomRight);
	/** 
	 * @brief Extended constructor, using arRealPoint for location, and
	 * arRealSize for size
	 * 
	 * @param pos The top left corner of the rectangle
	 * @param size The size of the rectangle
	 */
    arRealRect(const arRealPoint& pos, const arRealSize& size);

    // default copy ctor and assignment operators ok

	/** 
	 * @brief Get the upper left corner, x coordinate
	 * 
	 * @return The x coordinate of the upper left corner
	 */
    double GetX() const { return x; }
	/** 
	 * @brief Set the upper left corner, x coordinate
	 * 
	 * @param xx The x coordinate of the upper left corner
	 */
    void SetX(double xx) { x = xx; }

	/** 
	 * @brief Get the upper left corner, y coordinate
	 * 
	 * @return The y coordinate of the upper left corner
	 */
    double GetY() const { return y; }
	/** 
	 * @brief Set the upper left corner, y coordinate
	 * 
	 * @param yy The y coordinate of the upper left corner
	 */
    void SetY(double yy) { y = yy; }

	/** 
	 * @brief Get the width
	 * 
	 * @return The width
	 */
    double GetWidth() const { return width; }
	/** 
	 * @brief Set the width
	 * 
	 * @param w The width
	 */
    void SetWidth(double w) { width = w; }

	/** 
	 * @brief Get the height
	 * 
	 * @return The height
	 */
    double GetHeight() const { return height; }
	/** 
	 * @brief Set the height
	 * 
	 * @param h The height
	 */
    void SetHeight(double h) { height = h; }

	/** 
	 * @brief Get the upper left corner as a point
	 * 
	 * @return The upper left corner as a point
	 */
    arRealPoint GetPosition() const { return arRealPoint(x, y); }
	/** 
	 * @brief Set the upper left corner as a point
	 * 
	 * @param p The upper left corner as a point
	 */
    void SetPosition( const arRealPoint &p ) { x = p.x; y = p.y; }

	/** 
	 * @brief Get the dimensions as an arRealSize
	 * 
	 * @return The dimensions as an arRealSize 
	 */
    arRealSize GetSize() const { return arRealSize(width, height); }
	/** 
	 * @brief Set the dimensions from an arRealSize
	 * 
	 * @param s The dimensions as an arRealSize 
	 */
    void SetSize( const arRealSize &s ) { width = s.GetWidth(); height = s.GetHeight(); }

	/** 
	 * @brief Get the upper left corner as an arRealPoint
	 * 
	 * @return The upper left corner as an arRealPoint
	 */
    arRealPoint GetTopLeft() const { return GetPosition(); }
	/** 
	 * @brief Get the upper left corner as an arRealPoint
	 * 
	 * @return The upper left corner as an arRealPoint
	 */
    arRealPoint GetLeftTop() const { return GetTopLeft(); }
	/** 
	 * @brief Set the upper left corner as a point
	 * 
	 * @param p The upper left corner as a point
	 */
    void SetTopLeft(const arRealPoint &p) { SetPosition(p); }
	/** 
	 * @brief Set the upper left corner as a point
	 * 
	 * @param p The upper left corner as a point
	 */
    void SetLeftTop(const arRealPoint &p) { SetTopLeft(p); }

	/** 
	 * @brief Get the location of the bottom right corner as an arRealPoint
	 * 
	 * @return The location of the bottom right corner as an arRealPoint 
	 */
    arRealPoint GetBottomRight() const { return arRealPoint(GetRight(), GetBottom()); }
	/** 
	 * @brief Get the location of the bottom right corner as an arRealPoint
	 * 
	 * @return The location of the bottom right corner as an arRealPoint 
	 */
    arRealPoint GetRightBottom() const { return GetBottomRight(); }
	/** 
	 * @brief Set the location of the bottom right, using a point
	 * 
	 * @param p The arRealPoint which is to be the new bottom right
	 */
    void SetBottomRight(const arRealPoint &p) { SetRight(p.x); SetBottom(p.y); }
	/** 
	 * @brief Set the location of the bottom right, using a point
	 * 
	 * @param p The arRealPoint which is to be the new bottom right
	 */
    void SetRightBottom(const arRealPoint &p) { SetBottomRight(p); }

	/** 
	 * @brief Get the left edge
	 * 
	 * @return The left edge
	 */
    double GetLeft()   const { return x; }
	/** 
	 * @brief Get the top edge
	 * 
	 * @return The top edge
	 */
    double GetTop()    const { return y; }
	/** 
	 * @brief Get the bottom edge
	 * 
	 * @return The bottom edge
	 */
    double GetBottom() const { return y + height - 1; }
	/** 
	 * @brief Get the right edge
	 * 
	 * @return The right edge
	 */
    double GetRight()  const { return x + width - 1; }

	/** 
	 * @brief Set the left edge
	 * 
	 * @param left The left edge
	 */
    void SetLeft(double left) { x = left; }
	/** 
	 * @brief Set the right edge
	 * 
	 * @param right The right edge
	 */
    void SetRight(double right) { width = right - x + 1; }
	/** 
	 * @brief Set the top edge
	 * 
	 * @param top The top edge
	 */
    void SetTop(double top) { y = top; }
	/** 
	 * @brief Set the bottom edge
	 * 
	 * @param bottom The bottom edge
	 */
    void SetBottom(double bottom) { height = bottom - y + 1; }

	/** 
	 * @brief Increases the area covered by the rectangle
	 * 
	 * @param dx How much to increase the width by
	 * @param dy How much to increase the height by
	 * 
	 * @return a new ArRealRect which reflects the new size
	 */
    arRealRect& Inflate(double dx, double dy);
	/** 
	 * @brief Increases the area covered by the rectangle
	 * 
	 * @param d Amount to increase the height and width by
	 * 
	 * @return a new ArRealRect which reflects the new size
	 */
    arRealRect& Inflate(double d) { return Inflate(d, d); }
	/** 
	 * @brief Increases the area covered by the rectangle
	 * 
	 * @param dx How much to increase the width by
	 * @param dy How much to increase the height by
	 * 
	 * @return a new ArRealRect which reflects the new size
	 */
    arRealRect Inflate(double dx, double dy) const
    {
        arRealRect r = *this;
        r.Inflate(dx, dy);
        return r;
    }

	/** 
	 * @brief Decreases the area covered by the rectangle
	 * 
	 * @param dx How much to decrease the width by
	 * @param dy How much to decrease the height by
	 * 
	 * @return a new ArRealRect which reflects the new size
	 */
    arRealRect& Deflate(double dx, double dy) { return Inflate(-dx, -dy); }
	/** 
	 * @brief Decreases the area covered by the rectangle
	 * 
	 * @param d How much to decrease the width and height by
	 * 
	 * @return a new ArRealRect which reflects the new size
	 */
    arRealRect& Deflate(double d) { return Inflate(-d); }
	/** 
	 * @brief Decreases the area covered by the rectangle
	 * 
	 * @param dx How much to decrease the width by
	 * @param dy How much to decrease the height by
	 * 
	 * @return a new ArRealRect which reflects the new size
	 */
    arRealRect Deflate(double dx, double dy) const
    {
        arRealRect r = *this;
        r.Deflate(dx, dy);
        return r;
    }

	/** 
	 * @brief Adjust the location of the arRealRect by a delta value
	 * 
	 * @param dx How much to adjust x by
	 * @param dy How much to adjust y by
	 */
    void Offset(double dx, double dy) { x += dx; y += dy; }
	/** 
	 * @brief Adjust the location of the arRealRect by a delta value
	 * (represented by an arRealPoint)
	 * 
	 * @param pt The point which contains the offset values
	 */
    void Offset(const arRealPoint& pt) { Offset(pt.x, pt.y); }

	/** 
	 * @brief Return a rectangle which consists of the intersection of two
	 * rectangles, *this and rect
	 * 
	 * @param rect The rect to use with *this to determine the intersection
	 * 
	 * @return A new rect containing the intersection of *this and rect
	 */
    arRealRect& Intersect(const arRealRect& rect);
	/** 
	 * @brief Return a rectangle which consists of the intersection of two
	 * rectangles, *this and rect
	 * 
	 * @param rect The rect to use with *this to determine the intersection
	 * 
	 * @return A new rect containing the intersection of *this and rect
	 */
    arRealRect Intersect(const arRealRect& rect) const
    {
        arRealRect r = *this;
        r.Intersect(rect);
        return r;
    }

	/** 
	 * @brief Set the rectangle to be the smallest rectangle which
	 * includes both rectangles
	 * 
	 * @param rect The rectangle to join with this one
	 * 
	 * @return An arRealRect which contains *this and rect
	 */
    arRealRect operator+(const arRealRect& rect) const;
	/** 
	 * @brief Set the rectangle to be the smallest rectangle which
	 * includes both rectangles
	 * 
	 * @param rect The rectangle to join with this one
	 * 
	 * @return An arRealRect which contains *this and rect
	 */
    arRealRect& operator+=(const arRealRect& rect);

	/** 
	 * @brief Equality operator
	 * 
	 * @param rect rectangle to compare to *this
	 * 
	 * @return true if they are equal, false if they are not
	 */
    bool operator==(const arRealRect& rect) const;
	/** 
	 * @brief Inequality operator
	 * 
	 * @param rect rectangle to compare to *this
	 * 
	 * @return false if they are equal, true if they are not
	 */
    bool operator!=(const arRealRect& rect) const { return !(*this == rect); }

	/** 
	 * @brief Check to see if a point is inside this rect
	 * 
	 * @param x The x coordinate of the point to check
	 * @param y The y coordinate of the point to check
	 * 
	 * @return true if it is inside, false if it is not
	 */
    bool Inside(double x, double y) const;
	/** 
	 * @brief Check to see if a point is inside this rect
	 * 
	 * @param pt The point to check
	 * 
	 * @return true if it is inside, false if it is not
	 */
    bool Inside(const arRealPoint& pt) const { return Inside(pt.x, pt.y); }

	/** 
	 * @brief Check to see if this arRealRect intersects with another
	 * 
	 * @param rect The rectangle to compare this one to
	 * 
	 * @return true if they intersect, false if they do not
	 */
    bool Intersects(const arRealRect& rect) const;

public:
	/** 
	 * @var x
	 * The left edge of the rectangle
	 */
	/**
	 * @var y
	 * The top edge of the rectangle
	 */
	/**
	 * @var width
	 * The width of the rectangle
	 */
	/**
	 * @var height
	 * The height of the rectangle
	 */
    double x, y, width, height;
};

#endif //ARREALTYPES_H
