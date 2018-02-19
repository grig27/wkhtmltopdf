unit csAPIHeaderCore;

interface

uses
  SysUtils, Classes, Windows;

type

  TcsDLLHeader = class
  private
    FInitialized: Boolean;
    HLib: HMODULE;
  protected
    function GetLibraryName(): String; virtual;
    procedure InternalInitialize; virtual;
    procedure LoadAddress; virtual;
    function IntGenericGetProcAddress(lpProcName: PAnsiChar; length: integer): Pointer;
  public
    constructor Create();
    destructor Destroy; override;
    property LibraryName: String read GetLibraryName;
    property Initialized: Boolean read FInitialized;
    procedure Initialize;
  end;

  //function _GenericGetProcAddress(lpProcName: PAnsiChar; length: integer): Pointer;
  function GenericGetProcAddress(Handle: HMODULE; lpProcName: PAnsiChar; length: integer): Pointer;

implementation


function GenericGetProcAddress(Handle: HMODULE; lpProcName: PAnsiChar; length: integer): Pointer;
var
  proc: PAnsiChar;
  str: AnsiString;
begin
  str := lpProcName;//'_'+lpProcName+'@'+inttostr(length);
  proc := PAnsiChar(str);
  {$IFDEF MSwindows}
  result:= GetProcAddress(Handle, proc);
  {$ENDIF}
  {$IFDEF LINUX}
  result:= dlsym(Handle, lpProcName);
  {$ENDIF}

  if Result = nil then
  begin
    str := '_'+lpProcName+'@'+IntToStr(length);
    proc := PAnsiChar(str);
    {$IFDEF MSwindows}
    result:= GetProcAddress(Handle, proc);
    {$ENDIF}
    {$IFDEF LINUX}
    result:= dlsym(Handle, lpProcName);
    {$ENDIF}
  end;

end;

(*
function GenericGetProcAddress(lpProcName: PAnsiChar; length: integer): Pointer;
var
  proc: PAnsiChar;
  str: AnsiString;
begin
  {$IFDEF MSwindows}
  str := '_'+lpProcName+'@'+inttostr(length);
  proc := PAnsiChar(str);
  result:= GetProcAddress(OGRDLL_Handle, proc);
  {$ENDIF}
  {$IFDEF LINUX}
  result:= dlsym(OGRDLL_Handle, lpProcName);
  {$ENDIF}
end;
*)

{ TcsDLLHeader }

constructor TcsDLLHeader.Create();
begin
  inherited;
  FInitialized := False;
end;

destructor TcsDLLHeader.Destroy;
begin
  FreeLibrary(HLib);
  inherited;
end;

function TcsDLLHeader.GetLibraryName: String;
begin
  Result := '';
end;

procedure TcsDLLHeader.Initialize;
begin
  if not FInitialized then
  begin
    FInitialized := True;
    InternalInitialize;
  end;
end;

procedure TcsDLLHeader.InternalInitialize;
begin
  HLib := LoadLibrary(LPCWSTR(GetLibraryName));
  if HLib > 0 then
    LoadAddress;
end;

function TcsDLLHeader.IntGenericGetProcAddress(lpProcName: PAnsiChar;
  length: integer): Pointer;
begin
  Result := GenericGetProcAddress(HLib, lpProcName, length);
end;

procedure TcsDLLHeader.LoadAddress;
begin

end;

end.
