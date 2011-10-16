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
 
#include "globals.h"
#include "MapObject.h"

#include <wx/xrc/xmlres.h>

static const wxString className=wxT("MapCollection");

MapCollection* mapcollection = NULL;



void MapCollection::SetUndoMax(int n) {
    wxLogTrace(className, wxT("Entering SetUndoMax(int n)"));
    wxLogTrace(className, wxT("Exiting SetUndoMax(int n)"));
}

void MapCollection::RemovePreUndo() {
    wxLogTrace(className, wxT("Entering RemovePreUndo()"));
    wxLogTrace(className, wxT("Exiting RemovePreUndo()"));
}

void MapCollection::RecreateMapState(int number) {
    wxLogTrace(className, wxT("Entering RecreateMapState(int number)"));
    wxLogTrace(className, wxT("Exiting RecreateMapState(int number)"));
}

void MapCollection::SetLandscape(bool b) {
    wxLogTrace(className, wxT("Entering SetLandscape(bool b)"));
    wxLogTrace(className, wxT("Exiting SetLandscape(bool b)"));
}

void MapCollection::WriteSelectStates(wxStreamBase& s) {
    wxLogTrace(className, wxT("Entering WriteSelectStates(wxStreamBase& s)"));
    wxLogTrace(className, wxT("Exiting WriteSelectStates(wxStreamBase& s)"));
}

void MapCollection::ReadSelectStates(wxStreamBase& s, wxWindow* newhead) {
    wxLogTrace(className, wxT("Entering ReadSelectStates(wxStreamBase& s, wxWindow* newhead)"));
    wxLogTrace(className, wxT("Exiting ReadSelectStates(wxStreamBase& s, wxWindow* newhead)"));
}

void MapCollection::SuppressRedraw() {
    wxLogTrace(className, wxT("Entering SuppressRedraw()"));
    wxLogTrace(className, wxT("Exiting SuppressRedraw()"));
}

void MapCollection::RestoreRedraw() {
    wxLogTrace(className, wxT("Entering RestoreRedraw()"));
    wxLogTrace(className, wxT("Exiting RestoreRedraw()"));
}

std::vector<wxObject> MapCollection::GetSelectedObjectList() {
    wxLogTrace(className, wxT("Entering ::vector<wxObject> GetSelectedObjectList()"));
    wxLogTrace(className, wxT("Exiting ::vector<wxObject> GetSelectedObjectList()"));
}

wxString MapCollection::GetPushPinName(int index) {
    wxLogTrace(className, wxT("Entering GetPushPinName(int index)"));
    wxLogTrace(className, wxT("Exiting GetPushPinName(int index)"));
}

void MapCollection::SetPushPinName(int index, wxString s) {
    wxLogTrace(className, wxT("Entering SetPushPinName(int index, wxString s)"));
    wxLogTrace(className, wxT("Exiting SetPushPinName(int index, wxString s)"));
}

int MapCollection::GetPushPinHistoryCount(int index) {
    wxLogTrace(className, wxT("Entering GetPushPinHistoryCount(int index)"));
    wxLogTrace(className, wxT("Exiting GetPushPinHistoryCount(int index)"));
}

arRealPoint MapCollection::GetPushPinHistoryPoint(int index, int history) {
    wxLogTrace(className, wxT("Entering GetPushPinHistoryPoint(int index, int history)"));
    wxLogTrace(className, wxT("Exiting GetPushPinHistoryPoint(int index, int history)"));
}

void MapCollection::SetPushPinHistoryPoint(int index, int history, arRealPoint pt) {
    wxLogTrace(className, wxT("Entering SetPushPinHistoryPoint(int index, int history, arRealPoint pt)"));
    wxLogTrace(className, wxT("Exiting SetPushPinHistoryPoint(int index, int history, arRealPoint pt)"));
}

arRealPoint MapCollection::GetPushPinPoint(int index) {
    wxLogTrace(className, wxT("Entering GetPushPinPoint(int index)"));
    wxLogTrace(className, wxT("Exiting GetPushPinPoint(int index)"));
}

void MapCollection::SetPushPinPoint(int index, arRealPoint pt) {
    wxLogTrace(className, wxT("Entering SetPushPinPoint(int index, arRealPoint pt)"));
    wxLogTrace(className, wxT("Exiting SetPushPinPoint(int index, arRealPoint pt)"));
}

wxString MapCollection::GetPushPinHistoryNote(int index, int history) {
    wxLogTrace(className, wxT("Entering GetPushPinHistoryNote(int index, int history)"));
    wxLogTrace(className, wxT("Exiting GetPushPinHistoryNote(int index, int history)"));
}

void MapCollection::SetPushPinHistoryNote(int index, int history, wxString s) {
    wxLogTrace(className, wxT("Entering SetPushPinHistoryNote(int index, int history, wxString s)"));
    wxLogTrace(className, wxT("Exiting SetPushPinHistoryNote(int index, int history, wxString s)"));
}

wxString MapCollection::GetPushPinAnnotation(int index, int history) {
    wxLogTrace(className, wxT("Entering GetPushPinAnnotation(int index, int history)"));
    wxLogTrace(className, wxT("Exiting GetPushPinAnnotation(int index, int history)"));
}

void MapCollection::SetPushPinFlags(PushPinFlagSet ps) {
    wxLogTrace(className, wxT("Entering SetPushPinFlags(PushPinFlagSet ps)"));
    wxLogTrace(className, wxT("Exiting SetPushPinFlags(PushPinFlagSet ps)"));
}

wxString MapCollection::GetPushPinText() {
    wxLogTrace(className, wxT("Entering GetPushPinText()"));
    wxLogTrace(className, wxT("Exiting GetPushPinText()"));
}

