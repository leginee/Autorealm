unit ledgauge;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
     ExtCtrls, Math;

type
  TGaugeOrientation = (goHorizontal, goVertical);
  TGaugeScaling = (gsDecibel,gsLinear);

  TLedGauge = class(TGraphicControl)
  private
    { Private declarations }
    FOrient:TGaugeOrientation;
    FScale:TGaugeScaling;
    FMaxSample:Longint;
    FMinSample:Longint;
    FSample:Longint;
    FRed,FYellow,FGreen:Smallint;
    FBars:SmallInt;
    FPositive:boolean;
    FDelayTimer:TTimer;
    FDelay:LongInt;
    FDelayedMax:LongInt;

    function GetBarsLit:LongInt;
    procedure SetGaugeKind(value:TGaugeOrientation);
    procedure SetMaxSample(value:longint);
    procedure SetMinSample(value:longint);
    procedure SetSample(value:longint);
    procedure SetRed(value:smallint);
    procedure SetYellow(value:smallint);
    procedure SetGreen(value:smallint);
    procedure SetScale(value:TGaugeScaling);
    procedure SetPositive(value:boolean);
    procedure SetDelay(value:longint);

  protected
    { Protected declarations }
    procedure Paint; override;
    procedure TimerExpired(Sender: TObject);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property BarsLit: LongInt read GetBarsLit;
    property TotalBars: SmallInt read FBars;
  published
    { Published declarations }
    property Color;
    property Enabled;
    property Delay:LongInt read FDelay write SetDelay default 0;
    property Kind: TGaugeOrientation read FOrient write SetGaugeKind default goVertical;
    property Scaling: TGaugeScaling read FScale write SetScale default gsDecibel;
    property PositiveOnly: boolean read FPositive write SetPositive default true;
    property Font;
    property MaxSample: LongInt read FMaxSample write SetMaxSample default 32767;
    property MinSample: LongInt read FMinSample write SetMinSample default 0;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property Sample:LongInt read FSample write SetSample default 0;
    property RedBars: SmallInt read FRed write SetRed default 2;
    property YellowBars: SmallInt read FYellow write SetYellow default 3;
    property GreenBars: SmallInt read FGreen write SetGreen default 5;
  end;

  TDbLabel = class(TLabel)
  private
    { Private declarations }
    FMaxSample:Longint;
    FMinSample:Longint;
    FSample:Longint;
    FPositive:boolean;

    procedure SetMaxSample(value:longint);
    procedure SetMinSample(value:longint);
    procedure SetSample(value:longint);
    procedure SetPositive(value:boolean);

  protected
    { Protected declarations }
    procedure Recaption;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property Color;
    property Enabled;
    property PositiveOnly: boolean read FPositive write SetPositive default true;
    property Font;
    property MaxSample: LongInt read FMaxSample write SetMaxSample default 32767;
    property MinSample: LongInt read FMinSample write SetMinSample default 0;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property Sample:LongInt read FSample write SetSample default 0;
  end;

procedure Register;

implementation

function dB(r1,r2:double):double;
begin
  if (r2=0.0) or (r1=0.0) then
    dB:=0.0
  else
    dB:=log10(r1/r2)*20.0;
end;

function TLedGauge.GetBarsLit:LongInt;
begin
  if FScale=gsDecibel then begin
    if (FBars=0) or (FSample=FMinSample) then
      GetBarsLit:=0
    else
      GetBarsLit:=FBars-trunc(0.5+FBars*dB(FMaxSample-FMinSample,FSample-FMinSample)
                         / db(FMaxSample-FMinSample,1));
    end
  else begin
    GetBarsLit:=trunc(0.5+FBars*(FSample-FMinSample)/(FMaxSample-FMinSample));
    end;
end;


procedure TLedGauge.SetGaugeKind(value:TGaugeOrientation);
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

procedure TLedGauge.SetPositive(value:boolean);
begin
  FPositive:=value;
end;

procedure TLedGauge.SetMaxSample(value:longint);
begin
  if value<>FMaxSample then begin
{    if value<FMinSample then
      raise EInvalidOperation.CreateResFmt(SOutOfRange, [FMinValue+1,MaxInt]);
}
    FMaxSample:=value;
    if FSample>value then FSample:=value;

    Refresh;
    end;
end;

procedure TLedGauge.SetMinSample(value:longint);
begin
  if value<>FMinSample then begin
{    if (value>FMaxSample) then
      raise EInvalidOperation.CreateResFmt(SOutOfRange, [-MaxInt,FMaxValue-1]);
}
    FMinSample:=value;
    if FSample<value then FSample:=value;

    Refresh;
    end;
end;

procedure TLedGauge.SetSample(value:longint);
var OldBarsLit:longint;
begin
  OldBarsLit:=GetBarsLit;

  if (FPositive) then value:=abs(value);

  if value<FMinSample then
    Value:=FMinSample
  else if value>FMaxSample then
    Value:=FMaxSample;

  if value<>FSample then begin
    FSample := value;

    if FDelay <> 0 then begin
      if GetBarsLit > FDelayedMax then begin
        FDelayedMax := GetBarsLit;
        if FDelayTimer = nil then
          FDelayTimer := TTimer.Create(Self)
        else
          FDelayTimer.Enabled := False;

        FDelayTimer.OnTimer := TimerExpired;
        FDelayTimer.Interval := FDelay;
        FDelayTimer.Enabled  := True;
        end;
      end;

    if OldBarsLit <>GetBarsLit then Refresh;
    end;

