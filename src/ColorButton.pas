unit ColorButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, ImgList;

const clBrown      = TColor($325064);
      clCafeAuLait = TColor($ACCCE1);
      clCornFlower = TColor($FF0080);
      clTangerine  = TColor($71B8FF);
      clVioletRed  = TColor($8000FF);
      clMocha      = TColor($4985B6);
      clParchment  = TColor($BEEEFF);
      clOrange     = TColor($0080FF);
      clSeaFoam    = TColor($80FF00);
      clDkParchment= TColor($819FFF);

type
  TSaveUnderneathForm = class(TCustomForm)
  public
    property ActiveMDIChild;
    property ClientHandle;
    property DockManager;
    property MDIChildCount;
    property MDIChildren;
    property TileMode;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMNCHitTest(var Message:TWMNCHitTest); message WM_NCHITTEST;
  published
    property Action;
    property ActiveControl;
    property Align;
    property Anchors;
    property AutoScroll;
    property AutoSize;
    property BiDiMode;
    property BorderIcons;
    property BorderStyle;
    property BorderWidth;
    property Caption;
    property ClientHeight;
    property ClientWidth;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager;
    property DefaultMonitor;
    property DockSite;
    property DragKind;
    property DragMode;
    property Enabled;
    property ParentFont default False;
    property Font;
    property FormStyle;
    property Height;
    property HelpFile;
    property HorzScrollBar;
    property Icon;
    property KeyPreview;
    property Menu;
    property OldCreateOrder;
    property ObjectMenuItem;
    property ParentBiDiMode;
    property PixelsPerInch;
    property PopupMenu;
    property Position;
    property PrintScale;
    property Scaled;
    property ShowHint;
    property VertScrollBar;
    property Visible;
    property Width;
    property WindowState;
    property WindowMenu;
    property OnActivate;
    property OnCanResize;
    property OnClick;
    property OnClose;
    property OnCloseQuery;
    property OnConstrainedResize;
    property OnCreate;
    property OnDblClick;
    property OnDestroy;
    property OnDeactivate;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnHide;
    property OnHelp;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnPaint;
    property OnResize;
    property OnShortCut;
    property OnShow;
    property OnStartDock;
    property OnUnDock;
  end;

  TColorButton = class(TSpeedButton)
  private
    fColor,fTestColor:TColor;
    fAllowNone:boolean;
    fBorder:integer;
    iconbitmap:TBitmap;
    FDialogCaption:string;
    frm:TSaveUnderneathForm;
    fOnChange:TNotifyEvent;
    fOnDialog:TNotifyEvent;
    { Private declarations }
    procedure ColorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ColorKeyDown(Sender: TObject; var Key: Char);
    procedure NoneClick(Sender: TObject);
    procedure OtherClick(Sender: TObject);
  protected
    { Protected declarations }
    procedure SetAllowNone(allow:boolean);
    procedure SetColor(color:TColor);
    procedure SetBorder(m:integer);
    procedure UpdateGlyph;
    procedure CreateColorDialog;
    procedure CreateColorBitmaps;
    procedure SetDlgCaption(s:string);
    procedure WMPaletteChanged(var msg: TMessage); message WM_PALETTECHANGED;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Click; override;
    function GetPalette:HPALETTE; override;
  published
    { Published declarations }
    property AllowNone: Boolean read FAllowNone write SetAllowNone default False;
    property Color: TColor read FColor write SetColor default clBlack;
    property Border:integer read FBorder write SetBorder default 5;
    property DialogCaption:string read FDialogCaption write SetDlgCaption;
    property OnChange:TNotifyEvent read fOnChange write fOnChange;
    property OnDialog:TNotifyEvent read fOnDialog write fOnDialog;
  end;

  TPatternButton = class(TSpeedButton)
  private
    FImages: TCustomImageList;
    FImageChangeLink: TChangeLink;
    fPattern,fTestPattern:integer;
    fForegroundColor,fBackgroundColor:TColor;
    fBorder:integer;
    fDialogCaption:string;
    fMonochrome:boolean;
    fColumns,fRows:integer;
    fPatternWidth,fPatternHeight,fPatternBorder:integer;
    iconbitmap:TBitmap;
    frm:TSaveUnderneathForm;
    fOnChange:TNotifyEvent;
    fOnDialog:TNotifyEvent;
    { Private declarations }
    procedure PatternMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PatternKeyDown(Sender: TObject; var Key: Char);
    procedure SetImages(const Value: TCustomImageList);
    procedure ImageListChange(Sender: TObject);
    procedure UpdateDialogBitmap;
    procedure UpdateGlyph;
    procedure CreatePatternDialog;
    procedure CreatePatternBitmaps;
    function GetPatternEntry(x,y:integer):integer;
  protected
    { Protected declarations }
    procedure SetForegroundColor(color:TColor);
    procedure SetBackgroundColor(color:TColor);
    procedure SetMonochrome(m:boolean);
    procedure SetColumns(n:integer);
    procedure SetRows(n:integer);
    procedure SetPattern(n:integer);
    procedure SetBorder(m:integer);
    procedure SetDlgCaption(s:string);
    procedure SetPatternWidth(n:integer);
    procedure SetPatternHeight(n:integer);
    procedure SetPatternBorder(n:integer);
    function InvalidPattern(n:integer):boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    function Bitmap:TBitmap;
    function GetBitmap(n:integer):TBitmap;
    function GetMonochromeBitmap(n:integer):TBitmap;
  published
    { Published declarations }
    property Pattern: integer read fPattern write SetPattern default 0;
    property ForegroundColor: TColor read FForegroundColor write SetForegroundColor default clBlack;
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor default clWhite;
    property Border:integer read FBorder write SetBorder default 5;
    property DialogCaption:string read FDialogCaption write SetDlgCaption;
    property OnChange:TNotifyEvent read fOnChange write fOnChange;
    property OnDialog:TNotifyEvent read fOnDialog write fOnDialog;
    property Monochrome:boolean read fMonochrome write SetMonochrome default true;
    property Columns:integer read fColumns write SetColumns default 10;
    property Rows:integer read fRows write SetRows default 10;
    property Images: TCustomImageList read FImages write SetImages;
    property PatternWidth:integer read fPatternWidth write SetPatternWidth default 32;
    property PatternHeight:integer read fPatternHeight write SetPatternHeight default 32;
    property PatternBorder:integer read fPatternBorder write SetPatternBorder default 5;
  end;


