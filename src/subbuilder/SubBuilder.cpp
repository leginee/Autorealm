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


#include <wx/tokenzr.h>
#include <wx/log.h>

#include "subbuilder/ARDocumentBuilder.h"
#include "subbuilder/CurveModelBuilder.h"
#include "subbuilder/GridObjectBuilder.h"
#include "subbuilder/GroupModelBuilder.h"
#include "subbuilder/LineModelBuilder.h"
#include "subbuilder/OverlayBuilder.h"
#include "subbuilder/PolyCurveModelBuilder.h"
#include "subbuilder/PolyLineModelBuilder.h"
#include "subbuilder/PushpinBuilder.h"
#include "subbuilder/ViewPointBuilder.h"
#include "ViewPointModel.h"
#include "Tracer.h"


/**
 * @brief The trace string for this file.
 */
TRACEFLAG(wxT("SubBuilder"));

namespace subbuilderComponents 
{

    /********************************************************************/
    /********************************************************************/
    /*                      SubBuilder Classes                          */
    /********************************************************************/
    /********************************************************************/

    std::vector<BuilderStackEntry> bldrstack;

    
    void SubBuilder::addAttribs(const ObjectAttributes p_attribs, BuilderStackEntry& p_tag)
    {
        TRACER(wxT("SubBuilder::addAttribs"));
        wxASSERT(p_tag.m_obj != NULL);
        for (unsigned int i = 0; i < p_attribs.size(); ++i)
        {
            p_tag.m_obj->m_extraData[p_attribs.at(i).m_name] = p_attribs.at(i).m_value;
            TRACE(wxT("SubBuilder::addAttribs(): tag: %s, data: %s"),
                       p_attribs.at(i).m_name.c_str(),
                       p_tag.m_obj->m_extraData[p_attribs.at(i).m_name].c_str());
        }
    }


    
    /********************************************************************/
    /********************************************************************/
    /*                    Factory/Util Classes                          */
    /********************************************************************/
    /********************************************************************/

    SubBuilderFactory::SubBuilderFactory()
    {
        TRACER(wxT("SubBuilderFactory"));
        m_ardbldr     = new ARDocumentBuilder;
        m_curvebldr   = new CurveModelBuilder;
        m_gridbldr    = new GridObjectBuilder;
        m_grpbldr     = new GroupModelBuilder;
        m_linebldr    = new LineModelBuilder;
        m_overlaybldr = new OverlayBuilder;
        m_pcurvebldr  = new PolyCurveModelBuilder;
        m_plinebldr   = new PolyLineModelBuilder;
        m_pinbldr     = new PushpinBuilder;
        m_viewbldr    = new ViewPointBuilder;
    }
    
    SubBuilderFactory::~SubBuilderFactory()
    {
        TRACER(wxT("~SubBuilderFactory"));
        delete m_ardbldr;
        delete m_curvebldr;
        delete m_gridbldr;
        delete m_grpbldr;
        delete m_linebldr;
        delete m_overlaybldr;
        delete m_pcurvebldr;
        delete m_plinebldr;
        delete m_pinbldr;
        delete m_viewbldr;
    }
    
