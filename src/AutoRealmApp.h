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

#ifndef AUTOREALMAPP_H
#define AUTOREALMAPP_H
#include "globals.h"
#include <wx/image.h>
#include <wx/xrc/xmlres.h>

#include "MainWin.h"

/**
 * @mainpage
 *
 * - @ref status
 * - @ref standards
 * - @ref contributing
 * - @ref goals
 * - @ref translating
 * - @ref environment
 * - @ref developing
 * - <a href="doxygen-err.txt">Current List of Doxygen Warnings/Errors</a>.
 *   This list should always be empty, but is not currently. This needs to
 *   be fixed soon.
 *
 * @section status Where Are Things Now?
 *
 * We've tackled a lot of the lower hanging fruit, if you will. The code
 * compiles, runs, and produces windows on the screen. The windows are
 * built using wxWidgets XRC files, and as such are highly portable.
 * 
 * Some of the most important notes about this, though, are how the
 * autorealm_wx module is itself structured. I had a devil of a time
 * getting all of the pieces of the code together to make things work. As
 * such, I structured things this way:
 * 
 * - Top Level
 *         - CHANGELOG (self-explanatory)
 *         - COPYING.txt (copy of GPL)
 *         - Doxyfile (all code is being documented using Doxygen, to try and
 *                 make it easier to read and update at a later date, and to help
 *                 show inheritance hierarchies. This is the control file for
 *                 Doxygen)
 *         - README (directions on how to get it, and how to build it)
 *         - doc (hand generated documentation, such as text files to describe
 *                 everything)
 *         - extras (a small patch for wxWidgets which is needed for autorealm_wx)
 *         - src (the actual c++ source code for autorealm_wx)
 *         - ui-xrc (the directory holding the xrc files which are used to
 *                 generate the ui)
 *         - prior (this directory holds a snapshot in time of the delphi version
 *                 of autorealm)
 *         		- chmhelp (chm help files)
 *         		- components (required components to build delphi autorealm)
 *         		- delphi (the delphi version of autorealm, as of July 19)
 *         		- install (installshield build stuff for autorealm)
 *         		- textforms (the text editor version of the dfm files for
 *                 autorealm, especially useful for just reading properties without
 *                 having to resort to actually starting up Delphi)
 * 
 * @section standards Coding Rules / Standards
 * -# Code which is not documented with Doxygen tags will not be accepted.
 * -# Code which leaves error messages when Doxygen is run will not be
 *  accepted.
 * -# Code which does not compile on both Windows and Linux will not be
 *  accepted. However, I've found myself that the code may well compile on
 *  Linux and fail on Windows due to #include files. I'll fix the errors that I
 *  can, because I really do want to accept new code.
 * -# All code needs to have liberal wxDebug statements (every couple of lines
 *  doesn't hurt). This will help developers as they trace down bugs, but will
 *  be compiled out of the release/production code automatically, so is still
 *  good for that, too.
 * -# Code which hard codes dialog windows will not be accepted. XRC files
 *  only.
 * -# I also want to make sure that the code will eventually support easy
 *  internationalization and localization. While the actual C++ code doesn't do
 *  that job very well yet, the XRC files go a long way towards fixing it.
 * 
 * I know that some of those rules might be annoying, but I think if you take a
 * look at what's done so far, you'll see that it does work, and is pretty easy
 * to deal with because of those rules.
 * 
 * @section contributing How Can You Contribute?
 *
 * Now, if anybody does want to work on a section of the program, please do.
 * All I ask is that you let me know which one, so that I can mark it off as
 * being worked on, to try and avoid duplication of effort.
 * 
 * @section goals What Are We Trying To Accomplish Right Now?
 *
 * I'm trying to do just a straight port of the code. Basically, I want to take
 * the existing code, and do line for line ports where possible. Minor
 * restructuring, yes, but I want the code to behave as identically as possible
 * to the existing codebase. After the port is complete, I'm all for doing any
 * major restructuring from there that people will feel needs doing. But up
 * front, I want to have the same program, just re-written.
 *
 * As a special note, the code was branched as of July 19, 2004. When the
 * time comes, it will be necessary to pull a CVS diff of the autorealm
 * module as of June 15, 2004 to current, and verify that any new code is
 * present in the autorealm_wx module.
 */
