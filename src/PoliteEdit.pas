unit PoliteEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TPoliteEdit = class(TCustomEdit)
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
    property BorderStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
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

procedure TPoliteEdit.KeyPress(var Key: Char);
begin
  case Key of
    #13: begin
           (Owner as TCustomForm).ModalResult:=mrOk;
           Key:=#0;
         end;
    #27: begin
           (Owner as TCustomForm).ModalResult:=mrCancel;
           Key:=#0;
         end;
  else begin
    inherited KeyPress(Key);
    end;
  end;  
end;

procedure Register;
begin
  RegisterComponents('Custom', [TPoliteEdit]);
end;

end.