    SubBuilder* SubBuilderFactory::Get(const wxString& name)
    {
        SubBuilder* retval = NULL;
        
        TRACER(wxT("Get"));
        if (name == wxT("document"))
        {
            TRACE(wxT("getting ARDocumentBuilder"));
            retval = m_ardbldr;
        }
        else if (name == wxT("gridobject"))
        {
            TRACE(wxT("getting GridObjectBuilder"));
            retval = m_gridbldr;
        }
        else if (name == wxT("viewpoint"))
        {
            TRACE(wxT("getting ViewPointBuilder"));
            retval = m_viewbldr;
        }
        else if (name.Matches(wxT("overlay_*")) and (name != wxT("overlay_id")))
        {
            TRACE(wxT("getting OverlayBuilder"));
            retval = m_overlaybldr;
        }
        else if (name.Matches(wxT("pushpin*")))
        {
            TRACE(wxT("getting PushpinBuilder"));
            retval = m_pinbldr;
        }
        else if (name == wxT("drawchain"))
        {
            TRACE(wxT("getting GroupModelBuilder"));
            retval = m_grpbldr;
        }
        else if (name == wxT("curve"))
        {
            TRACE(wxT("getting CurveModelBuilder"));
            retval = m_curvebldr;
        }
        else if (name == wxT("line"))
        {
            TRACE(wxT("getting LineModelBuilder"));
            retval = m_linebldr;
        }
        else if (name == wxT("polycurve"))
        {
            TRACE(wxT("getting PolyCurveModelBuilder"));
            retval = m_pcurvebldr;
        }
        else if (name == wxT("polyline"))
        {
            TRACE(wxT("getting PolyLineModelBuilder"));
            retval = m_plinebldr;
        }
        else 
        {
            if (bldrstack.size() >= 1)
            {
                TRACE(wxT("minor tag, returning previous builder"));
                retval = bldrstack.at(bldrstack.size() - 1).m_bldr;
            }
            else
            {
                TRACE(wxT("minor tag, and no previous builder. Returning NULL"));
            }
        }
        return retval;
    }

    /**
     * @warning Where is the delete m_factory?
     */
    SubBuilderFactory* SubBuilderFactorySingleton::Get()
    {
        TRACER(wxT("SubBuilderFactorySingleton::Get()"));
        if (m_factory == NULL)
        {
            m_factory = new SubBuilderFactory();
        }
        return m_factory;
    }
    
    SubBuilderFactory* SubBuilderFactorySingleton::m_factory = NULL;
    
    
    /********************************************************************/
    /********************************************************************/
    /*                      Utility Routines                            */
    /********************************************************************/
    /********************************************************************/
    
