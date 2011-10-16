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
 *
 * This file contains many drawing functions used to actually place things
 * on-screen.
 */

#include <cmath>
#include <algorithm>

#include "generic_library.h"
#include "rand.h"
#include "DrawLines.h"
#include "LinePoints.h"
#include "geometry.h"

struct GlyphData {
	int width;
	int count;
	int start;
};

struct EndPointData {
	int width;
	int count;
	int start;
	int depth;
};

struct RandomData {
	int PatternWidth;
	int DotCount;
	int DotWidth;
	int DotType;
};

const int AllocationGrowth = 200;      // How large we grow SEGMENT_STYLE allocations at a gulp
const int fractal_depth = 16;          // number times we recurse the fractals for bounding box computations

const unsigned int dashdot[number_dithered_styles]={
	0x55555555,       // .O.O-X-X.O.O-X-X.O.O-X-X.O.O-X-X
	0xFFC3C3FF,       // OOOOXXXXOO..--XXOO..--XXOOOOXXXX
	0xFF1E3CFF,       // OOOOXXXX...OXXX-..OOXX--OOOOXXXX
	0xFFF3FFF3,       // OOOOXXXXOOOO--XXOOOOXXXXOOOO--XX
	0xF99F33CC,       // OOOOX--XO..OXXXX..OO--XXOO..XX--
	0x0F0F0F0F,       // ....XXXX....XXXX....XXXX....XXXX
	0x11111111,       // ...O---X...O---X...O---X...O---X
	0x10101010,       // ...O----...O----...O----...O----
	0xFFFFF924        // OOOOXXXXOOOOXXXXOOOOX--X..O.-X--
};

