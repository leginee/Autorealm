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

#ifndef MATRIXMATH_H
#define MATRIXMATH_H

#include "geometry.h"
/**
 * @var const inst ERR_INDEX_OUT_OF_BOUNDS
 * @brief If someone tries to get a value from the matrix that doesn't actually exist, this exception is thrown.
 */
const int ERR_INDEX_OUT_OF_BOUNDS = 1;

/**
 * @class Matrix3
 * @brief wraps up a 3x3 matrix in a nice little bundle
 *
 * This matrix class is used mostly for matrix transforms.
 */
class Matrix3 {
    private:
        double array[3][3];

    public:
        /**
         * @brief Constructor where the individual elements can be specified
         * @param c11 - the cell to put a value in
         * @param c21 - the cell to put a value in
         * @param c31 - the cell to put a value in
         * @param c12 - the cell to put a value in
         * @param c22 - the cell to put a value in
         * @param c32 - the cell to put a value in
         * @param c13 - the cell to put a value in
         * @param c23 - the cell to put a value in
         * @param c33 - the cell to put a value in
         */
        Matrix3(double c11=0.0, double c12=0.0, double c13=0.0,
                double c21=0.0, double c22=0.0, double c23=0.0,
                double c31=0.0, double c32=0.0, double c33=0.0);
        
        /**
         * @brief copy constructor
         *
         * @param rhs The matrix to copy from
         */
        Matrix3(const Matrix3& rhs);
        
        /**
         * @brief to get a reference to an individual data point
         * I wanted to use [], but you can't have two arguments
         *
         * @param x The column of the cell to be referenced
         * @param y The row of the cell to be referenced
         * @return A reference to the cell
         */
        double& cell(int x, int y);

        /**
         * @brief to get the value of the cell without discarding const qualifiers
         *
         * @param x The column of the cell to be referenced
         * @param y The row of the cell to be referenced
         * @return A const reference to the cell
         */
        const double& cell(int x, int y) const;
        
        /**
         * @brief are the two matrixes the same?
         *
         * @param m The matrix to compare to
         * @return true if they are, false if they are not
         */
        bool operator==(const Matrix3& m) const;
        
        /**
         * @brief allows matrix multiplication
         *
         * @param m The matrix to multiply by
         * @return The new matrix (this * m)
         */
        Matrix3 operator*(const Matrix3& m) const;

        /**
         * @brief determines whether this matrix is a pure offset matrix
         *
         * @return true if this is a pure offset matrix, false if not
         */
        bool isPureOffset() const;
        
        /**
         * @brief allows statemenst of the form matrix2=matrix1
         *
         * @param rhs The matrix to copy from
         */
        Matrix3& operator=(const Matrix3& rhs);

        /**
         * @brief creates a rotation matrix and passes it back
         *
         * @param degrees How much rotation should this matrix supply
         * @return A matrix which will rotate by that many degrees
         */
        static Matrix3 rotation(double degrees);

        /**
         * @brief creates a scaling matrix and passes it back
         *
         * @param xfactor The scaling factor in the x direction
         * @param yfactor The scaling factor in the y direction
         * @return A matrix which will scale by the specified x and y
         * factors
         */
        static Matrix3 scale(double xfactor, double yfactor);

        /**
         * @brief creates an offset matrix and passes it back
         *
         * @param dx How much to offset in the x direction
         * @param dy How much to offset in the y direction
         * @return A matrix which will offset by the specified x and y
         * factors
         */
        static Matrix3 offset(double dx, double dy);

        /**
         * @brief creates a skew matrix and passes it back
         *
         * @param sx How much to skew in the x direction
         * @param sy How much to skew in the y direction
         * @return A matrix which will skew by the specified x and y
         * factors
         */
        static Matrix3 skew(double sx, double sy);

        /**
         * @brief creates a flip matrix and passes it back
         *
         * @param xaxis Whether or not to allow to flip on the x axis
         * @param yaxis Whetehr or not to allow to flip on the y axis
         * @return A matrix which will flip in the specified directions
         */
        static Matrix3 flip(bool xaxis, bool yaxis);

};

/**
 * @brief Multiply a point by a matrix
 *
 * @param p The point to be multiplied
 * @param m The matrix by which to multiply it
 * @return The point after having been multiplied by the matrix.
 */
arRealPoint multiplyPointByMatrix(const arRealPoint& p, const Matrix3& m);

/**
 * @brief Converts degrees to radians.
 *
 * @param degrees the degrees to be converted
 * @return the degrees expressed as radians
 */
double deg2rad(int degrees);
/**
 * @brief Converts degrees to radians.
 *
 * @param degrees the degrees to be converted
 * @return the degrees expressed as radians
 */
double deg2rad(double degrees);

#endif // MATRIXMATH_H