    /**
     * @brief A list of all valid tags.
     * 
     * By coincidence, this list matches all tags which are usable in AuRX files.
     * The indentation shows the nesting. While it's not much by way of
     * documenting them, it'll do for now.
     */
    static const wxString allNames[] = 
    {
        wxT("document"),
            wxT("map"),
                wxT("globals"),
                    wxT("version"),
                    wxT("current_grid_color"),
                    wxT("background_color"),
                wxT("commentset"),
                    wxT("comments"),
                wxT("overlays"),
                    wxT("count"),
                    wxT("overlay_"),
                wxT("landscapeset"),
                    wxT("landscape"),
                wxT("grid"),
                    wxT("snaptogrid"),
                    wxT("snaptopoint"),
                    wxT("snapalong"),
                    wxT("rotatesnap"),
                    wxT("displaygrid"),
                    wxT("designgridunits"),
                wxT("viewpoints"),
                    wxT("count"),
                    wxT("id"),
                    wxT("viewpoint"),
                        wxT("name"),
                        wxT("clientwidth"),
                        wxT("clientheight"),
                        wxT("area"),
                        wxT("visible_overlays"),
                        wxT("active_overlays"),
                        wxT("gridobject"),
                            wxT("graph_scale"),
                            wxT("graph_unit_convert"),
                            wxT("graph_units"),
                            wxT("current_graph_units"),
                            wxT("current_size"),
                            wxT("type"),
                            wxT("bold_units"),
                            wxT("flags"),
                            wxT("position"),
                            wxT("primary_style"),
                            wxT("secondary_style"),
                wxT("pushpin_history"), // must handle. MapObject.pas:4796
                    wxT("count"), //i
                    wxT("waypoints_visible"),//b
                    wxT("show_number"),//b
                    wxT("show_note"),//b
                    wxT("pin_history_"), // ends with number
                        wxT("name"),//s (mime)
                        wxT("count"),//i
                        wxT("hist_"), // ends with number
                            wxT("point"),//coordpoint
                            wxT("note"),//s (mime)
                wxT("pushpins"), // must handle. MapObject.pas: 4826
                    wxT("count"),//i
                    wxT("pin_"), // ends with number
                        wxT("checked"),//b
                        wxT("placed"),//b
                        wxT("point"),//coordpoint
                wxT("map_contents"),
                    wxT("drawchain"),
                        // here's where all of the actual map objects go
                        // Look in Primitives.pas for GetAsDOMElement
                        // all elements get a "cid" tag at the end, which
                        // is nothing more than an incrementing counter
                        // first four elements are at Primitives.pas:4169
                        wxT("line"), //Primitives.pas:5835
                            wxT("color"),
                            wxT("overlay_id"),
                            wxT("extent"),
                            wxT("selected"),
                            wxT("x1"),
                            wxT("y1"),
                            wxT("x2"),
                            wxT("y2"),
                            wxT("style"),
                            wxT("thickness"),
                            wxT("fractal"),
                            wxT("sthickness"),
                            wxT("seed"),
                            wxT("roughness"),
                        wxT("curve"), //Primitives.pas:6851
                            wxT("color"),
                            wxT("overlay_id"),
                            wxT("extent"),
                            wxT("selected"),
                            wxT("p1"),
                            wxT("p2"),
                            wxT("p3"),
                            wxT("p4"),
                            wxT("style"),
                            wxT("thickness"),
                            wxT("fractal"),
                            wxT("sthickness"),
                            wxT("seed"),
                            wxT("roughness"),
                        wxT("polyline"), //Primitives.pas:9384
                            wxT("color"),
                            wxT("overlay_id"),
                            wxT("extent"),
                            wxT("selected"),
                            wxT("fillcolor"),
                            wxT("count"),
                            wxT("points"),
                            wxT("style"),
                            wxT("thickness"),
                            wxT("fractal"),
                            wxT("sthickness"),
                            wxT("seed"),
                            wxT("roughness"),
                        wxT("polycurve"), //Primitives.pas:7985
                            wxT("color"),
                            wxT("overlay_id"),
                            wxT("extent"),
                            wxT("selected"),
                            wxT("fillcolor"),
                            wxT("count"),
                            wxT("points"),
                            wxT("style"),
                            wxT("thickness"),
                            wxT("fractal"),
                            wxT("sthickness"),
                            wxT("seed"),
                            wxT("roughness"),
                        wxT("symbol"), //Primitives.pas:4804
                            wxT("color"),
                            wxT("overlay_id"),
                            wxT("extent"),
                            wxT("selected"),
                            wxT("x1"),
                            wxT("y1"),
                            wxT("cw"),
                            wxT("ch"),
                            wxT("chx"),
                            wxT("size"),
                            wxT("angle"),
                            wxT("text"),
                            wxT("outline_color"),
                        wxT("text"), //Primitives.pas:5098
                            wxT("color"),
                            wxT("overlay_id"),
                            wxT("extent"),
                            wxT("selected"),
                            wxT("font"),
                            wxT("bold"),
                            wxT("italic"),
                            wxT("underline"),
                            wxT("strikeout"),
                            wxT("formatflags"),
                        wxT("textcurve"),//Primitives.pas:8339
                            wxT("color"),
                            wxT("overlay_id"),
                            wxT("extent"),
                            wxT("selected"),
                            wxT("ch"),
                            wxT("size"),
                            wxT("text"),
                            wxT("font"),
                            wxT("bold"),
                            wxT("italic"),
                            wxT("underline"),
                            wxT("strikeout"),
                            wxT("outline_color"),
                        wxT("group"),//Primitives.pas:9889
                            wxT("color"),
                            wxT("overlay_id"),
                            wxT("extent"),
                            wxT("selected"),
                            wxT("drawchain"), //note that this is the
                                              //*same* drawchain tag that
                                              //contains this group.
                                              //Recursion!
                        wxT("bitmap"),//Primitives.pas:10111
                                    // see todo in base64.cpp when coding
                                    // this one!
                            wxT("color"),
                            wxT("overlay_id"),
                            wxT("extent"),
                            wxT("selected"),
                            wxT("corners"),
                            wxT("image"),
                        wxT("hyperlink"),//Primitives.pas:104040
                            wxT("color"),
                            wxT("overlay_id"),
                            wxT("extent"),
                            wxT("selected"),
                            wxT("x1"),
                            wxT("y1"),
                            wxT("text"),
                            wxT("execute"),
                            wxT("hidden"),
                    wxT("count"), // the final cid, +1
        wxT("")
    };

