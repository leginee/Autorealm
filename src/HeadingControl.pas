unit HeadingControl;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Graphics;

type
  THeadingControl = Class(TCustomControl)
  Private
    { Private declarations }
    FEdit               : TEdit;
    FEditChanging       : Boolean;
    FOnChange           : TNotifyEvent;
    FAddOnChange        : TNotifyEvent;
    FRingWidth          : Integer;
    FCompassColor       : TColor;
    FCompassColor45     : TColor;
    FAngleColor         : TColor;
    FAngleTextColor     : TColor;
    FNumDivisions       : Integer;
    FPressedButton      : Integer;
    FAngle              : Double;
    FLeftButtonDown     : Boolean;
    FShowVector         : Boolean;
    FShowDot            : Boolean;
    FbtnAdd1            : TButton;
    FbtnSub1            : TButton;
    FbtnAdd5            : TButton;
    FbtnSub5            : TButton;
    FShowAddButtons     : Boolean;
    FButtonSize         : Integer;
    FCenterPressed      : Boolean;
    FCanSetNumDivisions : Boolean;
    FDarkenAmount       : Double;
    FShowAngleText      : Boolean;
    FShowEditor         : Boolean;
    FShowPosNeg         : Boolean;
    Procedure   AdjustSize(Var W, H: Integer); Reintroduce;
    Procedure   WMSize(Var Message: TWMSize); Message WM_SIZE;
  protected
    { Protected declarations }
    Procedure   EditChange(Sender: TObject);
    Procedure   btnAdd1Click(Sender: TObject);
    Procedure   btnSub1Click(Sender: TObject);
    Procedure   btnAdd5Click(Sender: TObject);
    Procedure   btnSub5Click(Sender: TObject);
    Procedure   SetEnabled(Value: Boolean); Override;
    Function    GetCtl3D: Boolean;
    Procedure   SetCtl3D(B: Boolean);
    Procedure   Paint; Override;
    Procedure   SetRingWidth(I: Integer);
    Procedure   SetCompassColor(C: TColor);
    Procedure   SetCompassColor45(C: TColor);
    Procedure   SetAngleColor(C: TColor);
    Procedure   SetAngleTextColor(C: TColor);
    Procedure   SetNumDivisions(I: Integer);
    Procedure   SetAngle(D: Double);
    Procedure   PaintButton(I: Integer; Canvas: TCanvas);
    Procedure   DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure   DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    Procedure   DoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    Function    HandlePosNeg(A: Double): Double;
    Procedure   SetPressedButton(I: Integer);
    Procedure   SetShowVector(B: Boolean);
    Procedure   SetShowDot(B: Boolean);
    Procedure   SetShowAddButtons(B: Boolean);
    Procedure   SetButtonSize(I: Integer);
    Procedure   SetCanSetNumDivisions(B: Boolean);
    Procedure   SetDarkenAmount(D: Double);
    Procedure   SetShowAngleText(B: Boolean);
    Procedure   SetShowEditor(B: Boolean);
    Procedure   SetShowPosNeg(B: Boolean);
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); Override;
    Procedure   SetBounds(ALeft, ATop, AWidth, AHeight: Integer); Override;
  published
    { Published declarations }
    Property    Align;
    Property    Anchors;
    Property    Enabled;
    Property    Text;
    Property    Visible;
    Property    Color;
    Property    ShowHint;
    Property    OnChange           : TNotifyEvent Read FOnChange           Write FOnChange;
    Property    OnAddChange        : TNotifyEvent Read FAddOnChange        Write FAddOnChange;
    Property    Ctl3D              : Boolean      Read GetCtl3D            Write SetCtl3D;
    Property    RingWidth          : Integer      Read FRingWidth          Write SetRingWidth;
    Property    CompassColor       : TColor       Read FCompassColor       Write SetCompassColor;
    Property    CompassColor45     : TColor       Read FCompassColor45     Write SetCompassColor45;
    Property    AngleColor         : TColor       Read FAngleColor         Write SetAngleColor;
    Property    AngleTextColor     : TColor       Read FAngleTextColor     Write SetAngleTextColor;
    Property    NumDivisions       : Integer      Read FNumDivisions       Write SetNumDivisions;
    Property    Angle              : Double       Read FAngle              Write SetAngle;
    Property    ShowVector         : Boolean      Read FShowVector         Write SetShowVector;
    Property    ShowDot            : Boolean      Read FShowDot            Write SetShowDot;
    Property    ShowAddButtons     : Boolean      Read FShowAddButtons     Write SetShowAddButtons;
    Property    ButtonSize         : Integer      Read FButtonSize         Write SetButtonSize;
    Property    CanSetNumDivisions : Boolean      Read FCanSetNumDivisions Write SetCanSetNumDivisions;
    Property    DarkenAmount       : Double       Read FDarkenAmount       Write SetDarkenAmount;
    Property    ShowAngleText      : Boolean      Read FShowAngleText      Write SetShowAngleText;
    Property    ShowEditor         : Boolean      Read FShowEditor         Write SetShowEditor;
    Property    ShowPosNeg         : Boolean      Read FShowPosNeg         Write SetShowPosNeg;
  end;

