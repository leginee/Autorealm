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
#include "base64.h"
#include <wx/log.h>
#include <string>

const static int MIMELEN=65;
const static int MIMEPAD=64;

const static wxChar table[MIMELEN] = {
    wxT('A'), wxT('B'), wxT('C'), wxT('D'), wxT('E'), wxT('F'), wxT('G'),
    wxT('H'), wxT('I'), wxT('J'), wxT('K'), wxT('L'), wxT('M'), wxT('N'),
    wxT('O'), wxT('P'), wxT('Q'), wxT('R'), wxT('S'), wxT('T'), wxT('U'),
    wxT('V'), wxT('W'), wxT('X'), wxT('Y'), wxT('Z'), wxT('a'), wxT('b'),
    wxT('c'), wxT('d'), wxT('e'), wxT('f'), wxT('g'), wxT('h'), wxT('i'),
    wxT('j'), wxT('k'), wxT('l'), wxT('m'), wxT('n'), wxT('o'), wxT('p'),
    wxT('q'), wxT('r'), wxT('s'), wxT('t'), wxT('u'), wxT('v'), wxT('w'),
    wxT('x'), wxT('y'), wxT('z'), wxT('0'), wxT('1'), wxT('2'), wxT('3'),
    wxT('4'), wxT('5'), wxT('6'), wxT('7'), wxT('8'), wxT('9'), wxT('+'),
    wxT('/'), wxT('=')
};

int mimeIndexOf(wxChar t) {
    int i;
    int retval = -1;
    for (i=0; i<MIMELEN; i++) {
        if (table[i] == t) {
            retval = i;
        }
    }
    return(retval);
}

wxString base64encode(const wxString& data) {
    return(base64encode((const void*)data.mb_str(), data.Len()));
}

wxString base64encode(const void* data, const int len) {
    wxString output(wxT(""));
    int outcount=0;
    int ccount=0;
    int curr=0;
    int encode=0;
    wxInt8* vals = (wxInt8*)data;
    while (curr < len) {
        encode = encode << 8;
        encode |= vals[curr++];
        if (++ccount >= 3) {
            output += table[(encode >> 18) & 0x3f];
            output += table[(encode >> 12) & 0x3f];
            output += table[(encode >>  6) & 0x3f];
            output += table[(encode      ) & 0x3f];
            encode = 0;
            ccount = 0;
            outcount += 4;
            if (outcount >= 72) {
                output += wxT("\x0D\x0A");
                outcount = 0;
            }
        }
    }
    switch (len % 3) {
        case 0: break;
        case 1: 
            encode = encode << 16;
            output += table[(encode >> 18) & 0x3f];
            output += table[(encode >> 12) & 0x3f];
            output += table[64];
            output += table[64];
            break;
        case 2:
            encode = encode << 8;
            output += table[(encode >> 18) & 0x3f];
            output += table[(encode >> 12) & 0x3f];
            output += table[(encode >>  6) & 0x3f];
            output += table[64];
            break;
    }
    return(output);
}

void* base64decode(const wxString& instring, int& len) {
    len = 0;
    int index=0;
    int strlen = instring.Len();
    wxInt8* vals = new wxInt8[strlen];
    int curr = 0;
    int ccount = 0;
    int decode = 0;
	int mcount = 0;
    wxInt8 val;
    while (curr < strlen) {
        val = instring[curr++];
        index = mimeIndexOf(val);
        if (index > -1) {
            decode = decode << 6;
            if (index != MIMEPAD) {
                decode |= index;
            } else {
				mcount++;
			}
        	if (++ccount >= 4) {
            	vals[len++] = ((decode >> 16) & 0xff);
				if (mcount < 2) {
	            	vals[len++] = ((decode >>  8) & 0xff);
				}
            	if (mcount < 1) {
					vals[len++] = ((decode      ) & 0xff);
				}
            	ccount = 0;
            	decode = 0;
				mcount = 0;
        	}
        }
    }
    return(vals);
}

wxString base64decode(const wxString& instring) {
    int len = instring.Len();
    wxInt8* data;
    std::string hold;
    wxString decode;

    data = (wxInt8*)base64decode(instring, len);
	data[len] = '\0';
	hold = (char*)data;
    decode = wxString(hold.c_str(), *wxConvCurrent);
	delete data;
}