const unsigned int GlyphBits[531]={
	/*0*/   0x10,          // ---X----
	        0x20,          // --X-----
	        0x40,          // -X------
	        0x20,          // --X-----
	        0x10,          // ---X----
	        0x08,          // ----X---
	        0x04,          // -----X--
	        0x08,          // ----X---
	
	/*8*/   0x42,          // -X----X-
	
	/*9*/   0x24,          // --X--X--
	
	/*10*/  0x14,          // ---X-X--
	
	/*11*/  0x18,          // ---XX---
	        0x3C,          // --XXXX--
	        0x18,          // ---XX---
	        0x00,          // --------
	
	/*15*/  0xFF,          // XXXXXXXX
	        0x00,          // --------
	
	/*17*/  0xFF,          // XXXXXXXX
	        0x00,          // --------
	        0x00,          // --------
	        0x00,          // --------
	
	/*21*/  0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0xFE,          // XXXXXXX-
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	
	/*30*/  0x0420,        // ----.X..--X-....
	        0x0420,        // ----.X..--X-....
	        0x0420,        // ----.X..--X-....
	        0x3FFC,        // --XXXXXXXXXXXX..
	        0x0420,        // ----.X..--X-....
	        0x0420,        // ----.X..--X-....
	        0x0420,        // ----.X..--X-....
	        0x0420,        // ----.X..--X-....
	        0x0420,        // ----.X..--X-....
	
	/*39*/  0x3C,          // --XXXX--
	        0x00,          // --------
	
	/*41*/  0x3C,          // --XXXX--
	        0x00,          // --------
	        0x00,          // --------
	        0x00,          // --------
	
	/*45*/  0x14,          // ---X-X--
	        0x14,          // ---X-X--
	        0x14,          // ---X-X--
	        0x14,          // ---X-X--
	        0x00,          // --------
	        0x00,          // --------
	
	/*51*/  0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0xFE,          // XXXXXXX-
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x00,          // --------
	        0x00,          // --------
	
	/*60*/  0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x1E,          // ---XXXX-
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0xF0,          // XXXX----
	        0x10,          // ---X----
	        0x10,          // ---X----
	
	/*72*/  0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x1E,          // ---XXXX-
	        0x10,          // ---X----
	        0x1E,          // ---XXXX-
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0xF0,          // XXXX----
	        0x10,          // ---X----
	        0xF0,          // XXXX----
	
	/*86*/  0x00,          // --------
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x1E,          // ---XXXX-
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x00,          // --------
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0xF0,          // XXXX----
	        0x10,          // ---X----
	        0x10,          // ---X----
	
	/*98*/  0x0B80,        // ----X.XXX---....
	        0x0580,        // ----.X.XX---....
	
	/*100*/ 0x2B80,        // --X-X.XXX---....
	        0x5580,        // -X-X.X.XX---....
	
	/*102*/ 0x10090000,    // ---X....----X..X----....----....
	        0x00090000,    // ----....----X..X----....----....
	        0x02490000,    // ----..X.-X--X..X----....----....
	        0x00410000,    // ----....-X--...X----....----....
	        0x10090000,    // ---X....----X..X----....----....
	        0x02090000,    // ----..X.----X..X----....----....
	        0x00490000,    // ----....-X--X..X----....----....
	        0x82410000,    // X---..X.-X--...X----....----....
	        0x00090000,    // ----....----X..X----....----....
	
	/*111*/ 0x12490000,    // ---X..X.-X--X..X----....----....
	        0x12490000,    // ---X..X.-X--X..X----....----....
	        0x12490000,    // ---X..X.-X--X..X----....----....
	        0x12490000,    // ---X..X.-X--X..X----....----....
	        0x12490000,    // ---X..X.-X--X..X----....----....
	        0x12490000,    // ---X..X.-X--X..X----....----....
	        0x12490000,    // ---X..X.-X--X..X----....----....
	        0x12490000,    // ---X..X.-X--X..X----....----....
	        0x12490000,    // ---X..X.-X--X..X----....----....
	
	/*120*/ 0x00,          // --------
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x7C,          // -XXXXX--
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x00,          // --------
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	
	/*132*/ 0x00,          // --------
	        0x38,          // --XXX---
	        0x44,          // -X---X--
	        0x44,          // -X---X--
	        0x44,          // -X---X--
	        0x38,          // --XXX---
	        0x00,          // --------
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	
	/*144*/ 0x38,          // --XXX---
	        0x44,          // -X---X--
	        0x44,          // -X---X--
	        0x44,          // -X---X--
	        0x38,          // --XXX---
	        0x00,          // --------
	
	/*150*/ 0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x38,          // --XXX---
	        0x7C,          // -XXXXX--
	        0x38,          // --XXX---
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	
	/*160*/ 0x00,          // --------
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x38,          // --XXX---
	        0x7C,          // -XXXXX--
	        0x38,          // --XXX---
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x00,          // --------
	        0x00,          // --------
	
	/*170*/ 0x7E,          // -XXXXXX-
	        0x42,          // -X----X-
	        0x42,          // -X----X-
	        0x42,          // -X----X-
	        0x42,          // -X----X-
	        0x42,          // -X----X-
	
	/*176*/ 0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x7C,          // -XXXXX--
	        0x7C,          // -XXXXX--
	        0x7C,          // -XXXXX--
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	
	/*186*/ 0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0xFE,          // XXXXXXX-
	        0x7C,          // -XXXXX--
	        0x38,          // --XXX---
	        0x10,          // ---X----
	        0x00,          // --------
	        0x00,          // --------
	
	/*196*/ 0x7E,          // -XXXXXX-
	        0x02,          // ------X-
	        0x02,          // ------X-
	        0x02,          // ------X-
	        0x7E,          // -XXXXXX-
	        0x40,          // -X------
	        0x40,          // -X------
	        0x40,          // -X------
	
	/*204*/ 0xFE,          // XXXXXXX-
	        0x12,          // ---X--X-
	        0x12,          // ---X--X-
	        0x12,          // ---X--X-
	        0xFE,          // XXXXXXX-
	        0x90,          // X--X----
	        0x90,          // X--X----
	        0x90,          // X--X----
	
	/*212*/ 0x00,          // --------
	        0x38,          // --XXX---
	        0x7C,          // -XXXXX--
	        0x38,          // --XXX---
	        0x00,          // --------
	        0x10,          // ---X----
	        0x00,          // --------
	        0x10,          // ---X----
	        0x00,          // --------
	        0x10,          // ---X----
	        0x00,          // --------
	        0x10,          // ---X----
	        0x00,          // --------
	        0x10,          // ---X----
	        0x00,          // --------
	        0x10,          // ---X----
	        0x00,          // --------
	        0x10,          // ---X----
	        0x00,          // --------
	        0x10,          // ---X----
	        0x00,          // --------
	
	/*233*/ 0xFF,          // XXXXXXXX
	        0x01,          // -------X
	        0x01,          // -------X
	        0x07,          // -----XXX
	        0x01,          // -------X
	        0x01,          // -------X
	        0x1F,          // ---XXXXX
	        0x01,          // -------X
	        0x01,          // -------X
	        0x07,          // -----XXX
	        0x01,          // -------X
	        0x01,          // -------X
	        0x7F,          // -XXXXXXX
	        0x01,          // -------X
	        0x01,          // -------X
	        0x07,          // -----XXX
	        0x01,          // -------X
	        0x01,          // -------X
	        0x1F,          // ---XXXXX
	        0x01,          // -------X
	        0x01,          // -------X
	        0x07,          // -----XXX
	        0x01,          // -------X
	        0x01,          // -------X
	
	/*257*/ 0x1F,          // ---XXXXX
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x10,          // ---X----
	
	/*262*/ 0x00,          // --------
	        0x00,          // --------
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x1F,          // ---XXXXX
	        0x10,          // ---X----
	        0x10,          // ---X----
	        0x00,          // --------
	        0x00,          // --------
	
	/*271*/ 0x00000C00,    // ----....----....----OO..----....
	        0x0000DC00,    // ----....----....XX-XOO..----....
	        0x000DFC00,    // ----....----OO.OXXXXOO..----....
	        0x001FFC00,    // ----....---XOOOOXXXXOO..----....
	        0x007FFC00,    // ----....-XXXOOOOXXXXOO..----....
	        0x01FFFFC0,    // ----...OXXXXOOOOXXXXOOOOXX--....
	        0x007FFC00,    // ----....-XXXOOOOXXXXOO..----....
	        0x001FFC00,    // ----....---XOOOOXXXXOO..----....
	        0x000DFC00,    // ----....----OO.OXXXXOO..----....
	        0x0000DC00,    // ----....----....XX-XOO..----....
	        0x00000C00,    // ----....----....----OO..----....
	        0x00000000,    // ----....----....----....----....
	        0x00000000,    // ----....----....----....----....
	        0x00000000,    // ----....----....----....----....
	        0x00000000,    // ----....----....----....----....
	
	/*286*/ 0x3C,          // --XXXX--
	        0x24,          // --X--X--
	        0x24,          // --X--X--
	        0x24,          // --X--X--
	        0x24,          // --X--X--
	        0x24,          // --X--X--
	        0x24,          // --X--X--
	        0x24,          // --X--X--
	        0x24,          // --X--X--
	        0x3C,          // --XXXX--
	        0x3C,          // --XXXX--
	        0x3C,          // --XXXX--
	        0x3C,          // --XXXX--
	        0x3C,          // --XXXX--
	        0x3C,          // --XXXX--
	        0x3C,          // --XXXX--
	        0x3C,          // --XXXX--
	        0x3C,          // --XXXX--
	
	/*304*/ 0xFE,          // XXXXXXX-
	        0x92,          // X--X--X-
	        0x92,          // X--X--X-
	        0x92,          // X--X--X-
	        0x92,          // X--X--X-
	        0x92,          // X--X--X-
	        0x92,          // X--X--X-
	        0x92,          // X--X--X-
	        0x92,          // X--X--X-
	        0xEE,          // XXX-XXX-
	        0xEE,          // XXX-XXX-
	        0xEE,          // XXX-XXX-
	        0xEE,          // XXX-XXX-
	        0xEE,          // XXX-XXX-
	        0xEE,          // XXX-XXX-
	        0xEE,          // XXX-XXX-
	        0xEE,          // XXX-XXX-
	        0xEE,          // XXX-XXX-
	
	/*322*/ 0x92,          // X--X--X-
	
	/*323*/ 0x000C0000,    // ----....----XX..----....----....
	        0x00070000,    // ----....----.XXX----....----....
	        0x0001C000,    // ----....----...XXX--....----....
	        0x00007000,    // ----....----....-XXX....----....
	        0x00001C00,    // ----....----....---XXX..----....
	        0x00007000,    // ----....----....-XXX....----....
	        0x0063C000,    // ----....-XX-..XXXX--....----....
	        0x00300000,    // ----....--XX....----....----....
	        0x000E0000,    // ----....----XXX.----....----....
	        0x00038000,    // ----....----..XXX---....----....
	        0x00070000,    // ----....----.XXX----....----....
	        0x001C1000,    // ----....---XXX..---X....----....
	        0x00701800,    // ----....-XXX....---XX...----....
	        0x00C00C00,    // ----....XX--....----XX..----....
	        0x00060600,    // ----....----.XX.----.XX.----....
	        0x00038700,    // ----....----..XXX---.XXX----....
	        0x0000DC00,    // ----....----....XX-XXX..----....
	        0x00007000,    // ----....----....-XXX....----....
	        0x00060000,    // ----....----.XX.----....----....
	        0x03030000,    // ----..XX----..XX----....----....
	        0x01838000,    // ----...XX---..XXX---....----....
	        0x00CE0000,    // ----....XX--XXX.----....----....
	        0x00387000,    // ----....--XXX...-XXX....----....
	        0x0003D800,    // ----....----..XXXX-XX...----....
	        0x000E0C00,    // ----....----XXX.----XX..----....
	        0x00180600,    // ----....---XX...----.XX.----....
	        0x00000700,    // ----....----....----.XXX----....
	        0x00001C00,    // ----....----....---XXX..----....
	        0x00003000,    // ----....----....--XX....----....
	        0x00001800,    // ----....----....---XX...----....
	        0x00070C00,    // ----....----XXX.----XX..----....
	        0x00039800,    // ----....----..XXX--XX...----....
	        0x0000F000,    // ----....----....XXXX....----....
	        0x00000000,    // ----....----....----....----....
	        0x00301800,    // ----....--XX....---XX...----....
	        0x001C3000,    // ----....---XXX..--XX....----....
	        0x00076000,    // ----....----.XXX-XX-....----....
	        0x0001C000,    // ----....----...XXX--....----....
	        0x00008000,    // ----....----....X---....----....
	        0x00000000,    // ----....----....----....----....
	        0x00060000,    // ----....----.XX.----....----....
	        0x00038000,    // ----....----..XXX---....----....
	        0x0000C000,    // ----....----....XX--....----....
	        0x00007000,    // ----....----....-XXX....----....
	        0x0C001800,    // ----XX..----X...---XX...----....
	        0x063C3000,    // ----.XX.--XXXX..--XX....----....
	        0x03676000,    // ----..XX-XX-.XXX-XX-....----....
	        0x01C1C000,    // ----...XXX--...XXX--....----....
	        0x00008000,    // ----....----....X---....----....
	        0x000C0000,    // ----....----XX..----....----....
	        0x00070000,    // ----....----.XXX----....----....
	        0x00018000,    // ----....----...XX---....----....
	        0x000E0000,    // ----....----XXX.----....----....
	        0x00000000,    // ----....----....----....----....
	
	/*377*/ 0x70,          // -XXX....
	        0xF0,          // XXXX....
	        0xF0,          // XXXX....
	        0x70,          // -XXX....
	        0xF0,          // XXXX....
	
	/*382*/ 0x0100,        // ----...X----....
	        0x0280,        // ----..X.X---....
	        0x0440,        // ----.X..-X--....
	        0x0820,        // ----X...--X-....
	        0x1010,        // ---X....---X....
	        0x2008,        // --X-....----X...
	
	/*388*/ 0x0100,        // ----...O----....
	        0x0380,        // ----..OOX---....
	        0x07C0,        // ----.OOOXX--....
	        0x0FE0,        // ----OOOOXXX-....
	        0x1FF0,        // ---XOOOOXXXX....
	        0x3FF8,        // --XXOOOOXXXXO...
	
	/*394*/ 0x0100,        // ----...O----....
	        0x0100,        // ----...O----....
	        0x0380,        // ----..OOX---....
	        0x0380,        // ----..OOX---....
	        0x07C0,        // ----.OOOXX--....
	        0x07C0,        // ----.OOOXX--....
	        0x0FE0,        // ----OOOOXXX-....
	        0x0FE0,        // ----OOOOXXX-....
	        0x1FF0,        // ---XOOOOXXXX....
	        0x1FF0,        // ---XOOOOXXXX....
	
	/*404*/ 0x07C0,        // ----.OOOXX......
	
	/*405*/ 0x1FF0,        // ---XOOOOXXXX....
	
	/*406*/ 0x7FFC,        // -XXXOOOOXXXXOO..
	
	/*407*/ 0x2008,        // --X-....----O...
	        0x1010,        // ---X....---X....
	        0x0820,        // ----O...--X-....
	        0x0440,        // ----.O..-X--....
	        0x0280,        // ----..O.X---....
	        0x0100,        // ----...O----....
	
	/*413*/ 0x1010,        // ---X....---X....
	        0x0820,        // ----O...--X-....
	        0x0440,        // ----.O..-X--....
	        0x1290,        // ---X..O.X--X....
	        0x0920,        // ----O..O--X-....
	        0x0540,        // ----.O.O-X--....
	        0x1390,        // ---X..OOX--X....
	        0x0920,        // ----O..O--X-....
	        0x0540,        // ----.O.O-X--....
	        0x0380,        // ----..OOX---....
	
	/*423*/ 0x8002,        // X---....----..O.
	        0x8002,        // X---....----..O.
	        0x4004,        // -X--....----.O..
	        0x3018,        // --XX....---XO...
	        0x0FE0,        // ----OOOOXXX-....
	
	/*428*/ 0x0FE0,        // ----OOOOXXX-....
	        0x3018,        // --XX....---XO...
	        0x4004,        // -X--....----.O..
	        0x8002,        // X---....----..O.
	        0x8002,        // X---....----..O.
	
	/*433*/ 0x0FE0,        // ----OOOOXXX-....
	        0x0820,        // ----O...--X-....
	        0x0820,        // ----O...--X-....
	        0x0820,        // ----O...--X-....
	        0x0820,        // ----O...--X-....
	        0x0820,        // ----O...--X-....
	        0x0FE0,        // ----OOOOXXX-....
	
	/*440*/ 0x0FE0,        // ----OOOOXXX-....
	        0x0FE0,        // ----OOOOXXX-....
	        0x0FE0,        // ----OOOOXXX-....
	        0x0FE0,        // ----OOOOXXX-....
	        0x0FE0,        // ----OOOOXXX-....
	        0x0FE0,        // ----OOOOXXX-....
	        0x0FE0,        // ----OOOOXXX-....
	
	/*447*/ 0x0380,        // ----..OOX---....
	        0x0440,        // ----.O..-X--....
	        0x0820,        // ----O...--X-....
	        0x0820,        // ----O...--X-....
	        0x0820,        // ----O...--X-....
	        0x0440,        // ----.O..-X--....
	        0x0380,        // ----..OOX---....
	
	/*454*/ 0x0380,        // ----..OOX---....
	        0x07C0,        // ----.OOOXX--....
	        0x0FE0,        // ----OOOOXXX-....
	        0x0FE0,        // ----OOOOXXX-....
	        0x0FE0,        // ----OOOOXXX-....
	        0x07C0,        // ----.OOOXX--....
	        0x0380,        // ----..OOX---....
	
	/*461*/ 0x0100,        // ----...O----....
	        0x0280,        // ----..O.X---....
	        0x0440,        // ----.O..-X--....
	        0x0820,        // ----O...--X-....
	        0x0440,        // ----.O..-X--....
	        0x0280,        // ----..O.X---....
	        0x0100,        // ----...O----....
	
	/*468*/ 0x0100,        // ----...O----....
	        0x0380,        // ----..OOX---....
	        0x07C0,        // ----.OOOXX--....
	        0x0FE0,        // ----OOOOXXX-....
	        0x07C0,        // ----.OOOXX--....
	        0x0380,        // ----..OOX---....
	        0x0100,        // ----...O----....
	
	/*475*/ 0x0100,        // ----...O----....
	        0x0100,        // ----...O----....
	        0x0280,        // ----..O.X---....
	        0x0280,        // ----..O.X---....
	        0x0440,        // ----.O..-X--....
	        0x0440,        // ----.O..-X--....
	        0x0820,        // ----O...--X-....
	        0x0820,        // ----O...--X-....
	        0x1010,        // ---X....---X....
	        0x1010,        // ---X....---X....
	
	/*485*/ 0x1FF0,        // ---XOOOOXXXX....
	        0x1FF0,        // ---XOOOOXXXX....
	        0x0FE0,        // ----OOOOXXX-....
	        0x0FE0,        // ----OOOOXXX-....
	        0x07C0,        // ----.OOOXX--....
	        0x07C0,        // ----.OOOXX--....
	        0x0380,        // ----..OOX---....
	        0x0380,        // ----..OOX---....
	        0x0100,        // ----...O----....
	        0x0100,        // ----...O----....
	
	/*495*/ 0x3FF8,        // --XXOOOOXXXXO...
	        0x1FF0,        // ---XOOOOXXXX....
	        0x0FE0,        // ----OOOOXXX-....
	        0x07C0,        // ----.OOOXX--....
	        0x0380,        // ----..OOX---....
	        0x0100,        // ----...O----....
	
	/*501*/ 0x00070000,    // ----....----.OOO----....----....
	        0x00180000,    // ----....---XO...----....----....
	        0x00600000,    // ----....-XX-....----....----....
	        0x008E0000,    // ----....X---OOO.----....----....
	        0x00F10000,    // ----....XXXX...O----....----....
	        0x00060000,    // ----....----.OO.----....----....
	        0x02380000,    // ----..O.--XXO...----....----....
	        0x038E0000,    // ----..OOX---OOO.----....----....
	        0x02710000,    // ----..O.-XXX...O----....----....
	        0x010F0000,    // ----...O----OOOO----....----....
	        0x00C00000,    // ----....XX--....----....----....
	        0x00300000,    // ----....--XX....----....----....
	        0x000E0000,    // ----....----OOO.----....----....
	        0x00010000,    // ----....----...O----....----....
	        0x00070000,    // ----....----.OOO----....----....
	        0x00180000,    // ----....---XO...----....----....
	        0x001E0000,    // ----....---XOOO.----....----....
	        0x06010000,    // ----.OO.----...O----....----....
	        0x058E0000,    // ----.O.OX---OOO.----....----....
	        0x04700000,    // ----.O..-XXX....----....----....
	        0x02000000,    // ----..O.----....----....----....
	        0x01C00000,    // ----...OXX--....----....----....
	        0x03380000,    // ----..OO--XXO...----....----....
	        0x0C040000,    // ----OO..----.O..----....----....
	        0x09C00000,    // ----O..OXX--....----....----....
	        0x06300000,    // ----.OO.--XX....----....----....
	        0x001C0000,    // ----....---XOO..----....----....
	        0x00600000,    // ----....-XX-....----....----....
	        0x00860000,    // ----....X---.OO.----....----....
	        0x00F90000     // ----....XXXXO..O----....----....
	/*531*/
};