procedure Register;

implementation

Uses Math,Forms,Dialogs;

Const
  MinSize               = 32;
  MinRingWidth          = 6;

  DefEditWidth          = 48;
  DefButtonSize         = 20;
  DefWidth              = 32;
  DefHeight             = 56;
  DefRingWidth          = 8;
  DefCompassColor       = $8080FF;
  DefCompassColor45     = $80FF80;
  DefAngleColor         = clBlack;
  DefAngleTextColor     = clBlack;
  DefNumDivisions       = 4;
  DefAngle              = 0;
  DefDarkenAmount       = 0.8;
  DefShowAngleText      = False;
  DefShowVector         = True;
  DefShowDot            = False;
  DefShowEditor         = True;
  DefShowPosNeg         = False;
  DefShowAddButtons     = True;
  DefCanSetNumDivisions = True;

Constructor THeadingControl.Create(AOwner: TComponent);
Var W, H: Integer;
Begin
  Inherited Create(AOwner);
  ControlStyle           := ControlStyle - [csAcceptsControls, csSetCaption] + [csFramed, csOpaque];
  FShowAddButtons        := DefShowAddButtons;
  FShowEditor            := DefShowEditor;

  FEdit                  := TEdit.Create(Self);
  FEdit.Visible          := FShowEditor;
  FEdit.Enabled          := True;
  FEdit.Parent           := Self;

  FbtnAdd1               := TButton.Create(Self);
  FbtnAdd1.Visible       := FShowAddButtons;
  FbtnAdd1.Enabled       := True;
  FbtnAdd1.Parent        := Self;
  FbtnAdd1.Caption       := '+1';
  FbtnAdd1.OnClick       := btnAdd1Click;

  FbtnSub1               := TButton.Create(Self);
  FbtnSub1.Visible       := FShowAddButtons;
  FbtnSub1.Enabled       := True;
  FbtnSub1.Parent        := Self;
  FbtnSub1.Caption       := '-1';
  FbtnSub1.OnClick       := btnSub1Click;

  FbtnAdd5               := TButton.Create(Self);
  FbtnAdd5.Visible       := FShowAddButtons;
  FbtnAdd5.Enabled       := True;
  FbtnAdd5.Parent        := Self;
  FbtnAdd5.Caption       := '+5';
  FbtnAdd5.OnClick       := btnAdd5Click;

  FbtnSub5               := TButton.Create(Self);
  FbtnSub5.Visible       := FShowAddButtons;
  FbtnSub5.Enabled       := True;
  FbtnSub5.Parent        := Self;
  FbtnSub5.Caption       := '-5';
  FbtnSub5.OnClick       := btnSub5Click;

  ParentCtl3D            := False;
  Ctl3D                  := False;
  FEdit.Ctl3D            := True;
  Width                  := DefWidth;
  Height                 := DefHeight;
  FRingWidth             := DefRingWidth;
  FOnChange              := Nil;
  FAddOnChange           := Nil;
  FCompassColor          := DefCompassColor;
  FCompassColor45        := DefCompassColor45;
  FAngleColor            := DefAngleColor;
  FAngleTextColor        := DefAngleTextColor;
  FNumDivisions          := DefNumDivisions;
  FPressedButton         := -1;
  FAngle                 := DefAngle;
  OnMouseDown            := DoMouseDown;
  OnMouseUp              := DoMouseUp;
  OnMouseMove            := DoMouseMove;
  FEdit.Width            := DefEditWidth;
  FLeftButtonDown        := False;
  Color                  := clBtnFace;
  FEdit.OnChange         := EditChange;
  FShowVector            := DefShowVector;
  FShowDot               := DefShowDot;
  FButtonSize            := DefButtonSize;
  FEdit.Text             := FloatToStr(FAngle);
  FCenterPressed         := False;
  FCanSetNumDivisions    := DefCanSetNumDivisions;
  FDarkenAmount          := DefDarkenAmount;
  FShowAngleText         := DefShowAngleText;
  FShowPosNeg            := DefShowPosNeg;
  W := Width;
  H := Height;
  AdjustSize(W,H);
End; // THeadingControl.Create

Procedure AbsLeft(Var L: Integer; Control: TWinControl);
Begin
  Inc(L,Control.Left);
  If Control.Parent <> Nil Then AbsLeft(L,Control.Parent);
End; // AbsLeft

Procedure AbsTop(Var T: Integer; Control: TWinControl);
Begin
  Inc(T,Control.Top);
  If Control.Parent <> Nil Then AbsTop(T,Control.Parent);
End; // AbsTop

Procedure THeadingControl.AdjustSize(Var W, H: Integer);
Var
  Size  : Integer;
  I     : Integer;
  X0,Y0 : Integer;
  X,Y   : Array[0..3] Of Integer;

