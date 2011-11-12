# Port of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
# Used in rpgs and hobbyist GIS applications for mapmaking
# Copyright 2004-2006 The AutoRealm Team (http://www.autorealm.org/)
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

ifdef TRACE
	TRACEFLAGS=--trace=$(TRACE)
endif

VPATH=.
# The following section differentiates between Windows, Mac OS X, and UNIX style
# systems, such as Linux and FreeBSD.  
ifeq "$(OS)" "Windows_NT"
	CPP=g++
	PLATFORM=msw
	EXE=.exe
	MTHREADS=-mthreads
	WINDRES=windres
	EXPATINCPATH=-Ic:/mingw/local/include
	EXPATLIBPATH=-Lc:/mingw/local/lib
	EXPATLIBLINK=-lexpat
	STRIP=strip
else
ifeq "$(shell uname)" "Darwin"
	CPP=g++
	# Rez and File should go here too.
	PLATFORM=mac
	# Basic mac install puts everything in /usr/local.
	# Change to /sw/ if you are using fink.
	PREFIX=/usr/local/
	WX_BIN_PATH=$(PREFIX)bin/
	EXPATINCPATH=-I$(PREFIX)include
	EXPATLIBPATH=-L$(PREFIX)lib
	EXPATLIBLINK=-lexpat	
	# Needed to build .app file..
	SETFILE=/Developer/Tools/SetFile
	MACEXEC=AutoRealm.app
	CONTENTS=$(MACEXEC)/Contents
	BUNDLE=$(MACEXEC)
	STRIP=strip	
else
# This will sound like a truly bizarre setup, but it is actually useful.
# Basically, the following definitions will allow autorealm to build on
# Linux for Windows with the mingw tools installed. I won't cover how to
# do this, as this *is* an advanced feature to try and pull off, and is
# useful primarily for debugging purposes (i.e.: I would not try to build
# on Linux a binary that will actually be distributed for Windows
# platforms). The only thing I will say for how to configure this
# environment is to visit this url:
# http://wiki.wxwidgets.org/wiki.pl?Cross-Compiling_Under_Linux
ifdef MINGW
	PLATFORM=msw
	EXE=.exe
	CPP=i586-mingw32msvc-c++ -isystem/usr/i586-mingw32msvc/include -isystem/usr/include
	STRIP=i586-mingw32msvc-strip
	WINDRES=i586-mingw32msvc-windres
	EXPATINCPATH=-I/usr/include
	EXPATLIBPATH=-L/usr/lib
	EXPATLIBLINK=-lexpat
	WXCONF_EXTRA=--host=i586-mingw32msvc --unicode=no --toolkit=msw --prefix=/usr/local/mingw
else
	CPP=g++
	PLATFORM=gtk2
	STRIP=strip
	WINDRES=echo Unable to run windres without Windows
	EXPATINCPATH=-I/usr/include
	EXPATLIBPATH=-L/usr/lib
	EXPATLIBLINK=-lexpat
endif
endif
endif


# The following section lists the .o files in use to build AutoRealm. If
# you wish to add .o files to the build process, please add them to either
# PRIMITIVES or SUPPORT. If they do not belong to either of these
# components, add a new component, but make sure to name that component in
# OBJECTS. Doing so will make sure that your new .o files get the full
# benefits of the build process (i.e.: Proper cleanup, proper dependency
# checking, etc).
#
# If you don't do this, you're going to get weird problems, definitely.
#
# Please note that there is one special build component which, while
# necessary, should be used as sparingly as possible, and that is
# UNTESTABLES. These are object for which unit tests simply cannot be
# written, for whatever reason. Examples of why would include:
# 	* Classes which are interfaces (having one pure virtual method)
# 	* Classes which are actual GUI controls (such as the main window)
# If your class *can* have a unit test written for it, do not put the class
# into the UNTESTABLES.
EXEC=autorealm$(EXE)
MAIN=AutoRealmApp.o
SUBBUILDER=subbuilder/ARDocumentBuilder.o subbuilder/CurveModelBuilder.o \
	subbuilder/GridObjectBuilder.o subbuilder/GroupModelBuilder.o \
	subbuilder/LineModelBuilder.o subbuilder/OverlayBuilder.o \
	subbuilder/PolyCurveModelBuilder.o subbuilder/PolyLineModelBuilder.o \
	subbuilder/PushpinBuilder.o subbuilder/SubBuilder.o \
	subbuilder/ViewPointBuilder.o
