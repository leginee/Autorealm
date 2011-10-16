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
#include <iostream>
#include <wx/strconv.h>

int main(int argc, char** argv) {
    int retval = 0;
    int len;
    wxString input, output, decode;
	std::string hold;
    wxInt8* data;

    input = wxT("ABC");
    output = base64encode(input);
    data = (wxInt8*)base64decode(output, len);
	data[len] = '\0';
	hold = (char*)data;
    decode = wxString(hold.c_str(), *wxConvCurrent);
	delete data;
    std::cout << "\n\tInput was: \n" << input.mb_str() << "\n";
    std::cout << "\tOutput was: \n" << output.mb_str() << "\n";
    std::cout << "\tDecode was " << len << " bytes long: \n" << decode.mb_str() << "\n";
    if (output != wxT("QUJD")) {
        retval = 1;
        std::cout << "\tExpected \nQUJD\n- Failure!\n";
    }
    if (input != decode) {
        retval = 1;
        std::cout << "\tDecode failure!\n";
    }

    input = wxT("ABCD");
    output = base64encode(input);
    data = (wxInt8*)base64decode(output, len);
	data[len] = '\0';
	hold = (char*)data;
    decode = wxString(hold.c_str(), *wxConvCurrent);
	delete data;
    std::cout << "\n\tInput was: \n" << input.mb_str() << "\n";
    std::cout << "\tOutput was: \n" << output.mb_str() << "\n";
    std::cout << "\tDecode was " << len << " bytes long: \n" << decode.mb_str() << "\n";
    if (output != wxT("QUJDRA==")) {
        retval = 1;
        std::cout << "\tExpected \nQUJDRA==\n- Failure!\n";
    }
    if (input != decode) {
        retval = 1;
        std::cout << "\tDecode failure!\n";
    }

    input = wxT("ABCDE");
    output = base64encode(input);
    data = (wxInt8*)base64decode(output, len);
	data[len] = '\0';
	hold = (char*)data;
    decode = wxString(hold.c_str(), *wxConvCurrent);
	delete data;
    std::cout << "\n\tInput was: \n" << input.mb_str() << "\n";
    std::cout << "\tOutput was: \n" << output.mb_str() << "\n";
    std::cout << "\tDecode was " << len << " bytes long: \n" << decode.mb_str() << "\n";
    if (output != wxT("QUJDREU=")) {
        retval = 1;
        std::cout << "\tExpected \nQUJDREU=\n- Failure!\n";
    }
    if (input != decode) {
        retval = 1;
        std::cout << "\tDecode failure!\n";
    }

    input = wxT("ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ");
    output = base64encode(input);
    data = (wxInt8*)base64decode(output, len);
	data[len] = '\0';
	hold = (char*)data;
    decode = wxString(hold.c_str(), *wxConvCurrent);
	delete data;
    std::cout << "\n\tInput was: \n" << input.mb_str() << "\n";
    std::cout << "\tOutput was: \n" << output.mb_str() << "\n";
    std::cout << "\tDecode was " << len << " bytes long: \n" << decode.mb_str() << "\n";
    if (output != wxT("QUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVpBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWkFC\x0D\x0AQ0RFRkdISUpLTE1OT1BRUlNUVVZXWFlaQUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVo=")) {
        retval = 1;
        std::cout << "\tExpected \nQUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVpBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWkFC\x0D\x0AQ0RFRkdISUpLTE1OT1BRUlNUVVZXWFlaQUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVo=\n- Failure!\n";
    }
    if (input != decode) {
        retval = 1;
        std::cout << "\tDecode failure!\n";
    }

    if (retval != 0) {
        std::cout << "Failure in base64 encoding/decoding!\n";
    }
    return(retval);
}