void MapCollection::SetPushPinText(wxString s) {
    wxLogTrace(className, wxT("Entering SetPushPinText(wxString s)"));
    wxLogTrace(className, wxT("Exiting SetPushPinText(wxString s)"));
}

void MapCollection::SetReadOnly(bool b) {
    wxLogTrace(className, wxT("Entering SetReadOnly(bool b)"));
    wxLogTrace(className, wxT("Exiting SetReadOnly(bool b)"));
}

bool MapCollection::ReadOnlyPrevents() {
    wxLogTrace(className, wxT("Entering ReadOnlyPrevents()"));
    wxLogTrace(className, wxT("Exiting ReadOnlyPrevents()"));
}

wxXmlNode MapCollection::GetOverlaysAsDOMElement(wxXmlNode el) {
    wxLogTrace(className, wxT("Entering GetOverlaysAsDOMElement(wxXmlNode el)"));
    wxLogTrace(className, wxT("Exiting GetOverlaysAsDOMElement(wxXmlNode el)"));
}

void MapCollection::LoadOverlaysFromDOMElement(wxXmlNode el) {
    wxLogTrace(className, wxT("Entering LoadOverlaysFromDOMElement(wxXmlNode el)"));
    wxLogTrace(className, wxT("Exiting LoadOverlaysFromDOMElement(wxXmlNode el)"));
}

void MapCollection::SaveOverlaysToStream(wxStreamBase& s) {
    wxLogTrace(className, wxT("Entering SaveOverlaysToStream(wxStreamBase& s)"));
    wxLogTrace(className, wxT("Exiting SaveOverlaysToStream(wxStreamBase& s)"));
}

void MapCollection::LoadOverlaysFromStream(wxStreamBase& s) {
    wxLogTrace(className, wxT("Entering LoadOverlaysFromStream(wxStreamBase& s)"));
    wxLogTrace(className, wxT("Exiting LoadOverlaysFromStream(wxStreamBase& s)"));
}

void MapCollection::SplitSelectedChain(wxWindow* mainhead, wxWindow* maintail, wxWindow* chainhead, wxWindow* chaintail) {
    wxLogTrace(className, wxT("Entering SplitSelectedChain(wxWindow* mainhead, wxWindow* maintail, wxWindow* chainhead, wxWindow* chaintail)"));
    wxLogTrace(className, wxT("Exiting SplitSelectedChain(wxWindow* mainhead, wxWindow* maintail, wxWindow* chainhead, wxWindow* chaintail)"));
}

void MapCollection::GetFollowingSelection(wxWindow* insertat) {
    wxLogTrace(className, wxT("Entering GetFollowingSelection(wxWindow* insertat)"));
    wxLogTrace(className, wxT("Exiting GetFollowingSelection(wxWindow* insertat)"));
}

void MapCollection::GetTwoPriorSelection(wxWindow* insertat) {
    wxLogTrace(className, wxT("Entering GetTwoPriorSelection(wxWindow* insertat)"));
    wxLogTrace(className, wxT("Exiting GetTwoPriorSelection(wxWindow* insertat)"));
}

void MapCollection::SetMapChain(wxWindow* d) {
    wxLogTrace(className, wxT("Entering SetMapChain(wxWindow* d)"));
    wxLogTrace(className, wxT("Exiting SetMapChain(wxWindow* d)"));
}

MapCollection::MapCollection(wxWindow* parent) : BasePrimitives() {
    wxLogTrace(className, wxT("Entering MapCollection(wxWindow* parent)"));
    wxLogTrace(className, wxT("Exiting MapCollection(wxWindow* parent)"));
}

MapCollection::~MapCollection() {
    wxLogTrace(className, wxT("Entering ~MapCollection()"));
    wxLogTrace(className, wxT("Exiting ~MapCollection()"));
}

bool MapCollection::AnythingSelected() {
    wxLogTrace(className, wxT("Entering AnythingSelected()"));
    wxLogTrace(className, wxT("Exiting AnythingSelected()"));
}

bool MapCollection::getReadOnly() {
    wxLogTrace(className, wxT("Entering getReadOnly()"));
    wxLogTrace(className, wxT("Exiting getReadOnly()"));
}

void MapCollection::setReadOnly() {
    wxLogTrace(className, wxT("Entering setReadOnly()"));
    wxLogTrace(className, wxT("Exiting setReadOnly()"));
}

bool MapCollection::getLandscape() {
    wxLogTrace(className, wxT("Entering getLandscape()"));
    wxLogTrace(className, wxT("Exiting getLandscape()"));
}

void MapCollection::setLandscape() {
    wxLogTrace(className, wxT("Entering setLandscape()"));
    wxLogTrace(className, wxT("Exiting setLandscape()"));
}

void MapCollection::SynchronizeOverlayList(wxCheckListBox* list) {
    wxLogTrace(className, wxT("Entering SynchronizeOverlayList(wxCheckListBox* list)"));
    wxLogTrace(className, wxT("Exiting SynchronizeOverlayList(wxCheckListBox* list)"));
}

int MapCollection::GetViewPoints() {
    wxLogTrace(className, wxT("Entering GetViewPoints()"));
    wxLogTrace(className, wxT("Exiting GetViewPoints()"));
}

ViewPoint MapCollection::GetViewPoint(int index) {
    wxLogTrace(className, wxT("Entering GetViewPoint(int index)"));
    wxLogTrace(className, wxT("Exiting GetViewPoint(int index)"));
}

ViewPoint MapCollection::GetCurrentViewPoint() {
    wxLogTrace(className, wxT("Entering GetCurrentViewPoint()"));
    wxLogTrace(className, wxT("Exiting GetCurrentViewPoint()"));
}