procedure Register;
function CreateFreshPalette:HPALETTE;
function IsPaletteDevice:boolean;

implementation

uses CommCtrl;

const btnmargin=32;
      btnheight=24;
      btnwidth=75;
      cols=10;
      standard_rows=12;
      rows=14;

var CustomColor:array[0..cols*2-1] of TColor;
    hPal:HPALETTE;
    NeedToDeterminePalette,IsPaletteDev:boolean;


function GetColorEntry(col,row:integer):TColor;
const colortable:array[0..standard_rows-1] of TColor =
      (clGray,
       clDkParchment,
       clMocha,
       clRed,
       clVioletRed,
       clFuchsia,
       clOrange,
       clYellow,
       clLime,
       clAqua,
       clCornFlower,
       clBlue);

const dilute:array[boolean, 0..cols-1] of integer=
      ((200, 180, 160, 140, 120, 100, 80, 60, 40, 0),
       (165, 157, 139, 121, 100, 88,  76, 64, 52, 40));

var rgb,r,g,b,percent:integer;
begin
  if (row>High(colortable)) then begin
    Result:=CustomColor[col+(row-High(colortable)-1)*cols];
    if (Result=clNone) then Result:=clBtnFace;
    exit;
    end;

  rgb :=ColorToRGB(colortable[row]);

  r := (rgb and $FF);
  g := (rgb and $FF00) shr 8;
  b := (rgb and $FF0000) shr 16;

  percent := dilute[row<>0, col];
  r:=(r*percent) div 100;
  g:=(g*percent) div 100;
  b:=(b*percent) div 100;

  if (percent>=100) then begin
    percent:=((percent-100)*255) div 100;
    if (r=0) then r:=percent;
    if (g=0) then g:=percent;
    if (b=0) then b:=percent;
    end;

  if (r>$FF) then r:=$FF;
  if (g>$FF) then g:=$FF;
  if (b>$FF) then b:=$FF;

  if (rgb = $000000) then begin
    Result:=clBtnFace;
    end
  else begin
    rgb := r or (g shl 8) or (b shl 16);
    Result:=TColor(rgb);
    end;
