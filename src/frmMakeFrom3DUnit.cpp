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

#include "globals.h"
#include "frmMakeFrom3DUnit.h"

#include "Map.xpm"

static wxString className=wxT("frmMakeFrom3DUnit");

IMPLEMENT_DYNAMIC_CLASS(frmMakeFrom3DUnit, wxDialog)

BEGIN_EVENT_TABLE(frmMakeFrom3DUnit, wxDialog)
END_EVENT_TABLE()

/**
 * Normal constructor, simply calls the create function. Parameters are
 * identical to parameters for wxDialog::wxDialog()
 */
frmMakeFrom3DUnit::frmMakeFrom3DUnit(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    wxLogTrace(className, wxT("Entering frmMakeFrom3DUnit"));
    Create(parent, id, title, pos, size, style, name);
    wxLogTrace(className, wxT("Exiting frmMakeFrom3DUnit"));
}

/**
 * This routine is responsible for initializing the dialog window.
 * It loads up the xrc resource, and makes sure all is ready for
 * first onscreen display. For a blow-by-blow, read the wxLogTrace
 * statements in the code.
 * 
 * Parameters are identical to wxDialog::Create()
 *
 * @return Required by Create(), but unused
 */
bool frmMakeFrom3DUnit::Create(wxWindow *parent, wxWindowID id, const wxString& title,
    const wxPoint& pos, const wxSize& size, long style, const wxString& name) {
    
    wxLogTrace(className, wxT("Entering Create"));

    wxLogTrace(className, wxT("Loading resource"));
    wxXmlResource::Get()->LoadDialog(this, GetParent(), wxT("FIXME:RESNAMEHERE"));

    wxLogTrace(className, wxT("Constructing and setting icon"));
    SetIcon(wxICON(autorealm));

    wxLogTrace(className, wxT("Exiting Create"));
}

void frmMakeFrom3DUnit::rbConeClick() {
    wxLogTrace(className, wxT("beginning rbConeClick"));
    wxLogTrace(className, wxT("ending rbConeClick"));
}

void frmMakeFrom3DUnit::edtElasticityChange() {
    wxLogTrace(className, wxT("beginning edtElasticityChange"));
    wxLogTrace(className, wxT("ending edtElasticityChange"));
}

void frmMakeFrom3DUnit::udElasticityClick() {
    wxLogTrace(className, wxT("beginning udElasticityClick"));
    wxLogTrace(className, wxT("ending udElasticityClick"));
}

void frmMakeFrom3DUnit::tbElasticityChange() {
    wxLogTrace(className, wxT("beginning tbElasticityChange"));
    wxLogTrace(className, wxT("ending tbElasticityChange"));
}

void frmMakeFrom3DUnit::edtPolygonSidesChange() {
    wxLogTrace(className, wxT("beginning edtPolygonSidesChange"));
    wxLogTrace(className, wxT("ending edtPolygonSidesChange"));
}

void frmMakeFrom3DUnit::edtCenterHeightChange() {
    wxLogTrace(className, wxT("beginning edtCenterHeightChange"));
    wxLogTrace(className, wxT("ending edtCenterHeightChange"));
}

void frmMakeFrom3DUnit::udCenterHeightClick() {
    wxLogTrace(className, wxT("beginning udCenterHeightClick"));
    wxLogTrace(className, wxT("ending udCenterHeightClick"));
}

void frmMakeFrom3DUnit::tbCenterHeightChange() {
    wxLogTrace(className, wxT("beginning tbCenterHeightChange"));
    wxLogTrace(className, wxT("ending tbCenterHeightChange"));
}

void frmMakeFrom3DUnit::edtXRotChange() {
    wxLogTrace(className, wxT("beginning edtXRotChange"));
    wxLogTrace(className, wxT("ending edtXRotChange"));
}

void frmMakeFrom3DUnit::edtYRotChange() {
    wxLogTrace(className, wxT("beginning edtYRotChange"));
    wxLogTrace(className, wxT("ending edtYRotChange"));
}

void frmMakeFrom3DUnit::edtZRotChange() {
    wxLogTrace(className, wxT("beginning edtZRotChange"));
    wxLogTrace(className, wxT("ending edtZRotChange"));
}

void frmMakeFrom3DUnit::udXRotClick() {
    wxLogTrace(className, wxT("beginning udXRotClick"));
    wxLogTrace(className, wxT("ending udXRotClick"));
}

