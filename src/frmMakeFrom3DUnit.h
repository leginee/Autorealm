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
#ifndef FRMMAKEFROM3DUNIT_H
#define FRMMAKEFROM3DUNIT_H
#include "globals.h"
#include <vector>
#include <wx/xrc/xmlres.h>

#include "types.h"
#include "matrixmath.h"

union TRGBA {
    short R, G, B, A;
};

struct TVector {
    float x, y, z;
};

struct TBezier {
    TVector V1, V2, V3, V4;
};

struct TPatch {
    TBezier B1, B2, B3, B4;
};

struct TSurface {
    std::vector<TPatch> P;
};

typedef std::vector<arRealPoint> TPolygon;
/**
 * @class frmMakeFrom3DUnit
 *
 * @brief Descended from wxDialog, this class is used to BRIEFDESC
 *
 * FULLDESC
 */
class frmMakeFrom3DUnit : public wxDialog {
    public:
        /**
         * @brief Default constructor, used in two step window creation.
         */
        frmMakeFrom3DUnit(){};

        /**
         * @brief Main constructor, should be the most used
         */
        frmMakeFrom3DUnit(wxWindow *parent, wxWindowID id, const wxString& title,
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

		void rbConeClick();
		void edtElasticityChange();
		void udElasticityClick();
		void tbElasticityChange();
		void edtPolygonSidesChange();
		void edtCenterHeightChange();
		void udCenterHeightClick();
		void tbCenterHeightChange();
		void edtXRotChange();
		void edtYRotChange();
		void edtZRotChange();
		void udXRotClick();
		void udYRotClick();
		void udZRotClick();
		void tbXRotChange();
		void tbYRotChange();
		void tbZRotChange();
		void cbTopClick();
		void cbSidesClick();
		void edtMRChange();
		void udMRClick();
		void tbMRChange();
		void edtMGChange();
		void udMGClick();
		void tbMGChange();
		void edtMBChange();
		void udMBClick();
		void tbMBChange();
		void edtMHChange();
		void udMHClick();
		void tbMHChange();
		void edtMSChange();
		void udMSClick();
		void tbMSChange();
		void edtMVChange();
		void udMVClick();
		void tbMVChange();
		void edtLRChange();
		void udLRClick();
		void tbLRChange();
		void edtLGChange();
		void udLGClick();
		void tbLGChange();
		void edtLBChange();
		void udLBClick();
		void tbLBChange();
		void edtLHChange();
		void udLHClick();
		void tbLHChange();
		void edtLSChange();
		void udLSClick();
		void tbLSChange();
		void edtLVChange();
		void udLVClick();
		void tbLVChange();
		void edtARChange();
		void udARClick();
		void tbARChange();
		void edtAGChange();
		void udAGClick();
		void tbAGChange();
		void edtABChange();
		void udABClick();
		void tbABChange();
		void edtAHChange();
		void udAHClick();
		void tbAHChange();
		void edtASChange();
		void udASClick();
		void tbASChange();
		void edtAVChange();
		void udAVClick();
		void tbAVChange();
		void edtInnerRadiusChange();
		void udInnerRadiusClick();
		void tbInnerRadiusChange();
		void rbCylindricalClick();
		void edtOuterRadiusChange();
		void udOuterRadiusClick();
		void tbOuterRadiusChange();
		void cbPolygonalClick();
		void edtORChange();
		void udORClick();
		void tbORChange();
		void edtOGChange();
		void udOGClick();
		void tbOGChange();
		void edtOBChange();
		void udOBClick();
		void tbOBChange();
		void edtOHChange();
		void udOHClick();
		void tbOHChange();
		void edtOSChange();
		void udOSClick();
		void tbOSChange();
		void edtOVChange();
		void udOVClick();
		void tbOVChange();
		void cbUseOutlineColorClick();
		void rbSphericalClick();
		void cbSmoothClick();
		void cbRemoveHiddenSurfacesClick();
        void ExportSurface();

    private:
        wxColour ModelColor, LightColor, AmbientColor, OutlineColor;
        bool SettingModelRGB, SettingModelHSV;
        bool SettingLightRGB, SettingLightHSV;
        bool SettingAmbientRGB, SettingAmbientHSV;
        bool SettingOutlineRGB, SettingOutlineHSV;
		void PaintModel();
		void SetModelColorFromRGB();
		void SetModelColorFromHSV();
		void SetLightColorFromRGB();
		void SetLightColorFromHSV();
		void SetAmbientColorFromRGB();
		void SetAmbientColorFromHSV();
		void SetOutlineColorFromRGB();
		void SetOutlineColorFromHSV();
		void RGBtoHSV(float R,float G,float B, float& H,float& S,float& V);
		void HSVtoRGB(float H,float S,float V, float& R,float& G,float& B);
        TSurface GetSurface();
        wxColour GetColor(TVector Normal);
        wxColour GetOutlineColor(wxColour Col);

        DECLARE_DYNAMIC_CLASS(frmMakeFrom3DUnit)
        DECLARE_EVENT_TABLE()
};
#endif //FRMMAKEFROM3DUNIT_H
