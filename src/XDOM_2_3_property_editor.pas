unit XDOM_2_3_property_editor;

  {$IFDEF WIN32}
    {$IFNDEF VER140}
      {$DEFINE MSWINDOWS}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIN16}
    {$DEFINE MSWINDOWS}
  {$ENDIF}
  {$IFDEF VER140}
    {$DEFINE VER140+}
  {$ENDIF}
  {$IFDEF VER150}
    {$DEFINE VER140+}
  {$ENDIF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs, TypInfo,
  {$IFDEF MSWINDOWS}
    StdCtrls, Buttons, Controls,
    {$IFDEF VER140+} DesignIntf, DesignEditors;
    {$ELSE} DsgnIntf; {$ENDIF}
  {$ENDIF}
  {$IFDEF LINUX}
    QStdCtrls, QButtons, QControls, DesignIntf, DesignEditors;
  {$ENDIF}

type
  THandlerListEditor = class(TForm)
    ListBox1: TListBox;
    ListBox2: TListBox;
    CancelBtn: TBitBtn;
    AddBtn: TBitBtn;
    RemoveBtn: TBitBtn;
    ClearBtn: TBitBtn;
    UpBtn: TBitBtn;
    DownBtn: TBitBtn;
    OKBtn: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure CancelBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure RemoveBtnClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  THandlerListProperty = class(TPropertyEditor)
  protected
    FHandlerListEditor: THandlerListEditor;
    procedure FOnGetStrProc(const S: string);
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: String; override;
  end;

var
  HandlerListEditor: THandlerListEditor;

implementation

uses
  XDOM_2_3;

{$IFDEF MSWINDOWS}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

// ++++++++++++++++++++++++ THandlerListProperty ++++++++++++++++++++++++
procedure THandlerListProperty.FOnGetStrProc(const S: string);
begin
  if assigned(FHandlerListEditor) then
    if FHandlerListEditor.ListBox1.Items.IndexOf(S) = -1
      then FHandlerListEditor.ListBox2.Items.AddObject(S,Designer.GetComponent(S));
end;

procedure THandlerListProperty.Edit;
var
  i: integer;
  distributor: TXmlDistributor;
  S: string;
begin
  FHandlerListEditor:= THandlerListEditor.create(application);
  try
    distributor:= (GetComponent(0) as TXmlDistributor);
    with distributor.nextHandlers do begin
      for i:= 0 to pred(count) do begin
        S:= Designer.GetComponentName(items[i].XmlHandler);
        if S <> '' then FHandlerListEditor.ListBox1.Items.AddObject(S,items[i].XmlHandler);
      end;
    end;
    Designer.GetComponentNames(GetTypeData(TypeInfo(TXmlCustomHandler)),FOnGetStrProc);
    if FHandlerListEditor.showModal = mrOK then begin
      distributor.nextHandlers.Assign(FHandlerListEditor.ListBox1.Items);
      SetOrdValue(longint(distributor.nextHandlers));
    end;
  finally
    FHandlerListEditor.free;
  end;
end;

function THandlerListProperty.GetAttributes: TPropertyAttributes;
begin
  result:= [paDialog,paReadonly];
end;

function THandlerListProperty.GetValue: String;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;



// +++++++++++++++++++++++++ THandlerListEditor +++++++++++++++++++++++++
procedure THandlerListEditor.CancelBtnClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure THandlerListEditor.OKBtnClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure THandlerListEditor.AddBtnClick(Sender: TObject);
var
  i: integer;
begin
  with ListBox2 do begin
    items.beginUpdate; ListBox1.items.beginUpdate;
    for i:= 0 to pred(Items.Count) do
      if Selected[i] then ListBox1.Items.AddObject(items.Strings[i],items.Objects[i]);
    for i:= pred(Items.Count) downto 0 do
      if Selected[i] then items.Delete(i);
    items.endUpdate; ListBox1.items.endUpdate;
  end;
end;

procedure THandlerListEditor.RemoveBtnClick(Sender: TObject);
var
  i: integer;
begin
  with ListBox1 do begin
    items.beginUpdate; ListBox2.items.beginUpdate;
    for i:= 0 to pred(Items.Count) do
      if Selected[i] then ListBox2.Items.AddObject(items.Strings[i],items.Objects[i]);
    for i:= pred(Items.Count) downto 0 do
      if Selected[i] then items.Delete(i);
    items.endUpdate; ListBox2.items.endUpdate;
  end;
end;

procedure THandlerListEditor.UpBtnClick(Sender: TObject);
var
  i: integer;
begin
  with ListBox1 do begin
    for i:= 1 to pred(Items.Count) do
      if Selected[i] then items.Exchange(i,pred(i));
  end;
end;

procedure THandlerListEditor.DownBtnClick(Sender: TObject);
var
  i: integer;
begin
  with ListBox1 do begin
    for i:= Items.Count-2 downto 0 do
      if Selected[i] then items.Exchange(i,succ(i));
  end;
end;

procedure THandlerListEditor.ClearBtnClick(Sender: TObject);
var
  i: integer;
begin
  with ListBox1 do begin
    items.beginUpdate; ListBox2.items.beginUpdate;
    for i:= 0 to pred(Items.Count) do
      ListBox2.Items.AddObject(items.Strings[i],items.Objects[i]);
    clear;
    items.endUpdate; ListBox2.items.endUpdate;
  end;
end;

end.