void frmMakeFrom3DUnit::udYRotClick() {
    wxLogTrace(className, wxT("beginning udYRotClick"));
    wxLogTrace(className, wxT("ending udYRotClick"));
}

void frmMakeFrom3DUnit::udZRotClick() {
    wxLogTrace(className, wxT("beginning udZRotClick"));
    wxLogTrace(className, wxT("ending udZRotClick"));
}

void frmMakeFrom3DUnit::tbXRotChange() {
    wxLogTrace(className, wxT("beginning tbXRotChange"));
    wxLogTrace(className, wxT("ending tbXRotChange"));
}

void frmMakeFrom3DUnit::tbYRotChange() {
    wxLogTrace(className, wxT("beginning tbYRotChange"));
    wxLogTrace(className, wxT("ending tbYRotChange"));
}

void frmMakeFrom3DUnit::tbZRotChange() {
    wxLogTrace(className, wxT("beginning tbZRotChange"));
    wxLogTrace(className, wxT("ending tbZRotChange"));
}

void frmMakeFrom3DUnit::cbTopClick() {
    wxLogTrace(className, wxT("beginning cbTopClick"));
    wxLogTrace(className, wxT("ending cbTopClick"));
}

void frmMakeFrom3DUnit::cbSidesClick() {
    wxLogTrace(className, wxT("beginning cbSidesClick"));
    wxLogTrace(className, wxT("ending cbSidesClick"));
}

void frmMakeFrom3DUnit::edtMRChange() {
    wxLogTrace(className, wxT("beginning edtMRChange"));
    wxLogTrace(className, wxT("ending edtMRChange"));
}

void frmMakeFrom3DUnit::udMRClick() {
    wxLogTrace(className, wxT("beginning udMRClick"));
    wxLogTrace(className, wxT("ending udMRClick"));
}

void frmMakeFrom3DUnit::tbMRChange() {
    wxLogTrace(className, wxT("beginning tbMRChange"));
    wxLogTrace(className, wxT("ending tbMRChange"));
}

void frmMakeFrom3DUnit::edtMGChange() {
    wxLogTrace(className, wxT("beginning edtMGChange"));
    wxLogTrace(className, wxT("ending edtMGChange"));
}

void frmMakeFrom3DUnit::udMGClick() {
    wxLogTrace(className, wxT("beginning udMGClick"));
    wxLogTrace(className, wxT("ending udMGClick"));
}

void frmMakeFrom3DUnit::tbMGChange() {
    wxLogTrace(className, wxT("beginning tbMGChange"));
    wxLogTrace(className, wxT("ending tbMGChange"));
}

void frmMakeFrom3DUnit::edtMBChange() {
    wxLogTrace(className, wxT("beginning edtMBChange"));
    wxLogTrace(className, wxT("ending edtMBChange"));
}

void frmMakeFrom3DUnit::udMBClick() {
    wxLogTrace(className, wxT("beginning udMBClick"));
    wxLogTrace(className, wxT("ending udMBClick"));
}

void frmMakeFrom3DUnit::tbMBChange() {
    wxLogTrace(className, wxT("beginning tbMBChange"));
    wxLogTrace(className, wxT("ending tbMBChange"));
}

void frmMakeFrom3DUnit::edtMHChange() {
    wxLogTrace(className, wxT("beginning edtMHChange"));
    wxLogTrace(className, wxT("ending edtMHChange"));
}

void frmMakeFrom3DUnit::udMHClick() {
    wxLogTrace(className, wxT("beginning udMHClick"));
    wxLogTrace(className, wxT("ending udMHClick"));
}

void frmMakeFrom3DUnit::tbMHChange() {
    wxLogTrace(className, wxT("beginning tbMHChange"));
    wxLogTrace(className, wxT("ending tbMHChange"));
}

void frmMakeFrom3DUnit::edtMSChange() {
    wxLogTrace(className, wxT("beginning edtMSChange"));
    wxLogTrace(className, wxT("ending edtMSChange"));
}

void frmMakeFrom3DUnit::udMSClick() {
    wxLogTrace(className, wxT("beginning udMSClick"));
    wxLogTrace(className, wxT("ending udMSClick"));
}

void frmMakeFrom3DUnit::tbMSChange() {
    wxLogTrace(className, wxT("beginning tbMSChange"));
    wxLogTrace(className, wxT("ending tbMSChange"));
}