const EndPointData LineEnds[number_lineends]={
	{0,  0,  0,    0},    // No ending
	{16, 6,  382,  0},    // Hollow arrow
	{16, 6,  388,  0},    // Filled arrow
	{16, 10, 475,  0},    // Narrow Hollow arrow
	{16, 10, 394,  0},    // Narrow Filled arrow
	{16, 10, 413,  3},    // Arrow shaft
	{16, 6,  407,  5},    // Backwards angle
	{16, 6,  495,  0},    // Backwards Filled arrow
	{16, 10, 485,  0},    // Backwards Narrow Filled arrow
	{16, 1,  404,  0},    // Narrow Beam
	{16, 1,  405,  0},    // Med Beam
	{16, 1,  406,  0},    // Wide Beam
	{16, 5,  423,  4},    // Cup
	{16, 5,  428,  0},    // Inverted Cup
	{16, 7,  433,  3},    // Hollow Box
	{16, 7,  440,  3},    // Filled Box
	{16, 7,  447,  3},    // Hollow Circle
	{16, 7,  454,  3},    // Filled Circle
	{16, 7,  461,  3},    // Hollow Diamond
	{16, 7,  468,  3}     // Filled Diamond
};

const GlyphData Glyph[number_glyph_styles]={
      {8,  1,  8},         // Wide double line
      {8,  1,  10},        // Thin double line
      {8,  6,  45},        // Dashed double line
      {8,  8,  0},         // Sawtooth
      {8,  4,  11},        // Balls
      {8,  2,  15},        // Hashes
      {8,  4,  17},        // Spaced Hashes
      {8,  2,  39},        // Thin Hashes
      {8,  4,  41},        // Spaced Thin Hashes
      {8,  12, 120},       // +-+-+-+-+-
      {8,  5,  257},       // Solid "T" line
      {8,  5,  377},       // Bark
      {8,  9,  262},       // Dashed "T" line
      {8,  12, 132},       // o-o-o-o-o-
      {8,  6,  144},       // oooooooooo
      {8,  6,  170},       // Boxes
      {8,  10, 176},       // Box knotted line
      {8,  10, 186},       // Triangle knotted line
      {8,  10, 150},       // Circle knotted line
      {8,  21, 212},       // Telephone line
      {8,  10, 160},       // Dashed circle knotted line
      {8,  8,  196},       // Castle wall
      {8,  8,  204},       // Alternating boxes
      {8,  18, 286},       // Block Road
      {8,  18, 304},       // Double Block Road
      {8,  1,  9},         // Hollow Road
      {8,  1,  322},       // Double Hollow Road
      {8,  9,  21},        // Railroad tracks
      {16, 9,  30},        // Double Railroad tracks
      {8,  9,  51},        // Abandoned Railroad tracks
      {8,  12, 60},        // Narrow gauge
      {8,  14, 72},        // Double narrow gauge
      {8,  12, 86},        // Abandoned narrow gauge
      {16, 2,  98},        // Thin Shaded
      {16, 2,  100},       // Thick Shaded
      {32, 9,  102},       // Sparse Lake Border
      {32, 9,  111},       // Ribbon Lake Border
      {8,  24, 233},       // Ruler
      {32, 15, 271},       // Timberline
      {32, 54, 323},       // Packice
      {32, 30, 501}        // Leaves
};

