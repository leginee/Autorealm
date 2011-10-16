unit VLabel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TTextEdge = (teLeft, teRight);

  TVLabel = class(TCustomLabel)
  private
    FAutoSize:boolean;
    FTopEdge:TTextEdge;
    FFontIsVertical:boolean;
    FIgnoreFontChange:boolean;
    { Private declarations }
  protected
    procedure DoDrawText(var Rect: TRect; Flags: Longint); override;
    procedure Paint; override;
    procedure AdjustBounds; override;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure VerticalFont;
    procedure SetTopEdge(value:TTextEdge);
    procedure SetAutoSize(value:boolean); override;
    procedure Loaded; override;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  published
    property Align;
    property AutoSize:boolean read FAutoSize write SetAutoSize default true;
    property Caption;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Transparent;
    property TopEdge: TTextEdge read FTopEdge write SetTopEdge default teLeft;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    { Published declarations }
  end;

procedure Register;

implementation

constructor TVLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoSize:=true;
  TopEdge := teLeft;
  FFontIsVertical:=false;
  FIgnoreFontChange:=false;
  Font.Name:='Arial';
end;

procedure TVLabel.Loaded;
begin
  inherited Loaded;
  AdjustBounds;
end;

procedure TVLabel.SetAutoSize(value:boolean);
begin
  if (value<>FAutoSize) then begin
    FAutoSize:=value;
    AdjustBounds;
    end;
end;

procedure TVLabel.DoDrawText(var Rect: TRect; Flags: LongInt);
var
  Text: string;
begin
  if not FFontIsVertical then VerticalFont;

  Text := GetLabelText;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Canvas.Font := Font;
  if not Enabled then
  begin
    OffsetRect(Rect, 1, 1);
    Canvas.Font.Color := clBtnHighlight;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
    OffsetRect(Rect, -1, -1);
    Canvas.Font.Color := clBtnShadow;
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
  end
  else
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
end;

procedure TVLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Rect: TRect;
  DrawStyle: Integer;
begin
  with Canvas do
  begin
    if not Transparent then
    begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(ClientRect);
    end;
    Brush.Style := bsClear;
    Rect := ClientRect;
    DrawStyle := DT_EXPANDTABS or WordWraps[WordWrap] or Alignments[Alignment];

    { Calculate vertical layout }
    DoDrawText(Rect, DrawStyle or DT_CALCRECT);
    if FTopEdge=teLeft then
      OffsetRect(Rect, 0, Rect.Right)
    else
      OffsetRect(Rect, Rect.Bottom, 0);
    DoDrawText(Rect, DrawStyle or DT_NOCLIP);
  end;
end;

procedure TVLabel.VerticalFont;
var
  LogFont: TLogFont;
begin
  with LogFont do begin
    lfHeight := Font.Height;
    lfWidth := 0; { have font mapper choose }
    if (FTopEdge=teRight) then
        lfEscapement := 2700
    else
        lfEscapement := 900;

    lfOrientation := lfEscapement;
    if fsBold in Font.Style then
      lfWeight := FW_BOLD
    else
      lfWeight := FW_NORMAL;
    lfItalic := Byte(fsItalic in Font.Style);
    lfUnderline := Byte(fsUnderline in Font.Style);
    lfStrikeOut := Byte(fsStrikeOut in Font.Style);
    lfCharSet := Byte(Font.Charset);
    if AnsiCompareText(Font.Name, 'Default') = 0 then  // do not localize
      StrPCopy(lfFaceName, 'Arial')
    else
      StrPCopy(lfFaceName, Font.Name);
    lfQuality := DEFAULT_QUALITY;
    { Everything else as default }
    lfOutPrecision := OUT_DEFAULT_PRECIS;
    lfClipPrecision := CLIP_DEFAULT_PRECIS;
    case Font.Pitch of
      fpVariable: lfPitchAndFamily := VARIABLE_PITCH;
      fpFixed: lfPitchAndFamily := FIXED_PITCH;
    else
      lfPitchAndFamily := DEFAULT_PITCH;
    end;
    FIgnoreFontChange:=true;
    Font.Handle := CreateFontIndirect(LogFont);
    FIgnoreFontChange:=false;
    FFontIsVertical:=true;
  end;
end;

procedure TVLabel.AdjustBounds;
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  X,Y: Integer;
  Rect: TRect;
begin
  if not (csReading in ComponentState) and AutoSize then
  begin
    Rect := ClientRect;
    DC := GetDC(0);
    Canvas.Handle := DC;
    DoDrawText(Rect, (DT_EXPANDTABS or DT_CALCRECT) or WordWraps[WordWrap]);
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    X := Left;
    Y := Top;
    SetBounds(X, Y, Rect.Bottom, Rect.Right)
  end;
end;

procedure TVLabel.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
  AdjustBounds;
end;

procedure TVLabel.CMFontChanged(var Message: TMessage);
begin
  if FIgnoreFontChange then begin
    inherited;
  end else begin
    FFontIsVertical:=false;
    VerticalFont;
    AdjustBounds;
    end;
end;

procedure TVLabel.SetTopEdge(value:TTextEdge);
begin
  if (value<>FTopEdge) then begin
    FTopEdge:=value;
    VerticalFont;
    Invalidate;
    AdjustBounds;
    end;
end;

procedure Register;
begin
  RegisterComponents('Custom', [TVLabel]);
end;

end.