end;

procedure FillLogPalette(var LogPal:TMaxLogPalette);
var colorindex,column:integer;
    c:TColor;
    n:integer;
begin
  n:=0;
  LogPal.palVersion := $300;

  for colorindex:=0 to standard_rows-1 do begin
    for column:=0 to cols-1 do begin
      c:=GetColorEntry(column,colorindex);
      LogPal.palPalEntry[n].peRed  := (c and $FF);
      LogPal.palPalEntry[n].peGreen:= (c and $FF00) shr 8;
      LogPal.palPalEntry[n].peBlue := (c and $FF0000) shr 16;
      LogPal.palPalEntry[n].peFlags:= 0;
      inc(n);
      end;
    end;
  LogPal.palNumEntries := n;
end;

function CreateFreshPalette:HPALETTE;
var LogPal: TMaxLogPalette;
begin
  FillLogPalette(LogPal);
  Result:=CreatePalette(PLogPalette(@LogPal)^);
end;

function IsPaletteDevice:boolean;
var DC:HDC;
begin
  if NeedToDeterminePalette then begin
    dc:=GetDC(0);
    IsPaletteDev:=(GetDeviceCaps(dc,RASTERCAPS) and RC_PALETTE)<>0;
    ReleaseDC(0,dc);
    end;
  Result:=IsPaletteDev;
end;

{--------------------------------------------------------------------}

procedure TSaveUnderneathForm.CreateParams(var Params: TCreateParams);
begin
  // We set CS_SAVEBITS so we don't have to repaint the display after
  // this dialog comes up.
  inherited CreateParams(Params);
  with Params.WindowClass do
    style := style or CS_SAVEBITS;
end;

procedure TSaveUnderneathForm.WMNCHitTest(var Message:TWMNCHitTest);
var kind:integer;
    mousekey:integer;
begin
  kind:=DefWindowProc(Handle,Message.Msg,Message.Unused,Integer(Message.Pos));
  // Supress the default action for the mouse movement over the close button:
  // this generates a popup "Close" hint, which, although it shouldn't interfere
  // with the SAVEBITS style, actually invalidates the bitmap saved underneath
  // our dialog.  By disabling the Close tooltip, we won't have to repaint
  // (just like we specified that we wanted with the CS_SAVEBITS style).
  if kind<>HTCLOSE then
     inherited
  else begin
    // Because we don't let the default action happen, we have to interpret
    // the close action ourself by determining if they've clicked on close.
    // We check to see if the mouse button is down (but they may be swapped,
    // so we have to check that too).
    if GetSystemMetrics(SM_SWAPBUTTON)<>0 then mousekey:=VK_RBUTTON else mousekey:=VK_LBUTTON;
    if GetAsyncKeyState(mousekey)<0 then Close;
    end;
end;

{--------------------------------------------------------------------}


constructor TColorButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AllowAllUp:=true;
  fAllowNone := false;
  fColor := clBlack;
  fDialogCaption:='';
  fBorder:=5;
  UpdateGlyph;
  fOnChange:=nil;
  fOnDialog:=nil;
end;

procedure TColorButton.SetDlgCaption(s:string);
begin
  if (s<>fDialogCaption) then begin
    fDialogCaption:=s;
    end;
end;

procedure TColorButton.SetAllowNone(allow:boolean);
begin
  if allow<>fAllowNone then begin
    if (Down) then begin
      Down:=false;
      fAllowNone:=allow;
      Down:=true;
      end
    else
      fAllowNone:=allow;
    end;
end;

procedure TColorButton.WMPaletteChanged(var msg: TMessage);
begin
  NeedToDeterminePalette:=true;
end;

procedure TColorButton.SetBorder(m:integer);
begin
  if (fBorder<>m) then begin
    fBorder:=m;
    UpdateGlyph;
    end;
end;

procedure TColorButton.SetColor(color:TColor);
begin
  if color<>fColor then begin
    fColor:=color;
    UpdateGlyph;
    end;
  if Assigned(fOnChange) then fOnChange(self);
end;