/**
 * @page environment How To Set Up Your Environment
 *
 * This page is meant to help you get started with developing in
 * AutoRealm, specifically by helping you set up your environment. Once
 * that step is complete, you should read the sections on @ref developing,
 * which will help you out with some of the basics.
 *
 * - @ref environment_common
 *
 * - @ref environment_windows
 *
 * - @ref environment_linux
 *
 * - @ref environment_freebsd
 *
 * @section environment_common Common Programs For Every Platform
 *
 * -# Download <a href="http://www.python.org/">Python</a>, and install it
 *    where you wish.
 * -# Download <a href="http://www.wxpython.org/">wxPython</a>, and install it
 *    where you wish.
 * -# Download <a href="http://www.doxygen.org/">Doxygen</a>.
 *    @note Make sure to put the doxygen &quot;bin&quot; directory into
 *    your path!
 * -# Download <a href="http://www.graphviz.org/">GraphVIZ</a>.
 *    @note Make sure to put the graphviz &quot;bin&quot; directory into
 *    your path!
 *
 * @section environment_windows Configuring For Windows Development
 *
 * @note - You will build two versions of wxWidgets by following these steps.
 * This is deliberate, as wxWidgets provides some facilities only available
 * when debugging is turned on. It is useful to have both versions of the
 * library available, so these instructions make sure you build them.
 * 
 * @note - You will need to adjust your global path. Basically, reset it so that
 * it includes C:\\MinGW\\local\\bin and C:\\MinGW\\local\\lib . Make sure to do
 * this before taking the following steps!
 * 
 *
 * -# Download <a href="http://www.mingw.org/">MinGW</a> and install it
 *    into &quot;C:\\MinGW&quot;
 * -# Download <a href="http://www.mingw.org/">MSys</a> and install it
 *    into &quot;C:\\MinGW&quot;
 * -# Download <a href="http://unxutils.sourceforge.net/">a Windows version
 *    of unzip</a>, and place it somewhere in your path
 * -# Download <a href="http://www.sysinternals.com/ntw2k/freeware/debugview.shtml">
 *    DbgView</a> (or use another debugger, such as
 *    <a href="http://www.icelus.org/gvd/">GNU Visual Debugger</a>).
 *    @note These tools are useful for seeing the output from
 *    wxLogDebug/wxLogTrace. If you don't care to see the output, then don't
 *    worry about installing this tool.
 * -# Download <a href="http://www.wxwidgets.org/">wxWidgets</a>.
 *    @note Make sure to download release 2.6.0, and also make sure to download a
 *    copy of the documentation in your chosen format (chm, html, pdf, etc).
 *    Save them in the following locations (the steps below assume you do
 *    this):
 *      - c:\\temp\\wxWidgets-2.6.0.zip
 *      - c:\\temp\\wxWidgets-2.6.0-HTML.tar.gz
 * -# Start up a bash shell (using the MSYS icon), and do the following steps
 *      - cd /c
 *      - unzip c:/temp/wxWidgets-2.6.0.zip
 *      - tar -xzvf /c/temp/wxWidgets-2.6.0-HTML.tar.gz
 *      - mv wxWidgets-2.6.0 wx
 *      - cd wx
 *      - mkdir build-dbg
 *      - cd build-dbg
 *      - ../configure --enable-unicode --enable-debug --prefix=c:/mingw/local
 *      - make && make install
 *      - cd ../../../..
 *      - mkdir build-prd
 *      - cd build-prd
 *      - ../configure --enable-unicode --disable-debug --prefix=c:/mingw/local
 *      - make && make install
 *
 * You are done preparing your system for building AutoREALM, and may use the
 * information in @ref developing to begin developing now.
 *
 * @section environment_linux Configuring For Linux Development
 *
 * @note - You must have GTK+ 2.0 (or higher), and all development headers,
 * before this will work. Take whatever steps are needed by your package
 * manager to get it installed if it is not already installed.
 *
 * @note - You will build two versions of wxWidgets by following these
 * steps.  This is deliberate, as wxWidgets provides some facilities only
 * available when debugging is turned on. It is useful to have both
 * versions of the library available, so these instructions make sure you
 * build them.  
 *
 * -# Download <a href="http://www.wxwidgets.org/">wxWidgets</a>.
 *    @note Make sure to download release 2.6.0, and also make sure to download a
 *    copy of the documentation in your chosen format (chm, html, pdf, etc).
 *    Save them in the following locations (the steps below assume you do
 *    this):
 *      - $HOME/src/wx/wxWidgets-2.6.0.zip
 *      - $HOME/src/wx/wxWidgets-2.6.0-HTML.tar.gz
 * -# Start up a bash shell, and do the following steps
 *      - cd $HOME/src/wx
 *      - unzip wxWidgets-2.6.0.zip
 *      - mv wxGTK-2.6.0 wxGTK-2.6.0-dbg
 *      - unzip wxWidgets-2.6.0.zip
 *      - mv wxGTK-2.6.0 wxGTK-2.6.0-prd
 *      - tar -xzvf /c/temp/wxWidgets-2.6.0-HTML.tar.gz
 *      - cd wxGTK-2.6.0-dbg
 *      - ./configure --enable-unicode --enable-debug --prefix=/usr && make
 *      - cd $HOME/src/wx/wxGTK-2.6.0-prd
 *      - ./configure --enable-unicode --disable-debug --prefix=/usr && make
 *      - su - (root password required here)
 *      - cd /home/(your usernamehere)/src/wx/wxGTK-2.6.0-prd
 *      - make install
 *      - cd /home/(your usernamehere)/src/wx/wxGTK-2.6.0-dbg
 *      - make install
 *      - exit
 *
 * You are done preparing your system for building AutoREALM, and may use the
 * information in @ref developing to begin developing now.
 *
 * @section environment_freebsd Configuring For FreeBSD Development
 *
 * Before delving into the specifics of building/testing on FreeBSD, I
 * would like to thank Robert Huff. Due to his responses to me on the
 * AutoRealm mailing lists, I have access to a machine running FreeBSD on
 * which I can compile and test AutoRealm. Without him, these instructions
 * would not be written, and FreeBSD would not have an easy set of
 * instructions to follow to make AutoRealm work.
 *
 * For FreeBSD users, the same steps should be followed as for the Linux
 * users.  However, the following caveats do apply (and were written using
 * FreeBSD-6.0):
 *
 * -# <b>Warning! wxWidgets 2.5.4 and below does not work on FreeBSD!</b>
 *    The specific problem involves a seemingly infinite loop when trying
 *    to use wxrc and/or certain wxString member methods. Please use 2.5.5
 *    or higher.
 * -# All instructions are written assuming the use of the Bourne Shell
 *   (sh), not the C Shell (csh) or variants. If you wish to use one of the
 *   others, please adjust these instructions accordingly.
 * -# The version of "make" that comes with FreeBSD 6.0 will not compile
 *   wxWidgets itself, nor will it compile AutoRealm. Please obtain and use
 *   GNU/Make. The proper way to do this without conflicting with the
 *   system make is to install GNU/Make into /usr/local/bin as gmake. This can be accomplished with the following commands being entered (as root):
 *   	- cd /usr/ports/devel/gmake
 *   	- make
 * -# After that, prefix all ./configure commands with "MAKE=gmake". In addition,
 *   all calls to "make" should be replaced with calls to "gmake". To
 *   provide an example:
 *      - <b>Linux Version:</b> ./configure --enable-unicode --enable-debug --prefix=/usr && gmake
 *      - <b>FreeBSD Version:</b> MAKE=gmake ./configure --enable-unicode --enable-debug --prefix=/usr && gmake
 * -# To avoid some truly annoying messages from wxrc (and autorealm
 *   itself), make sure to handle setting your language and
 *   character set correctly. For me, I modified my environment variables
 *   in my login shell script like this, and the errors quietly went away:
 *      - MM_CHARSET=iso-8859-1; export MM_CHARSET
 *      - LANG=en_US.ISO8859-1; export LANG
 * -# I am not a native FreeBSD developer. While I do my best to test
 *   things, and make sure they all work correctly, some of my instructions
 *   may well be wrong.  Thanks to Robert Huff, I <b>do</b> have access to
 *   a FreeBSD machine on which I can compile and test the work, but that
 *   does not mean I am doing things perfectly.  If you find me doing
 *   something stupid/wrong, please say so. I'll be happy to learn a better
 *   way.
 *
 * Again, thank you Robert!
 */