Begin
  If W < MinSize Then W := MinSize;
  If H < MinSize Then H := MinSize;
  Size := Min(W,H);
  If H > W Then
  Begin
    FEdit.SetBounds(0,Size + 4,FEdit.Width,FEdit.Height);
    If Width - DefEditWidth >= 4 * FButtonSize Then
    Begin
      FEdit.Width := DefEditWidth;
      X0 := FEdit.Width + 4;
      Y0 := Size + 4;
      FBtnSub5.SetBounds(X0,Y0,FButtonSize,FButtonSize);
      FBtnSub1.SetBounds(X0 + FButtonSize,Y0,FButtonSize,FButtonSize);
      FBtnAdd1.SetBounds(X0 + 2 * FButtonSize,Y0,FButtonSize,FButtonSize);
      FBtnAdd5.SetBounds(X0 + 3 * FButtonSize,Y0,FButtonSize,FButtonSize);
    End
    Else
    Begin
      FEdit.Width := Width;
      X0 := 0;
      Y0 := Size + 8 + FEdit.Height;
      For I := 0 To 3 Do
      Begin
        X[I] := X0;
        Y[I] := Y0;
        If X0 + 2 * FButtonSize > Width Then
        Begin
          X0 := 0;
          Inc(Y0,FButtonSize);
        End
        Else Inc(X0,FButtonSize);
      End; // For I
      FBtnSub5.SetBounds(X[0],Y[0],FButtonSize,FButtonSize);
      FBtnSub1.SetBounds(X[1],Y[1],FButtonSize,FButtonSize);
      FBtnAdd1.SetBounds(X[2],Y[2],FButtonSize,FButtonSize);
      FBtnAdd5.SetBounds(X[3],Y[3],FButtonSize,FButtonSize);
    End;
  End
  Else
  Begin
    I := Width - Size - 4;
    If I < 8 Then I := 8;
    FEdit.Width := I;
    FEdit.SetBounds(Size + 4,0,FEdit.Width,FEdit.Height);
    X0 := Size + 4;
    Y0 := FEdit.Height + 4;
    For I := 0 To 3 Do
    Begin
      X[I] := X0;
      Y[I] := Y0;
      If X0 + 2 * FButtonSize > Width Then
      Begin
        X0 := Size + 4;
        Inc(Y0,FButtonSize);
      End
      Else Inc(X0,FButtonSize);
    End; // For I
    FBtnSub5.SetBounds(X[0],Y[0],FButtonSize,FButtonSize);
    FBtnSub1.SetBounds(X[1],Y[1],FButtonSize,FButtonSize);
    FBtnAdd1.SetBounds(X[2],Y[2],FButtonSize,FButtonSize);
    FBtnAdd5.SetBounds(X[3],Y[3],FButtonSize,FButtonSize);
  End;
End; // THeadingControl.AdjustSize

Procedure THeadingControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
Var W, H: Integer;
Begin
  W := AWidth;
  H := AHeight;
  AdjustSize(W, H);
  Inherited SetBounds(ALeft, ATop, W, H);
End; // THeadingControl.SetBounds

Procedure THeadingControl.WMSize(var Message: TWMSize);
Var W, H: Integer;
Begin
  Inherited;

  // check for minimum size

  W := Width;
  H := Height;
  AdjustSize(W, H);
  If (W <> Width) Or (H <> Height) Then Inherited SetBounds(Left, Top, W, H);
  Message.Result := 0;
End; // THeadingControl.WMSize

Procedure THeadingControl.EditChange(Sender: TObject);
Var
  D : Double;
  I : Integer;

Begin
  Text := FEdit.Text;
  Val(Text,D,I);
  If I = 0 Then
  Begin
    While D < 0 Do D := D + 360;
    While D >= 360 Do D := D - 360;
    FAngle := D;
    Repaint;
  End;
  If Assigned(FOnChange) And Not FEditChanging Then FOnChange(Self);
End; // THeadingControl.EditChange

Procedure THeadingControl.SetEnabled(Value: Boolean);
Begin
  Inherited;
  FEdit.Enabled    := Value;
  FbtnAdd1.Enabled := Value;
  FbtnAdd5.Enabled := Value;
End; // THeadingControl.SetEnabled

Function THeadingControl.GetCtl3D: Boolean;
Begin
  Result := FEdit.Ctl3D;
End; // THeadingControl.GetCtl3D

Procedure THeadingControl.SetCtl3D(B: Boolean);
Begin
  FEdit.Ctl3D := B;
End; // THeadingControl.SetCtl3D

Procedure THeadingControl.SetRingWidth(I: Integer);
Begin
  If I < MinRingWidth Then I := MinRingWidth;
  FRingWidth := I;
  Repaint;
End; // THeadingControl.SetRingWidth

Procedure THeadingControl.SetCompassColor(C: TColor);
Begin
  If C <> FCompassColor Then
  Begin
    FCompassColor := C;
    Repaint;
  End;
End; // THeadingControl.SetCompassColor

Procedure THeadingControl.SetCompassColor45(C: TColor);
Begin
  If C <> FCompassColor45 Then
  Begin
    FCompassColor45 := C;
    Repaint;
  End;
End; // THeadingControl.SetCompassColor45

Procedure THeadingControl.SetAngleColor(C: TColor);
Begin
  If C <> FAngleColor Then
  Begin
    FAngleColor := C;
    Repaint;
  End;
End; // THeadingControl.SetAngleColor

