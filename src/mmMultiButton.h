//
// Name     : mmMultiButton
// Purpose  : A clickable button that can
//            - have a bitmap and/or a text label.
//            - function as a toggle ("on/off") button.
//            - turn active/inactive on entering/leaving it with the mouse.
//            - add a drop-down arrow to the bitmap in a separate section
//              (DROPDOWN) or as part of the bitmap (WHOLEDROPDOWN).
//
//            NOTE:
//            - mmMB_DROPDOWN and mmMB_WHOLEDROPDOWN cannot be used at
//              the same time.
//            - mmMB_STATIC and mmMB_AUTODRAW are mutually exclusive.
//
// Author   : Arne Morken
// Copyright: (C) 2000-2002 MindMatters, www.mindmatters.no
// Licence  : wxWindows licence
// Further Work: Michael J. Pedersen. License unaltered. Additional work
// makes this work as an XRC component.
// Code downloaded from http://www.mindmatters.no/mmwx as version 0.3.
//

#ifndef _MMMULTIBUTTON_INCLUDED
#define _MMMULTIBUTTON_INCLUDED

#include "wx/wxprec.h"
#include <wx/xrc/xmlres.h>

#ifdef __BORLANDC__
    #pragma hdrstop
#endif

#ifndef WX_PRECOMP
    #include "wx/wx.h"
#endif

// mmMultiButton styles (re-use wxFrame/wxDialog style flags)

#define mmMB_FOCUS         0x0400 // Change bitmap on enter/leave.
#define mmMB_SELECT        0x0800 // Change bitmap on select.
#define mmMB_TOGGLE        0x1000 // Change bitmap on toggle.
#define mmMB_DROPDOWN      0x2000 // Draw a drop-down arrow in separate box.
#define mmMB_WHOLEDROPDOWN 0x4000 // Draw a drop-down arrow on the bitmap.
#define mmMB_STATIC        0x8000 // Do not react on mouse events.
#define mmMB_NO_AUTOSIZE   0x0020 // Button should use the given size, and
// not resize itself to fit bitmap/label.
#define mmMB_AUTODRAW      0x0010 // Automatically manage drawing of bitmap,
// label and border.

// MultiButton events

const wxEventType mmEVT_MULTIBUTTON_FIRST = wxEVT_FIRST + 5400;

const wxEventType mmEVT_TOGGLE           = mmEVT_MULTIBUTTON_FIRST + 1;
const wxEventType mmEVT_WHOLEDROP_TOGGLE = mmEVT_MULTIBUTTON_FIRST + 2;
const wxEventType mmEVT_DROP_TOGGLE      = mmEVT_MULTIBUTTON_FIRST + 3;

#define EVT_TOGGLE(id, fn)           DECLARE_EVENT_TABLE_ENTRY(mmEVT_TOGGLE,           id, -1, (wxObjectEventFunction)(wxEventFunction)(wxCommandEventFunction)&fn, (wxObject*)NULL ),
#define EVT_WHOLEDROP_TOGGLE(id, fn) DECLARE_EVENT_TABLE_ENTRY(mmEVT_WHOLEDROP_TOGGLE, id, -1, (wxObjectEventFunction)(wxEventFunction)(wxCommandEventFunction)&fn, (wxObject*)NULL ),
#define EVT_DROP_TOGGLE(id, fn)      DECLARE_EVENT_TABLE_ENTRY(mmEVT_DROP_TOGGLE,      id, -1, (wxObjectEventFunction)(wxEventFunction)(wxCommandEventFunction)&fn, (wxObject*)NULL ),

//////////////////////////////////////////////////////////////////////////////

class mmMultiButton: public wxWindow
{
    DECLARE_DYNAMIC_CLASS(mmMultiButton)

public:
    mmMultiButton() { }
    mmMultiButton(wxWindow *parent,
                  const wxWindowID id            = -1,
                  const wxString&  label         = wxEmptyString,
                  wxBitmap&  defaultBitmap = wxNullBitmap,
                  const wxPoint&   pos           = wxDefaultPosition,
                  const wxSize&    size          = wxDefaultSize,
                  const long int   style         = 0)
    // Constructor.
    // - parent: The button's parent.
    // - id: Button identifier.
    // - label: Optional label.
    // - bitmapDefault: Optional default icon
    // - pos: Position.
    // - size: Size.
    // - style: The following styles are available:
    //   mmMB_AUTODRAW : Automatically manage drawing of bitmap,
    //   		       label and border.
    //   mmMB_FOCUS    : Change icon on enter/leave.
    //   mmMB_SELECT   : Change icon on select.
    //   mmMB_TOGGLE   : Change icon on toggle.
    //   mmMB_STATIC   : Do not react on mouse events.
    { Create(parent, id, label, defaultBitmap, pos, size, style); }