/**
 * @page developing Developing With AutoRealm
 *
 * - @ref dev_work_with_cvs
 * - @ref dev_gen_build
 * - @ref dev_subclass_new_dlg_win
 * - @ref dev_gen_devdocs
 *
 * @section dev_work_with_cvs Working With CVS
 *
 * This is useful stuff when building up code and patches. It helps to make
 * sure you stay consistent with what's going on, especially in a
 * fast-moving target like this one is.
 *
 * - cvs -d:pserver:anonymous@cvs.sourceforge.net/cvsroot/autorealm login
 * - cvs -z6 -d:pserver:anonymous@cvs.sourceforge.net/cvsroot/autorealm co autorealm_wx
 *
 * You will now have a copy of the autorealm sources in a directory named
 * autorealm_wx.
 *
 * - cd autorealm_wx
 * - cvs -z6 update -d
 *
 * Your sources will be brought up to date with the latest sources
 * available in cvs.
 *
 * - cvs -z6 diff -u >patchfilename
 *
 * This will generate a patchfile which you may send to me or any autorealm
 * developer for incorporation into the main tree.
 *
 * @section dev_gen_build General AutoREALM build instructions
 *
 * The following assumes that you have downloaded the autorealm-src.tar.gz
 * into your $HOME directory, and will work the same on both Windows and
 * Linux.
 *
 * If you wish to make a debugging build with full symbol information, use
 * these steps, keeping in mind that none of the automatic tests have been
 * written or will compile at this time:
 *
 *  - cd $HOME/autorealm/src
 *  - make DEBUG=1 autorealm
 *
 * If you wish to make a full release ready version, take the following
 * steps:
 *
 *  - cd $HOME/autorealm/src
 *  - make
 *
 * Please make sure to generate the Doxygen documentation, and review it.
 * Instructions about formatting, etc, are listed in there, and
 * (eventually) all of these instructions will be placed into doxygen tags.
 * Please make sure to read it, so that we will both know your patches can
 * be accepted.
 *
 * @section dev_subclass_new_dlg_win Subclassing A New Dialog Window
 *
 * Especially right at this stage of development, the template files which
 * have been created will be useful. Basically, here's the steps to take:
 *
 * - If you have not already done so, create the dialog's XRC entries
 *   either in an existing file, or in a new file (but don't forget to add
 *   the new file to the Makefile!).
 *
 * - Modify the xrc file you just worked on, and make sure that the dialog
 *   you are creating has an attribute of "subclass" with a value that is
 *   named the same name as the subclass you are creating.
 *
 * - Copy the files DlgTemplate.h and DlgTemplate.cpp to the name of the
 *   new subclass you are creating. For instance, if you were creating the
 *   AlignDlg, you would copy DlgTemplate.h to AlignDlg.h and
 *   DlgTemplate.cpp to AlignDlg.cpp.
 *
 * - Edit the two files you have just created. You will need to perform the
 *   following substitutions:
 *      - DLGTEMPLATE_H = your new subclass in all uppercase, plus _H. for
 *        example, for AlignDlg, it would be ALIGNDLG_H
 *      - DlgTemplate = your new subclass name
 *      - In the .cpp file, find "FIXME:RESNAMEHERE", and change it to the
 *        name of the resource you created in step 1.
 *      - BRIEFDESC = A brief description of the new class's purpose
 *      - FULLDESC = A longer, more detailed description of the new class's
 *        purpose.
 * - All the blanks are now filled in, and you may do whatever other work you need to perform.
 *
 * @section dev_gen_devdocs Generating Developer Documentation
 *
 * The following assumes that you have downloaded the autorealm-src.tar.gz
 * into your $HOME directory, and will work the same on both Windows and
 * Linux.
 *
 * For an introduction to the code, complete with todo lists, bug lists,
 * etc, take the following steps (after building either a production or
 * debugging version):
 *
 * - cd $HOME/autorealm
 * - doxygen Doxyfile
 *
 * And then point a web browser at $HOME/autorealm/html/index.html
 */
