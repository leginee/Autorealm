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

// This file is used only to help gvd properly find all other files.
// It really does do nothing.
//
// Basically, the debugger of choice for me (Michael Pedersen) is
// gvd (the gnu visual debugger). However, it has one small, annoying
// bug in this situation, in that it ignores the first .o file's source
// file when building the tree. This, of course, is not good. I needed to
// have an empty, but technically correct, file to put as the first file.
// Hence, the need for this file. It should never have anything at all in
// it. NEVER.
//
// Of course, having said that above, I'm using this as a means to test
// the next set of .h files I'm building. Basically, as I write up the
// interface section, I'm adding the .h file as a #include to here. Once
// that's done, move on to the next one, etc. Once the corresponding .cpp
// file is done, the #include should be removed from this file.
void donop(void) {
}
