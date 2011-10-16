/*
 * Port of AutoREALM from Delphi/Object Pascal to wxWidgets/C++
 * Used in rpgs and hobbyist GIS applications for mapmaking
 * Copyright (C) 2004 Michael J. Pedersen <m.pedersen@icelus.org>,
 *                    Michael D. Condon <mcondon@austin.rr.com>
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
#ifndef MAPOBJECT_H
#define MAPOBJECT_H

#include <vector>
#include <set>
#include <iostream>

#include "globals.h"
#include <wx/xml/xml.h>
#include <wx/stream.h>

#include "ViewPoint.h"
#include "DrawPrimitive.h"
#include "matrixmath.h"
#include "HyperlinkPrimitive.h"
#include "arStringList.h"

// AutoREALM pre-release versions (prior to 1.0)
// Oldest supported file format
const long int MAP_VERSION_3 = 0x00000003;

// AutoREALM versions 1.0 through 1.03
// * Addition of LA (Landscape) chunk
const long int MAP_VERSION_4 = 0x00000004;

// AutoREALM versions 1.04 through 1.19
//  * Addition of Bitmap object type
//  * Addition of hyperlink object type
const long int MAP_VERSION_5 = 0x00000005;

// AutoREALM versions 1.20 and beyond...
//  * Addition of UUID to symbols in AuS file.
//  * Creation of user symbol object (symbols were previously just grouped objects).
const long int MAP_VERSION_6 = 0x00000006;

const long int CURRENT_MAP_VERSION = MAP_VERSION_6;
const long int MapVersion = CURRENT_MAP_VERSION;

enum ModType {modGrid, modBkColor, modUnitType, modUnitScale, modOverlay,
    modOverlayState, modViewport, modViews,
    modComments, modSettings, modPrinter,
    modDeleted, modAdded, modChanged, modSymbols, modPushPins};

enum ChunkType {CO_CHUNK, // Color Chunk: background and grid colors
    CM_CHUNK, // Comment Chunk: Map/symbol comments
    OV_CHUNK, // Overlay Chunk: overlays in the map
    GR_CHUNK, // Grid Chunk: grid/snap settings
    VW_CHUNK, // View Chunk: Viewpoints
    PP_CHUNK, // Pushpin Chunk: Push pins
    OB_CHUNK, // Object chunk: Actual map objects
    EO_CHUNK, // End chunk: End of map file
    LA_CHUNK, // Landscape chunk: printer settings for landscape/portrait
    SE_CHUNK, // Selected chunk: Saved selection states
    PH_CHUNK, // Pushpin History
    UNDO_OPERATION // Undo : Not a real chunk, but saves any addition info used in creating undo records
};

enum AlignType {NO_CHANGE, LEFT_TOP, CENTERS, RIGHT_BOTTOM,
    SLANTFORWARD, SLANTBACKWARD, SCATTER, JOG,
    SPACE_EQUALLY, STACK};

enum OrderType {Order_None, Order_LEFT_TOP, Order_RIGHT_TOP, Order_LEFT_BOTTOM, Order_RIGHT_BOTTOM,
               Order_CENTER, Order_EDGE, Order_RANDOM};

enum PushPinFlagType {PP_WaypointsVisible, PP_ShowNumber, PP_ShowNote};

typedef std::set<char> IdSet;
typedef std::set<ChunkType> ChunkSet;
typedef std::set<PushPinFlagType> PushPinFlagSet;
typedef std::set<ModType> ModFlagSet;

/**
 * UndoRecord
 *
 * Used to retain information about how to undo operations
 */
struct UndoRecord {
    /**
     * @brief The name of the UndoRecord
     */
    wxString name;
    ///@todo TMemoryStream? What the hell does it do? This, according to online docs, is the type used to treat a chunk of memory as an iostream. That should be easy enough to handle, once we're ready for it.

    /**
     * @brief A set of flags indicating the type of modification which was performed.
     */
    std::set<ModType> modflags;
};

/**
 * PushPinPoint
 *
 * Used to retain information about the pushpins on the map
 */
struct PushPinPoint {
    /**
     * @brief The note attached to this pushpin
     */
    wxString note;

    /**
     * @brief The location of this pushpin point on the map
     */
    arRealPoint point;
};

/**
 * @todo document this struct (struct PushPinInformation)
 */
struct PushPinInformation {
    wxString name;
    int HistoryCount;
    std::vector<PushPinPoint> History;
};

typedef arStringList<DrawPrimitive> PrimList;

/**
 * @todo document this object (class MapObject)
 */