const RandomData RandomDot[number_random_styles]={
      {2, 1, 0, 0},
      {4, 1, 0, 0},
      {6, 1, 0, 0},
      {2, 2, 0, 0},
      {4, 2, 0, 0},
      {6, 2, 0, 0},
      {2, 3, 0, 0},
      {4, 3, 0, 0},
      {6, 3, 0, 0},
      {2, 4, 0, 0},
      {4, 4, 0, 0},
      {6, 4, 0, 0},

      {2, 1, 1, 1},
      {4, 1, 1, 1},
      {6, 1, 1, 1},
      {2, 2, 1, 1},
      {4, 2, 1, 1},
      {6, 2, 1, 1},
      {2, 3, 1, 1},
      {4, 3, 1, 1},
      {6, 3, 1, 1},
      {2, 4, 1, 1},
      {4, 4, 1, 1},
      {6, 4, 1, 1},

      {2, 1, 2, 1},
      {4, 1, 2, 1},
      {6, 1, 2, 1},
      {2, 2, 2, 1},
      {4, 2, 2, 1},
      {6, 2, 2, 1},
      {2, 3, 2, 1},
      {4, 3, 2, 1},
      {6, 3, 2, 1},
      {2, 6, 2, 1},
      {4, 6, 2, 1},
      {6, 6, 2, 1},

      {2, 1, 1, 2},
      {4, 1, 1, 2},
      {6, 1, 1, 2},
      {2, 2, 1, 2},
      {4, 2, 1, 2},
      {6, 2, 1, 2},
      {2, 3, 1, 2},
      {4, 3, 1, 2},
      {6, 3, 1, 2},
      {2, 6, 1, 2},
      {4, 6, 1, 2},
      {6, 6, 1, 2},

      {2, 1, 2, 2},
      {4, 1, 2, 2},
      {6, 1, 2, 2},
      {2, 2, 2, 2},
      {4, 2, 2, 2},
      {6, 2, 2, 2},
      {2, 3, 2, 2},
      {4, 3, 2, 2},
      {6, 3, 2, 2},
      {2, 6, 2, 2},
      {4, 6, 2, 2},
      {6, 6, 2, 2}
};

const int RandTableLen=256;
int RandTable[RandTableLen];  // Table of Random Numbers generated for fractals
int LastSeed = -1;   // Optimization: don't regen the table if our seed is the same.

/**
 * @brief Draws a dot on the canvas
 */
void DrawDot(TLineContinue& ldr, int x, int y) {
	ldr.canvas->DrawPoint(x, y);
}

/**
 * @brief: Used in getting lines perpendicular to the main line for
 *          drawing glyph/line tips.
 *
 * Make sure the length of the line we create is in the
 * direction of the perpendicular, but make the sum of the
 * number of pixels in the x and y direction equals 16
 * (or 1/2 our maximum width).
 *
 * Without this property, our glyph line will not always be
 * centered around the correct point.
 *
 * The way to ensure this is to force the longest axis of the
 * line (0,0)-(px,py) equal to 1 (since we're still dealing with
 * unit coordinates), and scale the other axis accordingly.
 */
void correctperpendicular(arRealPoint& p) {
  if (std::abs(p.x)>std::abs(p.y)) {
    if (p.x>0) {
      p.y=p.y*(1/p.x);  p.x=1;
    } else {
      p.y=p.y*(-1/p.x); p.x=-1;
    }
  } else {
    if (p.y>0) {
      p.x=p.x*(1/p.y);  p.y=1;
    } else {
      p.x=p.x*(-1/p.y); p.y=-1;
    }
  }
}

/**
 * @brief DDA routine called by Window's LineDDA procedure. Called by normal
 * dash-dot type lines.
 *
 * Rotates the bitmask over by one bit each time it is called so the bits are
 * sequentially applied.
 *
 * @bug On 64 bit platforms, this one may be a problem. Basically, an
 * assumption is made here that an int is 32 bits. Need to find a way to restrict
 * to that 32 bits, and make sure it's no smaller than 32 bits, either.
 */
void DitherLineDDAProc(int x, int y, TLineContinue* ldr) {
	if ((ldr->bitmask & 1) != 0) {
		DrawDot(*ldr, x, y);
	}

	ldr->bitmask = (ldr->bitmask >> 1) + (ldr->bitmask << 31);
}

/**
 * @brief DDA routine called by Window's LineDDA procedure.
 *          Called for drawing symbols at line tips.
 *
 * See GlyphDDAProc for reasoning--this routine is very similar.
 */
void LineTipDDAProc(int x,int y, TLineContinue* ldr) {
	if (ldr->slice < ldr->numslices) {

		ldr->bitmask = GlyphBits[ldr->start+ldr->slice];

		// Occasional crash reported with a specific map (Kaje Village); failure was in
		// below LineDDA call.  Problem is that tip is being drawn off Canvas, and
		// VCL Canvas.Pixel property doesn't like being passed negative coordinates!
		// Although actual line is still onscreen, the tip will sometimes stray off
		// the corner.  A simple bounds check eliminates this boundary case.
		//
		//  LOG('LineTipDDAProc @%p, x=%d, y=%d, dx=%d, dy=%d Canvas=%p Style=%x Bitmask=%x NoPutPixel=%d',
		//                        [ldr,x,y,ldr^.dx,ldr^.dy,
		//                         @ldr^.Canvas,ldr^.Style.bits,ldr^.Bitmask,integer(ord(ldr^.NoPutPixel))]);

		if ((x-ldr->dx >= 0) && (y-ldr->dy >= 0)) {
			LinePoints(x-ldr->dx,y-ldr->dy,x+ldr->dx,y+ldr->dy, (void (*)(int, int, void*))DitherLineDDAProc,(void*)ldr);
		}

		ldr->slice++;
	}
}

/**
 * Draws a symbol at the tip of a line
 */
void DrawLineTip(coord x1, coord y1, coord x2, coord y2, int kind, wxDC& canvas) {
	arRealPoint p;
	double t;
	TLineContinue cont;

	if ((kind != 0) || (kind < number_lineends)) {
    	// Back the line segment up so the base of the tip aligns with the
    	// end of the line
		p = unitvector(arRealPoint(x1, y1), arRealPoint(x2, y2));
		x1 -= p.x*LineEnds[kind].depth;
		y1 -= p.x*LineEnds[kind].depth;

    	// Make the line segment only as long as the line tip
		x2 = x1 + p.x*LineEnds[kind].width;
		y2 = y1 + p.y*LineEnds[kind].width;

		// compute the perpendicular vector
		t   = p.x;
		p.x = -p.y;
		p.y = t;

		if ((p.x != 0) || (p.y != 0)) {
			correctperpendicular(p);
			cont.canvas    = &canvas;
			cont.width     = LineEnds[kind].width / 2;
			cont.start     = LineEnds[kind].start;
			cont.numslices = LineEnds[kind].count;
			cont.slice     = 0;
			cont.dx        = (int)(p.x*cont.width);
			cont.dy        = (int)(p.y*cont.width);
			LinePoints((int)x1, (int)y1, (int)x2, (int)y2, (void (*)(int, int, void*))LineTipDDAProc, (void*)&cont);
		}
	}
}