void MapCollection::SetCurrentViewPoint(const ViewPoint& view) {
    wxLogTrace(className, wxT("Entering SetCurrentViewPoint(const ViewPoint& view)"));
    wxLogTrace(className, wxT("Exiting SetCurrentViewPoint(const ViewPoint& view)"));
}

int MapCollection::FindViewPoint(const wxString& name) {
    wxLogTrace(className, wxT("Entering FindViewPoint(const wxString& name)"));
    wxLogTrace(className, wxT("Exiting FindViewPoint(const wxString& name)"));
}

void MapCollection::DeleteViewPoint(int index) {
    wxLogTrace(className, wxT("Entering DeleteViewPoint(int index)"));
    wxLogTrace(className, wxT("Exiting DeleteViewPoint(int index)"));
}

int MapCollection::SaveViewPoint(const ViewPoint& view, wxString name) {
    wxLogTrace(className, wxT("Entering SaveViewPoint(const ViewPoint& view, wxString name)"));
    wxLogTrace(className, wxT("Exiting SaveViewPoint(const ViewPoint& view, wxString name)"));
}

void MapCollection::RestoreLastView() {
    wxLogTrace(className, wxT("Entering RestoreLastView()"));
    wxLogTrace(className, wxT("Exiting RestoreLastView()"));
}

void MapCollection::RemoveAllViews() {
    wxLogTrace(className, wxT("Entering RemoveAllViews()"));
    wxLogTrace(className, wxT("Exiting RemoveAllViews()"));
}

void MapCollection::Clear() {
    wxLogTrace(className, wxT("Entering Clear()"));
    wxLogTrace(className, wxT("Exiting Clear()"));
}

bool MapCollection::IsEmpty() {
    wxLogTrace(className, wxT("Entering IsEmpty()"));
    wxLogTrace(className, wxT("Exiting IsEmpty()"));
}

bool MapCollection::Modified() {
    wxLogTrace(className, wxT("Entering Modified()"));
    wxLogTrace(className, wxT("Exiting Modified()"));
}

void MapCollection::ClearModified() {
    wxLogTrace(className, wxT("Entering ClearModified()"));
    wxLogTrace(className, wxT("Exiting ClearModified()"));
}

void MapCollection::ClearModified(ModType mtype) {
    wxLogTrace(className, wxT("Entering ClearModified(ModType mtype)"));
    wxLogTrace(className, wxT("Exiting ClearModified(ModType mtype)"));
}

void MapCollection::SetModified(ModType mtype) {
    wxLogTrace(className, wxT("Entering SetModified(ModType mtype)"));
    wxLogTrace(className, wxT("Exiting SetModified(ModType mtype)"));
}

wxString MapCollection::ModifiedDescription() {
    wxLogTrace(className, wxT("Entering ModifiedDescription()"));
    wxLogTrace(className, wxT("Exiting ModifiedDescription()"));
}

void MapCollection::Invalidate() {
    wxLogTrace(className, wxT("Entering Invalidate()"));
    wxLogTrace(className, wxT("Exiting Invalidate()"));
}

void MapCollection::InvalidateRect(wxRect ext, bool erase) {
    wxLogTrace(className, wxT("Entering InvalidateRect(wxRect ext, bool erase)"));
    wxLogTrace(className, wxT("Exiting InvalidateRect(wxRect ext, bool erase)"));
}

void MapCollection::InvalidateSelect(bool erase) {
    wxLogTrace(className, wxT("Entering InvalidateSelect(bool erase)"));
    wxLogTrace(className, wxT("Exiting InvalidateSelect(bool erase)"));
}

void MapCollection::Grid(const ViewPoint& view) {
    wxLogTrace(className, wxT("Entering Grid(const ViewPoint& view)"));
    wxLogTrace(className, wxT("Exiting Grid(const ViewPoint& view)"));
}

void MapCollection::Draw(const ViewPoint& view, bool showhandles) {
    wxLogTrace(className, wxT("Entering Draw(const ViewPoint& view, bool showhandles)"));
    wxLogTrace(className, wxT("Exiting Draw(const ViewPoint& view, bool showhandles)"));
}

OverlaySet MapCollection::OverlaysInUse() {
    wxLogTrace(className, wxT("Entering OverlaysInUse()"));
    wxLogTrace(className, wxT("Exiting OverlaysInUse()"));
}

void MapCollection::SelectAll() {
    wxLogTrace(className, wxT("Entering SelectAll()"));
    wxLogTrace(className, wxT("Exiting SelectAll()"));
}

void MapCollection::ShowAll(ViewPoint& view, coord zoomfactor) {
    wxLogTrace(className, wxT("Entering ShowAll(ViewPoint& view, coord zoomfactor)"));
    wxLogTrace(className, wxT("Exiting ShowAll(ViewPoint& view, coord zoomfactor)"));
}

void MapCollection::ClearSelection(bool redraw) {
    wxLogTrace(className, wxT("Entering ClearSelection(bool redraw=true)"));
    wxLogTrace(className, wxT("Exiting ClearSelection(bool redraw=true)"));
}

void MapCollection::CenterSelection(bool rescale) {
    wxLogTrace(className, wxT("Entering CenterSelection(bool rescale=false)"));
    wxLogTrace(className, wxT("Exiting CenterSelection(bool rescale=false)"));
}

void MapCollection::StartAdding(wxString name) {
    wxLogTrace(className, wxT("Entering StartAdding(wxString name)"));
    wxLogTrace(className, wxT("Exiting StartAdding(wxString name)"));
}

void MapCollection::EndAdding() {
    wxLogTrace(className, wxT("Entering EndAdding()"));
    wxLogTrace(className, wxT("Exiting EndAdding()"));
}

