unit PoliteSpinEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin;

type
  TPoliteSpinEdit = class(TSpinEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure KeyPress(var Key: Char); override;
  public
    { Public declarations }
  published
    { Published declarations }
    property AutoSelect;
    property AutoSize;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property EditorEnabled;
    property Enabled;
    property Font;
    property Increment;
    property MaxLength;
    property MaxValue;
    property MinValue;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Value;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

procedure Register;

implementation


procedure TPoliteSpinEdit.KeyPress(var Key: Char);
begin
  if (Key=#13) then begin
    (Owner as TCustomForm).ModalResult:=mrOk;
    Key:=#0;
    end
  else begin
    inherited KeyPress(Key);
    end;
end;

procedure Register;
begin
  RegisterComponents('Custom', [TPoliteSpinEdit]);
end;

end.