/**
 * Returns line style with any flags removed from the bitmask
 */
StyleAttrib CleanedLineStyle(StyleAttrib style) {
    if (style.bits != SEGMENT_STYLE.bits) {
        style.bytes.Last = style.bytes.Last & !0x80;
    }
    return(style);
}

/**
 * @brief Draws dashed line surrounding selected area
 * Caller must set the Canvas pen mode and color (usually pmNotXor if you want
 * to draw the actual color you've selected into the Pen).
 */
void Marquis(wxDC& canvas, int x1, int y1, int x2, int y2) {
	int ps;
	wxPen pen;
	
	ps = canvas.GetPen().GetStyle();
	///@todo get mainform background : Original code:
    //Canvas.Brush.Color:=MainForm.BackgroundColor.Color;
	pen = canvas.GetPen();
	pen.SetStyle(wxLONG_DASH);
	canvas.SetPen(pen);
	canvas.DrawRectangle(x1, y1, x2-x1, y2-y1);
	pen.SetStyle(ps);
	canvas.SetPen(pen);
}

/**
 * @brief Random number generator
 *
 * Used to give reliable random numbers that don't change, even if new
 * platforms/toolkits become available. While this function should, probably,
 * be replaced, it will not be at this time, at the least.
 */
int RndSeed(int& seed, const int max) {
	int retval = seed % max;
	seed = (seed * 261) % 65521;
	if (seed == 0) { seed++; }
	return(retval);
}

/**
 * @brief Returns total line styles available.
 *
 * This is essentially a fixed number since the user can't add their own
 * styles.  It's written as a function, because if we do let the user add
 * styles, they'd have to go at the bottom of the list, and we'd increment our
 * return value by the number of user styles.
 */
int GetNumberLineStyles() {
	return (1 + number_thick_styles + number_dithered_styles +
			number_glyph_styles + number_caligraphy_styles +
			number_random_styles + number_numeric_thickness_styles);
}

/**
 * @brief Returns total line end styles available.
 *
 * This is essentially a fixed number since the user can't add their own
 * styles.  It's written as a function, because if we do let the user add
 * styles, they'd have to go at the bottom of the list, and we'd increment our
 * return value by the number of user styles.
 */
int GetNumberLineEndStyles() {
	return (number_lineends);
}

/**
 * @brief Returns the nth fixed "random" number in the RandTable.
 *
 * After RandTable is filled with random numbers, the fractal algorithms use it
 * to get predictable random numbers from the table.  We can't use real random
 * numbers here because the total numbers required changes depending on our
 * zoom level.  Since the fractals are generated recursively, it would mean
 * that without doing this the shape of our fractal lines would change at each
 * zoom level.  This is unacceptable.
 *
 */
int FixedRandom(int n) {
	///@todo The original code used low(RandTable) and High(RandTable). Technically, this allows for an array with different starting/ending values than 0/256, as is required high. Since this is different, we may have a bug, or we may not. It's worth verifying one way or the other, though.
	return(RandTable[n % RandTableLen]);
}

/**
 * @brief: DDA routine called by Window's LineDDA procedure.
 *          Called by caligraphy type lines.
 *
 * We draw a broad stroke for each dot, centered around the real line.
 */
void CaligraphyDDAProc(int x, int y, TLineContinue* ldr) {
    ldr->canvas->DrawLine(x - ldr->dx,y - ldr->dy, x + ldr->dx, y + ldr->dy);
}

/**
 * @brief DDA routine called by Window's LineDDA procedure.
 *          Called by random type lines.
 *
 * The dy variable is used to control the "fuzziness"
 */
void RandomDDAProc(int x, int y, TLineContinue* ldr) {
    int i, width, height;
    for (i=1; i<ldr->numslices; i++) {
        x = x + RndSeed(ldr->start, ldr->width) - (ldr->width >> 1);
        y = y + RndSeed(ldr->start, ldr->width) - (ldr->width >> 1);
        switch (ldr->dy) {
            case 0:
                DrawDot(*ldr,x,y);
                break;
            case 1:
                ldr->canvas->DrawLine(x-ldr->dx,y-ldr->dx,x+ldr->dx,y+ldr->dx);
                ldr->canvas->DrawLine(x+ldr->dx,y-ldr->dx,x-ldr->dx,y+ldr->dx);
                break;
            case 2:
                width  = (x+ldr->dx) - (x-ldr->dx);
                height = (y+ldr->dx) - (y-ldr->dx);
                ldr->canvas->DrawRectangle(x-ldr->dx, y-ldr->dx, width, height);
                break;
        }
    }
}

/**
 
 * @brief DDA routine called by Window's LineDDA procedure. Called by glyph
 * type lines (ones with symbols in them).
 *
 * Draws many lines perpendicular to the original line, straddling it.  The
 * individual lines are dot-dash style lines, but we set the dot-dash mask to
 * the appropriate row of our glyph.  i.e.
 *
 * <pre>
    + + + +<Individual glyph slices drawn perp. to the line
    + + + +
   -+-+-+-+---------------------------------------------- line
    + + + +
    + + + +
   </pre>
 *
 * This isn't the best way to do this.  For one, it's pretty darn slow.  For
 * two, it leaves noticible gaps in the lines when rotated: 90 degree lines are
 * much more compact than 45 degree lines.  I explored several better options
 * for glyph lines, but they all suffered when it came to applying the pattern
 * to a fractal line or a curve. Specifically, joining corners when faced with
 * zillions of line stretches one pixel long (and frequently non tangential)
 * made representing the glyph lines as paths or polygons pretty darn
 * inconvient.  Doing that, they would have to be sliced into thin sections,
 * and reasonably joined when the intersection angle of the lines could be
 * pretty large.  So although not the best in terms of appearance of simple
 * straight lines, these "bitmap" lines are a good all-around compromise.
 */
void GlyphLineDDAProc(int x, int y, TLineContinue* ldr) {
	ldr->bitmask = GlyphBits[ldr->start+ldr->slice];
	LinePoints(x-ldr->dx, y-ldr->dy, x+ldr->dx, y+ldr->dx, (void (*)(int, int, void*))DitherLineDDAProc, ldr);
	ldr->slice++;
	if (ldr->slice >= ldr->numslices) {
		ldr->slice = 0;
	}
}

void DoFractal(int depth, coord x1, coord y1, coord x2, coord y2, double rfact, arRealRect& b) {
    double mx, my, px, py, r;
	arRealPoint p;
    
    encompass(b, x1, y1);
    encompass(b, x2, y2);
    p = unitperpendicular(x1, y1, x2, y2);
	px = p.x; py = p.y;

    if ((depth <= fractal_depth) || ((px != 0) && (py != 0))) {
        r = rfact*((FixedRandom(depth)/MaxRand)-0.5);
        mx = (x2+x1)*0.5 + (px*r);
        my = (y2+y1)*0.5 + (py*r);

        DoFractal(depth*2,   x1, y1, mx, my, rfact*0.5, b);
        DoFractal(depth*2+1, mx, my, x2, y2, rfact*0.5, b);
    }
}

/**
 * Purpose: Determine the bounding box for a fractal.
 *
 * Notes: Used in invalidating regions to find out the rectangle
 * surrounding the fractal.
 */
void GetFractalBox(coord x1, coord y1, coord x2, coord y2, double rfact, arRealRect& b) {
    b.x      = std::min(x1, x2);
    b.y      = std::min(y1, y2);
    b.width  = std::max(x2-x1, x1-x2);
    b.height = std::max(y2-y1, y1-y2);
    DoFractal(1, x1, y1, x2, y2, rfact, b);
}

/**
 * Fills the RandTable: future calls to fractal routines will have this
 * "shape".
 */
void FractalSetSeed(int n) {
    int i;

    if (LastSeed != n) {
		setRndSeed(n);
        for (i=0; i<RandTableLen; i++) {
            RandTable[i] = getRndNumber(MaxRand);
        }
        LastSeed = n;
    }
}