void MapCollection::Pan(int dx, int dy) {
    wxLogTrace(className, wxT("Entering Pan(int dx, int dy)"));
    wxLogTrace(className, wxT("Exiting Pan(int dx, int dy)"));
}

wxBitmap MapCollection::GetBitmap(bool all, bool viewonly, int width, int height) {
    wxLogTrace(className, wxT("Entering GetBitmap(bool all, bool viewonly, int width, int height)"));
    wxLogTrace(className, wxT("Exiting GetBitmap(bool all, bool viewonly, int width, int height)"));
}

bool MapCollection::FindScalpelPoint(coord x, coord y, DrawPrimitive& p, int& index) {
    wxLogTrace(className, wxT("Entering FindScalpelPoint(coord x, coord y, DrawPrimitive& p, int& index)"));
    wxLogTrace(className, wxT("Exiting FindScalpelPoint(coord x, coord y, DrawPrimitive& p, int& index)"));
}

bool MapCollection::FindClosestPoint(coord dx, coord dy, arRealPoint& point, bool allowselected) {
    wxLogTrace(className, wxT("Entering FindClosestPoint(coord dx, coord dy, arRealPoint& point, bool allowselected)"));
    wxLogTrace(className, wxT("Exiting FindClosestPoint(coord dx, coord dy, arRealPoint& point, bool allowselected)"));
}

bool MapCollection::FindClosestPointOn(coord dx, coord dy, arRealPoint& point, coord& angle, bool allowselected) {
    wxLogTrace(className, wxT("Entering FindClosestPointOn(coord dx, coord dy, arRealPoint& point, coord& angle, bool allowselected)"));
    wxLogTrace(className, wxT("Exiting FindClosestPointOn(coord dx, coord dy, arRealPoint& point, coord& angle, bool allowselected)"));
}

bool MapCollection::FindClosestIntersection(coord dx, coord dy, arRealPoint& point) {
    wxLogTrace(className, wxT("Entering FindClosestIntersection(coord dx, coord dy, arRealPoint& point)"));
    wxLogTrace(className, wxT("Exiting FindClosestIntersection(coord dx, coord dy, arRealPoint& point)"));
}

void MapCollection::SliceAlong(const arRealPoint& s1, const arRealPoint& s2) {
    wxLogTrace(className, wxT("Entering SliceAlong(const arRealPoint& s1, const arRealPoint& s2)"));
    wxLogTrace(className, wxT("Exiting SliceAlong(const arRealPoint& s1, const arRealPoint& s2)"));
}

void MapCollection::SliceAtPoint(const arRealPoint& s) {
    wxLogTrace(className, wxT("Entering SliceAtPoint(const arRealPoint& s)"));
    wxLogTrace(className, wxT("Exiting SliceAtPoint(const arRealPoint& s)"));
}

void MapCollection::ReverseSelected(bool styleonly) {
    wxLogTrace(className, wxT("Entering ReverseSelected(bool styleonly)"));
    wxLogTrace(className, wxT("Exiting ReverseSelected(bool styleonly)"));
}

bool MapCollection::SetFractalStateSelected(FractalState state) {
    wxLogTrace(className, wxT("Entering SetFractalStateSelected(FractalState state)"));
    wxLogTrace(className, wxT("Exiting SetFractalStateSelected(FractalState state)"));
}

void MapCollection::SelectClosestObject(coord dx, coord dy) {
    wxLogTrace(className, wxT("Entering SelectClosestObject(coord dx, coord dy)"));
    wxLogTrace(className, wxT("Exiting SelectClosestObject(coord dx, coord dy)"));
}

int MapCollection::SelectClickedObject(coord dx, coord dy) {
    wxLogTrace(className, wxT("Entering SelectClickedObject(coord dx, coord dy)"));
    wxLogTrace(className, wxT("Exiting SelectClickedObject(coord dx, coord dy)"));
}

int MapCollection::Select(arRealRect rect) {
    wxLogTrace(className, wxT("Entering Select(arRealRect rect)"));
    wxLogTrace(className, wxT("Exiting Select(arRealRect rect)"));
}

void MapCollection::SelectFromPoint(coord x, coord y, IdSet AcceptableTypes) {
    wxLogTrace(className, wxT("Entering SelectFromPoint(coord x, coord y, IdSet AcceptableTypes)"));
    wxLogTrace(className, wxT("Exiting SelectFromPoint(coord x, coord y, IdSet AcceptableTypes)"));
}

void MapCollection::IterateSelect(arRealRect rect) {
    wxLogTrace(className, wxT("Entering IterateSelect(arRealRect rect)"));
    wxLogTrace(className, wxT("Exiting IterateSelect(arRealRect rect)"));
}

void MapCollection::MoveSelection(coord dx, coord dy) {
    wxLogTrace(className, wxT("Entering MoveSelection(coord dx, coord dy)"));
    wxLogTrace(className, wxT("Exiting MoveSelection(coord dx, coord dy)"));
}

void MapCollection::ApplyMatrix(Matrix3 matrix) {
    wxLogTrace(className, wxT("Entering ApplyMatrix(Matrix3 matrix)"));
    wxLogTrace(className, wxT("Exiting ApplyMatrix(Matrix3 matrix)"));
}

Matrix3 MapCollection::CenterMatrix(Matrix3 mat) {
    wxLogTrace(className, wxT("Entering CenterMatrix(Matrix3 mat)"));
    wxLogTrace(className, wxT("Exiting CenterMatrix(Matrix3 mat)"));
}

void MapCollection::RotateSelection(double degrees) {
    wxLogTrace(className, wxT("Entering RotateSelection(double degrees)"));
    wxLogTrace(className, wxT("Exiting RotateSelection(double degrees)"));
}

