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

#include <wx/wx.h>

const wxString res_application_title(_("AutoREALM"));
const wxString res_main_editing_symbol(_("%s - EDITING SYMBOL %s"));
const wxString res_main_autorlm_hlp(_("Autorlm.hlp")); //use the name autorlm_(localization).hlp
const wxString res_main_undo(_("&Undo %s"));
const wxString res_main_redo(_("&Redo %s"));
const wxString res_main_add_overlay(_("Add Overlay"));
const wxString res_main_maximum_overlays_reached(_("Only %d overlays are allowed"));
const wxString res_main_maximum_overlay_title(_("Overlay limit"));
const wxString res_main_del_overlay(_("Delete the '%s' overlay?"));
const wxString res_main_sure(_("Are you sure?"));
const wxString res_main_remove_objects(_("Remove all objects within the '%s' overlay?"));
const wxString res_main_deleting(_(" (DELETING)"));
const wxString res_main_color_change_outline(_("Change Outline Color"));
const wxString res_main_grid_remove(_("Remove Grid"));
const wxString res_main_grid_bold(_("Change Bold Grid"));
const wxString res_main_grid_style1(_("Change Primary Grid Style"));
const wxString res_main_grid_style2(_("Change Secondary Grid Style"));
const wxString res_main_grid_default(_("default"));
const wxString res_main_grid_resize(_("Grid Resize"));
const wxString res_main_grid_squares(_("squares"));
const wxString res_main_grid_hexes(_("hexes"));
const wxString res_main_grid_triangles(_("triangles"));
const wxString res_main_grid_per_cm(_("/cm"));
const wxString res_main_grid_per_inch(_("/inch"));
const wxString res_main_file_nosave(_("Failed to save %s"));
const wxString res_main_file_noload(_("%s is not a valid map file."));
const wxString res_main_file_incompatible(_("%s was saved with an incompatible version of AutoREALM."));
const wxString res_main_file_noopen(_("Failed to open %s"));
const wxString res_main_file_noinsert(_("Cannot insert %s"));
const wxString res_main_file_exist(_("%s already exists.  Overwrite?"));
const wxString res_main_file_exist2(_("File already exists"));
const wxString res_main_file_changes(_("Save current map?  Changes include:"));
const wxString res_main_file_changes2(_("Existing Map has changed"));
const wxString res_main_rotate_degrees(_("Rotate %g degrees")); //g evoid FloattoStr
const wxString res_main_color_change_backgd(_("Change Background Color"));
const wxString res_main_color_change_grid(_("Change Grid Color"));
const wxString res_main_print_new_file(_("AutoREALM : New file"));
const wxString res_main_big_bitmap(_("Bitmap too large to be generated.  Try again with a smaller bitmap."));
const wxString res_main_big_bitmap_title(_("Error Creating Bitmap"));

const wxString res_main_pushpin(_("You can not display a push pin until it has been placed.\nRight-click on the map and select \"Place Push Pin\"."));

const wxString res_main_reload(_("This action requires AutoREALM to reload itself.\nYour current work will be saved into a temporary file,\nand you will lose the ability to undo.  Continue?"));

const wxString res_main_hyperlink_doc_not_found(_("Error opening '%s.'"));
const wxString res_main_hyperlink_exe_not_found(_("Error opening '%s'\nwith command-line parameters '%s'."));
const wxString res_main_hyperlink_hints(_("\n(Note: If your hyperlink filename contains spaces, surround the entire filename with\ndouble quotes, e.g. \"%s\".)"));

const wxString res_main_warning(_("Warning"));
const wxString res_main_view_saved(_("Display a saved view"));
const wxString res_main_view_save(_("Save View"));
const wxString res_main_view_delete(_("Delete View"));
const wxString res_main_move_sel(_("Move Selection"));
const wxString res_main_readme(_("readme.doc"));
const wxString res_main_figure_close(_("Close Figures"));
const wxString res_main_line_reverse(_("Reverse Line Direction"));
const wxString res_main_define_empty_symbol(_("No objects are selected.  Do you really wish to define an empty symbol?"));
const wxString res_main_set_x_size(_("Change selection x (and maybe y) size"));
const wxString res_main_set_y_size(_("Change selection y (and maybe x) size"));