procedure TColorButton.UpdateGlyph;
var newcolor:TBitmap;
    w,h:integer;
begin
  Glyph.FreeImage;     // Added from resource trace
  newcolor:=TBitmap.Create;
  w:=Width-fBorder;
  h:=Height-fBorder;
  newcolor.Width:=w;
  newcolor.Height:=h;
  if IsPaletteDevice then begin
    newcolor.HandleType:=bmDIB;
    newcolor.Palette:=CreateFreshPalette;
    end;
  newcolor.Canvas.Brush.Color:=clBtnFace;
  newcolor.Canvas.FillRect(Rect(0,0,w,h));
  if (Color=clNone) then begin
    newcolor.Canvas.Pen.Color:=clBtnText;
    newcolor.Canvas.Rectangle(1,1,w-2,h-2);
    newcolor.Canvas.MoveTo(1,1);
    newcolor.Canvas.LineTo(w-2,h-2);
    newcolor.Canvas.MoveTo(w-2,1);
    newcolor.Canvas.LineTo(1,h-2);
    end
  else begin
    newcolor.Canvas.Brush.Color:=Color;
    newcolor.Canvas.FillRect(Rect(1,1,w-2,h-2));
    if (Color=clBlack) then
      newcolor.Canvas.Pen.Color:=clWhite
    else
      newcolor.Canvas.Pen.Color:=clBlack;

    newcolor.Canvas.Rectangle(1,1,w-2,h-2);
    end;
  Glyph:=newcolor;
  newcolor.Free;
end;

function TColorButton.GetPalette:HPALETTE;
var LogPal: TMaxLogPalette;
begin
  if (hPal<>0) then begin
    Result:=hPal;
    exit;
    end;

  FillLogPalette(LogPal);
  hPal := CreatePalette(PLogPalette(@LogPal)^);
  Result:=hPal;
end;

procedure TColorButton.CreateColorBitmaps;
var w,h:integer;
    colorindex,column:integer;
    x1,y1,x2,y2:integer;
    c:TColor;
begin
  if iconbitmap<>nil then exit;

  w:=Width-fBorder;
  h:=Height-fBorder;

  iconbitmap:=TBitmap.Create;
  iconbitmap.Width := w*cols;
  iconbitmap.Height:= h*rows;
  if IsPaletteDevice then begin
    iconbitmap.HandleType:=bmDIB;
    iconbitmap.Palette:=CreateFreshPalette;
    end;

  for colorindex:=0 to rows-1 do begin
    for column:=0 to cols-1 do begin
      c:=GetColorEntry(column,colorindex);
      iconbitmap.Canvas.Brush.Color:=c;
      x1:=column*w;
      y1:=colorindex*h;
      x2:=x1+w;
      y2:=y1+h;
      iconbitmap.Canvas.FillRect(Rect(x1,y1,x2,y2));
      if (c=fColor) then begin
        iconbitmap.Canvas.Pen.Color:=clBlack;
        iconbitmap.Canvas.Rectangle(x1,y1,x2,y2);
        iconbitmap.Canvas.Pen.Color:=clWhite;
        iconbitmap.Canvas.Rectangle(x1+1,y1+1,x2-1,y2-1);
        end;
      end;
    end;
end;

procedure TColorButton.ColorMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var c:TColor;
begin
  x:=x div (Width-fBorder);
  y:=y div (Height-fBorder);
  c:=GetColorEntry(x,y);
  if (c=clNone) then begin
    OtherClick(Sender);
    end
  else begin
    fTestColor:=c;
    frm.ModalResult:=mrOk;
    end;
end;

procedure TColorButton.ColorKeyDown(Sender: TObject; var Key: Char);
begin
  case Key of
    #27: begin
           Key:=#0;
           frm.ModalResult:=mrCancel;
         end;
    end;
end;

procedure TColorButton.NoneClick(Sender: TObject);
begin
  fTestColor:=clNone;
  frm.ModalResult:=mrOk;
end;

procedure TColorButton.OtherClick(Sender: TObject);
var colordialog:TColorDialog;
    i,n:integer;
    color:cardinal;
    s:string;
    ch:char;
