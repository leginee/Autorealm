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
 * 
 * This file follows much the same idea as ObjectBuilder. The primary
 * difference, though, comes from the lack of a need for special classes.
 * Instead, there is a writeObject function which needs to be written, and
 * a dispatchObject which needs to be updated, for each new object type.
 */

#include "base64.h"
#include "ObjectWriter.h"
#include "ARDocument.h"
#include "GridObjectModel.h"
#include "ViewPointModel.h"
#include "Tracer.h"
#include "GroupModel.h"
#include "CurveModel.h"
#include "LineModel.h"
#include "PolyCurveModel.h"
#include "PolyLineModel.h"


TRACEFLAG(wxT("ObjectWriter"));

namespace {
 	int ColorToLong(wxColor p_col)
    {
 		unsigned char red, green, blue;
 		int retval = 0;
 		red   = p_col.Red();
 		green = p_col.Green();
 		blue  = p_col.Blue();
 		retval = (red << 16) | (green << 8) | (blue);
 		return retval;
 	}
  
 	wxString BoolToString(bool p_bool)
    {
 		wxString retval( p_bool ? wxT("true") : wxT("false"));
 		return retval;
 	}

	wxString OverlayVectorToString(OverlayVector p_vector)
    {
		wxString retval(wxT(""));
		wxString ints;
		bool first = true;
		for (unsigned int i = 0; i < p_vector.size(); i++)
        {
			if (p_vector.at(i))
            {
				ints.Printf(wxT("%d"), i);
				if (first)
                {
					retval += ints;
					first = false;
				} else
                {
					retval += wxT(",") + ints;
				}
			}
		}
		return retval;
	}

	wxString PointToString(const arRealPoint& p_pt)
    {
		wxString retval;
		retval.Printf(wxT("%f,%f"), p_pt.x, p_pt.y);
		return retval;
	}

    wxString PointsToString(const VPoints& p_points)
    {
        wxString retval(wxT(""));
        for (unsigned int i = 0; i < p_points.size(); ++i)
        {
            arRealPoint point = p_points.at(i);
            if (i == 0)
            {
                retval = PointToString(point);
            }
            else
            {
                retval = retval + wxT(":") + PointToString(point);
            }
        }
        return retval;
    }

	wxString RectToString(arRealRect p_rect)
    {
		wxString retval;
		retval.Printf(wxT("%f,%f,%f,%f"), p_rect.x, p_rect.y, p_rect.GetRight(), p_rect.GetBottom());
		return retval;
	}

    /**
     * @brief Converts a StyleAttrib object into a wxString.
     * 
     * @param p_style The StyleAttrib which have to be converted into a wxString.
     * @return The StyleAttrib as a wxString.
     */
    wxString StyleToString(const StyleAttrib& p_style)
    {
        wxString retval(wxT("1"));
        // @todo implementation of style class to write as a string
        // better to write a class method, who knows how to create a string of StyleAttrib.  
        return retval;
    }

	wxString GridTypeToString(GridObjectModel::GridType p_type)
    {
		wxString retval(wxT(""));
		switch (p_type)
        {
			case GridObjectModel::gtNone : retval = wxT("none"); break;
			case GridObjectModel::gtSquare : retval = wxT("square"); break;
			case GridObjectModel::gtHex : retval = wxT("hex"); break;
			case GridObjectModel::gtTriangle : retval = wxT("triangle"); break;
			case GridObjectModel::gtRotatedHex : retval = wxT("rotatedhex"); break;
			case GridObjectModel::gtDiamond : retval = wxT("diamond"); break;
			case GridObjectModel::gtHalfDiamond : retval = wxT("halfdiamond"); break;
			case GridObjectModel::gtPolar : retval = wxT("polar"); break;
		}
		return retval;
	}

	wxString PenTypeToString(GridObjectModel::GridPenStyle p_type)
    {
		wxString retval(wxT(""));
		switch (p_type)
        {
			case GridObjectModel::gpsDefault : retval = wxT("default"); break;
			case GridObjectModel::gpsSingle : retval = wxT("single"); break;
			case GridObjectModel::gpsDot : retval = wxT("dot"); break;
			case GridObjectModel::gpsDash : retval = wxT("dash"); break;
			case GridObjectModel::gpsDashDot : retval = wxT("dashdot"); break;
			case GridObjectModel::gpsDashDotDot : retval = wxT("dashdotdot"); break;
			case GridObjectModel::gpsBold : retval = wxT("bold"); break;
		}
		return retval;
	}