class MapCollection : public wxObject {
    private:
        DrawPrimitive *head, *tail;
        wxWindow *parent;
        std::set<ModType> modflags;
        //@todo ViewList: TList (this line is copied from MapObject.pas, and should be converted to use wxList, but until we define the view objects, we can't)
        bool fLandscape;
        int suppresscount;
        wxString mapComments;
        bool fReadOnly;

        // Speed Enhancements for Panning
        bool UsePanRects;
        wxRect PanRect1, PanRect2;

        // Undo Information
        int UndoMax, CurrentUndo;
        std::vector<UndoRecord> UndoArray;

        // Pushpin Information
        std::vector<PushPinInformation> pushpin;
        PushPinFlagSet sPushPin;

        void SetUndoMax(int n);
        void RemovePreUndo();
        void RecreateMapState(int number);
        void SetLandscape(bool b);
        void WriteSelectStates(wxStreamBase& s);
        void ReadSelectStates(wxStreamBase& s, wxWindow* newhead);

        void SuppressRedraw();
        void RestoreRedraw();
        std::vector<wxObject> GetSelectedObjectList();

        wxString GetPushPinName(int index);
        void SetPushPinName(int index, wxString s);
        int GetPushPinHistoryCount(int index);
        arRealPoint GetPushPinHistoryPoint(int index, int history);
        void SetPushPinHistoryPoint(int index, int history, arRealPoint pt);
        arRealPoint GetPushPinPoint(int index);
        void SetPushPinPoint(int index, arRealPoint pt);
        wxString GetPushPinHistoryNote(int index, int history);
        void SetPushPinHistoryNote(int index, int history, wxString s);
        wxString GetPushPinAnnotation(int index, int history);
        void SetPushPinFlags(PushPinFlagSet ps);
        wxString GetPushPinText();
        void SetPushPinText(wxString s);

        void SetReadOnly(bool b);
        bool ReadOnlyPrevents();

    protected:
        wxXmlNode GetOverlaysAsDOMElement(wxXmlNode el);
        void LoadOverlaysFromDOMElement(wxXmlNode el);
        void SaveOverlaysToStream(wxStreamBase& s);
        void LoadOverlaysFromStream(wxStreamBase& s);

        void SplitSelectedChain(wxWindow* mainhead, wxWindow* maintail,
            wxWindow* chainhead, wxWindow* chaintail);

        void GetFollowingSelection(wxWindow* insertat);
        void GetTwoPriorSelection(wxWindow* insertat);
        void SetMapChain(wxWindow* d);

    public:
        MapCollection(wxWindow* parent);
        ~MapCollection();

        ViewPoint CurrentView;
        PrimList BasePrimitives;

        bool AnythingSelected();

        bool getReadOnly();
        void setReadOnly();
        bool getLandscape();
        void setLandscape();
        void SynchronizeOverlayList(wxCheckListBox* list);
        int GetViewPoints();
        ViewPoint GetViewPoint(int index);
        ViewPoint GetCurrentViewPoint();
        void SetCurrentViewPoint(const ViewPoint& view);
        int FindViewPoint(const wxString& name);
        void DeleteViewPoint(int index);
        int SaveViewPoint(const ViewPoint& view, wxString name);
        void RestoreLastView();
        void RemoveAllViews();

        void Clear();
        bool IsEmpty();

        bool Modified();
        void ClearModified();
        void ClearModified(ModType mtype);
        void SetModified(ModType mtype);
        wxString ModifiedDescription();

        void Invalidate();
        void InvalidateRect(wxRect ext, bool erase);
        void InvalidateSelect(bool erase);
        void Grid(const ViewPoint& view);
        void Draw(const ViewPoint& view, bool showhandles);
        OverlaySet OverlaysInUse();
        void SelectAll();
        void ShowAll(ViewPoint& view, coord zoomfactor);
        void ClearSelection(bool redraw=true);
        void CenterSelection(bool rescale=false);
        void StartAdding(wxString name);
        void EndAdding();
        void Pan(int dx, int dy);

        ///@todo Convert: function GetMetafile(all: boolean): TMetaFile;
        wxBitmap GetBitmap(bool all, bool viewonly, int width, int height);