UNTESTABLES=$(SUBBUILDER) arColorButton.o arhelp.o MainWin.o \
	mmMultiButton.o Tracer.o \
	LineObjectModel.o PolyObjectModel.o
GUIOBJECTS=HSLColor.o 
COREOBJECTS=ObjectInterface.o ARDocument.o arRealTypes.o
MODELS=ViewPointModel.o GridObjectModel.o DrawnObjectModel.o \
	Pushpin.o GroupModel.o CurveModel.o LineModel.o \
	PolyLineModel.o PolyCurveModel.o
SUPPORT=expatpp.o ObjectBuilder.o ARExcept.o base64.o \
	ObjectWriter.o fileutils.o rand.o
FMOBJECTS=FileManagerFactory.o FileManager.o XMLFileManager.o \
	XMLParser.o
OBJECTS=$(SUPPORT) $(FMOBJECTS) $(COREOBJECTS) $(MODELS) $(GUIOBJECTS)
#RESOURCES=ResActions.o ResFill.o ResInfo.o ResMain.o \
	ResMenus.o ResOverlayColors.o ResOverlayIcons.o \
	ResPushPin.o ResSettings.o ResSplash.o ResAutoName.o \
	ResCursors.o
#TESTEXTRAS=test/TestAutoRealm.o test/randlist.o
#UNITTESTS=$(patsubst %.o,test/%Test.o,$(OBJECTS)) test/sizesTest.o \
	test/speedTest.o
UFILES=$(patsubst %.o,%.u,$(OBJECTS) $(MAIN) $(UNITTESTS) $(TESTEXTRAS))

# This small section allows us to stop the unit tests from running automatically during the buld
# if so desired. In order to do this, include SKIPTEST=1 in the make line (e.g. make DEBUG=1 SKIPTEST=1)
ifndef SKIPTEST
	CHECK=check
else
	CHECK=
endif

# If you have wx installed in a non-standard location, specify it here by
# adding a path in the WX_CONFIG variable in the appropriate platform section above.
# This allows unix developers to easily have multiple versions of wx
# installed without worrying about interactions with existing installations.
# When using Debian, the location of the wx-config script changes.
ifneq ($(wildcard /etc/alternatives/wx-config), /etc/alternatives/wx-config)
	WX_CONFIG=$(WX_BIN_PATH)wx-config $(WXCONF_EXTRA)
else
	WX_CONFIG=/etc/alternatives/wx-config $(WXCONF_EXTRA)
endif

ifeq "$(OS)" "Windows_NT"
	UNTESTABLES+=winres.o
endif

# Support programs, used at various points in the build process
CTAGS=ctags
WXRC=wxrc

# Development/Compiler/Linker flag gathering.
#
# CPPUNIT is used for testing, regardless of debug/release code being
# generated. For wx, make sure to compare for release/debug, and get the
# right flags.
#
# It's worth noting that, when running in DEBUG mode, it's assumed that you
# will want to run the unit tests, and that you will want your tags file
# updated. Both will be done, automatically, in DEBUG mode (i.e.: running
#
# make DEBUG=1 CTAGS_ON=1
#
CPPUNIT=$(shell cppunit-config --cflags --libs)
CPPUNIT_CFLAGS=$(shell cppunit-config --cflags)
CPPUNIT_LDFLAGS=$(shell cppunit-config --libs)

ifdef DEBUG
	EXTFLAGS=-g
	CPPFLAGS=$(shell $(WX_CONFIG) --debug=yes --cppflags) -Wall $(EXPATINCPATH)
	LDFLAGS=-g
	LIBS=$(MTHREADS) $(shell $(WX_CONFIG) --debug=yes --libs) $(EXPATLIBPATH) $(EXPATLIBLINK)
	ifdef CTAGS_ON
all: ctags
	endif
else
	EXTFLAGS=-O2
	MAINSTRIP=$(STRIP) $(EXEC)
	CPPFLAGS=$(shell $(WX_CONFIG) --debug=no --cppflags) $(EXPATINCPATH)
	LDFLAGS=-O2
	LIBS=$(MTHREADS) $(shell $(WX_CONFIG) --debug=no --libs) $(EXPATLIBPATH) $(EXPATLIBLINK)
endif

# Error checking. Is everything looking good at this point? Does it look
# like everything is installed, working, and ready to compile?
ifeq "x$(CPPUNIT)" "x"
	$(error CppUnit is not correctly installed on your system. Aborting.)
endif