Procedure THeadingControl.SetAngleTextColor(C: TColor);
Begin
  If C <> FAngleTextColor Then
  Begin
    FAngleTextColor := C;
    Repaint;
  End;
End; // THeadingControl.SetAngleTextColor

Procedure THeadingControl.SetShowVector(B: Boolean);
Begin
  If B <> FShowVector Then
  Begin
    FShowVector := B;
    Repaint;
  End;
End; // THeadingControl.SetShowVector

Procedure THeadingControl.SetShowDot(B: Boolean);
Begin
  If B <> FShowDot Then
  Begin
    FShowDot := B;
    Repaint;
  End;
End; // THeadingControl.SetShowDot

Procedure THeadingControl.SetShowAddButtons(B: Boolean);
Var W,H: Integer;
Begin
  If B <> FShowAddButtons Then
  Begin
    W := Width;
    H := Height;
    FShowAddButtons  := B;
    FbtnAdd1.Visible := B;
    FbtnSub1.Visible := B;
    FbtnAdd5.Visible := B;
    FbtnSub5.Visible := B;
    AdjustSize(W,H);
  End;
End; // THeadingControl.SetShowAddButtons

Procedure THeadingControl.SetShowEditor(B: Boolean);
Var W,H: Integer;
Begin
  If B <> FShowEditor Then
  Begin
    W := Width;
    H := Height;
    FShowEditor   := B;
    FEdit.Visible := B;
    AdjustSize(W,H);
  End;
End; // THeadingControl.SetShowAddButtons

Procedure THeadingControl.SetNumDivisions(I: Integer);
Begin
  If I < 2 Then I := 2;
  If I <> FNumDivisions Then
  Begin
    FNumDivisions := I;
    FPressedButton := -1;
    Repaint;
  End;
End; // THeadingControl.SetNumDivisions

Procedure THeadingControl.SetAngle(D: Double);
Begin
  While D < 0 Do D := D + 360;
  While D >= 360 Do D := D - 360;
  If D <> FAngle Then
  Begin
    FAngle := D;
    Repaint;
  End;
End; // THeadingControl.SetAngle

Procedure THeadingControl.SetPressedButton(I: Integer);
Begin
  If (FPressedButton <> I) Or FCenterPressed Then
  Begin
    FPressedButton := I;
    FCenterPressed := False;
    Repaint;
  End;
End; // THeadingControl.SetPressedButton

Procedure THeadingControl.SetButtonSize(I: Integer);
Var W,H: Integer;
Begin
  If I <> FButtonSize Then
  Begin
    FButtonSize := I;
    W := Width;
    H := Height;
    AdjustSize(W,H);
  End;
End; // THeadingControl.SetButtonSize

Procedure THeadingControl.SetCanSetNumDivisions(B: Boolean);
Begin
  If B <> FCanSetNumDivisions Then
  Begin
    FCanSetNumDivisions := B;
    Repaint;
  End;
End; // THeadingControl.SetCanSetNumDivisions

Procedure THeadingControl.SetShowAngleText(B: Boolean);
Begin
  If B <> FShowAngleText Then
  Begin
    FShowAngleText := B;
    Repaint;
  End;
End; // THeadingControl.SetShowAngleText

Procedure THeadingControl.SetDarkenAmount(D: Double);
Begin
  If D <> FDarkenAmount Then
  Begin
    FDarkenAmount := D;
    Repaint;
  End;
End; // THeadingControl.SetDarkenAmount

Procedure THeadingControl.SetShowPosNeg(B: Boolean);
Begin
  If B <> FShowPosNeg Then
  Begin
    FShowPosNeg := B;
    FEdit.Text := FloatToStr(HandlePosNeg(FAngle));
    Repaint;
  End;
End; // THeadingControl.SetShowPosNeg

Procedure THeadingControl.btnAdd1Click(Sender: TObject);
Begin
  FAngle := FAngle + 1;
  While FAngle < 0 Do FAngle := FAngle + 360;
  While FAngle >= 360 Do FAngle := FAngle - 360;
  FEdit.Text := FloatToStr(HandlePosNeg(FAngle));
End; // THeadingControl.btnAdd1Click

Procedure THeadingControl.btnSub1Click(Sender: TObject);
Begin
  FAngle := FAngle - 1;
  While FAngle < 0 Do FAngle := FAngle + 360;
  While FAngle >= 360 Do FAngle := FAngle - 360;
  FEdit.Text := FloatToStr(HandlePosNeg(FAngle));
End; // THeadingControl.btnSub1Click

Procedure THeadingControl.btnAdd5Click(Sender: TObject);
Begin
  FAngle := FAngle + 5;
  While FAngle < 0 Do FAngle := FAngle + 360;
  While FAngle >= 360 Do FAngle := FAngle - 360;
  FEdit.Text := FloatToStr(HandlePosNeg(FAngle));
End; // THeadingControl.btnAdd5Click

Procedure THeadingControl.btnSub5Click(Sender: TObject);
Begin
  FAngle := FAngle - 5;
  While FAngle < 0 Do FAngle := FAngle + 360;
  While FAngle >= 360 Do FAngle := FAngle - 360;
  FEdit.Text := FloatToStr(HandlePosNeg(FAngle));