        bool FindScalpelPoint(coord x, coord y, DrawPrimitive& p, int& index);
        bool FindClosestPoint(coord dx, coord dy, arRealPoint& point, bool allowselected);
        bool FindClosestPointOn(coord dx, coord dy, arRealPoint& point, coord& angle, bool allowselected);
        bool FindClosestIntersection(coord dx, coord dy, arRealPoint& point);
        void SliceAlong(const arRealPoint& s1, const arRealPoint& s2);
        void SliceAtPoint(const arRealPoint& s);
        void ReverseSelected(bool styleonly);
        bool SetFractalStateSelected(FractalState state);
        void SelectClosestObject(coord dx, coord dy);
        int SelectClickedObject(coord dx, coord dy);
        int Select(arRealRect rect);
        void SelectFromPoint(coord x, coord y, IdSet AcceptableTypes);
        void IterateSelect(arRealRect rect);
        void MoveSelection(coord dx, coord dy);
        void ApplyMatrix(Matrix3 matrix);
        Matrix3 CenterMatrix(Matrix3 mat);
        void RotateSelection(double degrees);
        void ScaleSelection(double xfactor, double yfactor);
        void SkewSelection(double xfactor, double yfactor);
        void FlipSelection(bool xaxis, bool yaxis);
        void AlignSelection(AlignType h, AlignType v, AlignType wd, AlignType hg);
        void OrderSelection(OrderType order);
        void CreateArray(int hc, int vc, coord hs, coord vs, bool hbetween, bool vbetween, bool Ellipse, bool Rotate, coord ex, coord ey);

        bool MoveHandle(HandleMode& mode, coord origx, coord origy, coord dx, coord dy);
        DrawPrimitive FindHandle(coord x, coord y, bool all=false);
        bool FindHyperLink(coord x, coord y, wxString& hypertext, HyperlinkFlags& hyperflags);
        bool FindEndPoint(coord& x, coord& y, DrawPrimitive ignoreobject, DrawPrimitive& p);
        void FindPointOn(coord& x, coord& y, coord& angle, DrawPrimitive ignoreobject, DrawPrimitive& p);
        void AddObject(DrawPrimitive p);
        wxRect Extent(ViewPoint view, bool all);
        arRealRect ExtentFloat(ViewPoint view, bool all);
        arRealRect CoordExtent(bool all);
        void RefreshExtent();

        bool SetStyle(StyleAttrib style);
        StyleAttrib GetStyle();
        bool SetSeed(int seed);
        int GetSeed();
        bool SetColor(wxColour color);
        wxColour GetColor();
        bool SetFillColor(wxColour color);
        wxColour GetFillColor();
        bool SetOverlay(int overlay);
        int GetOverlay();
        bool SetRoughness(int rough);
        int GetRoughness();
        bool SetTextAttrib(const ViewPoint& view, const TextAttrib& attrib);
        TextAttrib GetTextAttrib();

        void RemoveOverlay(int overlay, int replacement, bool delovl);

        void Delete();
        void Group();
        void UnGroup();
        void Decompose();

        void DeleteSelect();
        void GroupSelected();
        void UnGroupSelected();
        void DecomposeSelected();
        void CloseSelectedFigures();
        void DecomposeForPrintout(ViewPoint MapView);

        void SendToBack();
        void BringToFront();
        void SendBackward();
        void BringForward();

        MapCollection GetSelectedObjects(wxWindow* parent);

        DrawPrimitive CopyContents(bool FullCopy=false);
        void RestoreContents(DrawPrimitive d);

        void Cut();
        void Copy();
        void Paste();

        void SetUndoPoint(wxString name, bool compress=false);
        bool Undo();
        bool Redo();
        wxString CurrentUndoName();
        wxString CurrentRedoName();
        int getUndoLevels();
        void setUndoLevels(int levels);

        wxString getMapComments();
        void setMapComments(wxString comments);

        PushPinFlagSet getPushPinFlags();
        void setPushPinFlags(PushPinFlagSet flags);
        wxString getPushPinText();
        void setPushPinText(wxString text);
        wxString getPushPinName(int index);
        void setPushPinName(int index, wxString name);
        arRealPoint getPushPinPoint(int index);
        void setPushPinPoint(int index, arRealPoint name);
        int getPushPinHistoryCount(int index);
        arRealPoint getPushPinHistoryPoint(int index);
        void setPushPinHistoryPoint(int index, arRealPoint name);
        arRealPoint getPushPinHistoryNote(int index);
        void setPushPinHistoryNote(int index, arRealPoint name);
        wxString getPushPinAnnotation(int index, int history);

        void PushPinHistoryPointAdd(int index, arRealPoint pt, wxString note);
        void PushPinHistoryClear(int index);
        bool PushPinPlaced(int index);
        int PushPinCount();
        void DisplaySelectedSize();
        void CleanupBaseList();
        DrawPrimitive getHead();
        wxString ToString(float FNum, int DecPlaces);       

};

#endif //MapObject