    bool isTagInList(const wxString& p_tag)
    {
        TRACER(wxT("isTagInList"));
        int i = 0;
        bool retval = false;
        while (allNames[i] != wxT(""))
        {
            if (allNames[i++] == p_tag)
            {
                TRACE(wxT("tag found: %s"), p_tag.c_str());
                retval = true;
                break;
            }
        }
        return retval;
    }

    wxColor LongToColor(long int color)
    {
        TRACER(wxT("LongToColor"));
        int red   = (color & 0xff0000) >> 16;
        int green = (color & 0x00ff00) >>  8;
        int blue  = (color & 0x0000ff)      ;
        TRACE(wxT("red: %d, green: %d, blue: %d"), red, green, blue);
        return wxColor(red, green, blue);
    }

    bool StringToBool(const wxString& p_data) throw (ARInvalidBoolString)
    {
        TRACER(wxT("StringToBool"));
        bool retval;
        wxString lower = p_data.Lower();
        if ((lower == wxT("true")) or (lower == wxT("1")) or (lower == wxT("-1")))
        {
            TRACE(wxT("bool == true"));
            retval = true;
        }
        else if ((lower == wxT("false")) or (lower == wxT("0")))
        {
            TRACE(wxT("bool == false"));
            retval = false;
        }
        else
        {
            TRACE(wxT("bool == unknown"));
            wxString msg;
            msg.Printf(wxT("Boolean value '%s' is invalid"), lower.c_str());
            EXCEPT(ARInvalidBoolString, msg);
        }
        return retval;
    }

    OverlayVector StringToOverlayVector(const wxString& p_data) throw (ARBadNumberFormat)
    {
        TRACER(wxT("StringToOverlayVector"));
        wxString nextval, msg;
        wxStringTokenizer tok(p_data, wxT(","));
        OverlayVector retval;
        long int overnum;
        while (tok.HasMoreTokens())
        {
            nextval = tok.GetNextToken();
            TRACE(wxT("StringToOverlayVector: Overlay number %s"), nextval.c_str());
            if (!nextval.ToLong(&overnum) or (overnum < 0))
            {
                msg.Printf(wxT("Invalid Number: %s"), nextval.c_str());
                EXCEPT(ARBadNumberFormat, msg);
            }
            retval.at(overnum) = true;
        }
        return retval;
    }