void MapCollection::ScaleSelection(double xfactor, double yfactor) {
    wxLogTrace(className, wxT("Entering ScaleSelection(double xfactor, double yfactor)"));
    wxLogTrace(className, wxT("Exiting ScaleSelection(double xfactor, double yfactor)"));
}

void MapCollection::SkewSelection(double xfactor, double yfactor) {
    wxLogTrace(className, wxT("Entering SkewSelection(double xfactor, double yfactor)"));
    wxLogTrace(className, wxT("Exiting SkewSelection(double xfactor, double yfactor)"));
}

void MapCollection::FlipSelection(bool xaxis, bool yaxis) {
    wxLogTrace(className, wxT("Entering FlipSelection(bool xaxis, bool yaxis)"));
    wxLogTrace(className, wxT("Exiting FlipSelection(bool xaxis, bool yaxis)"));
}

void MapCollection::AlignSelection(AlignType h, AlignType v, AlignType wd, AlignType hg) {
    wxLogTrace(className, wxT("Entering AlignSelection(AlignType h, AlignType v, AlignType wd, AlignType hg)"));
    wxLogTrace(className, wxT("Exiting AlignSelection(AlignType h, AlignType v, AlignType wd, AlignType hg)"));
}

void MapCollection::OrderSelection(OrderType order) {
    wxLogTrace(className, wxT("Entering OrderSelection(OrderType order)"));
    wxLogTrace(className, wxT("Exiting OrderSelection(OrderType order)"));
}

void MapCollection::CreateArray(int hc, int vc, coord hs, coord vs, bool hbetween, bool vbetween, bool Ellipse, bool Rotate, coord ex, coord ey) {
    wxLogTrace(className, wxT("Entering CreateArray(int hc, int vc, coord hs, coord vs, bool hbetween, bool vbetween, bool Ellipse, bool Rotate, coord ex, coord ey)"));
    wxLogTrace(className, wxT("Exiting CreateArray(int hc, int vc, coord hs, coord vs, bool hbetween, bool vbetween, bool Ellipse, bool Rotate, coord ex, coord ey)"));
}

bool MapCollection::MoveHandle(HandleMode& mode, coord origx, coord origy, coord dx, coord dy) {
    wxLogTrace(className, wxT("Entering MoveHandle(HandleMode& mode, coord origx, coord origy, coord dx, coord dy)"));
    wxLogTrace(className, wxT("Exiting MoveHandle(HandleMode& mode, coord origx, coord origy, coord dx, coord dy)"));
}

DrawPrimitive MapCollection::FindHandle(coord x, coord y, bool all) {
    wxLogTrace(className, wxT("Entering FindHandle(coord x, coord y, bool all=false)"));
    wxLogTrace(className, wxT("Exiting FindHandle(coord x, coord y, bool all=false)"));
}

bool MapCollection::FindHyperLink(coord x, coord y, wxString& hypertext, HyperlinkFlags& hyperflags) {
    wxLogTrace(className, wxT("Entering FindHyperLink(coord x, coord y, wxString& hypertext, HyperlinkFlags& hyperflags)"));
    wxLogTrace(className, wxT("Exiting FindHyperLink(coord x, coord y, wxString& hypertext, HyperlinkFlags& hyperflags)"));
}

bool MapCollection::FindEndPoint(coord& x, coord& y, DrawPrimitive ignoreobject, DrawPrimitive& p) {
    wxLogTrace(className, wxT("Entering FindEndPoint(coord& x, coord& y, DrawPrimitive ignoreobject, DrawPrimitive& p)"));
    wxLogTrace(className, wxT("Exiting FindEndPoint(coord& x, coord& y, DrawPrimitive ignoreobject, DrawPrimitive& p)"));
}

void MapCollection::FindPointOn(coord& x, coord& y, coord& angle, DrawPrimitive ignoreobject, DrawPrimitive& p) {
    wxLogTrace(className, wxT("Entering FindPointOn(coord& x, coord& y, coord& angle, DrawPrimitive ignoreobject, DrawPrimitive& p)"));
    wxLogTrace(className, wxT("Exiting FindPointOn(coord& x, coord& y, coord& angle, DrawPrimitive ignoreobject, DrawPrimitive& p)"));
}

void MapCollection::AddObject(DrawPrimitive p) {
    wxLogTrace(className, wxT("Entering AddObject(DrawPrimitive p)"));
    wxLogTrace(className, wxT("Exiting AddObject(DrawPrimitive p)"));
}

wxRect MapCollection::Extent(ViewPoint view, bool all) {
    wxLogTrace(className, wxT("Entering Extent(ViewPoint view, bool all)"));
    wxLogTrace(className, wxT("Exiting Extent(ViewPoint view, bool all)"));
}

arRealRect MapCollection::ExtentFloat(ViewPoint view, bool all) {
    wxLogTrace(className, wxT("Entering ExtentFloat(ViewPoint view, bool all)"));
    wxLogTrace(className, wxT("Exiting ExtentFloat(ViewPoint view, bool all)"));
}

arRealRect MapCollection::CoordExtent(bool all) {
    wxLogTrace(className, wxT("Entering CoordExtent(bool all)"));
    wxLogTrace(className, wxT("Exiting CoordExtent(bool all)"));
}

void MapCollection::RefreshExtent() {
    wxLogTrace(className, wxT("Entering RefreshExtent()"));
    wxLogTrace(className, wxT("Exiting RefreshExtent()"));
}

bool MapCollection::SetStyle(StyleAttrib style) {
    wxLogTrace(className, wxT("Entering SetStyle(StyleAttrib style)"));
    wxLogTrace(className, wxT("Exiting SetStyle(StyleAttrib style)"));
}

