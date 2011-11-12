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


#include <wx/log.h>
#include <math.h>

#include "HSLColor.h"
#include "Tracer.h"

TRACEFLAG(wxT("HSLColor"));

HSLColor::HSLColor(const wxColor & color)
{
	TRACER(wxT("HSLColor::HSLColor(const wxColor &)"));
	CalculateHSL(color);
}

void HSLColor::CalculateHSL(const wxColor & color)
{
	TRACER(wxT("HSLColor::CalculateHSL(const wxColor &)"));
	
	// 1. Convert the RBG values to the range 0-1
	float fRed  	= color.Red() / 255.0f;
	float fBlue   	= color.Blue() / 255.0f;
	float fGreen   	= color.Green() / 255.0f;
	
	// 2. Find min and max values of R, B, G
	float minColor = fminf(fRed, fminf(fBlue, fGreen));
	float maxColor = fmaxf(fRed, fmaxf(fBlue, fGreen));
	
	// 3. L = (maxcolor + mincolor)/2
	float fLum = (maxColor+minColor)/2.0f;
	
	//4. If the max and min colors are the same (ie the color is some kind of grey), 
	//S is defined to be 0, and H is undefined but in programs usually written as 0
	float fSat =0.0f, fHue = 0.0f;
#ifdef __WXDEBUG__
	{
		wxString tmsg;
		tmsg.Printf(wxT("fRed: %f, fBlue: %f, fGreen: %f, minColor: %f, maxColor: %f"), fRed, fBlue, fGreen, minColor, maxColor);
		TRACE(tmsg);
		tmsg.Printf(wxT("fLum: %f, fSat: %f, fHue: %f"), fLum, fSat, fHue);
		TRACE(tmsg);
	}
#endif
	if(minColor != maxColor) {
		TRACE(wxT("minColor != maxColor"));
		//5. Otherwise, test L.
		//   If L <= 0.5, S=(maxcolor-mincolor)/(maxcolor+mincolor)
		//   If L >=0.5, S=(maxcolor-mincolor)/(2.0-maxcolor-mincolor)
		if(fLum <= 0.5f) {
			fSat = (maxColor-minColor)/(maxColor+minColor);
		} else {
			fSat = (maxColor-minColor)/(2.0-maxColor-minColor);
		}
#ifdef __WXDEBUG__
		{
			wxString tmsg;
			tmsg.Printf(wxT("fSat: %f"), fSat);
			TRACE(tmsg);
		}
#endif
		
		// 6. If R=maxcolor, H = (G-B)/(maxcolor-mincolor)
		//     If G=maxcolor, H = 2.0 + (B-R)/(maxcolor-mincolor)
		//     If B=maxcolor, H = 4.0 + (R-G)/(maxcolor-mincolor)
		if(fRed == maxColor) {
			fHue = (fGreen-fBlue)/(maxColor-minColor);
		} else if(fGreen == maxColor) {
			fHue = 2.0f + (fBlue-fRed)/(maxColor-minColor);
		} else { // fBlue == maxColor
			fHue = 4.0f + (fRed-fGreen)/(maxColor-minColor);
		}
#ifdef __WXDEBUG__
		{
			wxString tmsg;
			tmsg.Printf(wxT("fHue: %f"), fHue);
			TRACE(tmsg);
		}
#endif
	}
	
/*  7. To use the scaling shown in the video color page, convert L and S back to 
 * 		percentages, and H into an angle in degrees (ie scale it from 0-360). From the 
 * 		computation in step 6, H will range from 0-6. RGB space is a cube, and HSL space 
 * 		is a double hexacone, where L is the principal diagonal of the RGB cube. Thus corners of 
 * 		the RGB cube; red, yellow, green, cyan, blue, and magenta, become the vertices 
 * 		of the HSL hexagon. Then the value 0-6 for H tells you which section of the 
 * 		hexgon you are in. H is most commonly given as in degrees, so to convert
 *     H = H*60.0
 *     If H is negative, add 360 to complete the conversion. 
 */
 	m_luminance 	= static_cast<unsigned short int>(rintf(fLum * 255.0f));
 	m_saturation 	= static_cast<unsigned short int>(rintf(fSat * 255.0f));
 	
 	int iTempHue  = static_cast<int>(rintf(fHue * 255.0f / 6.0f));
 	if(iTempHue < 0) {
		TRACE(wxT("iTempHue < 0"));
 		iTempHue += 255;
 	}
 	
	m_hue = static_cast<unsigned short int>(iTempHue); 	
#ifdef __WXDEBUG__
	{
		wxString tmsg;
		tmsg.Printf(wxT("lum: %d, sat: %d, hue: %d"), m_luminance, m_saturation, m_hue);
		TRACE(tmsg);
	}
#endif
}
