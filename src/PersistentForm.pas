unit PersistentForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry, StdCtrls, ExtCtrls, CheckLst, Spin, comctrls;

type
  TPersistentForm = class(TForm)
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure Loaded; override;
  public
    { Public declarations }
    destructor Destroy; override;
    procedure Load;
    procedure Save;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Custom', [TPersistentForm]);
end;

{ TPersistentForm }

destructor TPersistentForm.Destroy;
begin
  Save;
  inherited Destroy;
end;

procedure TPersistentForm.Loaded;
begin
  inherited Loaded;
  Load;
end;

procedure TPersistentForm.Save;
var Ini:TRegIniFile;

  procedure SaveToRegistry(ctrl:TWinControl; keyname:string);
  var i,j:integer;
      s,v:string;
      c:TControl;
  begin
    for i:=0 to ctrl.ControlCount-1 do begin
      if (keyname='') then
        s:=ctrl.Controls[i].Name
      else
        s:=keyname+'\'+ctrl.Controls[i].Name;

      if (ctrl.Controls[i] is TWinControl) then begin
        SaveToRegistry((ctrl.Controls[i] as TWinControl), s);
        end;

      c:=ctrl.Controls[i];

      if c is TTrackBar then
        v := InttoStr((c as TTrackBar).Position)
      else if c is TSpinEdit then
         v := IntToStr((c as TSpinEdit).Value)
      else if c is TEdit then
         v := (c as TEdit).Text
      else if c is TMemo then
         v := (c as TMemo).Text
      else if c is TCheckBox then
         v := IntToStr(ord((c as TCheckBox).Checked))
      else if c is TRadioButton then
         v := IntToStr(ord((c as TRadioButton).Checked))
      else if c is TListBox then
         v := IntToStr((c as TListBox).ItemIndex)
      else if c is TRadioGroup then
         v := IntToStr((c as TRadioGroup).ItemIndex)
      else if c is TComboBox then
         v := (c as TComboBox).Text
      else if c is TCheckListBox then begin
        for j:=0 to (c as TCheckListBox).Items.Count-1 do begin
          v := IntToStr(ord((c as TCheckListBox).Checked[j]));
          Ini.WriteString(Name, s+'\'+(c as TCheckListBox).Items[j], v);
          end;
        c:=nil;
        end
      else
        c:=nil;

      if (c<>nil) then Ini.WriteString(Name, s, v);
      end;
  end;

begin
  Ini := TRegIniFile.Create('Software\'+Application.Title);
  SaveToRegistry(self,'');
  Ini.Free;
end;

procedure TPersistentForm.Load;
var Ini:TRegIniFile;

  procedure LoadFromRegistry(ctrl:TWinControl; keyname:string);
  var i,j:integer;
      s,v:string;
      c:TControl;
  begin
    for i:=0 to ctrl.ControlCount-1 do begin
      if (keyname='') then
        s:=ctrl.Controls[i].Name
      else
        s:=keyname+'\'+ctrl.Controls[i].Name;

      if (ctrl.Controls[i] is TWinControl) then begin
        LoadFromRegistry((ctrl.Controls[i] as TWinControl), s);
        end;
      v:=Ini.ReadString(Name, s, '«Unchanged»');

      if (v<>'«Unchanged»') then begin
        c:=ctrl.Controls[i];

        if c is TTrackBar then
           (c as TTrackBar).Position := StrToIntDef(v, (C as TTrackBar).Min)
        else if c is TSpinEdit then
           (c as TSpinEdit).Value := StrToIntDef(v, (C as TSpinEdit).MinValue)
        else if c is TEdit then
           (c as TEdit).Text := v
        else if c is TMemo then
           (c as TMemo).Text := v
        else if c is TCheckBox then
           (c as TCheckBox).Checked := Boolean(StrToIntDef(v,0))
        else if c is TRadioButton then
           (c as TRadioButton).Checked := Boolean(StrToIntDef(v,0))
        else if c is TListBox then
           (c as TListBox).ItemIndex := StrToIntDef(v,-1)
        else if c is TRadioGroup then
           (c as TRadioGroup).ItemIndex := StrToIntDef(v,-1)
        else if c is TComboBox then
           (c as TComboBox).Text := v
        else if c is TCheckListBox then begin
          for j:=0 to (c as TCheckListBox).Items.Count-1 do begin
            v:=Ini.ReadString(Name, s+'\'+(c as TCheckListBox).Items[j], '');
            (c as TCheckListBox).Checked[j] := Boolean(StrToIntDef(v,0));
            end;
          end;
        end;
      end;
  end;

begin
  Ini := TRegIniFile.Create('Software\'+Application.Title);
  LoadFromRegistry(self,'');
  Ini.Free;
end;

end.