const wxString res_cprint_default(_("Default printer; "));
const wxString res_cprint_ready(_("Ready"));
const wxString res_cprint_paused(_("Paused"));
const wxString res_cprint_error(_("Error"));
const wxString res_cprint_paper_jam(_("Paper jam"));
const wxString res_cprint_out_of_paper(_("Out of paper"));
const wxString res_cprint_paper_problem(_("Paper problem"));
const wxString res_cprint_offline(_("Offline"));
const wxString res_cprint_output_bin_full(_("Output bin full"));
const wxString res_cprint_not_available(_("Not available"));
const wxString res_cprint_toner_low(_("Toner low"));
const wxString res_cprint_no_toner(_("No toner"));
const wxString res_cprint_out_of_memory(_("Out of memory"));
const wxString res_cprint_door_open(_("Door open"));
const wxString res_cprint_unknown_server(_("Unknown server"));
const wxString res_cprint_power_save(_("Power save"));
const wxString res_defsymbol_group(_("A symbol cannot be defined without any groups.  Please create some groups in the symbol library and try again."));
const wxString res_defsymbol_group_sel(_("You must select a group for this symbol"));
const wxString res_graphgrid_centi(_("Centimeters"));  //appear in the dialoge Box "Map Settings"
const wxString res_graphgrid_inche(_("Inches"));
const wxString res_graphgrid_feet(_("Feet"));
const wxString res_graphgrid_cubit(_("Cubits"));
const wxString res_graphgrid_yards(_("Yards"));
const wxString res_graphgrid_meter(_("Meters"));
const wxString res_graphgrid_fatho(_("Fathoms"));
const wxString res_graphgrid_rods(_("Rods"));
const wxString res_graphgrid_chain(_("Chains"));
const wxString res_graphgrid_furlo(_("Furlongs"));
const wxString res_graphgrid_kilom(_("Kilometers"));
const wxString res_graphgrid_stadi(_("Stadia"));
const wxString res_graphgrid_miles(_("Miles"));
const wxString res_graphgrid_naumi(_("Nautical Miles"));
const wxString res_graphgrid_leagu(_("Leagues"));
const wxString res_graphgrid_dbf1(_("Days by foot on rugged terrain, burdened"));
const wxString res_graphgrid_dbf2(_("Days by foot, burdened"));
const wxString res_graphgrid_dbf3(_("Days by foot on rugged terrain"));
const wxString res_graphgrid_dbw(_("Days by wagon"));
const wxString res_graphgrid_dbf4(_("Days by foot"));
const wxString res_graphgrid_dbh1(_("Days by war horse"));
const wxString res_graphgrid_dbg1(_("Days by oared galley"));
const wxString res_graphgrid_dbh2(_("Days by horse"));
const wxString res_graphgrid_dbg2(_("Days by sailed galley"));
const wxString res_graphgrid_au(_("AU"));
const wxString res_graphgrid_ly(_("Light years"));
const wxString res_graphgrid_parse(_("Parsecs"));
const wxString res_linetool_line_add(_("Add Line"));
const wxString res_linetool_linef_add(_("Add Fractal Line"));
const wxString res_linetool_arc_add(_("Add Arc"));
const wxString res_linetool_linepoly_add(_("Add PolyLine"));
const wxString res_linetool_linefree_add(_("Add Freehand Line"));
const wxString res_linetool_linefpoly_add(_("Add Fractal PolyLine"));
const wxString res_linetool_lineffree_add(_("Add Fractal Freehand Line"));
const wxString res_linetool_curve_add(_("Add Curve"));
const wxString res_linetool_curvef_add(_("Add Fractal Curve"));
const wxString res_linetool_curvepoly_add(_("Add Poly Curve"));
const wxString res_linetool_curvefpoly_add(_("Add Fractal PolyCurve"));
const wxString res_linetool_circle_add(_("Add Circle"));
const wxString res_linetool_rect_add(_("Add Rectangle"));
const wxString res_linetool_polygon_add(_("Add Polygon"));
const wxString res_linetool_rosette_add(_("Add Rosette Grid"));
const wxString res_mapobj_view_sav(_("(View when map was last saved)"));
const wxString res_mapobj_undo_fail(_("Failed Undo Record"));
const wxString res_mapobj_undo_restore(_("*RESTORE*"));
const wxString res_mapobj_o_del(_("* Objects were deleted"));
const wxString res_mapobj_o_add(_("* Objects were added"));
const wxString res_mapobj_o_chd(_("* Objects were changed"));
const wxString res_mapobj_o_symbols(_("* Symbols were added"));
const wxString res_mapobj_o_overlays(_("* Overlays were changed"));
const wxString res_mapobj_o_comments(_("* Comments"));
const wxString res_mapobj_o_map(_("* Map settings"));
const wxString res_mapobj_o_grid(_("* Grid attributes"));
const wxString res_mapobj_o_backgd(_("* Background color"));
const wxString res_mapobj_o_units(_("* Units of measurement"));
const wxString res_mapobj_o_map2(_("* Map scale"));
const wxString res_mapobj_o_view(_("* Views were added, deleted, or changed"));
const wxString res_mapobj_o_overlays2(_("* Visible or frozen overlays have changed"));
const wxString res_mapobj_o_print(_("* Page orientation (i.e. Portrait/Landscape)"));
const wxString res_mapobj_o_viewport(_("* Viewport (i.e. window was zoomed and/or panned)"));
const wxString res_mapobj_undo_del(_("Delete"));
const wxString res_mapobj_undo_del_overlay(_("Delete Overlay"));
const wxString res_mapobj_array_create(_("Create Array %u x %u"));