	void dispatchObject(wxTextOutputStream& p_out, ObjectInterface* p_obj);

    /**
     * @brief Writes a XML element to the given output stream.
     * 
     * This function writes for example: <tagname>value</tagname>.  
     * 
     * @param p_out  The given output stream to write the XML code.
     * @param elName The name of the XML tag (element).
     * @param elval  The value of the XML tag.
     */ 
 	void writeElement(wxTextOutputStream& p_out, const wxString& elName, const wxString& elval)
    {
		p_out << wxT("<") << elName << wxT(">") << elval << wxT("</") << elName << wxT(">");
	}

    /**
     * @brief Writes a XML element to the given output stream.
     * 
     * This function writes for example: <tagname>value</tagname>.  
     * 
     * @param p_out  The given output stream to write the XML code.
     * @param elName The name of the XML tag (element).
     * @param value  The value of the XML tag as an integer number.
     */ 
    void writeElement(wxTextOutputStream& p_out, const wxString& elName, int value)
    {
        p_out << wxT("<") << elName << wxT(">") << value << wxT("</") << elName << wxT(">");
    }

    /**
     * @brief Writes a XML element to the given output stream.
     * 
     * This function writes for example: <tagname>value</tagname>.  
     * 
     * @param p_out  The given output stream to write the XML code.
     * @param elName The name of the XML tag (element).
     * @param value  The value of the XML tag as an unsigned integer number.
     */ 
    void writeElement(wxTextOutputStream& p_out, const wxString& elName, unsigned int value)
    {
        p_out << wxT("<") << elName << wxT(">") << value << wxT("</") << elName << wxT(">");
    }

    /**
     * @brief Writes a XML element to the given output stream.
     * 
     * This function writes for example: <tagname>value</tagname>.  
     * 
     * @param p_out  The given output stream to write the XML code.
     * @param elName The name of the XML tag (element).
     * @param value  The value of the XML tag as an double number.
     */ 
    void writeElement(wxTextOutputStream& p_out, const wxString& elName, double value)
    {
        p_out << wxT("<") << elName << wxT(">") << value << wxT("</") << elName << wxT(">");
    }

    /**
     * @brief Dispatches the children of the given object for writing into given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_obj The given object to dispatch the children.
     */
	void dispatchChildren(wxTextOutputStream& p_out, ObjectInterface* p_obj)
    {
		for (unsigned int i = 0; i < p_obj->countChildren(); ++i)
        {
			dispatchObject(p_out, p_obj->getChild(i));
		}
	}
    
    /**
     * @brief Writes the ViewPointModel object into the given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_doc The given ViewPointModel object for writing into the output stream.
     */
	void writeObject(wxTextOutputStream& p_out, ViewPointModel* p_doc)
    {
		p_out << wxT("<viewpoint>");
		writeElement(p_out, wxT("clientwidth"), p_doc->getWidth());
		writeElement(p_out, wxT("clientheight"), p_doc->getHeight());
		writeElement(p_out, wxT("area"), RectToString(p_doc->getArea()));
		writeElement(p_out, wxT("visible_overlays"), OverlayVectorToString(p_doc->getVisibleOverlays()));
		writeElement(p_out, wxT("active_overlays"), OverlayVectorToString(p_doc->getActiveOverlays()));
		dispatchChildren(p_out, p_doc);
		p_out << wxT("</viewpoint>");
	}