    arRealPoint StringToPoint(const wxString& p_data) throw (ARBadNumberFormat)
    {
        TRACER(wxT("StringToPoint"));
        arRealPoint pt;
        wxStringTokenizer tok(p_data, wxT(","));
        wxString nextval, msg;
        double val;

        pt.x = 0;
        pt.y = 0;
        if (tok.HasMoreTokens())
        {
            nextval = tok.GetNextToken();
            TRACE(wxT("Next token: %s"), nextval.c_str());
            if (!nextval.ToDouble(&val))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid left position"));
            }
            pt.x = val;
        }
        if (tok.HasMoreTokens())
        {
            nextval = tok.GetNextToken();
            TRACE(wxT("Next token: %s"), nextval.c_str());
            if (!nextval.ToDouble(&val))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid top position"));
            }
            pt.y = val;
        }
        TRACE(wxT("x: %4.4fL, y: %4.4fL"), pt.x, pt.y);
        return pt;
    }

    arRealRect StringToRect(const wxString& p_data) throw (ARBadNumberFormat)
    {
        TRACER(wxT("StringToRect"));
        arRealRect area;
        wxStringTokenizer tok(p_data, wxT(","));
        wxString nextval;
        double val;

        area.x = 0;
        area.y = 0;
        area.width = 0;
        area.height = 0;
        if (tok.HasMoreTokens())
        {
            nextval = tok.GetNextToken();
            TRACE(wxT("Next token: %s"), nextval.c_str());
            if (!nextval.ToDouble(&val))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid left position"));
            }
            area.x = val;
        }
        if (tok.HasMoreTokens())
        {
            nextval = tok.GetNextToken();
            TRACE(wxT("Next token: %s"), nextval.c_str());
            if (!nextval.ToDouble(&val))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid top position"));
            }
            area.y = val;
        }
        if (tok.HasMoreTokens())
        {
            nextval = tok.GetNextToken();
            TRACE(wxT("Next token: %s"), nextval.c_str());
            if (!nextval.ToDouble(&val))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid right position"));
            }
            area.SetRight(val);
        }
        if (tok.HasMoreTokens())
        {
            nextval = tok.GetNextToken();
            TRACE(wxT("Next token: %s"), nextval.c_str());
            if (!nextval.ToDouble(&val))
            {
                EXCEPT(ARBadNumberFormat, wxT("Invalid bottom position"));
            }
            area.SetBottom(val);
        }
        TRACE(wxT("x: %4.4fL, y: %4.4fL, w: %4.4fL, h: %4.4fL"), area.x, area.y, area.width, area.height);
        return area;
    }

    VPoints StringToVPoints(const wxString& p_data, unsigned int p_count)
                            throw (ARBadNumberFormat, ARInvalidTagException)
    {
        TRACER(wxT("StringToVPoints"));
        VPoints retval;
        wxStringTokenizer tok(p_data, wxT(":"));
        wxString nextval;

        retval.resize(p_count);
        for (unsigned int i = 0; i < p_count; ++i)
        {
            if (tok.HasMoreTokens())
            {
                nextval = tok.GetNextToken();
                TRACE(wxT("Next token: %s"), nextval.c_str());
                retval.at(i) = StringToPoint(nextval);
            }
            else
            {
                EXCEPT(ARInvalidTagException, wxT("Invalid number of points"));
                break;
            }            
        }
        
        return retval;
    }
    
    GridObjectModel::GridType StringToGridType(const wxString& p_data)
    {
        GridObjectModel::GridType retval = GridObjectModel::gtNone;
        
        TRACER(wxT("StringToGridType"));
        wxString data = p_data.Lower();
        
        if (data == wxT("square"))
        {
            retval = GridObjectModel::gtSquare;
        }
        if (data == wxT("hex"))
        {
            retval = GridObjectModel::gtHex;
        }
        if (data == wxT("triangle"))
        {
            retval = GridObjectModel::gtTriangle;
        }
        if (data == wxT("rotatedhex"))
        {
            retval = GridObjectModel::gtRotatedHex;
        }
        if (data == wxT("diamond"))
        {
            retval = GridObjectModel::gtDiamond;
        }
        if (data == wxT("halfdiamond"))
        {
            retval = GridObjectModel::gtHalfDiamond;
        }
        if (data == wxT("polar"))
        {
            retval = GridObjectModel::gtPolar;
        }
        
        return retval;
    }

    GridObjectModel::GridPenStyle StringToGridPenStyle(const wxString& p_data)
    {
        GridObjectModel::GridPenStyle retval = GridObjectModel::gpsDefault;
        
        TRACER(wxT("StringToGridPenStyle"));
        wxString data = p_data.Lower();
        
        if (data == wxT("single"))
        {
            TRACER(wxT("StringToGridPenStyle"));
            retval = GridObjectModel::gpsSingle;
        }
        if (data == wxT("dot"))
        {
            TRACER(wxT("StringToGridPenStyle"));
            retval = GridObjectModel::gpsDot;
        }
        if (data == wxT("dash"))
        {
            TRACER(wxT("StringToGridPenStyle"));
            retval = GridObjectModel::gpsDash;
        }
        if (data == wxT("dashdot"))
        {
            TRACER(wxT("StringToGridPenStyle"));
            retval = GridObjectModel::gpsDashDot;
        }
        if (data == wxT("dashdotdot"))
        {
            TRACER(wxT("StringToGridPenStyle"));
            retval = GridObjectModel::gpsDashDotDot;
        }
        if (data == wxT("bold"))
        {
            TRACER(wxT("StringToGridPenStyle"));
            retval = GridObjectModel::gpsBold;
        }
        return retval;
    }

    bool ProcessTag(DrawnObjectModel* p_obj, wxString p_tag, wxString p_data)
    {
        wxASSERT(p_obj != NULL);
        TRACER(wxT("ProcessTag"));
        bool retval = false;
        if (p_tag == wxT("color"))
        {
            retval = true;
            TRACE(wxT("Setting color %s"), p_data.c_str());
            long int color = 0;
            if (!p_data.ToLong(&color))
            {
                EXCEPT(ARBadColorException, wxT("problem with current grid color tag data"));
            }
            p_obj->setColor(LongToColor(color));
        }
        else if (p_tag == wxT("overlay_id"))
        {
            retval = true;
            TRACE(wxT("Setting overlay(s) %s"), p_data.c_str());
            p_obj->setOverlays(StringToOverlayVector(p_data));
        }
        else if (p_tag == wxT("extent"))
        {
            retval = true;
            TRACE(wxT("Setting extent %s"), p_data.c_str());
            arRealRect r = StringToRect(p_data);
            VPoints v;
            v.push_back(r.GetTopLeft());
            v.push_back(r.GetBottomRight());
            p_obj->setPoints(v);
        }
        else if (p_tag == wxT("selected"))
        {
            retval = true;
            TRACE(wxT("Setting selected %s"), p_data.c_str());
            p_obj->setSelected(StringToBool(p_data));
        }
        return retval;
    }

    BuilderStackEntry getBuilder(wxString p_name, ARDocument* p_doc)
    {
        TRACER(wxT("getBuilder()"));
        BuilderStackEntry entry;
        wxString tag(p_name.Lower()); // everything needs lower case tags
        if (bldrstack.size() > 0)
        {
            TRACE(wxT("non-empty stack, getting last entry"));
            entry = bldrstack.at(bldrstack.size() - 1);
        } 
        else
        {
            TRACE(wxT("empty stack, building empty entry"));
            entry.m_bldr = NULL;
            entry.m_obj = NULL;
            entry.m_tag = tag;
        }
        SubBuilder* bldr = SubBuilderFactorySingleton::Get()->Get(tag);
        wxASSERT(bldr != NULL);
        bldr->setDoc(p_doc);

        TRACE(wxT("filling in builderstack entry"));
        entry.m_bldr = bldr;
        entry.m_tag = tag;
        bldr->startObject(entry);
        TRACE(wxT("appending entry to bldrstack"));
        bldrstack.push_back(entry);
        return entry;
    }

    void printStack()
    {
        wxString log, log2;
        BuilderStackEntry bldr;
        for (unsigned int i = 0; i < bldrstack.size(); ++i)
        {
            log2.Printf(wxT("%s\n%d: "), log.c_str(), i);
            log = log2;
            bldr = bldrstack.at(i);
            if (dynamic_cast<ARDocumentBuilder*>(bldr.m_bldr) != NULL)
            {
                log += wxT("ARDocumentBuilder");
            }
            else if (dynamic_cast<GridObjectBuilder*>(bldr.m_bldr) != NULL)
            {
                log += wxT("GridObjectBuilder");
            }
            else if (dynamic_cast<ViewPointBuilder*>(bldr.m_bldr) != NULL)
            {
                log += wxT("ViewPointBuilder");            
            }
            else
            {
                log += wxT("Unknown Builder");
            }
            if (dynamic_cast<ARDocument*>(bldr.m_obj) != NULL)
            {
                log2.Printf(wxT("%s, ARDocument (%x) "), log.c_str(), bldr.m_obj);
                log = log2;
            }
            else if (dynamic_cast<GridObjectModel*>(bldr.m_obj) != NULL)
            {
                log2.Printf(wxT("%s, GridObjectModel (%x) "), log.c_str(), bldr.m_obj);
                log = log2;
            }
            else if (dynamic_cast<ViewPointModel*>(bldr.m_obj) != NULL)
            {
                log2.Printf(wxT("%s, ViewPointModel (%x) "), log.c_str(), bldr.m_obj);
                log = log2;
            }
            log += bldr.m_tag;
        }
        wxLogDebug(log);
    }

    void printExtraData(ObjectInterface* p_obj)
    {
        ObjPublicData::iterator i;
        for (i = p_obj->m_extraData.begin(); i != p_obj->m_extraData.end(); ++i)
        {
            wxLogDebug(wxT("key: %s, value: %s"), i->first.c_str(), i->second.c_str());
        }
    }

}   // namespace subbuilderComponents