const wxString res_mapobj_overlay_inv1(_("Warning: you have just added an object to a invisible overlay.\nThe overlay will be made visible."));

const wxString res_mapobj_overlay_inv2(_("Invisible Overlay"));
const wxString res_mapobj_undo_style(_("Change Style"));
const wxString res_mapobj_undo_color(_("Change Color"));
const wxString res_mapobj_undo_colorf(_("Change Fill Color"));
const wxString res_mapobj_undo_seed(_("Change Seed"));
const wxString res_mapobj_undo_rough(_("Change Roughness"));
const wxString res_mapobj_undo_overlay(_("Change Overlay"));
const wxString res_mapobj_undo_group(_("Group"));
const wxString res_mapobj_undo_back(_("Send To Back"));
const wxString res_mapobj_undo_front(_("Bring To Front"));
const wxString res_mapobj_undo_backward_one(_("Send Backwards"));
const wxString res_mapobj_undo_forward_one(_("Send Forwards"));
const wxString res_mapobj_undo_group_no(_("Ungroup"));
const wxString res_mapobj_undo_decompose(_("Decompose"));
const wxString res_mapobj_file_chunk_no(_("Error: Expecting chunk missing. Cannot load file."));
const wxString res_mapobj_file_end(_("Error: file ended prematurely!  File contents up to end of file have been read, however data is missing.  Try opening your .BAK file for a more complete copy."));
const wxString res_mapobj_file_chunk_un(_("Error: file contains unknown chunk id!  Cannot load file."));
const wxString res_mapobj_undo_paste(_("Paste"));
const wxString res_mapobj_file_name_in(_("%s is not a valid map file."));
const wxString res_mapobj_file_ver_in(_("%s was saved with an incompatible version of AutoREALM."));
const wxString res_mapobj_file_version_error(_("This file is for a newer version of AutoREALM than supported. Open anyway?\n\nWarning: this may cause AutoREALM to crash!"));
const wxString res_mapobj_file_version_error_title(_("Version Error"));
const wxString res_mapobj_undo_file_insert(_("Insert of %s"));               // Replaced with metafile name
const wxString res_mapobj_metafile_comment(_("Created by AutoREALM"));
const wxString res_mapobj_metafile_title(_("%d x %d Map"));                   // Replaced with width & height in pixels
const wxString res_mapset_undo_comment(_("Change Comments"));
const wxString res_primitives_combine1(_("Combine operation failed"));
const wxString res_primitives_types(_("Objects to be combined are different types."));
const wxString res_primitives_combine2(_("Failure to combine objects"));
const wxString res_primitives_convert(_("Failure to convert objects"));
const wxString res_selfont_font_name(_("Font Name Change"));
const wxString res_selfont_font_size(_("Font Size Change"));

const wxString res_seltool_freez(_("You are trying to select items in a frozen overlay.\nTry unfreezing an overlay (for example, in this case, \"%s\"\nby clicking on the overlay's gray checkbox.\n\nIf you no longer wish to see this message, click \"Ignore\",\notherwise, click \"OK\"."));

