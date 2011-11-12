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

#include <wx/wx.h>

/**
 * A library routine to set the random number seed.
 * @param seed A new seed to be used
 */
void setRndSeed(wxUint32 seed);

/** 
 * A library routine to get the current random number seed.
 * @return a double indicating the current seed.
 */
wxUint32 getRndSeed();

/**
 * This is a rewrite of the PRNG from Delphi. The algorithm was supplied
 * by AndyGryc, who wrote it in C, using GCC data types (long long, for
 * instance).
 *
 * This rewrite was then written by myself (Michael Pedersen) from that
 * code.  This is necessary to preserve compatibility with the fractal
 * line generator used by prior versions of AutoRealm. It is also worth
 * noting the speed boost achieved by this method: 100,000,000 calls to
 * this function takes between 1 and 2 seconds, at most.
 *
 * @param range The maximum value of the random number to be produced. Defaults
 * to 2^32-1
 */
wxUint32 getRndNumber(wxUint32 range=2147483637);