void frmMakeFrom3DUnit::edtMVChange() {
    wxLogTrace(className, wxT("beginning edtMVChange"));
    wxLogTrace(className, wxT("ending edtMVChange"));
}

void frmMakeFrom3DUnit::udMVClick() {
    wxLogTrace(className, wxT("beginning udMVClick"));
    wxLogTrace(className, wxT("ending udMVClick"));
}

void frmMakeFrom3DUnit::tbMVChange() {
    wxLogTrace(className, wxT("beginning tbMVChange"));
    wxLogTrace(className, wxT("ending tbMVChange"));
}

void frmMakeFrom3DUnit::edtLRChange() {
    wxLogTrace(className, wxT("beginning edtLRChange"));
    wxLogTrace(className, wxT("ending edtLRChange"));
}

void frmMakeFrom3DUnit::udLRClick() {
    wxLogTrace(className, wxT("beginning udLRClick"));
    wxLogTrace(className, wxT("ending udLRClick"));
}

void frmMakeFrom3DUnit::tbLRChange() {
    wxLogTrace(className, wxT("beginning tbLRChange"));
    wxLogTrace(className, wxT("ending tbLRChange"));
}

void frmMakeFrom3DUnit::edtLGChange() {
    wxLogTrace(className, wxT("beginning edtLGChange"));
    wxLogTrace(className, wxT("ending edtLGChange"));
}

void frmMakeFrom3DUnit::udLGClick() {
    wxLogTrace(className, wxT("beginning udLGClick"));
    wxLogTrace(className, wxT("ending udLGClick"));
}

void frmMakeFrom3DUnit::tbLGChange() {
    wxLogTrace(className, wxT("beginning tbLGChange"));
    wxLogTrace(className, wxT("ending tbLGChange"));
}

void frmMakeFrom3DUnit::edtLBChange() {
    wxLogTrace(className, wxT("beginning edtLBChange"));
    wxLogTrace(className, wxT("ending edtLBChange"));
}

void frmMakeFrom3DUnit::udLBClick() {
    wxLogTrace(className, wxT("beginning udLBClick"));
    wxLogTrace(className, wxT("ending udLBClick"));
}

void frmMakeFrom3DUnit::tbLBChange() {
    wxLogTrace(className, wxT("beginning tbLBChange"));
    wxLogTrace(className, wxT("ending tbLBChange"));
}

void frmMakeFrom3DUnit::edtLHChange() {
    wxLogTrace(className, wxT("beginning edtLHChange"));
    wxLogTrace(className, wxT("ending edtLHChange"));
}

void frmMakeFrom3DUnit::udLHClick() {
    wxLogTrace(className, wxT("beginning udLHClick"));
    wxLogTrace(className, wxT("ending udLHClick"));
}

void frmMakeFrom3DUnit::tbLHChange() {
    wxLogTrace(className, wxT("beginning tbLHChange"));
    wxLogTrace(className, wxT("ending tbLHChange"));
}

void frmMakeFrom3DUnit::edtLSChange() {
    wxLogTrace(className, wxT("beginning edtLSChange"));
    wxLogTrace(className, wxT("ending edtLSChange"));
}

void frmMakeFrom3DUnit::udLSClick() {
    wxLogTrace(className, wxT("beginning udLSClick"));
    wxLogTrace(className, wxT("ending udLSClick"));
}

void frmMakeFrom3DUnit::tbLSChange() {
    wxLogTrace(className, wxT("beginning tbLSChange"));
    wxLogTrace(className, wxT("ending tbLSChange"));
}

void frmMakeFrom3DUnit::edtLVChange() {
    wxLogTrace(className, wxT("beginning edtLVChange"));
    wxLogTrace(className, wxT("ending edtLVChange"));
}

void frmMakeFrom3DUnit::udLVClick() {
    wxLogTrace(className, wxT("beginning udLVClick"));
    wxLogTrace(className, wxT("ending udLVClick"));
}

void frmMakeFrom3DUnit::tbLVChange() {
    wxLogTrace(className, wxT("beginning tbLVChange"));
    wxLogTrace(className, wxT("ending tbLVChange"));
}

void frmMakeFrom3DUnit::edtARChange() {
    wxLogTrace(className, wxT("beginning edtARChange"));
    wxLogTrace(className, wxT("ending edtARChange"));
}