    /**
     * @brief Writes the GridObjectModel object into the given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_doc The given GridObjectModel object for writing into the output stream.
     */
	void writeObject(wxTextOutputStream& p_out, GridObjectModel* p_doc)
    {
		p_out << wxT("<gridobject>");
		writeElement(p_out, wxT("graph_scale"), p_doc->getGraphScale());
		writeElement(p_out, wxT("graph_unit_convert"), p_doc->getGraphUnitConvert());
		writeElement(p_out, wxT("graph_units"), p_doc->getGraphUnits());
		writeElement(p_out, wxT("current_graph_units"), p_doc->getCurrentGraphUnits());
		writeElement(p_out, wxT("current_size"), p_doc->getCurrentGridSize());
		writeElement(p_out, wxT("type"), GridTypeToString(p_doc->getType()));
		writeElement(p_out, wxT("bold_units"), p_doc->getBoldUnits());
		writeElement(p_out, wxT("flags"), p_doc->getFlags());
		writeElement(p_out, wxT("position"), p_doc->getPosition());
		writeElement(p_out, wxT("primary_style"), PenTypeToString(p_doc->getPrimaryStyle()));
		writeElement(p_out, wxT("secondary_style"), PenTypeToString(p_doc->getSecondaryStyle()));
		dispatchChildren(p_out, p_doc);
		p_out << wxT("</gridobject>");

	}

    /**
     * @brief Writes the ARDocument object into the given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_doc The given ARDocument object for writing into the output stream.
     */
	void writeObject(wxTextOutputStream& p_out, ARDocument* p_doc)
    {
        int i;
		wxString si, hsnum;
		p_out << wxT("<globals>");
		writeElement(p_out, wxT("version"), p_doc->getVersion());
		writeElement(p_out, wxT("current_grid_color"), ColorToLong(p_doc->getGridColor()));
		writeElement(p_out, wxT("background_color"), ColorToLong(p_doc->getBgColor()));
		p_out << wxT("</globals>");
		p_out << wxT("<commentset>");
		writeElement(p_out, wxT("comments"), base64encode(p_doc->getComments()));
		p_out << wxT("</commentset>");
		p_out << wxT("<overlays>");
		i = p_doc->getOverlayCount();
		writeElement(p_out, wxT("count"), i);
		for (int j = 0; j < i; j++)
        {
			si.Printf(wxT("%d"), j);
			p_out << wxT("<") << wxString(wxT("overlay_")) + si << wxT(">");
			writeElement(p_out, wxT("name"), base64encode(p_doc->getOverlayName(j)));
			p_out << wxT("</") << wxString(wxT("overlay_")) + si << wxT(">");
		}
		p_out << wxT("</overlays>");
		p_out << wxT("<landscapeset>");
		writeElement(p_out, wxT("landscape"), BoolToString(p_doc->getLandscape()));
		p_out << wxT("</landscapeset>");
		p_out << wxT("<grid>");
		writeElement(p_out, wxT("snaptogrid"), BoolToString(p_doc->getSnapToGrid()));
		writeElement(p_out, wxT("snaptopoint"), BoolToString(p_doc->getSnapToPoint()));
		writeElement(p_out, wxT("snapalong"), BoolToString(p_doc->getSnapAlong()));
		writeElement(p_out, wxT("rotatesnap"), BoolToString(p_doc->getRotateSnap()));
		writeElement(p_out, wxT("displaygrid"), BoolToString(p_doc->getDisplayGrid()));
		writeElement(p_out, wxT("designgridunits"), p_doc->getDesignGridUnits());
		p_out << wxT("</grid>");
		PushpinCollection pins = p_doc->getPushpins();
		p_out << wxT("<pushpin_history>");
		writeElement(p_out, wxT("waypoints_visible"), BoolToString(pins.m_waypointsVisible));
		writeElement(p_out, wxT("show_number"), BoolToString(pins.m_showNumber));
		writeElement(p_out, wxT("show_note"), BoolToString(pins.m_showNote));
		for (unsigned int j = 0; j < pins.m_pins.size(); j++)
        {
			Pushpin pin = pins.m_pins.at(j);
			si.Printf(wxT("%d"), j);
			p_out << wxString(wxT("<pin_history_")) + si << wxT(">");
			writeElement(p_out, wxT("name"), pin.m_name);
			unsigned int max = pin.m_history.size();
			for (int k = max; k > 0; k--)
            {
				hsnum.Printf(wxT("%d"), k);
				p_out << wxString(wxT("<hist_")) + hsnum << wxT(">");
				writeElement(p_out, wxT("point"), PointToString(pin.m_history.at(max-k).m_point));
				writeElement(p_out, wxT("note"), base64encode(pin.m_history.at(max-k).m_note));
				p_out << wxString(wxT("</hist_")) + hsnum << wxT(">");
			}
			p_out << wxString(wxT("</pin_history_")) + si << wxT(">");
		}
		p_out << wxT("</pushpin_history>");
		p_out << wxT("<pushpins>");
		for (unsigned int j = 0; j < pins.m_pins.size(); j++)
        {
			si.Printf(wxT("%d"), j);
			p_out << wxString(wxT("<pin_")) + si << wxT(">");
			writeElement(p_out, wxT("checked"), pins.m_pins.at(j).m_checked);
			writeElement(p_out, wxT("placed"), pins.m_pins.at(j).m_placed);
			writeElement(p_out, wxT("point"), PointToString(pins.m_pins.at(j).m_point));
			p_out << wxString(wxT("</pin_")) + si << wxT(">");
		}
		p_out << wxT("</pushpins>");
		dispatchChildren(p_out, p_doc);
	}

