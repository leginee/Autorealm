unit range;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
     ExtCtrls;

type
  TGaugeOrientation = (goHorizontal, goVertical);

  TRange = class(TCustomControl)
  private
    { Private declarations }
    FOrient:TGaugeOrientation;
    FDivisions:LongInt;
    FLow,FHigh:LongInt;
    FStartMouse:LongInt;
    FRangeColor:TColor;
    FTicks:boolean;
    FOnChange:TNotifyEvent;

    procedure SetGaugeKind(value:TGaugeOrientation);
    procedure SetLow(value:longint);
    procedure SetHigh(value:longint);
    procedure SetDivisions(value:longint);
    procedure SetRangeColor(value:TColor);
    procedure SetTicks(value:boolean);

  protected
    { Protected declarations }
    procedure WMLButtonDown(var msg: TWMLButtonDown);      message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var msg: TWMLButtonDblClk);  message WM_LBUTTONDBLCLK;
    procedure WMMouseMove(var msg: TWMMouseMove);          message WM_MOUSEMOVE;
    procedure WMLButtonUp(var msg: TWMLButtonUp);          message WM_LBUTTONUP;

    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property Divisions: LongInt read FDivisions write SetDivisions default 10;
    property Color;
    property RangeColor:TColor read FRangeColor write SetRangeColor default clHighlight;
    property Enabled;
    property Kind: TGaugeOrientation read FOrient write SetGaugeKind default goHorizontal;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property Low: LongInt read FLow write SetLow default 0;
    property High: LongInt read FHigh write SetHigh default 0;
    property Ticks: boolean read FTicks write SetTicks default true;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;


procedure Register;

implementation

procedure TRange.SetGaugeKind(value:TGaugeOrientation);
var temp:Longint;
begin
  if value<>FOrient then begin
    FOrient := value;
    temp:=Width;
    Width:=Height;
    Height:=temp;
    Refresh;
    end;
end;

procedure TRange.SetRangeColor(value:TColor);
begin
  if value<>FRangeColor then begin
    FRangeColor:=value;
    Refresh;
    end;
end;

procedure TRange.SetTicks(value:boolean);
begin
  if value<>FTicks then begin
    FTicks:=value;
    Refresh;
    end;
end;

procedure TRange.SetHigh(value:longint);
var temp:LongInt;
begin
  if value<>FHigh then begin
    if (value>=0) and (value<=FDivisions) then begin
      FHigh:=value;
      if (FLow>FHigh) then begin
        temp:=FLow;
        FLow:=FHigh;
        FHigh:=temp;
        end;
      Refresh;
      if Assigned(FOnChange) then FOnChange(Self);
      end;
    end;
end;

procedure TRange.SetLow(value:longint);
var temp:LongInt;
begin
  if value<>FLow then begin
    if (value>=0) and (value<=FDivisions) then begin
      FLow:=value;
      if (FLow>FHigh) then begin
        temp:=FLow;
        FLow:=FHigh;
        FHigh:=temp;
        end;
      Refresh;
      if Assigned(FOnChange) then FOnChange(Self);
      end;
    end;
end;

procedure TRange.SetDivisions(value:Longint);
begin
  if (value<>FDivisions) and (value<>0) then begin
    if (FLow<value)   then FLow:=value;
    if (FHigh<value)  then FHigh:=value;
    FDivisions:=value;
    Refresh;
    end;
end;

procedure TRange.Paint;
var i:integer;
    x1,y1,x2,y2:integer;
    r:TRect;
begin
  if (FDivisions<>0) then begin
    r.left:=0;
    r.top:=0;
    r.right:=Width;
    r.bottom:=Height;

    Canvas.Brush.Color:=Color;
    Canvas.FillRect(r);

    Canvas.Pen.Color := clBlack;
    Canvas.Rectangle(0,0,r.right,r.bottom);

    Canvas.Brush.Color:=FRangeColor;
    if (FOrient=goHorizontal) and (FLow<>FHigh) then begin
      r.top:=0;
      r.bottom:=Height;

      r.left:=(FLow*Width) div FDivisions;
      r.right:=(FHigh*Width) div FDivisions;
      end
    else begin
      r.left:=0;
      r.right:=Width;

      r.top:=(FLow*Height) div FDivisions;
      r.bottom:=(FHigh*Height) div FDivisions;
      end;

    Canvas.FillRect(r);

    if (FTicks) then begin
      for i:=0 to FDivisions do begin
      	if (i>=FLow) and (i<FHigh) then
      	  Canvas.Pen.Color := Color
      	else
      	  Canvas.Pen.Color := FRangeColor;

      	if (FOrient=goHorizontal) then begin
      	  x1:=(i*Width) div FDivisions;
      	  x2:=x1;
      	  y1:=1;
      	  y2:=Height-1;
      	  end
      	else begin
      	  y1:=(i*Height) div FDivisions;
      	  y2:=y1;
      	  x1:=1;
      	  x2:=Width-1;
      	  end;

      	Canvas.MoveTo(x1,y1);
      	Canvas.LineTo(x2,y2);
        end;
      end;
    end;
end;

constructor TRange.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csCaptureMouse, csFramed, csOpaque];

  FOrient:=goHorizontal;
  FDivisions:=10;
  FLow:=0;
  FHigh:=0;
  FRangeColor:=clHighlight;
  FTicks:=true;

  Width := 10*FDivisions;
  Height := 20;
  Color := clWhite;
end;

procedure TRange.WMLButtonDown(var msg: TWMLButtonDown);
var x,y:integer;
begin
  x:=msg.Xpos;
  y:=msg.YPos;

  SetCapture(Handle);

  if (FOrient=goHorizontal) then begin
    FStartMouse:= (X*FDivisions) div Width;
    SetLow(FStartMouse);
    SetHigh(FStartMouse);
    end
  else begin
    FStartMouse:= (Y*FDivisions) div Height;
    SetLow(FStartMouse);
    SetHigh(FStartMouse);
    end;
end;

procedure TRange.WMLButtonDblClk(var msg: TWMLButtonDblClk);
begin
end;

procedure TRange.WMMouseMove(var msg: TWMMouseMove);
var x,y:integer;
    nm:LongInt;
begin
  x:=msg.Xpos;
  y:=msg.YPos;

  if (GetCapture = Handle) then begin
    if (FOrient=goHorizontal) then
      nm:= (X*FDivisions) div Width
    else
      nm:= (Y*FDivisions) div Height;

    if (nm<FStartMouse) then begin
      SetLow(nm);
      SetHigh(FStartMouse);
      end
    else begin
      SetLow(FStartMouse);
      SetHigh(nm);
      end;
    end;
end;


procedure TRange.WMLButtonUp(var msg: TWMLButtonUp);
var x,y:integer;
    nm:LongInt;
begin
  x:=msg.Xpos;
  y:=msg.YPos;
  if (GetCapture = Handle) then begin
    ReleaseCapture;

    if (FOrient=goHorizontal) then
      nm:= (X*FDivisions) div Width
    else
      nm:= (Y*FDivisions) div Height;

    if (nm<FStartMouse) then begin
      SetLow(nm);
      SetHigh(FStartMouse);
      end
    else begin
      SetLow(FStartMouse);
      SetHigh(nm);
      end;
    end;
end;


procedure Register;
begin
  RegisterComponents('Custom', [TRange]);
end;

end.