End; // THeadingControl.btnSub5Click

Function THeadingControl.HandlePosNeg(A: Double): Double;
Begin
  If FShowPosNeg Then
  Begin
    While A < -179 Do A := A + 360;
    While A > 180 Do A := A - 360;
    Result := A;
  End
  Else
  Begin
    While A < 0 Do A := A + 360;
    While A >= 360 Do A := A - 360;
    Result := A;
  End;
End; // THeadingControl.HandlePosNeg

Procedure THeadingControl.Paint;
Var
  I    : Integer;
  Size : Integer;
  FBMP : TBitmap;

  Procedure Ellipse1(X1,Y1,X2,Y2: Integer);
  Begin
    FBMP.Canvas.Brush.Style := bsClear;
    FBMP.Canvas.Pen.Color   := clWhite;
    FBMP.Canvas.Arc(X1 + 0,Y1 + 1,X2 + 0,Y2 + 1,X2 + 0,Y1 + 1,X1 + 0,Y2 + 1);
    FBMP.Canvas.Arc(X1 + 1,Y1 + 0,X2 + 1,Y2 + 0,X2 + 1,Y1 + 0,X1 + 1,Y2 + 0);
    FBMP.Canvas.Arc(X1 + 1,Y1 + 1,X2 + 1,Y2 + 1,X2 + 1,Y1 + 1,X1 + 1,Y2 + 1);
    FBMP.Canvas.Pen.Color   := clGray;
    FBMP.Canvas.Arc(X1,Y1,X2,Y2,X1,Y2,X2,Y1);
    FBMP.Canvas.Arc(X1 + 0,Y1 + 1,X2 + 0,Y2 + 1,X1 + 0,Y2 + 1,X2 + 0,Y1 + 1);
    FBMP.Canvas.Arc(X1 + 1,Y1 + 0,X2 + 1,Y2 + 0,X1 + 1,Y2 + 0,X2 + 1,Y1 + 0);
    FBMP.Canvas.Pen.Color   := clBlack;
    FBMP.Canvas.Arc(X1,Y1,X2,Y2,X2,Y1,X1,Y2);
    FBMP.Canvas.Pen.Color   := clBlack;
    FBMP.Canvas.Arc(X1 + 1,Y1 + 1,X2 + 1,Y2 + 1,X1 + 1,Y2 + 1,X2 + 1,Y1 + 1);
    FBMP.Canvas.Brush.Style := bsSolid;
  End; // Ellipse1

  Procedure Ellipse2(X1,Y1,X2,Y2: Integer);
  Begin
    FBMP.Canvas.Brush.Style := bsClear;
    FBMP.Canvas.Pen.Color   := clGray;
    FBMP.Canvas.Arc(X1,Y1,X2,Y2,X2,Y1,X1,Y2);
    FBMP.Canvas.Arc(X1 + 0,Y1 + 1,X2 + 0,Y2 + 1,X2 + 0,Y1 + 1,X1 + 0,Y2 + 1);
    FBMP.Canvas.Arc(X1 + 1,Y1 + 0,X2 + 1,Y2 + 0,X2 + 1,Y1 + 0,X1 + 1,Y2 + 0);
    FBMP.Canvas.Pen.Color   := clWhite;
    FBMP.Canvas.Arc(X1 + 0,Y1 + 1,X2 + 0,Y2 + 1,X1 + 0,Y2 + 1,X2 + 0,Y1 + 1);
    FBMP.Canvas.Arc(X1 + 1,Y1 + 0,X2 + 1,Y2 + 0,X1 + 1,Y2 + 0,X2 + 1,Y1 + 0);
    FBMP.Canvas.Arc(X1 + 1,Y1 + 1,X2 + 1,Y2 + 1,X1 + 1,Y2 + 1,X2 + 1,Y1 + 1);
    FBMP.Canvas.Pen.Color   := clBlack;
    FBMP.Canvas.Arc(X1 + 1,Y1 + 1,X2 + 1,Y2 + 1,X2 + 1,Y1 + 1,X1 + 1,Y2 + 1);
    FBMP.Canvas.Pen.Color   := clBlack;
    FBMP.Canvas.Arc(X1,Y1,X2,Y2,X1,Y2,X2,Y1);
    FBMP.Canvas.Brush.Style := bsSolid;
  End; // Ellipse2

  Procedure DrawVector;
  Var R,X,Y: Integer;
  Begin
    R := (Size Div 2) - RingWidth - 1;
    X := (Size Div 2) + Round(R * Sin(FAngle * Pi / 180));
    Y := (Size Div 2) - Round(R * Cos(FAngle * Pi / 180));
    FBMP.Canvas.Pen.Color := FAngleColor;
    If FCanSetNumDivisions And FCenterPressed Then
    Begin
      FBMP.Canvas.MoveTo((Size Div 2) + 1,(Size Div 2) + 1);
      FBMP.Canvas.LineTo(X + 1,Y + 1);
    End
    Else
    Begin
      FBMP.Canvas.MoveTo(Size Div 2,Size Div 2);
      FBMP.Canvas.LineTo(X,Y);
    End;
  End; // DrawVector

  Procedure DrawDot;
  Var R,X,Y: Integer;
  Begin
    R := (Size Div 2) - (RingWidth Div 2);
    X := (Size Div 2) + Round(R * Sin(FAngle * Pi / 180));
    Y := (Size Div 2) - Round(R * Cos(FAngle * Pi / 180));
    FBMP.Canvas.Pixels[X,Y] := FAngleColor;
    FBMP.Canvas.Pixels[X - 1,Y] := FAngleColor;
    FBMP.Canvas.Pixels[X + 1,Y] := FAngleColor;
    FBMP.Canvas.Pixels[X,Y - 1] := FAngleColor;
    FBMP.Canvas.Pixels[X,Y + 1] := FAngleColor;
  End; // DrawDot

  Procedure DrawAngleText;
  Var
    X,Y : Integer;
    St  : String;

  Begin
    St := Format('%6.2f',[HandlePosNeg(FAngle)]) + '°';
    X := (Size Div 2) - (FBMP.Canvas.TextWidth(St) Div 2);
    Y := (Size Div 2) - (FBMP.Canvas.TextHeight(St) Div 2);
    FBMP.Canvas.Font.Color  := FAngleTextColor;
    FBMP.Canvas.Brush.Color := Color;
    If FCanSetNumDivisions And FCenterPressed
     Then FBMP.Canvas.TextOut(X + 1,Y + 1,St)
     Else FBMP.Canvas.TextOut(X,Y,St);
  End; // DrawAngleText