/**
 * Initializes the TLineContinue struct for the beginning of a line.
 */
TLineContinue GetLineStyleStart(StyleAttrib style) {
    int n, w;
    TLineContinue result;

    result.points.clear();
    result.count = 0;
    result.allocated = 0;
    result.first = true;

    if (IsLineStyleInverted(style)) {
        result.invertLine = -1;
    } else {
        result.invertLine = 1;
    }

    result.style = CleanedLineStyle(style);
    n = result.style.bytes.Line;

    if ((n >= start_dithered_style) && (n < start_dithered_style + number_dithered_styles)) {
        n -= start_dithered_style;
        result.bitmask = dashdot[n % number_dithered_styles];
    } else if ((n >= start_glyph_style) && (n < start_glyph_style + number_glyph_styles)) {
        n -= start_glyph_style;
        result.slice = 0;
        result.width = Glyph[n].width / 2;
        result.start = Glyph[n].start;
        result.numslices = Glyph[n].count;
    } else if ((n >= start_caligraphy_style) && (n < start_caligraphy_style + number_caligraphy_styles)) {
        n -= start_caligraphy_style;
        w = (n/4)*2+2; // width of the calligraphy line
        n &= 3;        // only four angles \ / | -
        switch (n) {
            case 0: result.dx = -w; result.dy = w; break; // / angle
            case 1: result.dx =  0; result.dy = w; break; // | angle
            case 2: result.dx =  w; result.dy = w; break; // \ angle
            case 3: result.dx =  w; result.dy = 0; break; // - angle
        }
    } else if ((n >= start_random_style) && (n < start_random_style + number_random_styles)) {
        n -= start_random_style;
        result.width = RandomDot[n].PatternWidth;
        result.start = -1;
        result.numslices = RandomDot[n].DotCount;
        result.dx = RandomDot[n].DotWidth;
        result.dy = RandomDot[n].DotType;
    }
    return(result);
}

/**
 * @brief Draws a line (x1,y1)-(x2,y2).
 *
 * Requires the continue record be filled out before hand.  That is, this
 * routine does no initialization or cleanup, and doesn't handle the line tips.
 * It is called multiple times, though for polylines.
 */
void DrawLineContinue(wxDC& canvas, coord x1, coord y1, coord x2, coord y2, TLineContinue& cont) {
    wxRect r, clip;
    int oldpenwidth, dots, technology;
    double px, py, angle, thickness, xofs, yofs;
    wxPoint points[4];
    wxColour oldbrushcolor;
    int oldbrushstyle;
    wxPen pen;
    wxBrush brush;

    r.x = (int)x1;
    r.y = (int)y1;
    r.width = abs((int)(x2-x1));
    r.height = abs((int)(y2-y1));

    // If the line "Style" is SEGMENT_STYLE, we're actually
    // just cataloging how many times we've called DrawLineContinue
    // and with what arguments so we can perform a decompose.
    // Add the line (allocate more space if necessary).
    
    if (cont.style.bits == SEGMENT_STYLE.bits) {
        if (cont.count+2 > cont.allocated) {
            cont.allocated += AllocationGrowth;
            cont.points.resize(cont.points.size() + AllocationGrowth);
        }

        if (cont.count == 0) {
            cont.points[0].x = x1;
            cont.points[0].y = y1;
            cont.points[1].x = x2;
            cont.points[1].y = y2;
            cont.count += 2;
        } else {
            cont.points[cont.count].x = x2;
            cont.points[cont.count].y = y2;
            cont.count++;
        }
    } else {
        if (cont.first) {
            cont.canvas = &canvas;
            DrawLineTip(x1, y1, x2, y2, cont.style.bytes.First, canvas);
        }
        ///@todo find a way to tell if this is going to a printer or not.
        // Set a boolean if the canvas is to a printer or metafile:
        // we need to adjust how we draw dots if it is.
        //technology = GetDeviceCaps(Canvas.Handle,TECHNOLOGY);
        //cont.noPutPixel = (technology!=DT_RASDISPLAY);
        cont.noPutPixel = false;

        // Total number of actual pixels we will draw.  Used
        // in keeping clipped lines from incorrectly moving our patterns
        // up the line segment.
        dots = r.height + r.width + 1;

        canvas.GetClippingBox(clip);
        if (0 == cont.style.bytes.Line) {
            // Null Lines: No operation to be done here
        } else if (start_thick_style <= cont.style.bytes.Line <= start_thick_style+number_thick_styles-1) {
            // Thick Lines
            if (visiblewithin(r, clip)) {
                oldpenwidth = canvas.GetPen().GetWidth();
                pen = canvas.GetPen();
                pen.SetWidth(GetLineThickness(cont.style));
                canvas.SetPen(pen);
                canvas.DrawLine(r.x, r.y, r.x+r.width, r.y+r.height);
                pen.SetWidth(oldpenwidth);
                canvas.SetPen(pen);
            }
        } else if (start_dithered_style <= cont.style.bytes.Line <= start_dithered_style+number_dithered_styles-1) {
            // Dash-Dot Lines
            if (visiblewithin(r, clip)) {
                LinePoints(r.x, r.y, r.x+r.width, r.y+r.height, (void (*)(int, int, void*))DitherLineDDAProc, (void*)&cont);
            } else {
                // Even if we don't draw the line, make sure we
                // adjust the bitmask so that polylines won't get
                // messed up.  That is, rotate the bitmask for as
                // many dots as we would have drawn, but don't draw
                // it since it is out of the clipping region.
                dots &= 31;
                cont.bitmask = (cont.bitmask >> dots) + (cont.bitmask << 32-dots);
            }
        } else if (start_glyph_style <= cont.style.bytes.Line <= start_glyph_style+number_glyph_styles-1) {
            // Glyph Lines
            if (visiblewithin(r, clip)) {
                arRealPoint p = unitperpendicular(arRealPoint(x1, y1), arRealPoint(x2, y2));
                if ((p.x != 0) || (p.y != 0)) {
                    correctperpendicular(p);
                    cont.dx = (int)(p.x * cont.width) * cont.invertLine;
                    cont.dy = (int)(p.y * cont.width) * cont.invertLine;
                    LinePoints(r.x, r.y, r.x+r.width, r.y+r.height, (void (*)(int, int, void*))GlyphLineDDAProc, (void*)&cont);
                }
            } else {
                // Even if we don't draw the line, make sure we
                // adjust the bitmask so that polylines won't get
                // messed up.  That is, rotate the bitmask for as
                // many dots as we would have drawn, but don't draw
                // it since it is out of the clipping region.
                cont.slice = cont.slice+dots % cont.numslices;
            }
        } else if (start_caligraphy_style <= cont.style.bytes.Line <= start_caligraphy_style+number_caligraphy_styles-1) {
            // Calligraphy Lines
            if (visiblewithin(r, clip)) {
                oldpenwidth = canvas.GetPen().GetWidth();
                pen = canvas.GetPen();
                pen.SetWidth(2);
                canvas.SetPen(pen);
                LinePoints(r.x, r.y, r.x+r.width, r.y+r.height, (void (*)(int, int, void*))CaligraphyDDAProc, (void*)&cont);
            }
        } else if (start_random_style <= cont.style.bytes.Line <= start_random_style+number_random_styles-1) {
            // Random Lines
            if (visiblewithin(r, clip)) {
                if (cont.start == -1) {
                    cont.start = (int)x1^(int)y1^(int)x2^(int)y2;
                }
                pen = canvas.GetPen();
                oldpenwidth = pen.GetWidth();
                pen.SetWidth(1);
                canvas.SetPen(pen);
                LinePoints(r.x, r.y, r.x+r.width, r.y+r.height, (void (*)(int, int, void*))RandomDDAProc, (void*)&cont);
                pen.SetWidth(oldpenwidth);
                canvas.SetPen(pen);
            }
        } else if (start_numeric_thickness_style <= cont.style.bytes.Line <= start_numeric_thickness_style+number_numeric_thickness_styles-1) {
            // Lines with a numeric thickness
            if (visiblewithin(r, clip)) {
                pen = canvas.GetPen();
                brush = canvas.GetBrush();
                oldpenwidth = pen.GetWidth();
                oldbrushcolor = brush.GetColour();
                oldbrushstyle = brush.GetStyle();
                brush.SetStyle(wxSOLID);
                brush.SetColour(pen.GetColour());
                pen.SetWidth(0);
                canvas.SetPen(pen);
                canvas.SetBrush(brush);
                angle = atan2(r.height, r.width);
                thickness = cont.style.FullStyle.SThickness / 2;
                xofs = thickness * cos(angle-M_PI/2);
                yofs = thickness * sin(angle-M_PI/2);
                points[0].x = (int)round(r.x + xofs, 0);
                points[0].y = (int)round(r.y + yofs, 0);
                points[1].x = (int)round(r.x + r.width  - 1 + xofs, 0) + 1;
                points[1].y = (int)round(r.y + r.height - 1 + yofs, 0) + 1;
                points[2].x = (int)round(r.x + r.width  - 1 - xofs, 0) + 1;
                points[2].y = (int)round(r.y + r.height - 1 - yofs, 0) + 1;
                points[3].x = (int)round(r.x - xofs, 0);
                points[3].y = (int)round(r.y - yofs, 0);
                canvas.DrawPolygon(4, points);
                pen.SetWidth(oldpenwidth);
                brush.SetColour(oldbrushcolor);
                brush.SetStyle(oldbrushstyle);
                canvas.SetBrush(brush);
                canvas.SetPen(pen);
            }
        }
    }
    cont.first = false;
    cont.p1.x = x1;
    cont.p1.y = y1;
    cont.p2.x = x2;
    cont.p2.y = y2;
}