begin
  colordialog:=TColorDialog.Create(frm);
  colordialog.Color:=fColor;
  colordialog.Options:=[cdFullOpen, cdAnyColor];

  ch:='A';
  for i:=Low(CustomColor) to High(CustomColor) do begin
    if (CustomColor[i]<>clNone) then begin
      colordialog.CustomColors.Add('Color'+ch+'='+IntToHex(CustomColor[i],6));
      inc(ch);
      end;
    end;

  if colordialog.Execute then begin
    fTestColor:=colordialog.Color;
    frm.ModalResult:=mrOk;
    for i:=0 to High(CustomColor) do CustomColor[i]:=clNone;
    n:=0;
    for i:=0 to colordialog.CustomColors.Count-1 do begin
      s:=colordialog.CustomColors.Strings[i];
      delete(s,1,pos('=',s));
      color := StrToInt('$'+s);
      if (color<>$FFFFFFFF) then begin
        CustomColor[n]:=color;
        inc(n);
        end;
      end;
    end;
  colordialog.Free;
end;

procedure TColorButton.CreateColorDialog;
var custombtn:TButton;
    nonebtn:TButton;
    img:TImage;
    pic:TPicture;
    p:TPoint;
begin
  CreateColorBitmaps;
  frm:=TSaveUnderneathForm.CreateNew(self);
  frm.Width:=iconbitmap.Width + GetSystemMetrics(SM_CXBORDER)*3;
  frm.Height:=btnmargin + iconbitmap.Height +
              GetSystemMetrics(SM_CYBORDER)*3 +
              GetSystemMetrics(SM_CYCAPTION);
  p:=ClientToScreen(Point(0,Height));
  frm.Top:=p.Y;
  frm.Left:=p.X;
  if (frm.Top + frm.Height > Screen.Height) then begin
    frm.Top := Screen.Height - frm.Height;
    end;
  if (frm.Left + frm.Width > Screen.Width) then begin
    frm.Left := Screen.Width - frm.Width;
    end;
  frm.BorderStyle:=bsToolWindow;
  frm.Caption:=fDialogCaption;
  frm.KeyPreview:=true;
  frm.OnKeyPress:=ColorKeyDown;

  pic:=TPicture.Create;
  pic.Bitmap:=iconbitmap;

  img:=TImage.Create(frm);
  img.Autosize:=true;
  img.Top:=btnmargin;
  img.Left:=0;
  img.Picture:=Pic;
  img.Parent:=frm;
  img.OnMouseUp:=ColorMouseUp;

  custombtn:=TButton.Create(frm);
  customBtn.Top:=(btnmargin-btnheight) div 2;
  customBtn.Left:=0;
  customBtn.Width:=btnwidth;
  customBtn.Height:=btnheight;
  customBtn.Caption:='&Custom...';
  customBtn.OnClick:=OtherClick;
  customBtn.Parent:=frm;

  if AllowNone then begin
    nonebtn:=TButton.Create(frm);
    nonebtn.Top:=(btnmargin-btnheight) div 2;
    nonebtn.Left:=frm.Width div 2;
    nonebtn.Width:=btnwidth;
    nonebtn.Height:=btnheight;
    nonebtn.Caption:='&No Color';
    nonebtn.OnClick:=NoneClick;
    nonebtn.Parent:=frm;
    end;

  fTestColor:=fColor;

  if Assigned(fOnDialog) then fOnDialog(self);

  if frm.ShowModal=mrOk then SetColor(fTestColor);

  img.Free;
  pic.Free;
  frm.Free;
  iconbitmap.Free;
  iconbitmap:=nil;
end;

procedure TColorButton.Click;
begin
  Down:=true;
  CreateColorDialog;
  Down:=false;
end;

{------------------------------------------------------------------------}

{$DEFINE AVOIDING_TBRUSH}

constructor TPatternButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AllowAllUp:=true;
  fForegroundColor := clBlack;
  fBackgroundColor := clWhite;
  fMonochrome := true;
  fPattern:=0;
  fDialogCaption:='';
  fColumns:=10;
  fRows:=10;
  fBorder:=5;
  UpdateGlyph;
  fPatternWidth:=32;
  fPatternHeight:=32;
  fPatternBorder:=5;
  fOnChange:=nil;
  fOnDialog:=nil;
  FImages:=nil;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
end;