StyleAttrib MapCollection::GetStyle() {
    wxLogTrace(className, wxT("Entering GetStyle()"));
    wxLogTrace(className, wxT("Exiting GetStyle()"));
}

bool MapCollection::SetSeed(int seed) {
    wxLogTrace(className, wxT("Entering SetSeed(int seed)"));
    wxLogTrace(className, wxT("Exiting SetSeed(int seed)"));
}

int MapCollection::GetSeed() {
    wxLogTrace(className, wxT("Entering GetSeed()"));
    wxLogTrace(className, wxT("Exiting GetSeed()"));
}

bool MapCollection::SetColor(wxColour color) {
    wxLogTrace(className, wxT("Entering SetColor(wxColour color)"));
    wxLogTrace(className, wxT("Exiting SetColor(wxColour color)"));
}

wxColour MapCollection::GetColor() {
    wxLogTrace(className, wxT("Entering GetColor()"));
    wxLogTrace(className, wxT("Exiting GetColor()"));
}

bool MapCollection::SetFillColor(wxColour color) {
    wxLogTrace(className, wxT("Entering SetFillColor(wxColour color)"));
    wxLogTrace(className, wxT("Exiting SetFillColor(wxColour color)"));
}

wxColour MapCollection::GetFillColor() {
    wxLogTrace(className, wxT("Entering GetFillColor()"));
    wxLogTrace(className, wxT("Exiting GetFillColor()"));
}

bool MapCollection::SetOverlay(int overlay) {
    wxLogTrace(className, wxT("Entering SetOverlay(int overlay)"));
    wxLogTrace(className, wxT("Exiting SetOverlay(int overlay)"));
}

int MapCollection::GetOverlay() {
    wxLogTrace(className, wxT("Entering GetOverlay()"));
    wxLogTrace(className, wxT("Exiting GetOverlay()"));
}

bool MapCollection::SetRoughness(int rough) {
    wxLogTrace(className, wxT("Entering SetRoughness(int rough)"));
    wxLogTrace(className, wxT("Exiting SetRoughness(int rough)"));
}

int MapCollection::GetRoughness() {
    wxLogTrace(className, wxT("Entering GetRoughness()"));
    wxLogTrace(className, wxT("Exiting GetRoughness()"));
}

bool MapCollection::SetTextAttrib(const ViewPoint& view, const TextAttrib& attrib) {
    wxLogTrace(className, wxT("Entering SetTextAttrib(const ViewPoint& view, const TextAttrib& attrib)"));
    wxLogTrace(className, wxT("Exiting SetTextAttrib(const ViewPoint& view, const TextAttrib& attrib)"));
}

TextAttrib MapCollection::GetTextAttrib() {
    wxLogTrace(className, wxT("Entering GetTextAttrib()"));
    wxLogTrace(className, wxT("Exiting GetTextAttrib()"));
}

void MapCollection::RemoveOverlay(int overlay, int replacement, bool delovl) {
    wxLogTrace(className, wxT("Entering RemoveOverlay(int overlay, int replacement, bool delovl)"));
    wxLogTrace(className, wxT("Exiting RemoveOverlay(int overlay, int replacement, bool delovl)"));
}

void MapCollection::Delete() {
    wxLogTrace(className, wxT("Entering Delete()"));
    wxLogTrace(className, wxT("Exiting Delete()"));
}

void MapCollection::Group() {
    wxLogTrace(className, wxT("Entering Group()"));
    wxLogTrace(className, wxT("Exiting Group()"));
}

void MapCollection::UnGroup() {
    wxLogTrace(className, wxT("Entering UnGroup()"));
    wxLogTrace(className, wxT("Exiting UnGroup()"));
}

void MapCollection::Decompose() {
    wxLogTrace(className, wxT("Entering Decompose()"));
    wxLogTrace(className, wxT("Exiting Decompose()"));
}

void MapCollection::DeleteSelect() {
    wxLogTrace(className, wxT("Entering DeleteSelect()"));
    wxLogTrace(className, wxT("Exiting DeleteSelect()"));
}

void MapCollection::GroupSelected() {
    wxLogTrace(className, wxT("Entering GroupSelected()"));
    wxLogTrace(className, wxT("Exiting GroupSelected()"));
}

void MapCollection::UnGroupSelected() {
    wxLogTrace(className, wxT("Entering UnGroupSelected()"));
    wxLogTrace(className, wxT("Exiting UnGroupSelected()"));
}

void MapCollection::DecomposeSelected() {
    wxLogTrace(className, wxT("Entering DecomposeSelected()"));
    wxLogTrace(className, wxT("Exiting DecomposeSelected()"));
}

void MapCollection::CloseSelectedFigures() {
    wxLogTrace(className, wxT("Entering CloseSelectedFigures()"));
    wxLogTrace(className, wxT("Exiting CloseSelectedFigures()"));
}

void MapCollection::DecomposeForPrintout(ViewPoint MapView) {
    wxLogTrace(className, wxT("Entering DecomposeForPrintout(ViewPoint MapView)"));
    wxLogTrace(className, wxT("Exiting DecomposeForPrintout(ViewPoint MapView)"));
}

void MapCollection::SendToBack() {
    wxLogTrace(className, wxT("Entering SendToBack()"));
    wxLogTrace(className, wxT("Exiting SendToBack()"));
}

void MapCollection::BringToFront() {
    wxLogTrace(className, wxT("Entering BringToFront()"));
    wxLogTrace(className, wxT("Exiting BringToFront()"));
}

void MapCollection::SendBackward() {
    wxLogTrace(className, wxT("Entering SendBackward()"));
    wxLogTrace(className, wxT("Exiting SendBackward()"));
}