const wxString res_seltool_undo_handle(_("Move Handle"));
const wxString res_seltool_undo_strech(_("Stretch Selection"));
const wxString res_seltool_undo_rotate(_("Rotate Selection"));
const wxString res_seltool_undo_move(_("Move Selection"));
const wxString res_seltool_undo_glue(_("Glue"));
const wxString res_seltool_undo_scalpel1(_("Scalpel Delete Node"));
const wxString res_seltool_undo_scalpel2(_("Scalpel Separate Node"));
const wxString res_seltool_undo_scalpel3(_("Scalpel Add Intersection Node"));
const wxString res_seltool_undo_scalpel4(_("Scalpel Slice Along Line"));
const wxString res_symbolfile_file_notvalid(_("%s is not a valid symbol file."));
const wxString res_symbollib_lose(_("WARNING: This will lose all changes to the symbol library.  Continue?"));
const wxString res_symbollib_lose_title(_("Revert to Saved"));
const wxString res_symbollib_del(_("Do you want to delete the %s group and all symbols in it?"));
const wxString res_symbollib_del_title(_("Delete Group"));
const wxString res_symbollib_restart(_("Your changes to favorites will not take place until you restart AutoREALM."));
const wxString res_symbollib_note(_("NOTE"));
const wxString res_symbollib_del_symbol(_("Do you want to delete the %s symbol from the %s group?"));
const wxString res_symbollib_del_symbol_title(_("Delete Symbol"));
const wxString res_symbollib_caption_done(_("Don&e"));
const wxString res_symbollib_caption_cancel(_("Cance&l"));
const wxString res_symbollib_caption_edit(_("&Edit Properties"));
const wxString res_symbollib_caption_del(_("De&lete"));
const wxString res_texttool_symbol_add(_("Add Symbol"));
const wxString res_texttool_symbols_adds(_("Add Multiple Symbols"));
const wxString res_texttool_text_add(_("Add Text"));
const wxString res_texttool_text_c_add(_("Add Curved Text"));
const wxString res_selectfont_font_name(_("Font Name Change"));
const wxString res_selectfont_font_size(_("Font Size Change"));
const wxString res_selectfont_font_bold(_("Font Bold"));
const wxString res_selectfont_font_italic(_("Font Italic"));
const wxString res_selectfont_font_underline(_("Font Underline"));
const wxString res_selectfont_align_left(_("Align Text Left"));
const wxString res_selectfont_align_center(_("Align Text Center"));
const wxString res_selectfont_align_right(_("Align Text Right"));
const wxString res_selectfont_text_change(_("Text Changes"));

const wxString res_ct_translate(_("Translate Colors"));
const wxString res_ct_inv_translate(_("Inverse Translate Colors"));

const wxString res_mapobj_o_pushpin(_("* Push pin names, locations, or waypoints"));
const wxString res_texttool_hyperlink_add(_("Hyperlink"));
const wxString res_main_hyperlink_drop(_("Drag/drop Hyperlink(s)"));
const wxString res_hyperlink_change(_("Hyperlink Changes"));
const wxString res_fail_hyperlink(_("Hyperlink Failed to Execute"));

const wxString res_pushpin_out_of_range(_("Push pin index of history out of range"));
const wxString res_pushpinwaypointcaption(_("Push Pin Waypoint"));
const wxString res_pushpinwaypointprompt(_("Enter the note you want associated with this waypoint:"));
const wxString res_pushpinwaypointerror(_("You can not set a waypoint until the push pin has been placed.\nRight-click on the map and select \"Place Push Pin\"."));
const wxString res_pushpinclearprompt(_("Push Pin History Clear"));
const wxString res_pushpinclearcaption(_("Are you sure you want to clear %s's history?"));
const wxString res_pushpinnamecaption(_("Push Pin Rename"));
const wxString res_pushpinnameprompt(_("New push pin name (blank reverts to color):"));
const wxString res_pushpinselectcaption(_("Push Pin"));
const wxString res_pushpinselecterror(_("You must first select a push pin by clicking on it"));
const wxString res_XMLMismatchedTag(_("XML tag mismatch: \"%s\" found; \"%s\" expected."));
const wxString res_XMLBadPinName(_("\"%s\" is not a valid push pin name."));
const wxString res_PushPinPaste(_("Error Pasting Push Pins"));

const wxString res_BulletNotFoundText(_("HyperlinkBullet.bmp not found in program directory: hyperlinks will not be visible."));
const wxString res_BulletNotFoundCaption(_("Error Loading Bitmap"));

const wxString res_autoname_nopen(_("Cannot open rule file %s!"));

const wxString res_settings_badzoom(_("Zoom multiplier must be >= 1.0"));

const wxString res_bitmapproperties_badbitmap(_("Cannot create bitmap (bad size)"));

  // "Undo" set point names for operations to change fractals
const wxString res_fractalstate_normal(_("Set to normal lines"));
const wxString res_fractalstate_fractal(_("Set to fractal lines"));
const wxString res_fractalstate_toggle(_("Toggle fractal state"));

const wxString res_main_line_flip(_("Flip Line Style"));