Begin
  // Create a back buffer to which we will draw, to avoid flicker

  FBMP             := TBitmap.Create;
  Size             := Min(Width,Height);
  FBMP.Width       := Size;
  FBMP.Height      := Size;
  FBMP.PixelFormat := pf32Bit;

  // Clear the rectangle

  FBMP.Canvas.Pen.Color   := Color;
  FBMP.Canvas.Brush.Color := Color;
  FBMP.Canvas.Brush.Style := bsSolid;
  FBMP.Canvas.Rectangle(0,0,Size,Size);

  // Paint the inner and outer rings (for floodfill purposes)

  Ellipse1(0,0,Size - 1,Size - 1);
  Ellipse2(RingWidth,RingWidth,Size - RingWidth - 1,Size - RingWidth - 1);

  // Paint the buttons

  For I := 0 To FNumDivisions - 1 Do PaintButton(I,FBMP.Canvas);

  // Paint the inner and outer rings again

  Ellipse1(0,0,Size - 1,Size - 1);
  Ellipse2(RingWidth,RingWidth,Size - RingWidth - 1,Size - RingWidth - 1);

  // Paint the center button if necessary

  If FCanSetNumDivisions And Not FCenterPressed Then
   Ellipse1(RingWidth,RingWidth,Size - RingWidth - 1,Size - RingWidth - 1);

  // Draw the angle vector

  If FShowVector Then DrawVector;

  // Draw the angle dot

  If FShowDot Then DrawDot;

  // Draw a string showing the angle

  If FShowAngleText Then DrawAngleText;

  // Copy the bitmap

  Canvas.CopyMode := cmSrcCopy;
  FBMP.Canvas.CopyMode := cmSrcCopy;
  Canvas.Draw(0,0,FBMP);
End; // THeadingControl.Paint

Procedure THeadingControl.PaintButton(I: Integer; Canvas: TCanvas);
Type
  TRGBA = Packed Record
    R,G,B,A: Byte;
  End;
  
Var
  A,A1   : Double;
  Ang    : Double;
  Size   : Integer;
  Center : Integer;
  C      : TColor;
  X,Y    : Integer;

  Procedure DrawLine1(X1,Y1,X2,Y2: Integer);
  Begin
    Canvas.Pen.Color := clBlack;
    Canvas.MoveTo(X1,Y1);
    Canvas.LineTo(X2,Y2);
    Canvas.Pen.Color := clWhite;
    Canvas.MoveTo(X1 + 1,Y1);
    Canvas.LineTo(X2 + 1,Y2);
  End; // DrawLine1

  Procedure DrawLine2(X1,Y1,X2,Y2: Integer);
  Begin
    Canvas.Pen.Color := clGray;
    Canvas.MoveTo(X1 - 1,Y1);
    Canvas.LineTo(X2 - 1,Y2);
    Canvas.Pen.Color := clBlack;
    Canvas.MoveTo(X1,Y1);
    Canvas.LineTo(X2,Y2);
  End; // DrawLine2

  Function Darken(C: TColor): TColor;
  Var
    R1,G1,B1 : Integer;
    C1       : TColor;

  Begin
    R1 := TRGBA(C).R;
    G1 := TRGBA(C).G;
    B1 := TRGBA(C).B;
    R1 := Round(R1 * FDarkenAmount);
    G1 := Round(G1 * FDarkenAmount);
    B1 := Round(B1 * FDarkenAmount);
    If R1 < 0 Then R1 := 0;
    If G1 < 0 Then G1 := 0;
    If B1 < 0 Then B1 := 0;
    If R1 > 255 Then R1 := 255;
    If G1 > 255 Then G1 := 255;
    If B1 > 255 Then B1 := 255;
    TRGBA(C1).R := R1;
    TRGBA(C1).G := G1;
    TRGBA(C1).B := B1;
    TRGBA(C1).A := 0;
    Result := C1;
  End; // Darken

