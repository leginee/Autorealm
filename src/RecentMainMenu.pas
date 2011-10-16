unit RecentMainMenu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus,Registry;

type
  TRecentEvent=procedure(Sender:TObject; FileName:string) of object;

  TRecentMainMenu = class(TMainMenu)
  private
    { Private declarations }
    fRecentList:TStringList;
    fCount:integer;
    FOnRecentClick:TRecentEvent;
    fMax:integer;
  protected
    { Protected declarations }
    procedure Open;
    procedure Close;
    procedure ChangeMax(value:integer);
    function GetRecent(Index:integer):string;
    procedure MenuItemClick(Sender: TObject);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearRecentMenu;
    procedure AddToRecent(FileName:string);
    procedure UpdateRecentFiles;
    property RecentCount:integer read fCount;
    property Recent[Index:integer]:string read GetRecent;
  published
    { Published declarations }
    property MaxRecentItems:integer read fMax write ChangeMax default 10;
    property OnRecentClick: TRecentEvent read FOnRecentClick write FOnRecentClick;
  end;

procedure Register;

implementation

procedure TRecentMainMenu.Open;
var Ini:TRegIniFile;
    s:string;
begin
  Ini := TRegIniFile.Create('Software\'+Application.Title);
  ClearRecentMenu;
  repeat
    s:=Ini.ReadString('RecentFiles', IntToStr(fCount+1),'');
    if (s<>'') then begin
      fRecentList.Add(s);
      inc(fCount);
      end;
  until s='';
  Ini.Free;
end;

procedure TRecentMainMenu.Close;
var Ini:TRegIniFile;
    i:integer;
begin
  Ini := TRegIniFile.Create('Software\'+Application.Title);
  Ini.EraseSection('RecentFiles');
  for i:=1 to fCount do begin
    Ini.WriteString('RecentFiles', IntToStr(i), fRecentList[i-1]);
    end;

  Ini.Free;
end;

procedure TRecentMainMenu.UpdateRecentFiles;
var i,n:integer;
    NewItem: TMenuItem;
begin
  if (Items.Count>0) then begin
    n:=Items[0].Count-1;
    while (Items[0].Items[n].Caption<>'-') do begin
      Items[0].Delete(n);
      dec(n);
      end;

    Items[0].Items[n].Visible:=(fCount<>0);

    for i:=1 to fCount do begin
      NewItem := TMenuItem.Create(Self);
      NewItem.Caption := '&'+IntToStr(i)+' '+StringReplace(fRecentList[i-1],'&','&&',[rfReplaceAll]);
      NewItem.Hint:='Open recent file';
      NewItem.OnClick:=MenuItemClick;
      Items[0].Add(NewItem);
      end;
    end;
end;

procedure TRecentMainMenu.MenuItemClick(Sender: TObject);
var s:string;
begin
  if Assigned(FOnRecentClick) then begin
    if (Sender is TMenuItem) then begin
      s:=TMenuItem(Sender).Caption;
      s:=copy(s,pos(' ',s)+1,length(s));
      s:=StringReplace(s,'&&','&',[rfReplaceAll]);
      FOnRecentClick(Sender,s);
      end;
    end;
end;

constructor TRecentMainMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fRecentList := TStringList.Create;
  fCount:=0;
  fMax:=10;
  Open;
end;

destructor TRecentMainMenu.Destroy;
begin
  Close;
  fRecentList.Destroy;
  fCount:=0;
  inherited Destroy;
end;

procedure TRecentMainMenu.ClearRecentMenu;
begin
  fRecentList.Clear;
  fCount:=0;
end;

procedure TRecentMainMenu.ChangeMax(value:integer);
begin
  if (fCount>value) then begin
    fCount:=value;
    Close;
    Open;
    end;

  fMax:=value;
end;

procedure TRecentMainMenu.AddToRecent(FileName:string);
var where:integer;
begin
  // If it's already in the list, remove it and reinsert it at the top.
  where:=fRecentList.IndexOf(FileName);
  if (where<>-1) then begin
    fRecentList.Delete(where);
    dec(fCount);
    end;

  fRecentList.Insert(0, FileName);

  if (fCount+1>fMax) then
    fRecentList.Delete(fMax-1)
  else
    inc(fCount);

  UpdateRecentFiles;
end;

function TRecentMainMenu.GetRecent(Index:integer):string;
begin
  GetRecent:=fRecentList[Index];
end;

procedure Register;
begin
  RegisterComponents('Custom', [TRecentMainMenu]);
end;

end.