void frmMakeFrom3DUnit::udARClick() {
    wxLogTrace(className, wxT("beginning udARClick"));
    wxLogTrace(className, wxT("ending udARClick"));
}

void frmMakeFrom3DUnit::tbARChange() {
    wxLogTrace(className, wxT("beginning tbARChange"));
    wxLogTrace(className, wxT("ending tbARChange"));
}

void frmMakeFrom3DUnit::edtAGChange() {
    wxLogTrace(className, wxT("beginning edtAGChange"));
    wxLogTrace(className, wxT("ending edtAGChange"));
}

void frmMakeFrom3DUnit::udAGClick() {
    wxLogTrace(className, wxT("beginning udAGClick"));
    wxLogTrace(className, wxT("ending udAGClick"));
}

void frmMakeFrom3DUnit::tbAGChange() {
    wxLogTrace(className, wxT("beginning tbAGChange"));
    wxLogTrace(className, wxT("ending tbAGChange"));
}

void frmMakeFrom3DUnit::edtABChange() {
    wxLogTrace(className, wxT("beginning edtABChange"));
    wxLogTrace(className, wxT("ending edtABChange"));
}

void frmMakeFrom3DUnit::udABClick() {
    wxLogTrace(className, wxT("beginning udABClick"));
    wxLogTrace(className, wxT("ending udABClick"));
}

void frmMakeFrom3DUnit::tbABChange() {
    wxLogTrace(className, wxT("beginning tbABChange"));
    wxLogTrace(className, wxT("ending tbABChange"));
}

void frmMakeFrom3DUnit::edtAHChange() {
    wxLogTrace(className, wxT("beginning edtAHChange"));
    wxLogTrace(className, wxT("ending edtAHChange"));
}

void frmMakeFrom3DUnit::udAHClick() {
    wxLogTrace(className, wxT("beginning udAHClick"));
    wxLogTrace(className, wxT("ending udAHClick"));
}

void frmMakeFrom3DUnit::tbAHChange() {
    wxLogTrace(className, wxT("beginning tbAHChange"));
    wxLogTrace(className, wxT("ending tbAHChange"));
}

void frmMakeFrom3DUnit::edtASChange() {
    wxLogTrace(className, wxT("beginning edtASChange"));
    wxLogTrace(className, wxT("ending edtASChange"));
}

void frmMakeFrom3DUnit::udASClick() {
    wxLogTrace(className, wxT("beginning udASClick"));
    wxLogTrace(className, wxT("ending udASClick"));
}

void frmMakeFrom3DUnit::tbASChange() {
    wxLogTrace(className, wxT("beginning tbASChange"));
    wxLogTrace(className, wxT("ending tbASChange"));
}

void frmMakeFrom3DUnit::edtAVChange() {
    wxLogTrace(className, wxT("beginning edtAVChange"));
    wxLogTrace(className, wxT("ending edtAVChange"));
}

void frmMakeFrom3DUnit::udAVClick() {
    wxLogTrace(className, wxT("beginning udAVClick"));
    wxLogTrace(className, wxT("ending udAVClick"));
}

void frmMakeFrom3DUnit::tbAVChange() {
    wxLogTrace(className, wxT("beginning tbAVChange"));
    wxLogTrace(className, wxT("ending tbAVChange"));
}

void frmMakeFrom3DUnit::edtInnerRadiusChange() {
    wxLogTrace(className, wxT("beginning edtInnerRadiusChange"));
    wxLogTrace(className, wxT("ending edtInnerRadiusChange"));
}

void frmMakeFrom3DUnit::udInnerRadiusClick() {
    wxLogTrace(className, wxT("beginning udInnerRadiusClick"));
    wxLogTrace(className, wxT("ending udInnerRadiusClick"));
}

void frmMakeFrom3DUnit::tbInnerRadiusChange() {
    wxLogTrace(className, wxT("beginning tbInnerRadiusChange"));
    wxLogTrace(className, wxT("ending tbInnerRadiusChange"));
}

void frmMakeFrom3DUnit::rbCylindricalClick() {
    wxLogTrace(className, wxT("beginning rbCylindricalClick"));
    wxLogTrace(className, wxT("ending rbCylindricalClick"));
}

void frmMakeFrom3DUnit::edtOuterRadiusChange() {
    wxLogTrace(className, wxT("beginning edtOuterRadiusChange"));
    wxLogTrace(className, wxT("ending edtOuterRadiusChange"));
}