void MapCollection::BringForward() {
    wxLogTrace(className, wxT("Entering BringForward()"));
    wxLogTrace(className, wxT("Exiting BringForward()"));
}

MapCollection MapCollection::GetSelectedObjects(wxWindow* parent) {
    wxLogTrace(className, wxT("Entering GetSelectedObjects(wxWindow* parent)"));
    wxLogTrace(className, wxT("Exiting GetSelectedObjects(wxWindow* parent)"));
}

DrawPrimitive MapCollection::CopyContents(bool FullCopy) {
    wxLogTrace(className, wxT("Entering CopyContents(bool FullCopy=false)"));
    wxLogTrace(className, wxT("Exiting CopyContents(bool FullCopy=false)"));
}

void MapCollection::RestoreContents(DrawPrimitive d) {
    wxLogTrace(className, wxT("Entering RestoreContents(DrawPrimitive d)"));
    wxLogTrace(className, wxT("Exiting RestoreContents(DrawPrimitive d)"));
}

void MapCollection::Cut() {
    wxLogTrace(className, wxT("Entering Cut()"));
    wxLogTrace(className, wxT("Exiting Cut()"));
}

void MapCollection::Copy() {
    wxLogTrace(className, wxT("Entering Copy()"));
    wxLogTrace(className, wxT("Exiting Copy()"));
}

void MapCollection::Paste() {
    wxLogTrace(className, wxT("Entering Paste()"));
    wxLogTrace(className, wxT("Exiting Paste()"));
}

void MapCollection::SetUndoPoint(wxString name, bool compress) {
    wxLogTrace(className, wxT("Entering SetUndoPoint(wxString name, bool compress=false)"));
    wxLogTrace(className, wxT("Exiting SetUndoPoint(wxString name, bool compress=false)"));
}

bool MapCollection::Undo() {
    wxLogTrace(className, wxT("Entering Undo()"));
    wxLogTrace(className, wxT("Exiting Undo()"));
}

bool MapCollection::Redo() {
    wxLogTrace(className, wxT("Entering Redo()"));
    wxLogTrace(className, wxT("Exiting Redo()"));
}

wxString MapCollection::CurrentUndoName() {
    wxLogTrace(className, wxT("Entering CurrentUndoName()"));
    wxLogTrace(className, wxT("Exiting CurrentUndoName()"));
}

wxString MapCollection::CurrentRedoName() {
    wxLogTrace(className, wxT("Entering CurrentRedoName()"));
    wxLogTrace(className, wxT("Exiting CurrentRedoName()"));
}

int MapCollection::getUndoLevels() {
    wxLogTrace(className, wxT("Entering getUndoLevels()"));
    wxLogTrace(className, wxT("Exiting getUndoLevels()"));
}

void MapCollection::setUndoLevels(int levels) {
    wxLogTrace(className, wxT("Entering setUndoLevels(int levels)"));
    wxLogTrace(className, wxT("Exiting setUndoLevels(int levels)"));
}

wxString MapCollection::getMapComments() {
    wxLogTrace(className, wxT("Entering getMapComments()"));
    wxLogTrace(className, wxT("Exiting getMapComments()"));
}

void MapCollection::setMapComments(wxString comments) {
    wxLogTrace(className, wxT("Entering setMapComments(wxString comments)"));
    wxLogTrace(className, wxT("Exiting setMapComments(wxString comments)"));
}

PushPinFlagSet MapCollection::getPushPinFlags() {
    wxLogTrace(className, wxT("Entering getPushPinFlags()"));
    wxLogTrace(className, wxT("Exiting getPushPinFlags()"));
}

void MapCollection::setPushPinFlags(PushPinFlagSet flags) {
    wxLogTrace(className, wxT("Entering setPushPinFlags(PushPinFlagSet flags)"));
    wxLogTrace(className, wxT("Exiting setPushPinFlags(PushPinFlagSet flags)"));
}

wxString MapCollection::getPushPinText() {
    wxLogTrace(className, wxT("Entering getPushPinText()"));
    wxLogTrace(className, wxT("Exiting getPushPinText()"));
}

void MapCollection::setPushPinText(wxString text) {
    wxLogTrace(className, wxT("Entering setPushPinText(wxString text)"));
    wxLogTrace(className, wxT("Exiting setPushPinText(wxString text)"));
}

wxString MapCollection::getPushPinName(int index) {
    wxLogTrace(className, wxT("Entering getPushPinName(int index)"));
    wxLogTrace(className, wxT("Exiting getPushPinName(int index)"));
}

void MapCollection::setPushPinName(int index, wxString name) {
    wxLogTrace(className, wxT("Entering setPushPinName(int index, wxString name)"));
    wxLogTrace(className, wxT("Exiting setPushPinName(int index, wxString name)"));
}

arRealPoint MapCollection::getPushPinPoint(int index) {
    wxLogTrace(className, wxT("Entering getPushPinPoint(int index)"));
    wxLogTrace(className, wxT("Exiting getPushPinPoint(int index)"));
}

void MapCollection::setPushPinPoint(int index, arRealPoint name) {
    wxLogTrace(className, wxT("Entering setPushPinPoint(int index, arRealPoint name)"));
    wxLogTrace(className, wxT("Exiting setPushPinPoint(int index, arRealPoint name)"));
}

int MapCollection::getPushPinHistoryCount(int index) {
    wxLogTrace(className, wxT("Entering getPushPinHistoryCount(int index)"));
    wxLogTrace(className, wxT("Exiting getPushPinHistoryCount(int index)"));
}

