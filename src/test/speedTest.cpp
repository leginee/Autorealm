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
#include <iostream>
#include <vector>
#include <time.h>
#include <stdio.h>

extern void PrintHeader(const char * szHeading);
extern void PrintFooter();

/**
 * Main driver for the speed tester. This is a simple test, meant to help us
 * keep track of the speed of various primitives, so we can try to keep them fast
 * (and see when we're letting them get too slow).
 *
 * All we really have to do is include the proper header file, and add another
 * line (such as the one below) whenever we create another primitive.
 */
void speedTest() {
	
	PrintHeader("Speeds");
	
	std::vector<void *> vecFoo;
	for(int i=1; i<1000000; i++)
	{
		vecFoo.push_back(NULL);
	}
	
	time_t tStart = time(NULL);
	
	//pretend we are moving elements around.

	std::vector<void*>::iterator it = vecFoo.end();
	it--;
	vecFoo.erase(it);
	it = vecFoo.begin();
	it += 4;
	
	vecFoo.insert(it, NULL);
	
	time_t tEnd = time(NULL);
	
	printf("Elapsed time (sec): %f\n", difftime(tEnd, tStart));

	PrintFooter();
}
