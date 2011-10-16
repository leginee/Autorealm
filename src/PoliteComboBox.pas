unit PoliteComboBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TPoliteComboBox = class(TCustomComboBox)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure KeyPress(var Key: Char); override;
  published
    { Published declarations }
    property Align; // zifnabbe 2002/08/18
    property Style; {Must be published before Items}
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property Items;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure TPoliteComboBox.KeyPress(var Key: Char);
begin
  case Key of
    #13: begin
           if DroppedDown then begin
              DroppedDown:=false;
              end
           else begin
             (Owner as TCustomForm).ModalResult:=mrOk;
           end;

           Key:=#0;
         end;
    #27: begin
           if DroppedDown then begin
              DroppedDown:=false;
             end
           else begin
             (Owner as TCustomForm).ModalResult:=mrCancel;
           end;

           Key:=#0;
         end;
    else begin
      inherited KeyPress(Key);
    end;
  end;  
end;

procedure Register;
begin
  RegisterComponents('Custom', [TPoliteComboBox]);
end;

end.
