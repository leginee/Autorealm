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

#include "globals.h"
#include "types.h"
#include "matrixmath.h"
#include "generic_library.h"

double deg2rad(double degrees) {
    return(rad * degrees);
}

double deg2rad(int degrees) {
    return(rad * (double)degrees);
}

Matrix3::Matrix3(double c11, double c12, double c13,
                 double c21, double c22, double c23,
                 double c31, double c32, double c33) {
    array[0][0] = c11; array[0][1] = c12; array[0][2] = c13;
    array[1][0] = c21; array[1][1] = c22; array[1][2] = c23;
    array[2][0] = c31; array[2][1] = c32; array[2][2] = c33;
};

Matrix3::Matrix3(const Matrix3& rhs) {
    int x,y;
    for(x = 0; x < 3; x++)
        for(y = 0; y < 3; y++)
            array[x][y] = rhs.cell(x,y);
}

const double& Matrix3::cell(int x, int y) const {
    if((x < 0) || (x > 2) || (y < 0) || (y > 2)) throw ERR_INDEX_OUT_OF_BOUNDS;
    return array[x][y];
}

double& Matrix3::cell(int x, int y) {
    if((x < 0) || (x > 2) || (y < 0) || (y > 2)) throw ERR_INDEX_OUT_OF_BOUNDS;
    return array[x][y];
}

bool Matrix3::operator==(const Matrix3& other) const {
    return  (array[0][0] == other.cell(0,0)) &&
            (array[0][1] == other.cell(0,1)) &&
            (array[0][2] == other.cell(0,2)) &&
            (array[1][0] == other.cell(1,0)) &&
            (array[1][1] == other.cell(1,1)) &&
            (array[1][2] == other.cell(1,2)) &&
            (array[2][0] == other.cell(2,0)) &&
            (array[2][1] == other.cell(2,1)) &&
            (array[2][2] == other.cell(2,2));
}

Matrix3 Matrix3::operator*(const Matrix3& m) const {
    Matrix3 retval;
    int x,y;
    
    for(y = 0; y < 3; y++)
        for(x = 0; x < 3; x++)
            retval.cell(x,y) =  array[y][0] * m.cell(0, x) +
                                array[y][1] * m.cell(1, x) +
                                array[y][2] * m.cell(2, x);

    return retval;
}

bool Matrix3::isPureOffset() const {
    return (*this) == offset(array[2][0],array[2][1]);
}

Matrix3& Matrix3::operator=(const Matrix3& rhs) {
    int x,y;
    for(x = 0; x < 2; x++)
        for(y = 0; y < 2; y++)
            array[x][y] = rhs.cell(x,y);

    return *this;
}

Matrix3 Matrix3::rotation(double degrees) {
    double rad = deg2rad(-degrees);
    return Matrix3( cos(rad),  sin(rad), 0,
                    -sin(rad), cos(rad), 0,
                    0,         0,        1);
}

Matrix3 Matrix3::scale(double xfactor, double yfactor) {
    return Matrix3( xfactor, 0,       0,
                    0,       yfactor, 0,
                    0,       0,       1);
}

Matrix3 Matrix3::offset(double dx, double dy) {
    return Matrix3( 1,  0,  0,
                    0,  1,  0,
                    dx, dy, 1);
}

Matrix3 Matrix3::skew(double sx, double sy) {
    return Matrix3( 1,  sy, 0,
                    sx, 1,  0,
                    0,  0,  1);
}

Matrix3 Matrix3::flip(bool xaxis, bool yaxis) {
    return scale( (xaxis ? -1 : 1), (yaxis ? -1 : 1) );
}

/**
 * Note: Makes the assumption that since the matrix is homogenous
 * matrix, the last column is 0,0,1
 */
arRealPoint multiplyPointByMatrix(const arRealPoint& p, const Matrix3& m) {
    return arRealPoint( p.x * m.cell(0,0) + p.y * m.cell(1,0) + m.cell(2,0),
                        p.x * m.cell(0,1) + p.y * m.cell(1,1) + m.cell(2,1));
}
