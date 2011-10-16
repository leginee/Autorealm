unit PaintWindow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TPaintWindow = class(TCustomForm)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property AutoScroll;
    property HorzScrollBar;
    property VertScrollBar;
    property Align;
    property BoundsRect;
    property ClientHeight;
    property ClientWidth;
    property Enabled;
    property Height;
    property Hint;
    property Left;
    property ShowHint;
    property Top;
    property Visible;
    property Width;
    property OnPaint;
    property Canvas;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Custom', [TPaintWindow]);
end;

end.
 