unit ImageCheckListBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, ImgList;

type
  TImageCheckListBox = class(TCheckListBox)
  private
    FImages: TCustomImageList;
    FImageChangeLink: TChangeLink;
    FSaveStates: TList;

    function GetImageIndex(n: Integer): integer;
    procedure SetImageIndex(n: Integer; const Value: integer);
    procedure SetImages(const Value: TCustomImageList);
    procedure ImageListChange(Sender: TObject);
    function CreateWrapper(Index: Integer): TObject;
    function ExtractWrapper(Index: Integer): TObject;
    function GetWrapper(Index: Integer): TObject;
    function HaveWrapper(Index: Integer): Boolean;
    procedure WMDestroy(var Msg : TWMDestroy);message WM_DESTROY;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    { Private declarations }
  protected
    { Protected declarations }
    procedure SetItemData(Index: Integer; AData: LongInt); override;
    function GetItemData(Index: Integer): LongInt; override;
    procedure ResetContent; override;
    procedure DeleteString(Index: Integer); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    property ImageIndex[n:Integer]: integer read GetImageIndex write SetImageIndex;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
  published
    { Published declarations }
    property Images: TCustomImageList read FImages write SetImages;
  end;

procedure Register;

implementation

type
  TImageCheckListBoxDataWrapper = class
  private
    FData: LongInt;
    FImageIndex: integer;
  public
    class function GetDefaultIndex: integer;
    property ImageIndex: integer read FImageIndex write FImageIndex;
  end;

{ TImageCheckListBoxDataWrapper }

class function TImageCheckListBoxDataWrapper.GetDefaultIndex: integer;
begin
  Result := -1;
end;

{ TImageCheckListBox }

procedure TImageCheckListBox.CNDrawItem(var Message: TWMDrawItem);
begin
  with Message.DrawItemStruct^ do begin
    if FImages<>nil then rcItem.Right := rcItem.Right - FImages.Width - 2;
    end;
  inherited;
end;

procedure TImageCheckListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var image:integer;
    t,l:integer;
begin
  if FImages=nil then
    inherited
  else begin
    image:=GetImageIndex(Index);

    if (image<>-1) then begin
      t:=(Rect.Top+Rect.Bottom-FImages.Height) div 2;
      l:=Rect.Right+1;
      FImages.Draw(Canvas, l, t, image, Enabled);
      end;

    inherited DrawItem(Index, Rect, State);
    end;
end;

function TImageCheckListBox.GetItemData(Index: Integer): LongInt;
begin
  Result := 0;
  if HaveWrapper(Index) then
    Result := TImageCheckListBoxDataWrapper(GetWrapper(Index)).FData;
end;

function TImageCheckListBox.GetWrapper(Index: Integer): TObject;
begin
  Result := ExtractWrapper(Index);
  if Result = nil then
    Result := CreateWrapper(Index);
end;

function TImageCheckListBox.ExtractWrapper(Index: Integer): TObject;
begin
  Result := TImageCheckListBoxDataWrapper(inherited GetItemData(Index));
  if LB_ERR = Integer(Result) then
    raise EListError.CreateFmt('Error %d accessing list data', [Index]);
  if (Result <> nil) and (not (Result is TImageCheckListBoxDataWrapper)) then
    Result := nil;
end;

function TImageCheckListBox.CreateWrapper(Index: Integer): TObject;
var wrapper:TImageCheckListBoxDataWrapper;
begin
  wrapper := TImageCheckListBoxDataWrapper.Create;
  if wrapper<>nil then begin
    wrapper.ImageIndex := TImageCheckListBoxDataWrapper.GetDefaultIndex;
    end;
  Result:=wrapper;
  inherited SetItemData(Index, LongInt(Result));
end;

function TImageCheckListBox.HaveWrapper(Index: Integer): Boolean;
begin
  Result := ExtractWrapper(Index) <> nil;
end;

procedure TImageCheckListBox.SetItemData(Index: Integer; AData: LongInt);
var Wrapper: TImageCheckListBoxDataWrapper;
begin
  Wrapper := TImageCheckListBoxDataWrapper(GetWrapper(Index));
  Wrapper.FData := AData;
  if FSaveStates <> nil then
    if FSaveStates.Count > 0 then
    begin
     Wrapper.ImageIndex := integer(FSaveStates[0]);
     FSaveStates.Delete(0);
    end;
end;

procedure TImageCheckListBox.ResetContent;
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
    if HaveWrapper(I) then
      GetWrapper(I).Free;
  inherited;
end;

procedure TImageCheckListBox.DeleteString(Index: Integer);
begin
  if HaveWrapper(Index) then
    GetWrapper(Index).Free;
  inherited;
end;

constructor TImageCheckListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FImages:=nil;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
end;

procedure TImageCheckListBox.CreateWnd;
begin
  inherited CreateWnd;
  if FSaveStates <> nil then
  begin
    FSaveStates.Free;
    FSaveStates := nil;
  end;
end;

procedure TImageCheckListBox.DestroyWnd;
var
  I: Integer;
begin
  if Items.Count > 0 then
  begin
    FSaveStates := TList.Create;
    for I := 0 to Items.Count -1 do
      FSaveStates.Add(TObject(ImageIndex[I]));
  end;
  inherited DestroyWnd;
end;

function TImageCheckListBox.GetImageIndex(n: Integer): integer;
begin
  if HaveWrapper(n) then
    Result := TImageCheckListBoxDataWrapper(GetWrapper(n)).ImageIndex
  else
    Result := TImageCheckListBoxDataWrapper.GetDefaultIndex;
end;

procedure TImageCheckListBox.SetImageIndex(n: Integer; const Value: integer);
begin
  if value <> GetImageIndex(n) then
  begin
    TImageCheckListBoxDataWrapper(GetWrapper(n)).ImageIndex := Value;
    Invalidate;
  end;
end;

procedure TImageCheckListBox.ImageListChange(Sender: TObject);
begin
  if (Sender = Images) then Invalidate;
end;

procedure TImageCheckListBox.SetImages(const Value: TCustomImageList);
begin
  if FImages <> nil then FImages.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if FImages <> nil then
  begin
    FImages.RegisterChanges(FImageChangeLink);
    FImages.FreeNotification(Self);
  end
  else
    Invalidate;
end;

destructor TImageCheckListBox.Destroy;
begin
  FImageChangeLink.Free;
  FSaveStates.Free;
  inherited;
end;

procedure TImageCheckListBox.WMDestroy(var Msg: TWMDestroy);
var i: Integer;
begin
  for i := 0 to Items.Count -1 do ExtractWrapper(i).Free;
  inherited;
end;

procedure TImageCheckListBox.WMSize(var Message: TWMSize);
begin
  Invalidate;
  inherited;
end;


procedure Register;
begin
  RegisterComponents('Custom', [TImageCheckListBox]);
end;


end.