arRealPoint MapCollection::getPushPinHistoryPoint(int index) {
    wxLogTrace(className, wxT("Entering getPushPinHistoryPoint(int index)"));
    wxLogTrace(className, wxT("Exiting getPushPinHistoryPoint(int index)"));
}

void MapCollection::setPushPinHistoryPoint(int index, arRealPoint name) {
    wxLogTrace(className, wxT("Entering setPushPinHistoryPoint(int index, arRealPoint name)"));
    wxLogTrace(className, wxT("Exiting setPushPinHistoryPoint(int index, arRealPoint name)"));
}

arRealPoint MapCollection::getPushPinHistoryNote(int index) {
    wxLogTrace(className, wxT("Entering getPushPinHistoryNote(int index)"));
    wxLogTrace(className, wxT("Exiting getPushPinHistoryNote(int index)"));
}

void MapCollection::setPushPinHistoryNote(int index, arRealPoint name) {
    wxLogTrace(className, wxT("Entering setPushPinHistoryNote(int index, arRealPoint name)"));
    wxLogTrace(className, wxT("Exiting setPushPinHistoryNote(int index, arRealPoint name)"));
}

wxString MapCollection::getPushPinAnnotation(int index, int history) {
    wxLogTrace(className, wxT("Entering getPushPinAnnotation(int index, int history)"));
    wxLogTrace(className, wxT("Exiting getPushPinAnnotation(int index, int history)"));
}

void MapCollection::PushPinHistoryPointAdd(int index, arRealPoint pt, wxString note) {
    wxLogTrace(className, wxT("Entering PushPinHistoryPointAdd(int index, arRealPoint pt, wxString note)"));
    wxLogTrace(className, wxT("Exiting PushPinHistoryPointAdd(int index, arRealPoint pt, wxString note)"));
}

void MapCollection::PushPinHistoryClear(int index) {
    wxLogTrace(className, wxT("Entering PushPinHistoryClear(int index)"));
    wxLogTrace(className, wxT("Exiting PushPinHistoryClear(int index)"));
}

bool MapCollection::PushPinPlaced(int index) {
    wxLogTrace(className, wxT("Entering PushPinPlaced(int index)"));
    wxLogTrace(className, wxT("Exiting PushPinPlaced(int index)"));
}

int MapCollection::PushPinCount() {
    wxLogTrace(className, wxT("Entering PushPinCount()"));
    wxLogTrace(className, wxT("Exiting PushPinCount()"));
    return pushpin.size();
}


/*
  Name: DisplaySelectedSize
  @brief Displays size of selected rectangle
*/
void MapCollection::DisplaySelectedSize() {
    wxLogTrace(className, wxT("Entering DisplaySelectedSize()"));
    
    arRealRect SelectedRect;         // selected rectangle
    float EditXSize = 0.0f;          // selected area X size
    float EditYSize = 0.0f;          // selected area Y size
    wxTextCtrl* EditXSizeWin;        // text window for X size
    wxTextCtrl* EditYSizeWin;        // text window for Y size
    wxString EditXSizeStr(wxT(""));  // to convert float to string
    wxString EditYSizeStr(wxT(""));  // to convert float to string
    wxString logMessage;             // temp string for log msgs
    extern MainWin* glbMainWin;
    
    wxASSERT(glbMainWin != NULL);  // make sure we have a main window
    
    // compute new X and Y values if necessary
    if (AnythingSelected()) {
        SelectedRect = CoordExtent(false);   // false=use only selected objects for 
                                             // calculation of extent instead of
                                             // entire mapcollection.
       
        EditXSize = SelectedRect.GetWidth();
        EditYSize = SelectedRect.GetHeight();
        
        EditXSize = EditXSize * 
                    mapcollection->CurrentView.grid.GraphUnitConvert * 
                    mapcollection->CurrentView.grid.GraphScale;
                     
        EditYSize = EditYSize * 
                    mapcollection->CurrentView.grid.GraphUnitConvert * 
                    mapcollection->CurrentView.grid.GraphScale;
        
        EditXSizeStr = ToString(EditXSize, 2);
        EditYSizeStr = ToString(EditYSize, 2);
    }
    
    // fetch our X and Y size windows
    EditXSizeWin = static_cast<wxTextCtrl*>(glbMainWin->
	               FindWindowByName(wxT("txtXSize"), glbMainWin));
    wxASSERT(EditXSizeWin != NULL);
    
    EditYSizeWin = static_cast<wxTextCtrl*>(glbMainWin->
                       FindWindowByName(wxT("txtYSize"), glbMainWin));
    wxASSERT(EditYSize != NULL);
    
    // update values
    EditXSizeWin->SetLabel(EditXSizeStr);
    EditYSizeWin->SetLabel(EditYSizeStr);
 
    wxLogTrace(className, wxT("Exiting DisplaySelectedSize()"));
}

void MapCollection::CleanupBaseList() {
    wxLogTrace(className, wxT("Entering CleanupBaseList()"));
    BasePrimitives.Cleanup();
    wxLogTrace(className, wxT("Exiting CleanupBaseList()"));
}

/*
 Name: getHead
 @brief accessor for head (head of list of our DrawPrimitives)
*/
DrawPrimitive MapCollection::getHead() {
    wxLogTrace(className, wxT("Entering getHead()"));
    wxLogTrace(className, wxT("Exiting getHead()"));
    return *head;
}



/*
  Name: FloatToString   
  @brief Utility method to convert from float to string
*/
wxString MapCollection::ToString(float FNum, int DecPlaces) {
    wxString Result, Format;

    wxASSERT(DecPlaces >= 0);
    wxASSERT(DecPlaces <= 6);

    Format.Printf(wxT("%%.%df"), DecPlaces);
    Result.Printf(Format, FNum);
    
    return Result;
}
    
    

    

	
