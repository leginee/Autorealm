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
#include <time.h>
#include "rand.h"

static wxUint32 rndseed=time(NULL);

void setRndSeed(wxUint32 seed) {
    rndseed = seed;
}

wxUint32 getRndSeed() {
    return(rndseed);
}

wxUint32 getRndNumber(wxUint32 range) {
/**
 * This is a standardized random number generator for use across pretty well
 * all platforms. At the time it was first written, the major concern was for
 * the ability to work on even 16 bit systems. While this is no longer a
 * concern, the random number generator still reflects some of these concerns.
 * For further details about why to choose this pseudo-random number generator
 * over any others, please refer to "The Communications of the ACM" October
 * 1988, Vol. 31, Issue 10.
*/

// This PRNG went through a few re-writes, mostly out of curiousity. The
// end result of the experimentation was only to satisfy my curiousity.
// The iterations are listed as follows:
//
// 1) Highly portable, floating point version. Works on everything,
//    basically.
// 2) Version using unsigned long long int (int64)
// 3) Version using doubles, without using the "high portability" stuff
//
// PRNG, v1
//    const double a=16807.0;
//    const double m=2147483647.0;
//    const double q=127773.0; // m div a
//    const double r=2836.0;   // m mod a
//
//    double lo, hi, test;
//
//    hi = (double)(long)(rndseed / q);
//    lo = rndseed - (q * hi);
//    test = (a * lo) - (r * hi);
//    rndseed = test + ((test > 0.0) ? 0.0 : m);
//    return(rndseed / m);
// PRNG, v2
//    const long long a=16807;
//    const long long m=2147483647;
//    rndseed = (a*rndseed) % m;
//    return ((double)rndseed / (double)m);
// PRNG, v3
//    const double a = 16807.0;
//    const double m = 2147483647.0;
//    double temp = a*rndseed;
//    rndseed = temp - (m * (unsigned long long)(temp/m));
//    return (rndseed/m);
//
// The thing I found most curious was how there was no appreciable time
// difference between these three very different implementations. Running
// for 100,000,000 iterations took approximately 10 seconds for each of
// the three versions. Given the choice, I would use v2 in the future for
// any such work, simply because it is the easiest to maintain and read
// later.
//
// The final version is Delphi compatible, and should produce the exact
// same results as the Delphi PRNG. This is necessary to preserve
// compatibility with the fractal line generator used by prior versions
// of AutoRealm. It is also worth noting the speed boost achieved by this
// method: 100,000,000 calls to this function takes between 1 and 2
// seconds, at most.
    rndseed = (rndseed * 0x08088405) + 1;
    return (wxUint32)(((wxUint64)range * (wxUint64)rndseed) >> 32);
}