/**
 * @brief Ends a line.
 *
 * If a SEGMENT_STYLE line, we return the list of segments.
 */
VPoints GetLineEnd(TLineContinue& cont, int& count) {
    VPoints result;
    if (cont.style.bits == SEGMENT_STYLE.bits) {
        result = cont.points;
        count = cont.count;
    } else {
        DrawLineTip(cont.p2.x, cont.p2.y, cont.p1.x, cont.p1.y, cont.style.bytes.Last, *(cont.canvas));
    }
    return(result);
}

/**
 * @brief Routine for drawing a single line segment without the fuss & muss.
 *
 * For polylines, you can't call this, you need to do LineStart, Continue, End.
 */
void DrawLineStyle(wxDC& canvas, int x1, int y1, int x2, int y2, StyleAttrib style) {
    TLineContinue cont;
    int count;

    cont = GetLineStyleStart(style);
    DrawLineContinue(canvas, x1, y1, x2, y2, cont);
    GetLineEnd(cont, count);
}

void doBezier(int depth, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, wxDC& canvas, TLineContinue& cont) {
    arRealPoint q1, q2, q3, r1, r2, s1;

    if ((depth != 1) && (std::abs(p1.x - p4.x) < 3) && (std::abs(p1.y - p4.y) < 3)) {
        DrawLineContinue(canvas, (int)p1.x, (int)p1.y, (int)p4.x, (int)p4.y, cont);
    } else {
        q1 = avepoints(p1, p2);
        q2 = avepoints(p2, p3);
        q3 = avepoints(p3, p4);
        r1 = avepoints(q1, q2);
        r2 = avepoints(q2, q3);
        s1 = avepoints(r1, r2);

        depth++;
        doBezier(depth, p1, q1, r1, s1, canvas, cont);
        doBezier(depth, s1, r2, q3, p4, canvas, cont);
    }
}

/**
 * @brief Draws a bezier curve
 *
 * If there is more resolution desired, split the curve, and recurse.
 * The curve is split using a simple and effective equality: De Castigilu's
 * Algorithm):
 *
 *  <pre>
 *  Conceptual
 *  (coordinates)
 *   p1
 *     > q1
 *   p2    > r1
 *     > q2    > s1
 *   p3    > r2
 *     > q3
 *   p4
 *  </pre>
 *
 * p1..p4 are the points of the original bezier curve.  Each parent coord. on
 * the tree above is the average of the two coords below.  The point s1
 * is the split point, and the curves <p1 q1 r1 s1>, and <p4 q3 r2 s1> are the
 * two resulting Bezier curves.  The combination of the two curves resulting
 * from splitting reproduces the original (disregarding roundoff errors).
 */
void DrawBezier(wxDC& canvas, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, TLineContinue& cont) {
    int temp;
    doBezier(1, p1, p2, p3, p4, canvas, cont);
    GetLineEnd(cont, temp);
}

void doFractalBezier(int depth, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, double rfact, wxDC& canvas, TLineContinue& cont) {
    arRealPoint q1, q2, q3, r1, r2, s1, p;
    double d, r;

    d = distance(p1.x, p1.y, p4.x, p4.y);
    if ((d <= 2) && (depth > 1)) {
        DrawLineContinue(canvas, (int)p1.x, (int)p1.y, (int)p4.x, (int)p4.y, cont);
    } else {
        q1 = avepoints(p1, p2);
        q2 = avepoints(p2, p3);
        q3 = avepoints(p3, p4);
        r1 = avepoints(q1, q2);
        r2 = avepoints(q2, q3);
        s1 = avepoints(r1, r2);

        p = unitperpendicular(p1, p4);
        r = rfact*((FixedRandom(depth)/MaxRand)-0.5);
        s1.x += p.x*r;
        s1.y += p.y*r;

        doFractalBezier(depth*2,   p1, q1, r1, s1, rfact*0.5, canvas, cont);
        doFractalBezier(depth*2+1, s1, r2, q3, p4, rfact*0.5, canvas, cont);
    }
}

/**
 * @brief Draws fractal bezier curve.
 *
 * Assumes that FractalSetSeed has been called.
 */
void DrawFractalBezier(wxDC& canvas, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, double rfact, TLineContinue& cont) {
    doFractalBezier(1, p1, p2, p3, p4, rfact, canvas, cont);
}

void DrawArc(wxDC& canvas, arRealPoint p1, arRealPoint p2, arRealPoint p3, TLineContinue& cont) {
    arRealPoint c;
    wxColour oldcolor;
    wxPen pen;
    wxBrush brush;
    double r1, r2, a1, a2, d, h, r, x, y, x1, y1, x2, y2;

    // Find out where the center of the circle is.  We can do this by thinking of
    // each point on the arc as the center of its own circle, both of which are the
    // same size.  Then we only have to find the intersection of the two circles
    r1 = powf(p2.x - p1.x, 2) + powf(p2.y - p1.y, 2);
    r2 = powf(p3.x - p1.x, 2) + powf(p3.y - p1.y, 2);
    d  = powf(p3.x - p2.x, 2) + powf(p3.y - p2.y, 2);
    if (r1 < r2) {
        r1 = r2;
    }

    r = r1;

    if ((d > 0) && (r1 > 0)) {
        r = sqrtf(r);
        d = sqrtf(d);
        if (d < (2*r1)) {
            // Solve for the two intersection points

            h = sqrtf(powf(r, 2) - powf(d/2, 2));
            x = (p2.x + p3.x ) / 2;
            y = (p2.y + p3.y ) / 2;

            x1 = x + h * (p3.y - p2.y) / d;
            y1 = y - h * (p3.x - p2.x) / d;
            x2 = x - h * (p3.y - p2.y) / d;
            y2 = y + h * (p3.x - p2.x) / d;

            // Pick whichever one is closer to the cursor

            r1 = powf(x1 - p1.x, 2) + powf(y1 - p1.y, 2);
            r2 = powf(x2 - p1.x, 2) + powf(y2 - p1.y, 2);

            if (r2 < r1) {
                x1 = x2;
                y1 = y2;
            }

            // Windows wants to draw counterclockwise, so adjust if necessary

            if (p2.x != x1) {
                a1 = atan2(p2.y - y1, p2.x - x1);
            } else if (p2.y > y1) {
                a1 = M_PI/2;
            } else {
                a1 = -M_PI/2;
            }

            if (p3.x != x1) {
                a2 = atan2(p3.y - y1, p3.x - x1);
            } else if (p3.y > y1) {
                a2 = M_PI/2;
            } else {
                a2 = -M_PI/2;
            }

            while (a1 < 0) {
                a1 += 2*M_PI;
            }
            while (a2 < 0) {
                a2 += 2*M_PI;
            }
            
            r2 = a1 - a2;
            
            // We want to go counterclockwise, so flip if we have to

            if (r2 < 0) {
                c  = p2;
                p2 = p3;
                p3 = c;
            }
            
            // Flip again under certain circumstances

            if ((r2 > M_PI) || (r2 < -M_PI)) {
                c  = p2;
                p2 = p3;
                p3 = c;
            }

            // Draw the arc

            pen = canvas.GetPen();
            brush = canvas.GetBrush();
            oldcolor = pen.GetColour();
            brush.SetStyle(wxCLEAR);
            //@bug must find out how to get CurrentColor
            //pen.SetColour(CurrentColor);
            //Canvas.Arc(Round(X1 - R),Round(Y1 - R),
            //  Round(X1 + R),Round(Y1 + R),
            //  Round(P2.X),Round(P2.Y),
            //  Round(P3.X),Round(P3.Y));
            // @bug must make "DrawEllipticArc" (below) match "Canvas.Arc" (above)
            //canvas.DrawEllipticArc(
                    //(int)round(x1-r, 0), (int)round(y1-r, 0),
                    //(int)round(x1+r, 0), (int)round(y1+r, 0),
                    //);
            canvas.DrawRectangle((int)round(x1, 0)-1, (int)round(y1, 0)-1, 2, 2);
            pen.SetColour(oldcolor);
            canvas.SetPen(pen);
        }
    }
}