void frmMakeFrom3DUnit::udOuterRadiusClick() {
    wxLogTrace(className, wxT("beginning udOuterRadiusClick"));
    wxLogTrace(className, wxT("ending udOuterRadiusClick"));
}

void frmMakeFrom3DUnit::tbOuterRadiusChange() {
    wxLogTrace(className, wxT("beginning tbOuterRadiusChange"));
    wxLogTrace(className, wxT("ending tbOuterRadiusChange"));
}

void frmMakeFrom3DUnit::cbPolygonalClick() {
    wxLogTrace(className, wxT("beginning cbPolygonalClick"));
    wxLogTrace(className, wxT("ending cbPolygonalClick"));
}

void frmMakeFrom3DUnit::edtORChange() {
    wxLogTrace(className, wxT("beginning edtORChange"));
    wxLogTrace(className, wxT("ending edtORChange"));
}

void frmMakeFrom3DUnit::udORClick() {
    wxLogTrace(className, wxT("beginning udORClick"));
    wxLogTrace(className, wxT("ending udORClick"));
}

void frmMakeFrom3DUnit::tbORChange() {
    wxLogTrace(className, wxT("beginning tbORChange"));
    wxLogTrace(className, wxT("ending tbORChange"));
}

void frmMakeFrom3DUnit::edtOGChange() {
    wxLogTrace(className, wxT("beginning edtOGChange"));
    wxLogTrace(className, wxT("ending edtOGChange"));
}

void frmMakeFrom3DUnit::udOGClick() {
    wxLogTrace(className, wxT("beginning udOGClick"));
    wxLogTrace(className, wxT("ending udOGClick"));
}

void frmMakeFrom3DUnit::tbOGChange() {
    wxLogTrace(className, wxT("beginning tbOGChange"));
    wxLogTrace(className, wxT("ending tbOGChange"));
}

void frmMakeFrom3DUnit::edtOBChange() {
    wxLogTrace(className, wxT("beginning edtOBChange"));
    wxLogTrace(className, wxT("ending edtOBChange"));
}

void frmMakeFrom3DUnit::udOBClick() {
    wxLogTrace(className, wxT("beginning udOBClick"));
    wxLogTrace(className, wxT("ending udOBClick"));
}

void frmMakeFrom3DUnit::tbOBChange() {
    wxLogTrace(className, wxT("beginning tbOBChange"));
    wxLogTrace(className, wxT("ending tbOBChange"));
}

void frmMakeFrom3DUnit::edtOHChange() {
    wxLogTrace(className, wxT("beginning edtOHChange"));
    wxLogTrace(className, wxT("ending edtOHChange"));
}

void frmMakeFrom3DUnit::udOHClick() {
    wxLogTrace(className, wxT("beginning udOHClick"));
    wxLogTrace(className, wxT("ending udOHClick"));
}

void frmMakeFrom3DUnit::tbOHChange() {
    wxLogTrace(className, wxT("beginning tbOHChange"));
    wxLogTrace(className, wxT("ending tbOHChange"));
}

void frmMakeFrom3DUnit::edtOSChange() {
    wxLogTrace(className, wxT("beginning edtOSChange"));
    wxLogTrace(className, wxT("ending edtOSChange"));
}

void frmMakeFrom3DUnit::udOSClick() {
    wxLogTrace(className, wxT("beginning udOSClick"));
    wxLogTrace(className, wxT("ending udOSClick"));
}

void frmMakeFrom3DUnit::tbOSChange() {
    wxLogTrace(className, wxT("beginning tbOSChange"));
    wxLogTrace(className, wxT("ending tbOSChange"));
}

void frmMakeFrom3DUnit::edtOVChange() {
    wxLogTrace(className, wxT("beginning edtOVChange"));
    wxLogTrace(className, wxT("ending edtOVChange"));
}

void frmMakeFrom3DUnit::udOVClick() {
    wxLogTrace(className, wxT("beginning udOVClick"));
    wxLogTrace(className, wxT("ending udOVClick"));
}

void frmMakeFrom3DUnit::tbOVChange() {
    wxLogTrace(className, wxT("beginning tbOVChange"));
    wxLogTrace(className, wxT("ending tbOVChange"));
}

void frmMakeFrom3DUnit::cbUseOutlineColorClick() {
    wxLogTrace(className, wxT("beginning cbUseOutlineColorClick"));
    wxLogTrace(className, wxT("ending cbUseOutlineColorClick"));
}