    /**
     * @brief Writes the DrawnObjectModel object into the given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_doc The given DrawnObjectModel object for writing into the output stream.
     */
	void writeDrawnObjectStandard(wxTextOutputStream& p_out, DrawnObjectModel* p_doc)
    {
		writeElement(p_out, wxT("color"), ColorToLong(p_doc->getColor()));
		writeElement(p_out, wxT("overlay_id"), OverlayVectorToString(p_doc->getOverlays()));
		writeElement(p_out, wxT("extent"), RectToString(p_doc->getExtent()));
		writeElement(p_out, wxT("selected"), BoolToString(p_doc->getSelected()));
	}

    /**
     * @brief Writes the LineObjectModel object into the given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_doc The given LineObjectModel object for writing into the output stream.
     */
    void writeLineObjectModelStandard(wxTextOutputStream& p_out, LineObjectModel* p_doc)
    {
        writeElement(p_out, wxT("style"), StyleToString(p_doc->getStyle()));
        writeElement(p_out, wxT("thickness"), p_doc->getThickness());
        writeElement(p_out, wxT("fractal"), BoolToString(p_doc->isFractal()));
        writeElement(p_out, wxT("sthickness"), p_doc->getSthickness());
        writeElement(p_out, wxT("seed"), p_doc->getSeed());
        writeElement(p_out, wxT("roughness"), p_doc->getRoughness());
    }

    /**
     * @brief Writes the PolyObjectModel object into the given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_doc The given PolyObjectModel object for writing into the output stream.
     */
    void writePolyObjectModelStandard(wxTextOutputStream& p_out, PolyObjectModel* p_doc)
    {
        writeElement(p_out, wxT("fillcolor"), ColorToLong(p_doc->getFillColor()));
        writeElement(p_out, wxT("count"), p_doc->getCount());
        writeElement(p_out, wxT("points"), PointsToString(p_doc->getPoints()));
    }

    /**
     * @brief Writes the GroupModel object into the given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_doc The given GroupModel object for writing into the output stream.
     */
	void writeObject(wxTextOutputStream& p_out, GroupModel* p_doc)
    {
		p_out << wxT("<drawchain>");
		writeDrawnObjectStandard(p_out, p_doc);
		dispatchChildren(p_out, p_doc);
		p_out << wxT("</drawchain>");
	}

    /**
     * @brief Writes the CurveModel object into the given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_doc The given CurveModel object for writing into the output stream.
     */
    void writeObject(wxTextOutputStream& p_out, CurveModel* p_doc)
    {
        p_out << wxT("<curve>");
        // write basis class members
        writeDrawnObjectStandard(p_out, p_doc);
        // write specific members of CurveModel
        writeElement(p_out, wxT("p1"), PointToString(p_doc->getPoint(0)));
        writeElement(p_out, wxT("p2"), PointToString(p_doc->getPoint(1)));
        writeElement(p_out, wxT("p3"), PointToString(p_doc->getPoint(2)));
        writeElement(p_out, wxT("p4"), PointToString(p_doc->getPoint(3)));
        // write abstract basis class LineObjectModel members
        writeLineObjectModelStandard(p_out, p_doc);
        p_out << wxT("</curve>");
    }