destructor TPatternButton.Destroy;
begin
  FImageChangeLink.Free;
  inherited Destroy;
end;


procedure TPatternButton.ImageListChange(Sender: TObject);
begin
  if (Sender = Images) then begin
    UpdateGlyph;
    UpdateDialogBitmap;
    if Assigned(fOnChange) then fOnChange(self);
    end;
end;

procedure TPatternButton.SetImages(const Value: TCustomImageList);
begin
  if FImages <> nil then FImages.UnRegisterChanges(FImageChangeLink);

  FImages := Value;

  if FImages <> nil then begin
    FImages.RegisterChanges(FImageChangeLink);
    FImages.FreeNotification(Self);
    end
  else
    UpdateGlyph;
end;

function TPatternButton.InvalidPattern(n:integer):boolean;
begin
  Result:=(ForegroundColor=clNone) or (BackgroundColor=clNone)
          or (FImages=nil) or (n<0) or (n>=FImages.Count);
end;

function TPatternButton.GetMonochromeBitmap(n:integer):TBitmap;
begin
  Result:=TBitmap.Create;
  Result.Monochrome:=true;
  if (FImages<>nil) and (n>=0) and (n<FImages.Count) then begin
    Result.Width:=FImages.Width;
    Result.Height:=FImages.Height;
    FImages.GetBitmap(n,Result);
    end
  else begin
    Result.Width:=8;
    Result.Height:=8;
    Result.Canvas.Brush.Color:=clBtnFace;
    Result.Canvas.FillRect(Rect(0,0,Result.Width,Result.Height));
    end;
end;

function TPatternButton.GetBitmap(n:integer):TBitmap;
var bits:TBitmap;
begin
  Result:=TBitmap.Create;

  if not InvalidPattern(n) then begin
    Result.Width:=FImages.Width;
    Result.Height:=FImages.Height;

    if IsPaletteDevice then begin
      Result.HandleType:=bmDIB;
      Result.Palette:=CreateFreshPalette;
      end;

    if Monochrome then begin
      bits:=GetMonochromeBitmap(n);

      Result.Canvas.Brush.Color:=BackgroundColor;
      Result.Canvas.Font.Color:=ForegroundColor;
      Result.Canvas.Draw(0,0, bits);

      bits.Free;
      end
    else begin
      FImages.GetBitmap(n,Result);
      end;
    end
  else begin
    Result.Width:=8;
    Result.Height:=8;
    Result.Canvas.Brush.Color:=clBtnFace;
    Result.Canvas.FillRect(Rect(0,0,Result.Width,Result.Height));
    end;
end;

function TPatternButton.Bitmap:TBitmap;
begin
  Result:=GetBitmap(Pattern);
end;

procedure TPatternButton.SetDlgCaption(s:string);
begin
  if (s<>fDialogCaption) then begin
    fDialogCaption:=s;
    end;
end;

procedure TPatternButton.UpdateDialogBitmap;
begin
  if iconbitmap<>nil then begin
    iconbitmap.Free;
    iconbitmap:=nil;
    CreatePatternBitmaps;
    end;
end;

procedure TPatternButton.SetMonochrome(m:boolean);
begin
  if (fMonochrome<>m) then begin
    fMonochrome:=m;
    UpdateGlyph;
    UpdateDialogBitmap;
    if Assigned(fOnChange) then fOnChange(self);
    end;
end;

procedure TPatternButton.SetBorder(m:integer);
begin
  if (fBorder<>m) then begin
    fBorder:=m;
    UpdateGlyph;
//    if Assigned(fOnChange) then fOnChange(self);
    end;
end;

procedure TPatternButton.SetPatternBorder(n:integer);
begin
  if (fPatternBorder<>n) then begin
    fPatternBorder:=n;
    UpdateDialogBitmap;
    end;
end;

procedure TPatternButton.SetPatternWidth(n:integer);
begin
  if (fPatternWidth<>n) then begin
    fPatternWidth:=n;
    UpdateDialogBitmap;
    end;
end;

procedure TPatternButton.SetPatternHeight(n:integer);
begin
  if (fPatternHeight<>n) then begin
    fPatternHeight:=n;
    UpdateDialogBitmap;
    end;
end;

