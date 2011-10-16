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
#include "xmlutils.h"
#include <wx/tokenzr.h>

wxXmlNode* findNamedChild(const wxString& cname, const wxXmlNode& el) {
    wxXmlNode* retval=NULL;
    wxXmlNode* next=el.GetChildren();

    while ((next != NULL) && (retval == NULL)) {
        if (next->GetName().Trim(true).Trim(false).CmpNoCase(cname) == 0) {
            retval = next;
        }
        next = next->GetNext();
    }
    return(retval);
}

wxXmlNode* newElWithChild(const wxString& elname, const wxString& eldata) {
    wxXmlNode* child;
    wxXmlNode* el;

    el = new wxXmlNode(wxXML_ELEMENT_NODE, elname, wxT(""));
    child = new wxXmlNode(wxXML_TEXT_NODE, wxT(""), eldata);
    wxASSERT(child != NULL);
    wxASSERT(el != NULL);
    el->AddChild(child);
    return(el);
}

double getElContentd(wxXmlNode* el) {
    wxString val = getElContents(el);
    double retval;
    val.ToDouble(&retval);
    return(retval);
}

float getElContentf(wxXmlNode* el) {
    wxString val = getElContents(el);
    double retval;
    val.ToDouble(&retval);
    return((float)retval);
}

int getElContenti(wxXmlNode* el) {
    wxString val = getElContents(el);
    long retval;
    val.ToLong(&retval);
    return((int)retval);
}

long getElContentl(wxXmlNode* el) {
    wxString val = getElContents(el);
    long retval;
    val.ToLong(&retval);
    return(retval);
}

wxString getElContents(wxXmlNode* el) {
    wxASSERT(el != NULL);
    wxXmlNode* next=el->GetChildren();
    wxString val;

    while (next != NULL) {
        if (next->GetType() == wxXML_TEXT_NODE) {
            val += next->GetContent();
        }
        next = next->GetNext();
    }
    return(val);
}

bool        getElContentb(wxXmlNode* el) {
    bool retval;
    wxString val;
    long num;

    val = getElContents(el);
    if (val.IsNumber()) {
        val.ToLong(&num);
        retval = (num == 0) ? true : false;
    } else {
        retval = (val.CmpNoCase(wxT("TRUE")) == 0) ? true : false;
    }
    return(retval);
}

arRealPoint getElContentp(wxXmlNode* el) {
    arRealPoint retval;
    wxString val, hold;
    int pos;
    coord i;

    val = getElContents(el);
    pos = val.Find(wxT(','));
    if (pos > -1) {
        hold = val.Mid(0, pos-1);
        hold.ToDouble(&i);
        retval.x = i;
        hold = val.Mid(pos+1);
        hold.ToDouble(&i);
        retval.y = i;
    }
    return(retval);
}

VPoints     getElContentv(wxXmlNode* el) {
    wxString curr = getElContents(el);
    wxStringTokenizer tok(curr, wxT(":"));
    VPoints points;
    arRealPoint p;
    wxString val, hold;
    int pos, count;
    coord i;

    while (tok.HasMoreTokens()) {
        count = points.size();
        points.resize(count+1);
        val = tok.GetNextToken();
        pos = val.Find(wxT(','));
        if (pos > -1) {
            hold = val.Mid(0, pos-1);
            hold.ToDouble(&i);
            p.x = i;
            hold = val.Mid(pos+1);
            hold.ToDouble(&i);
            p.y = i;
            points[count] = p;
        }
    }
    return(points);
}

arRealRect  getElContentr(wxXmlNode* el) {
    wxString curr=getElContents(el), val;
    wxStringTokenizer tok(curr, wxT(","));
    arRealRect r;
    coord left, top, bottom, right;
    
    val = tok.GetNextToken();
    val.ToDouble(&left);
    val = tok.GetNextToken();
    val.ToDouble(&top);
    val = tok.GetNextToken();
    val.ToDouble(&bottom);
    val = tok.GetNextToken();
    val.ToDouble(&right);
    r.SetLeft(left);
    r.SetTop(top);
    r.SetBottom(bottom);
    r.SetRight(right);
    return(r);
}

wxXmlNode* getAsXml(const wxString& name, int i) {
    wxString msg;
    msg.Printf(wxT("%d"), i);
    return(newElWithChild(name, msg));
}

wxXmlNode* getAsXml(const wxString& name, unsigned int i) {
    wxString msg;
    msg.Printf(wxT("%u"), i);
    return(newElWithChild(name, msg));
}

wxXmlNode* getAsXml(const wxString& name, const wxString& data) {
    return(newElWithChild(name, data));
}

wxXmlNode* getAsXml(const wxString& name, bool val) {
    wxString msg;
    msg = val ? wxT("-1") : wxT("0");
    return(newElWithChild(name, msg));
}

wxXmlNode* getAsXml(const wxString& name, double val) {
    wxString msg;
    msg.Printf(wxT("%f"), val);
    return(newElWithChild(name, msg));
}

wxXmlNode* getAsXml(const wxString& name, const arRealPoint& p) {
    wxString msg;
    msg.Printf(wxT("%d,%d"), p.x, p.y);
    return(newElWithChild(name, msg));
}

wxXmlNode* getAsXml(const wxString& name, const VPoints& p, int count) {
    int i;
    wxString st, msg;
    for (i=0; i<count; i++) {
        if (!st.IsEmpty()) {
            st += wxT(":");
        }
        msg.Printf(wxT("%f,%f"), p[i].x, p[i].y);
        st += msg;
    }
    return(newElWithChild(name, st));
}

wxXmlNode* getAsXml(const wxString& name, const arRealRect& r) {
    wxString msg;
    msg.Printf(wxT("%f,%f,%f,%f"), r.GetLeft(), r.GetTop(), r.GetRight(), r.GetBottom());
    return(newElWithChild(name, msg));
}

double      ReadDoubleFromBinaryStream(wxFileInputStream& ins) {
    double retval;
    ins.Read(&retval, 8);
    return(retval);
}

float       ReadFloatFromBinaryStream(wxFileInputStream& ins) {
    float retval;
    ins.Read(&retval, 4);
    return(retval);
}

int         ReadIntFromBinaryStream(wxFileInputStream& ins) {
    int retval;
    ins.Read(&retval, 4);
    retval = wxINT32_SWAP_ON_BE(retval);
    return(retval);
}

long        ReadLongFromBinaryStream(wxFileInputStream& ins) {
    long retval;
    ins.Read(&retval, 8);
    retval = wxINT32_SWAP_ON_BE(retval);
    return(retval);
}

int         ReadByteFromBinaryStream(wxFileInputStream& ins) {
    int retval;
    retval = 0;
    ins.Read(&retval, 1);
    return(retval);
}

bool        ReadBoolFromBinaryStream(wxFileInputStream& ins) {
    bool retval = false;
    ins.Read(&retval, 1);
    return(retval);
}

arRealPoint ReadarRealPointFromBinaryStream(wxFileInputStream& ins) {
}

VPoints     ReadVPointsFromBinaryStream(wxFileInputStream& ins) {
}

arRealRect  ReadarRealRectFromBinaryStream(wxFileInputStream& ins) {
}

wxString ReadStringFromBinaryStream(wxFileInputStream& ins) {
    int len;
    wxChar* p;

    ins.Read(&len, 4); // 4 = sizeof(int) on Intel
    len = wxINT32_SWAP_ON_BE(len);
    p = new wxChar[len];
    ins.Read(p, len);
    wxString retval(p, len);
    delete p;
    return(retval);
}