/**
 * @page translating Getting A Translation Accepted
 *
 * If you wish to translate AutoREALM into your native language, you do not
 * need to download the whole build environment. It is sufficient to download
 * the latest version of the source code from CVS (see "Obtaining Sources From
 * CVS" below), and use the tool poEdit to perform the translations (trust me,
 * poedit is a very nice way of handling it). Here's what you will do:
 * 
 * -# Download and install <a href="http://poedit.sourceforge.net/">poEdit</a>
 * -# Run poEdit, and when you do, you will have to take the following steps
 *      -# Create a new catalog or edit an existing catalog
 *      -# For each untranslated original string, provide a translation
 *      -# Save the file as a .po file
 *      -# Submit the saved .po file to the autorealm team. It will be
 *         included in the next release.
 *
 * While you can edit .po files by hand, we feel that poEdit is a very nice
 * tool for doing the job, and should definitely be given consideration.
 */

/**
 * @class AutoRealmApp
 *
 * @brief Main driver for the whole application
 *
 * Derived from wxApp, this class is the main driver for the entire
 * application. It will be responsible for startup, shutdown, and
 * everything in between.
 *
 * @todo Enable dockable toolbars in main window
 * @todo Create and add custom controls to frmCTManager. Upper grid was
 *      labelled a "TDrawGrid", and lower grid was labelled "TStringGrid"
 * @todo Populate comboboxes, lists, drop down boxes
 * @todo Fix spacing between controls
 * @todo Add shortcut keys where possible to menus, labels, etc
 * @todo Use cursors where possible (if possible to do so in cross
 *      platform manner). A deleted directory in ui-xrc (cursors) has them.
 * @todo Port "Custom Print" dialog
 * @todo wxLogTrace() all of Josh's work, as it needs to be done still.
 */
class AutoRealmApp: public wxApp {
    public:
        /**
         * @brief Startup routines for the whole application
         */
        virtual bool OnInit();

    protected:
        /**
         * This is the main window for the application. It does not use
         * std::auto_ptr for pointer management as this causes a runtime
         * crash at exit (as both wxWidgets and std::auto_ptr try to delete
         * the same memory).
         */
        MainWin *mainwin;

        /**
         * Used to make sure i18n functions are properly available, to make for
         * nicer application to maintain
         */
        wxLocale locale;
};

/**
 * @class wxDialog
 * This class is the parent class of any dialog window used by AutoREALM.
 * The documentation for it is maintained within wxWidgets
 */
/**
 * @class wxApp
 * This class documentation is maintained within wxWidgets
 */
/**
 * @class wxStaticBitmap
 * This class documentation is maintained within wxWidgets
 */
/**
 * @class wxFrame
 * This class documentation is maintained within wxWidgets
 */
#endif //AUTOREALMAPP_H