procedure TPatternButton.SetColumns(n:integer);
begin
  if (fColumns<>n) then begin
    fColumns:=n;
    UpdateDialogBitmap;
    end;
end;

procedure TPatternButton.SetRows(n:integer);
begin
  if (fRows<>n) then begin
    fRows:=n;
    UpdateDialogBitmap;
    end;
end;

procedure TPatternButton.SetPattern(n:integer);
begin
  if (fPattern<>n) then begin
    fPattern:=n;
    UpdateGlyph;
    UpdateDialogBitmap;
    end;
  if Assigned(fOnChange) then fOnChange(self);
end;

procedure TPatternButton.SetForegroundColor(color:TColor);
begin
  if color<>fForeGroundColor then begin
    fForeGroundColor:=color;
    UpdateGlyph;
    UpdateDialogBitmap;
//    if Assigned(fOnChange) then fOnChange(self);
    end;
end;

procedure TPatternButton.SetBackgroundColor(color:TColor);
begin
  if color<>fBackGroundColor then begin
    fBackGroundColor:=color;
    UpdateGlyph;
    UpdateDialogBitmap;
//    if Assigned(fOnChange) then fOnChange(self);
    end;
end;

function TPatternButton.GetPatternEntry(x,y:integer):integer;
begin
  Result:=x+y*Columns;
  if (Result>=FImages.Count) then Result:=-1;
end;

procedure TPatternButton.UpdateGlyph;
var newPattern:TBitmap;
    brushbmp:TBitmap;
    w,h:integer;
begin
  Glyph.FreeImage;     // Added from resource trace
  newPattern:=TBitmap.Create;
  w:=Width-fBorder;
  h:=Height-fBorder;
  newPattern.Width:=w;
  newPattern.Height:=h;
  newPattern.Canvas.Brush.Color:=clBtnFace;
  newPattern.Canvas.FillRect(Rect(0,0,w,h));
  if not InvalidPattern(Pattern) then begin
    brushbmp:=Bitmap;
    newPattern.Canvas.Pen.Color := ForeGroundColor;
    newPattern.Canvas.Brush.Bitmap := brushbmp;
    newPattern.Canvas.RoundRect(1,1,w-2,h-2,w div 2,h div 2);
    brushbmp.Free;
    end;

  Glyph:=newPattern;
  newpattern.Free;    // Added from resource trace
end;

procedure TPatternButton.CreatePatternBitmaps;
var w,h:integer;
    r,c:integer;
    i,j:integer;
    x1,y1,x2,y2:integer;
    e:integer;
    bitmap,bits:TBitmap;
{$IFDEF AVOIDING_TBRUSH}
    BrushHandle:HGDIOBJ;
{$ENDIF}
begin
  if iconbitmap<>nil then exit;

  w:=PatternWidth;
  h:=PatternHeight;

  iconbitmap:=TBitmap.Create;
  iconbitmap.Width := w*columns+PatternBorder;
  iconbitmap.Height:= h*rows+PatternBorder;
  if IsPaletteDevice then begin
    iconbitmap.HandleType := bmDIB;
    iconbitmap.Palette:=CreateFreshPalette;
    end;

  iconbitmap.Canvas.Brush.Style:=bsSolid;
  iconbitmap.Canvas.Brush.Color:=Color;
  iconbitmap.Canvas.Rectangle(0,0,iconbitmap.Width,iconbitmap.Height);

  bitmap:=TBitmap.Create;
  bitmap.Width := FImages.Width;
  bitmap.Height:= FImages.Height;
  if IsPaletteDevice then begin
    bitmap.HandleType:=bmDIB;
    bitmap.Palette:=CreateFreshPalette;
    end;
  bitmap.Canvas.Brush.Color:=BackgroundColor;
  bitmap.Canvas.Font.Color:=ForegroundColor;

  e:=0;
  for r:=0 to rows-1 do begin
    for c:=0 to columns-1 do begin
      if (e<>-1) then begin
        if Monochrome then begin
          bits:=GetMonochromeBitmap(e);
          bitmap.Canvas.Draw(0,0, bits);
          bits.Free;
          end
        else begin
          FImages.GetBitmap(e,bitmap);
          end;