void GetArcCenter(arRealPoint p1, arRealPoint p2, arRealPoint p3, coord& x1, coord& y1) {
    double r1, r2, d, h, r, x, y, x2, y2;

    x1 = y1 = -1;
    // Find out where the center of the circle is.  We can do this by thinking of
    // each point on the arc as the center of its own circle, both of which are the
    // same size.  Then we only have to find the intersection of the two circles
    r1 = powf(p2.x - p1.x, 2) + powf(p2.y - p1.y, 2);
    r2 = powf(p3.x - p1.x, 2) + powf(p3.y - p1.y, 2);
    d  = powf(p3.x - p2.x, 2) + powf(p3.y - p2.y, 2);
    if (r1 < r2) {
        r1 = r2;
    }

    r = r1;

    if ((d > 0) && (r1 > 0)) {
        r = sqrtf(r);
        d = sqrtf(d);
        if (d < (2*r1)) {
            // Solve for the two intersection points

            h = sqrtf(powf(r, 2) - powf(d/2, 2));
            x = (p2.x + p3.x ) / 2;
            y = (p2.y + p3.y ) / 2;

            x1 = x + h * (p3.y - p2.y) / d;
            y1 = y - h * (p3.x - p2.x) / d;
            x2 = x - h * (p3.y - p2.y) / d;
            y2 = y + h * (p3.x - p2.x) / d;

            // Pick whichever one is closer to the cursor

            r1 = powf(x1 - p1.x, 2) + powf(y1 - p1.y, 2);
            r2 = powf(x2 - p1.x, 2) + powf(y2 - p1.y, 2);

            if (r2 < r1) {
                x1 = x2;
                y1 = y2;
            }
        }
    }    
}

void doGetBezierBox(int depth, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, arRealRect& b) {
	arRealPoint q1, q2, q3, r1, r2, s1;
	
	if (depth < 7) {
		q1 = avepoints(p1, p2);
		q2 = avepoints(p2, p3);
		q3 = avepoints(p3, p4);
		r1 = avepoints(q1, q2);
		r2 = avepoints(q2, q3);
		s1 = avepoints(r1, r2);

		encompass(b, s1.x, s1.y);
		doGetBezierBox(depth+1, p1, q1, r1, s1, b);
		doGetBezierBox(depth+1, s1, r2, q3, p4, b);
	}
}

/**
 * @brief Gets a bounding box for a bezier curve
 *
 * Used in calculation of invalid regions
 */
void GetBezierBox(arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, arRealRect& b) {
	b.x      = std::min(p1.x, p4.x);
	b.y      = std::min(p1.y, p4.y);
	b.width  = std::max(p1.x, p4.x);
	b.height = std::max(p1.y, p4.y);
	doGetBezierBox(1, p1, p2, p3, p4, b);
}

void doGetFractalBezierBox(int depth, arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, double rfact, arRealRect& b) {
	arRealPoint q1, q2, q3, r1, r2, s1, p;
	double r;

	if (depth <= fractal_depth) {
		p = unitperpendicular(p1, p4);
		if ((p.x != 0) && (p.y != 0)) {
			q1 = avepoints(p1, p2);
			q2 = avepoints(p2, p3);
			q3 = avepoints(p3, p4);
			r1 = avepoints(q1, q2);
			r2 = avepoints(q2, q3);
			s1 = avepoints(r1, r2);

			r = rfact*((FixedRandom(depth)/MaxRand)-0.5);
			s1.x += p.x*r;
			s1.y += p.y*r;
			encompass(b, s1.x, s1.y);
			doGetFractalBezierBox(depth*2,   p1, q1, r1, s1, rfact*0.5, b);
			doGetFractalBezierBox(depth*2+1, p1, q1, r1, s1, rfact*0.5, b);
		}
	}
}

/**
 * @brief Gets a bounding box for a fractal bezier curve
 *
 * Used in calculation of invalidation regions
 */
void GetFractalBezierBox(arRealPoint p1, arRealPoint p2, arRealPoint p3, arRealPoint p4, double rfact, arRealRect& b) {
	b.x      = std::min(p1.x, p4.x);
	b.y      = std::min(p1.y, p4.y);
	b.width  = std::max(p1.x, p4.x);
	b.height = std::max(p1.y, p4.y);
	doGetFractalBezierBox(1, p1, p2, p3, p4, rfact, b);
}

/**
 * @brief Get width of line style
 *
 * Called by drawing primitives if the "Quick Draw" mode is set
 * to reduce drawing time.
 *
 * Could also be used to shrink the invalidation regions slightly.
 * When the canvas is manipulated, the area affected is invalidated
 * plus a several pixel border to make sure changing line styles
 * also get invalidated.  If we were "smarter", we could calculate
 * exactly how wide that border would need to be.  Needless to say,
 * it's easier just to slightly inflate the invalidation region and
 * suffer the minor (if any) cost in repaint time.
 */
int GetLineThickness(StyleAttrib style) {
	if (style.bytes.Line > start_dithered_style) {
		return(1);
	} else {
		return(style.bytes.Line);
	}
}

/**
 * @brief Figure out if the line style requires a substantial amount of
 *          time to draw or not.
 *
 * Called by drawing primitives if the "Quick Draw" mode is set
 *          to reduce drawing time.
 */
bool IsAComplexLine(StyleAttrib style) {
    return(style.bytes.Line >= start_glyph_style);
}

/**
 * @brief Flips a line's style
 */
StyleAttrib InvertLineStyle(StyleAttrib style) {
	if (style.bits != SEGMENT_STYLE.bits) {
		style.bytes.Last ^= 0x80;
	}
	return(style);
}

/**
 * @brief Returns true if the line style is to be inverted (used for
 *          "reversing" lines)
 */
bool IsLineStyleInverted(StyleAttrib style) {
	if (style.bits == SEGMENT_STYLE.bits) {
		return(false);
	} else {
		return(style.bytes.Last ^ 0x80);
	}
}

void doFractalLine(int depth, coord x1, coord y1, coord x2, coord y2, double rfact, TLineContinue& cont, wxDC& canvas) {
    double d, r;
    arRealPoint m, p;
    d = distance(x1, y1, x2, y2);
    if (d <= 2) {
        DrawLineContinue(canvas, (int)x1, (int)y1, (int)x2, (int)y2, cont);
    } else {
        // Take the mid-point of the line, and move us some amount above/below the line
        // along the perpendicular.
        p = unitperpendicular(x1, y1, x2, y2);
        r = rfact*((FixedRandom(depth)/MaxRand)-0.5);

        m.x = (x2+x1)*0.5 + p.x*r;
        m.y = (y2+y1)*0.5 + p.y*r;

        doFractalLine(depth*2,   x1,  y1,  m.x, m.y, rfact*0.5, cont, canvas);
        doFractalLine(depth*2+1, m.x, m.y, x2,  y2,  rfact*0.5, cont, canvas);
    }
}

/**
 * @brief Draws a fractal line; rfact is the "width".
 *
 * Assumes that FractalSetSeed has been called.
 */

void FractalLine(wxDC& canvas, coord x1, coord y1, coord x2, coord y2, double rfact, TLineContinue& cont) {
    int temp;
    doFractalLine(1, x1, y1, x2, y2, rfact, cont, canvas);
    GetLineEnd(cont, temp);
}