void frmMakeFrom3DUnit::rbSphericalClick() {
    wxLogTrace(className, wxT("beginning rbSphericalClick"));
    wxLogTrace(className, wxT("ending rbSphericalClick"));
}

void frmMakeFrom3DUnit::cbSmoothClick() {
    wxLogTrace(className, wxT("beginning cbSmoothClick"));
    wxLogTrace(className, wxT("ending cbSmoothClick"));
}

void frmMakeFrom3DUnit::cbRemoveHiddenSurfacesClick() {
    wxLogTrace(className, wxT("beginning cbRemoveHiddenSurfacesClick"));
    wxLogTrace(className, wxT("ending cbRemoveHiddenSurfacesClick"));
}

void frmMakeFrom3DUnit::PaintModel() {
    wxLogTrace(className, wxT("beginning PaintModel"));
    wxLogTrace(className, wxT("ending PaintModel"));
}

void frmMakeFrom3DUnit::SetModelColorFromRGB() {
    wxLogTrace(className, wxT("beginning SetModelColorFromRGB"));
    wxLogTrace(className, wxT("ending SetModelColorFromRGB"));
}

void frmMakeFrom3DUnit::SetModelColorFromHSV() {
    wxLogTrace(className, wxT("beginning SetModelColorFromHSV"));
    wxLogTrace(className, wxT("ending SetModelColorFromHSV"));
}

void frmMakeFrom3DUnit::SetLightColorFromRGB() {
    wxLogTrace(className, wxT("beginning SetLightColorFromRGB"));
    wxLogTrace(className, wxT("ending SetLightColorFromRGB"));
}

void frmMakeFrom3DUnit::SetLightColorFromHSV() {
    wxLogTrace(className, wxT("beginning SetLightColorFromHSV"));
    wxLogTrace(className, wxT("ending SetLightColorFromHSV"));
}

void frmMakeFrom3DUnit::SetAmbientColorFromRGB() {
    wxLogTrace(className, wxT("beginning SetAmbientColorFromRGB"));
    wxLogTrace(className, wxT("ending SetAmbientColorFromRGB"));
}

void frmMakeFrom3DUnit::SetAmbientColorFromHSV() {
    wxLogTrace(className, wxT("beginning SetAmbientColorFromHSV"));
    wxLogTrace(className, wxT("ending SetAmbientColorFromHSV"));
}

void frmMakeFrom3DUnit::SetOutlineColorFromRGB() {
    wxLogTrace(className, wxT("beginning SetOutlineColorFromRGB"));
    wxLogTrace(className, wxT("ending SetOutlineColorFromRGB"));
}

void frmMakeFrom3DUnit::SetOutlineColorFromHSV() {
    wxLogTrace(className, wxT("beginning SetOutlineColorFromHSV"));
    wxLogTrace(className, wxT("ending SetOutlineColorFromHSV"));
}

void frmMakeFrom3DUnit::RGBtoHSV(float R,float G,float B, float& H,float& S,float& V) {
    wxLogTrace(className, wxT("beginning RGBtoHSV"));
    wxLogTrace(className, wxT("ending RGBtoHSV"));
}

void frmMakeFrom3DUnit::HSVtoRGB(float H,float S,float V, float& R,float& G,float& B) {
    wxLogTrace(className, wxT("beginning HSVtoRGB"));
    wxLogTrace(className, wxT("ending HSVtoRGB"));
}

TSurface frmMakeFrom3DUnit::GetSurface() {
    wxLogTrace(className, wxT("beginning GetSurface"));
    wxLogTrace(className, wxT("ending GetSurface"));
}

wxColour frmMakeFrom3DUnit::GetColor(TVector Normal) {
    wxLogTrace(className, wxT("beginning GetColor"));
    wxLogTrace(className, wxT("ending GetColor"));
}

wxColour frmMakeFrom3DUnit::GetOutlineColor(wxColour Col) {
    wxLogTrace(className, wxT("beginning GetOutlineColor"));
    wxLogTrace(className, wxT("ending GetOutlineColor"));
}

void frmMakeFrom3DUnit::ExportSurface() {
    wxLogTrace(className, wxT("beginning ExportSurface"));
    wxLogTrace(className, wxT("ending ExportSurface"));
}

frmMakeFrom3DUnit* frmmakefrom3dunit=NULL;