end;

procedure TLedGauge.SetRed(value:smallint);
begin
  if value<>FRed then begin
    FRed:=value;
    FBars:=FRed+FYellow+FGreen;
    Refresh;
    end;
end;

procedure TLedGauge.SetYellow(value:smallint);
begin
  if value<>FYellow then begin
    FYellow:=value;
    FBars:=FRed+FYellow+FGreen;
    Refresh;
    end;
end;

procedure TLedGauge.SetGreen(value:smallint);
begin
  if value<>FGreen then begin
    FGreen:=value;
    FBars:=FRed+FYellow+FGreen;
    Refresh;
    end;
end;

procedure TLedGauge.SetScale(value:TGaugeScaling);
begin
  if value<>FScale then begin
    FScale:=value;
    Refresh;
    end;
end;

procedure TLedGauge.SetDelay(value:longint);
begin
  if value<>FDelay then begin
    FDelay:=value;
    FDelayedMax:=0;
    if FDelayTimer<>nil then FDelayTimer.Enabled:=false;
    Refresh;
    end;
end;

procedure TLedGauge.Paint;
var i,n,xy:integer;
    c:TColor;
    wh:integer;
    r:TRect;
begin
  if (FBars<>0) then begin
    Canvas.Brush.Color:=Color;
    r.top:=0;
    r.left:=0;
    if FOrient=goHorizontal then begin
      r.bottom:=Height;
      wh:=(Width-1) div FBars;
      r.right:=wh*FBars+2;
      xy:=1;
      end
    else begin
      r.right:=Width;
      wh:=(Height-1) div FBars;
      r.bottom:=wh*FBars+2;
      xy:=wh*(FBars-1)+1;
      end;
    Canvas.FillRect(r);

    n:=GetBarsLit;
    for i:=1 to FBars do begin
      if i<=FGreen then
        c:=clLime
      else if i<=FGreen+FYellow then
        c:=clYellow
      else
        c:=clRed;

      if (i<>FDelayedMax) then begin
        if i>n then c := c and $555555;
        end;

      Canvas.Brush.Color := c;

      if FOrient=goHorizontal then begin
        r.top:=1;
        r.left:=xy;
        r.bottom:=Height-1;
        r.right:=xy+wh-1;
        inc(xy,wh);
        end
      else begin
        r.top:=xy;
        r.left:=1;
        r.bottom:=xy+wh-1;
        r.right:=width-1;
        dec(xy,wh);
        end;

      Canvas.FillRect(r);
      end;
    end;
end;

constructor TLedGauge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csFramed, csOpaque];

  FOrient:=goVertical;
  FScale:=gsDecibel;
  FMaxSample:=32767;
  FMinSample:=0;
  FSample:=0;
  FRed:=2;
  FYellow:=3;
  FGreen:=5;
  FBars:=FRed+FYellow+FGreen;

  FPositive:=true;
  Width := 20;
  Height := 10*FBars;
  Color := clBlack;
  FDelayTimer:=nil;
  FDelayedMax:=0;
end;

destructor TLedGauge.Destroy;
begin
  if FDelayTimer <> nil then
    FDelayTimer.Free;

  inherited Destroy;
end;

procedure TLedGauge.TimerExpired(Sender: TObject);
begin
  FDelayedMax:=GetBarsLit;

  if FDelayedMax=0 then FDelayTimer.Enabled := False;

  Refresh;
end;


{--------------------------------------------------------}

procedure TdBLabel.SetPositive(value:boolean);
begin
  FPositive:=value;
end;

procedure TdBLabel.Recaption;
begin
  Caption:=Format('%.1f dB', [dB(FSample-FMinSample,FMaxSample-FMinSample)]);
end;

procedure TdBLabel.SetMaxSample(value:longint);
begin
  if value<>FMaxSample then begin
{    if value<FMinSample then
      raise EInvalidOperation.CreateResFmt(SOutOfRange, [FMinValue+1,MaxInt]);
}
    FMaxSample:=value;
    if FSample>value then FSample:=value;

    Recaption;
    end;
end;

procedure TdBLabel.SetMinSample(value:longint);
begin
  if value<>FMinSample then begin
{    if (value>FMaxSample) then
      raise EInvalidOperation.CreateResFmt(SOutOfRange, [-MaxInt,FMaxValue-1]);
}
    FMinSample:=value;
    if FSample<value then FSample:=value;

    Recaption;
    end;
end;

procedure TdBLabel.SetSample(value:longint);
begin
  if (FPositive) then value:=abs(value);

  if value<FMinSample then
    Value:=FMinSample
  else if value>FMaxSample then
    Value:=FMaxSample;

  if value<>FSample then begin
    FSample := value;
    Recaption;
    end;

end;

constructor TdBLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FMaxSample:=32767;
  FMinSample:=0;
  FSample:=0;
  FPositive:=true;

  Color := clBlack;
  Font.Color := clLime;
  Font.Name := 'Arial';
  Font.Size := 11;
  Font.Style := [fsBold];
  Alignment := taRightJustify;
  Autosize:=false;
  Caption:='0.0 dB';
  Width:=56;
  Height:=18;
end;



procedure Register;
begin
  RegisterComponents('Custom', [TLedGauge, TDbLabel]);
end;

end.