Begin
  If (I >= 0) And (I < FNumDivisions) Then
  Begin
    Size   := Min(Width,Height);
    Center := Size Div 2;
    A1 := 360 / (2 * FNumDivisions);
    A  := 360 * (I / FNumDivisions);

    Canvas.Pen.Color := clBlack;
    Ang := (A - A1) * (Pi / 180);

    If I = FPressedButton Then
    Begin
      DrawLine2(Trunc(Center + ((Size / 2) - RingWidth - 0.5) * Sin(Ang)),
                Trunc(Center - ((Size / 2) - RingWidth - 0.5) * Cos(Ang)),
                Trunc(Center + Size * Sin(Ang) / 2),
                Trunc(Center - Size * Cos(Ang) / 2));

      Ang := (A + A1) * (Pi / 180);
      DrawLine1(Trunc(Center + ((Size / 2) - RingWidth - 0.5) * Sin(Ang)),
                Trunc(Center - ((Size / 2) - RingWidth - 0.5) * Cos(Ang)),
                Trunc(Center + Size * Sin(Ang) / 2),
                Trunc(Center - Size * Cos(Ang) / 2));
    End
    Else
    Begin
      DrawLine1(Trunc(Center + ((Size / 2) - RingWidth - 0.5) * Sin(Ang)),
                Trunc(Center - ((Size / 2) - RingWidth - 0.5) * Cos(Ang)),
                Trunc(Center + Size * Sin(Ang) / 2),
                Trunc(Center - Size * Cos(Ang) / 2));

      Ang := (A + A1) * (Pi / 180);
      DrawLine2(Trunc(Center + ((Size / 2) - RingWidth - 0.5) * Sin(Ang)),
                Trunc(Center - ((Size / 2) - RingWidth - 0.5) * Cos(Ang)),
                Trunc(Center + Size * Sin(Ang) / 2),
                Trunc(Center - Size * Cos(Ang) / 2));
    End;

    Canvas.Brush.Style := bsSolid;

    // N,S,E,W colors

    If (I = 0) Or
       (((FNumDivisions And 1) = 0) And (I = (FNumDivisions Shr 1))) Or
       (((FNumDivisions And 3) = 0) And
        ((I = (FNumDivisions Shr 2)) Or
         (I = 3 * (FNumDivisions Shr 2)))) Then Canvas.Brush.Color := FCompassColor

    // NE, SE, NW, SW colors

    Else If (((FNumDivisions And 7) = 0) And
             ((I = (FNumDivisions Shr 3)) Or
              (I = 3 * (FNumDivisions Shr 3)) Or
              (I = 5 * (FNumDivisions Shr 3)) Or
              (I = 7 * (FNumDivisions Shr 3)))) Then Canvas.Brush.Color := FCompassColor45

    // All other colors

    Else Canvas.Brush.Color := Color;

    // Fill the division

    X := Round(Center + (Size - RingWidth) * Sin(A * Pi / 180) / 2);
    Y := Round(Center - (Size - RingWidth) * Cos(A * Pi / 180) / 2);

    // Basic colors like clSilver are enumerated, and aren't standard RGBA colors.
    // The solution is to save the original color, then write the desired color
    // to the bitmap and read it back as a true RGBA.  Then restore the original
    // color so the flood fill will work.

    C := Canvas.Pixels[X,Y];
    Canvas.Pixels[X,Y] := Canvas.Brush.Color;
    Canvas.Brush.Color := Canvas.Pixels[X,Y];
    If I = FPressedButton Then Canvas.Brush.Color := Darken(Canvas.Brush.Color);
    Canvas.Pixels[X,Y] := C;

    Canvas.FloodFill(X,Y,C,fsSurface);
  End;
End; // THeadingControl.PaintButton

Procedure THeadingControl.DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  Size   : Integer;
  Center : Integer;
  A,A1,D : Double;

Begin
  If Button = mbLeft Then
  Begin
    FLeftButtonDown := True;
    Size   := Min(Width,Height);
    Center := Size Div 2;
    D      := Sqr(X - Center) + Sqr(Y - Center);
    If D > 0 Then
    Begin
      D := Sqrt(D);
      If (D >= Round((Size / 2) - FRingWidth)) And (D < Round(Size / 2)) Then
      Begin
        A := ArcTan2(X - Center,Center - Y) * (180 / Pi);
        A1 := 360 / (2 * FNumDivisions);
        A := A + A1;
        While A < 0 Do A := A + 360;
        While A >= 360 Do A := A - 360;
        SetPressedButton(Trunc(FNumDivisions * (A / 360)));
      End
      Else If D < Round((Size / 2) - FRingWidth) Then
      Begin
        FCenterPressed := True;
        Repaint;
      End
      Else SetPressedButton(-1);
    End
    Else SetPressedButton(-1);
  End
  Else SetPressedButton(-1);
End; // THeadingControl.DoMouseDown