    /**
     * @brief Writes the LineModel object into the given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_doc The given LineModel object for writing into the output stream.
     */
    void writeObject(wxTextOutputStream& p_out, LineModel* p_doc)
    {
        p_out << wxT("<line>");
        // write basis class members
        writeDrawnObjectStandard(p_out, p_doc);
        // write specific members of LineModel
        arRealPoint pt = p_doc->getPoint(0);
        writeElement(p_out, wxT("x1"), pt.x);
        writeElement(p_out, wxT("y1"), pt.y);
        pt = p_doc->getPoint(1);
        writeElement(p_out, wxT("x2"), pt.x);
        writeElement(p_out, wxT("y2"), pt.y);
        // write abstract basis class LineObjectModel members
        writeLineObjectModelStandard(p_out, p_doc);
        p_out << wxT("</line>");
    }

    /**
     * @brief Writes the PolyCurveModel object into the given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_doc The given PolyCurveModel object for writing into the output stream.
     */
    void writeObject(wxTextOutputStream& p_out, PolyCurveModel* p_doc)
    {
        p_out << wxT("<polycurve>");
        // write DrawnObject class members
        writeDrawnObjectStandard(p_out, p_doc);
        // write specific members of abstract class PolyObjectModel
        writePolyObjectModelStandard(p_out, p_doc);
        // write abstract basis class LineObjectModel members
        writeLineObjectModelStandard(p_out, p_doc);
        p_out << wxT("</polycurve>");
    }

    /**
     * @brief Writes the PolyLineModel object into the given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_doc The given PolyLineModel object for writing into the output stream.
     */
    void writeObject(wxTextOutputStream& p_out, PolyLineModel* p_doc)
    {
        p_out << wxT("<polyline>");
        // write DrawnObject class members
        writeDrawnObjectStandard(p_out, p_doc);
        // write specific members of abstract class PolyObjectModel
        writePolyObjectModelStandard(p_out, p_doc);
        // write abstract basis class LineObjectModel members
        writeLineObjectModelStandard(p_out, p_doc);
        p_out << wxT("</polyline>");
    }

    /**
     * @brief Dispatches the given object for writing into given output stream.
     * 
     * @param p_out The given output stream to write the XML code.
     * @param p_obj The given object to dispatch.
     */
	void dispatchObject(wxTextOutputStream& p_out, ObjectInterface* p_obj)
    {
		ARDocument* doc = dynamic_cast<ARDocument*>(p_obj);
		ViewPointModel* vp = dynamic_cast<ViewPointModel*>(p_obj);
		GridObjectModel* grid = dynamic_cast<GridObjectModel*>(p_obj);
		GroupModel* grp = dynamic_cast<GroupModel*>(p_obj);
        CurveModel* curve = dynamic_cast<CurveModel*>(p_obj);
        LineModel* line = dynamic_cast<LineModel*>(p_obj);
        PolyCurveModel* pcurve = dynamic_cast<PolyCurveModel*>(p_obj);
        PolyLineModel* pline = dynamic_cast<PolyLineModel*>(p_obj);

		if (doc != NULL)
        {
			writeObject(p_out, doc);
		} 
        else if (vp != NULL) 
        {
			writeObject(p_out, vp);
		} 
        else if (grid != NULL)
        {
			writeObject(p_out, grid);
		} 
        else if (grp != NULL)
        {
			writeObject(p_out, grp);
		}
        else if (curve != NULL)
        {
            writeObject(p_out, curve);
        }
        else if (line != NULL)
        {
            writeObject(p_out, line);
        }
        else if (pcurve != NULL)
        {
            writeObject(p_out, pcurve);
        }
        else if (pline != NULL)
        {
            writeObject(p_out, pline);
        }
	}
};  // Namespace end


ObjectWriter::ObjectWriter(ARDocument* p_doc)
 : m_doc(p_doc)
{
	TRACER(wxT("ObjectWriter::ObjectWriter()"));
}


void ObjectWriter::write(wxTextOutputStream& p_out)
{
	TRACER(wxT("ObjectWriter::write()"));
	p_out << wxT("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	p_out << wxT("<document><map>");
	dispatchObject(p_out, m_doc);
	p_out << wxT("</map></document>");
}