    bool Create(wxWindow *parent,
                const wxWindowID id            = -1,
                const wxString&  label         = wxEmptyString,
                wxBitmap&  defaultBitmap = wxNullBitmap,
                const wxPoint&   pos           = wxDefaultPosition,
                const wxSize&    size          = wxDefaultSize,
                const long int   style         = 0);

    void     SetDefaultBitmap(wxBitmap bm);
    void     SetSelectedBitmap(wxBitmap bm);
    void     SetFocusBitmap(wxBitmap bm);
    void     SetToggleBitmap(wxBitmap bm);

    void     SetLabel(wxString str); // Change button label.
    void     SetStyle(const long style); // Change style.
    void     SetFocus(const bool hasFocus);
    void     SetSelected(const bool isSelected);
    void     SetToggleDown(const bool isToggleDown);
    void     SetWholeDropToggleDown(const bool isWholeDropToggleDown);
    void     SetDropToggleDown(const bool isDropToggleDown);

    wxString GetLabel(void) const { return mLabelStr; }
    // Return the label of the button (if any).

    bool     IsToggleDown(void) const { return mIsToggleDown; }
    // Return TRUE if the button is pressed and WHOLEDROP is set
    bool     IsWholeDropPressed(void) const { return mIsWholeDropToggleDown; }
    // Return TRUE if the drop down arrow is pressed
    bool     IsDropToggleDown(void) const { return mIsDropToggleDown; }
    // Return TRUE if the drop down arrow is pressed
    bool     IsSelected(void) const { return mIsSelected; }
    // Return TRUE if the button is selected
    bool     HasFocus(void) const { return mHasFocus; }
    // Return TRUE if the button has focus

    bool     MouseIsOnButton();
    // Returns TRUE if mouse pointer is over the button

    bool     Enable(bool enable);

private:
    DECLARE_EVENT_TABLE()

    void     OnPaint(wxPaintEvent& event);
    void     OnMouse(wxMouseEvent& event);

    void     RedrawBitmaps(wxDC& dc);
    void     RedrawLabel(wxDC& dc);
    void     RedrawBorders(wxDC& dc);

    void     FindAndSetSize();

    long     mStyle;
    wxString mLabelStr;

    bool     mHasFocus;              // TRUE if mouse is over button.
    bool     mIsActivated;           // TRUE if button is activated.
    bool     mIsToggleDown;          // TRUE if button is toggled down.
    bool     mIsWholeDropToggleDown; // TRUE if mouse down over drop arrow
    bool     mIsDropToggleDown;      // TRUE if mouse down over drop arrow
    bool     mIsSelected;            // TRUE if button is selected.

    int      mBorderSize;
    int      mMarginSize;

    wxBitmap mDefaultBitmap;
    wxBitmap mSelectedBitmap;
    wxBitmap mFocusBitmap;
    wxBitmap mToggleBitmap;
}; // class mmMultiButton

/**
 * This is the custom XmlHandler for the mmMultiButton. It must be
 * inserted into the xmlhandler tree like so:
 * 
 * <pre>
 * #include "mmMultiButton.h"
 * 
 * wxXmlHandler::Get()->AddHandler(new mmMultiButtonXmlHandler);
 * </pre>
 * 
 * Without the above being done, this will not work.
 * 
 * The XRC node structure for the mmMultiButton class is as follows:
 * <pre>
 *     <object class="mmMultiButton" name="btnColorTextOutline">
 * 			<bitmap>filename</bitmap>
 * 			<selectedbitmap>filename</selectedbitmap>
 * 			<focusbitmap>filename</focusbitmap>
 * 			<togglebitmap>filename</togglebitmap>
 * 			<label>text label</label>
 * 			<style>style options</style>
 * 			<toggled>1(down)/0(not down)</toggled>
 *     </object>
 * </pre>
 * 
 * Either <pre><nocolor></pre> or <pre><defaultcolor></pre> may be
 * defined. If nocolor is defined, it takes precedence over defaultcolor.
 * 
 * Any other XRC nodes may be used as usual (tooltip, etc).
 */
class mmMultiButtonXmlHandler : public wxXmlResourceHandler {
    DECLARE_DYNAMIC_CLASS(mmMultiButtonXmlHandler)
public:
	/**
	 * Default constructor for the mmMultiButtonXmlHandler
	 */
    mmMultiButtonXmlHandler();
	/**
	 * This routine is responsible for creating the actual mmMultiButton
	 * from the data in the XRC file.
	 * 
	 * @return A fully constructed mmMultiButton.
	 */
    virtual wxObject * DoCreateResource();
	/**
	 * This method is responsible for determining whether or not this class
	 * can handle this node of the XML file.
	 * 
	 * @param node   The current node, which should indicate the class of object to be
	 *               built.
	 * 
	 * @return True if the node class is of type "mmMultiButton", false otherwise.
	 */
    virtual bool CanHandle(wxXmlNode *node);
};
#endif 