{$IFDEF AVOIDING_TBRUSH}
        BrushHandle:=CreatePatternBrush(bitmap.Handle);
        iconbitmap.Canvas.Brush.Handle := BrushHandle;
{$ELSE}
        iconbitmap.Canvas.Brush.Bitmap:=bitmap;
{$ENDIF}
        x1:=c*w + PatternBorder;
        y1:=r*h + PatternBorder;
        x2:=x1+w - PatternBorder;
        y2:=y1+h - PatternBorder;

        for i:=0 to (w div 8) do for j:=0 to (h div 8) do
          iconbitmap.Canvas.Draw(x1+i*8,y1+j*8,bitmap);

//      iconbitmap.Canvas.FillRect(Rect(x1,y1,x2,y2));

        if (e=fPattern) then begin
          iconbitmap.Canvas.Brush.Style:=bsClear;
          iconbitmap.Canvas.Pen.Color:=clBlack;
          iconbitmap.Canvas.Rectangle(x1,y1,x2,y2);
          iconbitmap.Canvas.Pen.Color:=clWhite;
          iconbitmap.Canvas.Rectangle(x1+1,y1+1,x2-1,y2-1);
          end;
{$IFDEF AVOIDING_TBRUSH}
        iconbitmap.Canvas.Brush.Handle:=0;
        DeleteObject(BrushHandle);
{$ENDIF}
        end;
      inc(e);
      if (e>=FImages.Count) then e:=-1;
      end;
    end;

  bitmap.Free;
end;

procedure TPatternButton.PatternMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  x:=x div PatternWidth;
  y:=y div PatternHeight;
  fTestPattern:=GetPatternEntry(x,y);
  frm.ModalResult:=mrOk;
end;

procedure TPatternButton.PatternKeyDown(Sender: TObject; var Key: Char);
begin
  case Key of
    #27: begin
           Key:=#0;
           frm.ModalResult:=mrCancel;
         end;
    end;
end;

procedure TPatternButton.CreatePatternDialog;
var img:TImage;
    pic:TPicture;
    p:TPoint;
    DialogResult:integer;
begin
  CreatePatternBitmaps;
  frm:=TSaveUnderneathForm.CreateNew(self);
  frm.Width:=iconbitmap.Width + GetSystemMetrics(SM_CXBORDER)*3;
  frm.Height:=iconbitmap.Height +
              GetSystemMetrics(SM_CYBORDER)*3 +
              GetSystemMetrics(SM_CYCAPTION);
  p:=ClientToScreen(Point(0,Height));
  frm.Top:=p.Y;
  frm.Left:=p.X;
  if (frm.Top + frm.Height > Screen.Height) then begin
    frm.Top := Screen.Height - frm.Height;
    end;
  if (frm.Left + frm.Width > Screen.Width) then begin
    frm.Left := Screen.Width - frm.Width;
    end;
  frm.BorderStyle:=bsToolWindow;
  frm.Caption:=fDialogCaption;
  frm.KeyPreview:=true;
  frm.OnKeyPress:=PatternKeyDown;

  pic:=TPicture.Create;
  pic.Bitmap:=iconbitmap;

  img:=TImage.Create(frm);
  img.Autosize:=true;
  img.Top:=0;
  img.Left:=0;
  img.Picture:=Pic;
  img.Parent:=frm;
  img.OnMouseUp:=PatternMouseUp;

  fTestPattern:=fPattern;

  if Assigned(fOnDialog) then fOnDialog(self);

  DialogResult:=frm.ShowModal;

  iconbitmap.Free;
  iconbitmap:=nil;

  if DialogResult=mrOk then SetPattern(fTestPattern);

  img.Free;
  pic.Free;
  frm.Free;
end;

procedure TPatternButton.Click;
begin
  if not InvalidPattern(0) then begin
    Down:=true;
    CreatePatternDialog;
    Down:=false;
    end;
end;

{------------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents('Custom', [TColorButton,TPatternButton, TSaveUnderneathForm]);
end;

procedure InitializeCustomColors;
var i:integer;
begin
  for i:=Low(CustomColor) to High(CustomColor) do CustomColor[i]:=clNone;
  hPal:=0;
  NeedToDeterminePalette:=true;
end;

initialization
  InitializeCustomColors;
finalization
  if (hPal<>0) then DeleteObject(hPal);
end.
