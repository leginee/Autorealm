ifeq "$(OS)" "Windows_NT"
	PLATFORM=msw
	EXE=.exe
	MTHREADS=-mthreads
	WINDRES=windres
else
	PLATFORM=gtk2
	WINDRES=echo Unable to run windres off Windows
endif

EXEC=autorealm$(EXE)
NAMEEXEC=autoname$(EXE)
MAIN=AutoRealmApp.o
COMPONENTS=FillPattern.o clkStaticBitmap.o RotateBitmap.o
UI=CustomHint.o DefineNewSymbolDlg.o DeleteViewDlg.o HyperlinkPropDlg.o
DIALOGS=AlignDlg.o AutoNameDlg.o BitmapPropertiesDlg.o \
		CTManager.o ChartGrid.o ArrayDlg.o MapSettingsDlg.o NewGroupDlg.o \
		OrderDlg.o PolygonSidesDlg.o ReplacementOverlayDlg.o SaveViewDlg.o \
		FlipDlg.o ScaleDlg.o ChooseFontDlg.o SettingsDlg.o SkewDlg.o \
		MoveSelection.o frmMakeFrom3DUnit.o TSymbolLibraryForm.o
PRIMITIVES=BitmapPrimitive.o CurvePrimitive.o DrawPrimitive.o \
	GroupPrimitive.o HyperlinkPrimitive.o LinePrimitive.o \
	PolyCurvePrimitive.o PolyLinePrimitive.o SymbolPrimitive.o \
	TextCurvePrimitive.o TextPrimitive.o Primitives.o MapObject.o \
	DrawLines.o
TOOLHANDLERS=TNormalLineToolHandler.o TFractalLineToolHandler.o \
	TNormalPolyLineToolHandler.o TFractalPolyLineToolHandler.o \
	TNormalCurveToolHandler.o TFractalCurveToolHandler.o \
	TNormalArcToolHandler.o TPolyCurveToolHandler.o \
	TFractalPolyCurveToolHandler.o TNormalCircleToolHandler.o \
	TRectangleToolHandler.o TPolygonToolHandler.o \
	TFreehandLineToolHandler.o TFreehandFractalToolHandler.o \
	TChartGridToolHandler.o TIconToolHandler.o TPatternIconToolHandler.o \
	TSprayIconToolHandler.o TTextToolHandler.o TTextCurveToolHandler.o \
	THyperlinkToolHandler.o
SUPPORT=matrixmath.o geometry.o generic_library.o ViewPoint.o \
	GraphGrid.o LinePoints.o rand.o base64.o maputils.o xmlutils.o \
	arRealTypes.o AutoNameGen.o Snap.o ToolObject.o SelectionTool.o \
	RulerToolHandler.o FreehandRulerToolHandler.o ZoomToolHandler.o \
	PanToolHandler.o GlueHandler.o ScalpelHandler.o TextSpecialties.o \
	Bezier.o Symbol.o SymbolGroup.o SymbolGroupList.o
OBJECTS=$(SUPPORT) MainWin.o $(COMPONENTS) $(DIALOGS) $(PRIMITIVES) \
	$(TOOLHANDLERS) $(UI)
RESOURCES=ResActions.o ResFill.o ResInfo.o ResMain.o ResMenus.o \
	ResOverlayColors.o ResOverlayIcons.o ResPushPin.o ResSettings.o \
	ResSplash.o ResAutoName.o ResCursors.o
TESTPROGS=randtest$(EXE) randtest.o base64test$(EXE) base64test.o
NEVERCOMPILE=DlgTemplate.o xrcpo.o

CTAGS=ctags

# If you have wx installed in a non-standard location, specify it here by
# adding a path before wx-config.
# This allows unix developers to easily have multiple versions of wx
# installed without worrying about interactions with existing installations.
WX_CONFIG=wx-config
#WX_CONFIG=/home/oojah/src/wxroot-dbg/bin/wx-config

ifeq "$(OS)" "Windows_NT"
	OBJECTS+=winres.o
endif

CPP=g++

ifdef DEBUG
	EXTFLAGS=-g
	CPPFLAGS=$(shell ${WX_CONFIG} --debug=yes --cppflags)
	LDFLAGS=-g
	LIBS=$(MTHREADS) $(shell ${WX_CONFIG} --debug=yes --libs)
all: ctags
else
	EXTFLAGS=-O2
	MAINSTRIP=strip $(EXEC)
	NAMESTRIP=strip $(NAMEEXEC)
	CPPFLAGS=$(shell ${WX_CONFIG} --debug=no --cppflags)
	LDFLAGS=-O2
	LIBS=$(MTHREADS) $(shell ${WX_CONFIG} --debug=no --libs)
endif

WXRC=wxrc

LIBS+=$(CXXLIB)

UFILES=$(patsubst %.o,%.u,$(OBJECTS) $(OBJTESTS) $(MAIN))

all: $(EXEC) xrcpo.cpp $(NAMEEXEC)

$(EXEC): dummy.o $(MAIN) $(OBJECTS) $(RESOURCES) $(VEROBJ)
	$(CPP) -o $(EXEC) $^ $(EXTFLAGS) $(LDFLAGS) $(LIBS)
	$(MAINSTRIP)

$(NAMEEXEC): AutoNameGen.o AutoNameDlg.o ResAutoName.o AutoName.o
	$(CPP) -o autoname$(EXE) $^ $(EXTFLAGS) $(LDFLAGS) $(LIBS)
	$(NAMESTRIP)

xrcpo.cpp: ../ui-xrc/*.xrc
	$(WXRC) -g $^ >xrcpo.cpp

clean:
	-rm $(EXEC)
	-rm $(OBJECTS) $(SQL_SOURCES)
	-rm $(MAIN)
	-rm $(UFILES) $(patsubst %.o,%.u,$(SQL_SOURCES)) $(patsubst %.o, %.u,$(VEROBJ))
	-rm ../tags
	-rm $(RESOURCES)
	-rm $(patsubst %.o,%.u,$(RESOURCES))
	-rm xrcpo.cpp dummy.o dummy.u tags
	-rm $(TESTPROGS)

%.o: %.rc
	$(WINDRES) -o $(@) $^

%.o: %.cpp
	$(CPP) -M $(CPPFLAGS) $(EXTFLAGS) $< >$(subst .cpp,.u, $<)
	$(CPP) -c $(CPPFLAGS) $(EXTFLAGS) $<

Res%.cpp: ../ui-xrc/%.xrc
	$(WXRC) -c -n Init$*Handler -o ./Res$*.cpp ../ui-xrc/$*.xrc

check: $(TESTPROGS)

randtest$(EXE): rand.o randtest.o
	$(CPP) -o $(@) $^ $(EXTFLAGS) $(LDFLAGS) $(LIBS)
	./$(@)

base64test$(EXE): base64.o base64test.o
	$(CPP) -o $(@) $^ $(EXTFLAGS) $(LDFLAGS) $(LIBS)
	./$(@)

ctags:
	$(CTAGS) *.h *.cpp

.PHONY: clean all check

-include $(UFILES)
