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
#ifndef CTMANAGER_H
#define CTMANAGER_H
#include "globals.h"
#include <wx/xrc/xmlres.h>

#include "ViewPoint.h"
#include "DrawPrimitive.h"

struct CTColorRef {
    wxColour oldc, newc;
};

class CTProfile {
    protected:
        wxString FName, FFileName;
        wxArrayString FList;
        int PGetNumColors();
        wxColour PGetOldColor(int index);
        wxColour PGetNewColor(int index);
        void PSetNewColor(int index, wxColour C);

    public:
        CTProfile();

        ~CTProfile();

        void LoadFromFile(wxString file);
        void SaveToFile(wxString file);
        void SaveToFile();
        void Add(wxColour oldc, wxColour newc);
        void Remove(int index);
        int IndexOfOld(wxColour oldc);
        int IndexOfNew(wxColour newc);
        void CopyFrom(CTProfile P);
        void Clear();
        wxString GetFName();
        void SetFName();
        wxString GetFileName();
        void SetFileName();
        int GetNumColors();
        wxColour GetOldColor(int index);
        wxColour GetNewColor(int index);
        void SetNewColor(int index, wxColour C);
};

/**
 * @class CTManager
 *
 * @brief Descended from wxFrame, this class is used to BRIEFDESC
 *
 * FULLDESC
 */
class CTManager : public wxFrame {
    public:
        /**
         * @brief Default constructor, used in two step window creation.
         */
        CTManager(){};

        /**
         * @brief Main constructor, should be the most used
         */
        CTManager(wxWindow *parent, wxWindowID id, const wxString& title,
            const wxPoint& pos = wxDefaultPosition,
            const wxSize& size = wxDefaultSize,
            long style = wxDEFAULT_DIALOG_STYLE,
            const wxString& name = wxT("dialogBox"));

        /**
         * @brief Part two of two step window creation
         */
        bool Create(wxWindow *parent, wxWindowID id, const wxString& title,
            const wxPoint& pos = wxDefaultPosition,
            const wxSize& size = wxDefaultSize,
            long style = wxDEFAULT_DIALOG_STYLE,
            const wxString& name = wxT("dialogBox"));

        void FormShow();
        void FormResize();
        void FormDestroy();
        void FormCreate();
        void lblSelectionItemsClick();
        void dgSelectionColorsDrawCell(wxObject sender, int ACol, int ARow, wxRect rect); //TGridDrawState
        void cbProfilesChange();
        void btnNewClick();
        void btnSaveClick();
        void btnRenameClick();
        void sgSelectionColorsDrawCell(wxObject sender, int ACol, int ARow, wxRect rect); //TGridDrawState
        void btnAddClick();
        void sgProfileClick();
        void ColorButton2Change();
        void btnRemoveTranslationClick();
        void btnDeleteClick();
        void FormClose();
        void dgSelectionColorsClick();
        void TranslateSelectionColors();
        void InverseTranslateSelectionColors();
        
    private:
        DECLARE_DYNAMIC_CLASS(CTManager)
        DECLARE_EVENT_TABLE()

        ViewPoint View;
        wxArrayString SelectedList, PrimitiveColors, CTProfiles;
        bool PrimitiveColorListValid, Modified;
        CTProfile WorkProfile;

        void PopulateColorList(DrawPrimitive D);
        void AddColor(wxArrayString list, wxColour C);
        void SetupColorList();
        void SetupProfileColorList();
        void ClearCTProfiles();
        void LoadCTProfiles();
        void SetModified(bool b);
        void Translate(DrawPrimitive D);
        void InverseTranslate(DrawPrimitive D);
};
#endif //CTMANAGER_H
