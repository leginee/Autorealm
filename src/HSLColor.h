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

#ifndef HSLCOLOR_H
#define HSLCOLOR_H
#include <wx/colour.h>


/**
 * A simple class to turn a wxColor into a Hue, Saturation and Luminance.
 * 
 * This class uses a variant of the following algorith from http://130.113.54.154/~monger/hsl-rgb.html
 * 
 * RGB - HSL
 *
 *  1. Convert the RBG values to the range 0-1
 *    
 *  2. Find min and max values of R, B, G
 *     In the example, maxcolor = .83, mincolor=.07
 *
 *  3. L = (maxcolor + mincolor)/2
 *     For the example, L = (.83+.07)/2 = .45
 *
 *  4. If the max and min colors are the same (ie the color is some kind of grey), S is defined to be 0, and H is undefined but in programs usually written as 0
 *
 *  5. Otherwise, test L.
 *     If L < 0.5, S=(maxcolor-mincolor)/(maxcolor+mincolor)
 *     If L >=0.5, S=(maxcolor-mincolor)/(2.0-maxcolor-mincolor)
 *     For the example, L=0.45 so S=(.83-.07)/(.83+.07) = .84
 *
 *  6. If R=maxcolor, H = (G-B)/(maxcolor-mincolor)
 *     If G=maxcolor, H = 2.0 + (B-R)/(maxcolor-mincolor)
 *     If B=maxcolor, H = 4.0 + (R-G)/(maxcolor-mincolor)
 *     For the example, R=maxcolor so H = (.07-.07)/(.83-.07) = 0
 *
 *  7. To use the scaling shown in the video color page, convert L and S back to 
 * 		percentages, and H into an angle in degrees (ie scale it from 0-360). From the 
 * 		computation in step 6, H will range from 0-6. RGB space is a cube, and HSL space 
 * 		is a double hexacone, where L is the principal diagonal of the RGB cube. Thus corners of 
 * 		the RGB cube; red, yellow, green, cyan, blue, and magenta, become the vertices 
 * 		of the HSL hexagon. Then the value 0-6 for H tells you which section of the 
 * 		hexgon you are in. H is most commonly given as in degrees, so to convert
 *     H = H*60.0
 *     If H is negative, add 360 to complete the conversion. 
 */
class HSLColor {
	public:
		/**
		 * Constructor to take a wxColor, pull the RGB values and convert
		 */
		HSLColor(const wxColor & color);
		
		/**
		 * The hue of the color from 0-255
		 */
		unsigned short int  hue() const { return m_hue; }

		/**
		 * The saturation of the color from 0-255
		 */
		unsigned short int  saturation() const { return m_saturation; }

		/**
		 * The luminance of the color from 0-255
		 */		
		unsigned short int  luminance() const { return m_luminance; }

	protected:
		/**
		 * Calculates the hue, saturation and luminance
		 */
		void CalculateHSL(const wxColor & color);
	
		/**
		 * The hue of the color
		 */
		unsigned short int  m_hue;
		/**
		 * The saturation of the color
		 */
		unsigned short int  m_saturation;
		/**
		 * The luminance of the color
		 */
		unsigned short int  m_luminance;
};

#endif //HSLCOLOR_H
