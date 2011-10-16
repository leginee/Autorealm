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
#include <iostream>
#include <time.h>
#include "rand.h"

int main(int argc, char** argv) {
    wxUint32 u;
    wxUint32 seed;
    setRndSeed(1);
    for (int i=0; i<10000; i++) { u = getRndNumber(2147483637); }
    seed = getRndSeed();
    std::cout <<"The current value of seed is: " << seed << ", and this is " ;
    if (seed == 1361578161) {
        std::cout <<"what it should be. PASS!\n";
    } else {
        std::cout <<"NOT what it should be. FAIL!\n";
    }
    time_t start, end;
    start = time(NULL);
    for (int i=0; i<100000000; i++) { u = getRndNumber(2147483637); }
    end = time(NULL);
    std::cout << "This took " << end - start << " seconds\n";

    bool found=false;
    int i=0;
    int rndNum;
    wxUint32 rndNumL;

    while ((i++<10000) && (!found)) {
        seed = getRndSeed();
        rndNum = getRndNumber(10);
        found = ((rndNum >= 0) && (rndNum <= 10)) ? false : true;
        if (found) {
            setRndSeed(seed);
            rndNumL = getRndNumber(10);
        } else {
            rndNumL = rndNum;
        }
    }

    if (found) {
        std::cout << "Found invalid number: " << rndNum << ", wxUint32 = " << rndNumL << "\n";
    } else {
        std::cout << "No invalid number found.\n";
    }
}