Procedure THeadingControl.DoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
Var
  Size   : Integer;
  Center : Integer;
  A,A1,D : Double;
  I      : Integer;
  FC     : Boolean;
  St     : String;

Begin
  Size   := Min(Width,Height);
  Center := Size Div 2;
  D      := Sqr(X - Center) + Sqr(Y - Center);
  If FLeftButtonDown Then
  Begin
    If D > 0 Then
    Begin
      D := Sqrt(D);
      If (D >= Round((Size / 2) - FRingWidth)) And (D < Round(Size / 2)) Then
      Begin
        A := ArcTan2(X - Center,Center - Y) * (180 / Pi);
        A1 := 360 / (2 * FNumDivisions);
        A := A + A1;
        While A < 0 Do A := A + 360;
        While A >= 360 Do A := A - 360;
        SetPressedButton(Trunc(FNumDivisions * (A / 360)));
        FC := False;
      End
      Else If D < Round((Size / 2) - FRingWidth) Then FC := True
      Else
      Begin
        SetPressedButton(-1);
        FC := False;
      End;
    End
    Else
    Begin
      SetPressedButton(-1);
      FC := True;
    End;
  End
  Else
  Begin
    FC := False;
    SetPressedButton(-1);
    If D > 0 Then
    Begin
      D := Sqrt(D);
      If (D >= Round((Size / 2) - FRingWidth)) And (D < Round(Size / 2)) Then
      Begin
        A := ArcTan2(X - Center,Center - Y) * (180 / Pi);
        A1 := 360 / (2 * FNumDivisions);
        A := A + A1;
        While A < 0 Do A := A + 360;
        While A >= 360 Do A := A - 360;
        I    := Trunc(FNumDivisions * (A / 360));
        A    := I * 360 / FNumDivisions;
        St   := Format('%6.2f',[HandlePosNeg(A)]) + '°';
        If St <> Hint Then
        Begin
          Application.CancelHint;
          Hint := St;
        End;
        Application.ProcessMessages;
      End
      Else If D < Round((Size / 2) - FRingWidth) Then
      Begin
        St := Hint;
        If FCanSetNumDivisions
         Then St := Format('Angle: %6.2f',[HandlePosNeg(FAngle)]) + '°'#13#10'Divisions: ' + IntToStr(FNumDivisions) + ' (click to change)'
         Else St := Format('Angle: %6.2f',[HandlePosNeg(FAngle)]) + '°';
        If St <> Hint Then
        Begin
          Application.CancelHint;
          Hint := St;
        End;
        Application.ProcessMessages;
      End
      Else Hint := '';
    End
    Else Hint := '';
  End;
  If FC <> FCenterPressed Then
  Begin
    FCenterPressed := FC;
    Repaint;
  End;
End; // THeadingControl.DoMouseMove

Procedure THeadingControl.DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  Size   : Integer;
  Center : Integer;
  A,A1,D : Double;
  I,J    : Integer;
  St     : String;

Begin
  If Button = mbLeft Then
  Begin
    fLeftButtonDown := False;
    Size   := Min(Width,Height);
    Center := Size Div 2;
    D      := Sqr(X - Center) + Sqr(Y - Center);
    If D > 0 Then
    Begin
      D := Sqrt(D);
      If (D >= Round((Size / 2) - FRingWidth)) And (D < Round(Size / 2)) Then
      Begin
        A := ArcTan2(X - Center,Center - Y) * (180 / Pi);
        A1 := 360 / (2 * FNumDivisions);
        A := A + A1;
        While A < 0 Do A := A + 360;
        While A >= 360 Do A := A - 360;
        I := Trunc(FNumDivisions * (A / 360));
        A := I * 360 / FNumDivisions;
        FEdit.Text := FloatToStr(HandlePosNeg(A));  // Causes automatic repaint
      End
      Else If D < Round((Size / 2) - FRingWidth) Then
      Begin
        If FCanSetNumDivisions Then
        Begin
          St := IntToStr(FNumDivisions);
          If InputQuery('Enter number of divisions','Divisions (2-72):',St) Then
          Begin
            Val(St,I,J);
            If (J = 0) And (I >= 2) And (I <= 72)
             Then NumDivisions := I
             Else ShowMessage('Number of divisions must be between 2 and 72');
          End;
        End;
      End;
    End;
    SetPressedButton(-1);
  End;
End; // THeadingControl.DoMouseUp

procedure Register;
begin
  RegisterComponents('Samples', [THeadingControl]);
end;

{ ======================================================================== }
{  This program is free software; you can redistribute it and/or modify    }
{  it under the terms of the GNU General Public License as published by    }
{  the Free Software Foundation; either version 2 of the License, or       }
{  (at your option) any later version.                                     }
{                                                                          }
{  This program is distributed in the hope that it will be useful,         }
{  but WITHOUT ANY WARRANTY; without even the implied warranty of          }
{  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU       }
{  General Public License for more details.                                }
{                                                                          }
{  You should have received a copy of the GNU General Public License       }
{  along with this program; if not, write to the Free Software             }
{  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.               }
{ ======================================================================== }
{                 Copyright (c) 2002, John Dullea                          }
{ ======================================================================== }
end.