ifeq "$(CPPFLAGS)" "$(EXPATINCPATH)"
	$(error wxWidgets is not correctly installed on your system. Aborting!)
endif

# Dependency and explicit compilation rules
#
# First, the all: target, so the Makefile will work as expected for
# everybody. Then, any extra dependencies for the unit tests are listed.
# Finally, all explicit compilation rules.
#
# If you have any extra dependencies for your unit tests, list them here,
# using a pattern similar to what you see here.
#
# Exec builds the app, bundle compiles it into a bundle for the mac
# but could be used for generating output on other platforms in the 
# future.  Check runs the unit tests.
all: $(EXEC) xrcpo.cpp $(BUNDLE) $(CHECK)

$(EXEC): dummy.o $(MAIN) $(OBJECTS) $(GUIOBJECTS) $(RESOURCES) $(VEROBJ) $(UNTESTABLES)
	$(CPP) -o $(EXEC) $^ $(EXTFLAGS) $(LDFLAGS) $(LIBS)
	$(MAINSTRIP)

Test$(EXEC): dummy.o $(TESTEXTRAS) $(OBJECTS) $(VEROBJ) $(UNTESTABLES) $(UNITTESTS)
	$(CPP) -o Test$(EXEC) $^ $(EXTFLAGS) $(LDFLAGS) $(LIBS) $(CPPUNIT_LDFLAGS)

clean:
	-rm $(EXEC) Test$(EXEC)
	-rm -r $(EXEC).app
	-rm $(OBJECTS) $(SQL_SOURCES)
	-rm $(MAIN)
	-rm $(UFILES) $(patsubst %.o,%.u,$(SQL_SOURCES)) $(patsubst %.o, %.u,$(VEROBJ))
	-rm ../tags
	-rm $(RESOURCES)
	-rm $(patsubst %.o,%.u,$(RESOURCES))
	-rm xrcpo.cpp dummy.o dummy.u tags
	-rm $(UNITTESTS)
	-rm $(UNTESTABLES) $(patsubst %.o, %.u, $(UNTESTABLES))
	-rm $(TESTEXTRAS)

xrcpo.cpp: ../ui-xrc/*.xrc
	$(WXRC) -g $^ >xrcpo.cpp

ctags:
	$(CTAGS) *.h *.cpp

$(MACEXEC): $(EXEC) mac/Info.plist mac/wxmac.icns
	echo "Building .app bundle"
	mkdir -p $(CONTENTS)
	mkdir -p $(CONTENTS)/MacOS
	mkdir -p $(CONTENTS)/Resources
	cp -f mac/Info.plist $(CONTENTS)/Info.plist
	echo -n "APPL????" > $(CONTENTS)/PkgInfo
	cp -f $(EXEC) $(CONTENTS)/MacOS/$(EXEC)
	cp -f mac/wxmac.icns $(CONTENTS)/Resources/AutoRealm.icns
	$(SETFILE) -a BC $(MACEXEC)
# Left here for future use.  
# $(RESCOMP) -d __DARWIN__ -t APPL -d __WXMAC__ -o $(EXEC) Carbon.r sample.r


# Implicit rules
#
# Here's where the magic of the Makefiles occurs. Chances are very good
# that you don't want to change anything in this section. Basically, this
# section tells GNU/Make how to build every .o, and every executable, used
# by this system.
%.o: %.rc
	$(WINDRES) -o $(@) $^

%.o: %.cpp
	$(CPP) -M -MT $(subst .cpp,.o,$<) $(CPPFLAGS) $(EXTFLAGS) -I. $(CPPUNIT_CFLAGS) $< >$(subst .cpp,.u, $<)
	$(CPP) -c $(CPPFLAGS) $(EXTFLAGS) -I. $(CPPUNIT_CFLAGS) -o $(subst .cpp,.o, $<) $<

Res%.cpp: ../ui-xrc/%.xrc
	$(WXRC) -c -n Init$*Handler -o ./Res$*.cpp ../ui-xrc/$*.xrc

# Phony targets. This is how we make sure than GNU/Make knows that, if
# these are requested, they have to be run every time.
.PHONY: clean all check test ctags

test: check
check: Test$(EXEC)
	./Test$(EXEC) $(TRACEFLAGS)

# Finally, where we include the .u files generated in the implicit rules.
# We make sure to rebuild everything thanks to this line, and the magic of
# the implicit rules above.
-include $(UFILES) $(patsubst %.o, %.u, $(UNTESTABLES))
