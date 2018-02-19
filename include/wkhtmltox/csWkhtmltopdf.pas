unit csWkhtmltopdf;

interface

uses
  SysUtils,
  csAPIHeaderCore;

  //https://github.com/wkhtmltopdf/wkhtmltopdf

type

  Twkhtmltopdf_global_settings = Pointer;
  Twkhtmltopdf_object_settings = Pointer;
  Twkhtmltopdf_converter = Pointer;

  TwkhtmltopdfProgress = reference to procedure (const AMessage: String; Percent: Integer);

  PInteger = ^integer;

  Twkhtmltopdf_init = function (wkhtmltopdf_init: Integer): Integer; stdcall;
  Twkhtmltopdf_deinit = function (): Integer; stdcall;
  Twkhtmltopdf_version = function (): PAnsiChar; stdcall;

  Twkhtmltopdf_create_global_settings = function (): Twkhtmltopdf_global_settings; stdcall;

  Twkhtmltopdf_destroy_global_settings = procedure
    (Awkhtmltopdf_global_settings: Twkhtmltopdf_global_settings); stdcall;

  Twkhtmltopdf_create_object_settings = function (): Twkhtmltopdf_object_settings; stdcall;

  Twkhtmltopdf_destroy_object_settings = procedure
    (Awkhtmltopdf_object_settings: Twkhtmltopdf_object_settings); stdcall;

  Twkhtmltopdf_set_global_setting = function (Awkhtmltopdf_global_settings: Twkhtmltopdf_global_settings;
    AName: PAnsiChar; AValue: PAnsiChar): Integer; stdcall;

  Twkhtmltopdf_set_object_setting = function (ATwkhtmltopdf_object_settings: Twkhtmltopdf_object_settings;
    AName: PAnsiChar; AValue: PAnsiChar): Integer; stdcall;

  Twkhtmltopdf_create_converter = function (Awkhtmltopdf_global_settings:
    Twkhtmltopdf_global_settings): Twkhtmltopdf_converter; stdcall;

  Twkhtmltopdf_destroy_converter = procedure (Awkhtmltopdf_converter: Twkhtmltopdf_converter); stdcall;

  Twkhtmltopdf_add_object = procedure(Awkhtmltopdf_converter: Twkhtmltopdf_converter;
    ATwkhtmltopdf_object_settings: Twkhtmltopdf_object_settings; AValue: PAnsiChar); stdcall;

  Twkhtmltopdf_convert = function (Awkhtmltopdf_converter: Twkhtmltopdf_converter): Integer; stdcall;

  Twkhtmltopdf_str_callback = procedure(const Awkhtmltopdf_converter: Twkhtmltopdf_converter;
    AValue: PAnsiChar) cdecl;
  Twkhtmltopdf_int_callback = procedure(const Awkhtmltopdf_converter: Twkhtmltopdf_converter;
    AValue: Integer) cdecl;
  Twkhtmltopdf_void_callback = procedure(const Awkhtmltopdf_converter: Twkhtmltopdf_converter); cdecl;

  Twkhtmltopdf_set_warning_callback = procedure (Awkhtmltopdf_converter: Twkhtmltopdf_converter;
    Awkhtmltopdf_str_callback: Twkhtmltopdf_str_callback); stdcall;
  Twkhtmltopdf_set_error_callback = procedure (Awkhtmltopdf_converter: Twkhtmltopdf_converter;
    Awkhtmltopdf_str_callback: Twkhtmltopdf_str_callback); stdcall;
  Twkhtmltopdf_set_phase_changed_callback = procedure (Awkhtmltopdf_converter: Twkhtmltopdf_converter;
    Awkhtmltopdf_void_callback: Twkhtmltopdf_void_callback); stdcall;
  Twkhtmltopdf_set_progress_changed_callback = procedure (Awkhtmltopdf_converter: Twkhtmltopdf_converter;
    Awkhtmltopdf_int_callback: Twkhtmltopdf_int_callback); stdcall;
  Twkhtmltopdf_set_finished_callback = procedure (Awkhtmltopdf_converter: Twkhtmltopdf_converter;
    Awkhtmltopdf_int_callback: Twkhtmltopdf_int_callback); stdcall;

  TcsWkhtmltopdfHeader = class(TcsDLLHeader)
  private
    FProgress: TwkhtmltopdfProgress;
    procedure SetProgress(const Value: TwkhtmltopdfProgress);
  protected
    Fwkhtmltopdf_init: Twkhtmltopdf_init;
    Fwkhtmltopdf_deinit: Twkhtmltopdf_deinit;
    Fwkhtmltopdf_version: Twkhtmltopdf_version;
    Fwkhtmltopdf_create_global_settings: Twkhtmltopdf_create_global_settings;
    Fwkhtmltopdf_destroy_global_settings: Twkhtmltopdf_destroy_global_settings;
    Fwkhtmltopdf_create_object_settings: Twkhtmltopdf_create_object_settings;
    Fwkhtmltopdf_destroy_object_settings: Twkhtmltopdf_destroy_object_settings;
    Fwkhtmltopdf_set_global_setting: Twkhtmltopdf_set_global_setting;
    Fwkhtmltopdf_set_object_setting: Twkhtmltopdf_set_object_setting;
    Fwkhtmltopdf_create_converter: Twkhtmltopdf_create_converter;
    Fwkhtmltopdf_destroy_converter: Twkhtmltopdf_destroy_converter;
    Fwkhtmltopdf_convert: Twkhtmltopdf_convert;
    Fwkhtmltopdf_add_object: Twkhtmltopdf_add_object;

    Fwkhtmltopdf_set_warning_callback: Twkhtmltopdf_set_warning_callback;
    Fwkhtmltopdf_set_error_callback: Twkhtmltopdf_set_error_callback;
    Fwkhtmltopdf_set_phase_changed_callback: Twkhtmltopdf_set_phase_changed_callback;
    Fwkhtmltopdf_set_progress_changed_callback: Twkhtmltopdf_set_progress_changed_callback;
    Fwkhtmltopdf_set_finished_callback: Twkhtmltopdf_set_finished_callback;

    function GetLibraryName: string; override;
    procedure LoadAddress; override;
  public
    property Progress: TwkhtmltopdfProgress read FProgress write SetProgress;
    function init(wkhtmltopdf_init: Integer): Integer;
    function deinit(): Integer;
    function version(): String;
    function create_global_settings(): Twkhtmltopdf_global_settings;
    procedure destroy_global_settings(Awkhtmltopdf_global_settings: Twkhtmltopdf_global_settings);
    function create_object_settings(): Twkhtmltopdf_object_settings;
    procedure destroy_object_settings(Awkhtmltopdf_object_settings: Twkhtmltopdf_object_settings);
    function set_global_setting(Awkhtmltopdf_global_settings: Twkhtmltopdf_global_settings;
      const AName, AValue: PAnsiChar): Integer;
    function set_object_setting(ATwkhtmltopdf_object_settings: Twkhtmltopdf_object_settings;
      const AName, AValue: PAnsiChar): Integer;
    function create_converter(Awkhtmltopdf_global_settings:
      Twkhtmltopdf_global_settings): Twkhtmltopdf_converter;
    procedure destroy_converter(Awkhtmltopdf_converter: Twkhtmltopdf_converter);
    procedure add_object(Awkhtmltopdf_converter: Twkhtmltopdf_converter;
      ATwkhtmltopdf_object_settings: Twkhtmltopdf_object_settings; AValue: PAnsiChar);
    function convert(Awkhtmltopdf_converter: Twkhtmltopdf_converter): Integer;

    procedure set_warning_callback(Awkhtmltopdf_converter: Twkhtmltopdf_converter;
      Awkhtmltopdf_str_callback: Twkhtmltopdf_str_callback); stdcall;
    procedure set_error_callback(Awkhtmltopdf_converter: Twkhtmltopdf_converter;
      Awkhtmltopdf_str_callback: Twkhtmltopdf_str_callback); stdcall;
    procedure set_phase_changed_callback(Awkhtmltopdf_converter: Twkhtmltopdf_converter;
      Awkhtmltopdf_void_callback: Twkhtmltopdf_void_callback); stdcall;
    procedure set_progress_changed_callback(Awkhtmltopdf_converter: Twkhtmltopdf_converter;
      Awkhtmltopdf_int_callback: Twkhtmltopdf_int_callback); stdcall;
    procedure set_finished_callback(Awkhtmltopdf_converter: Twkhtmltopdf_converter;
      Awkhtmltopdf_int_callback: Twkhtmltopdf_int_callback); stdcall;

    procedure warning_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter;
      AValue: PAnsiChar); cdecl;
    procedure error_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter;
      AValue: PAnsiChar); cdecl;
    procedure phase_changed_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter); cdecl;
    procedure progress_changed_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter;
      AValue: Integer); cdecl;
    procedure finished_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter;
      AValue: Integer); cdecl;
  end;

function ConvertHTMLToPDF(AInputHTML, AOutPDF: String; AProgress: TwkhtmltopdfProgress): Boolean;

procedure warning_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter; AValue: PAnsiChar); cdecl;
procedure error_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter; AValue: PAnsiChar); cdecl;
procedure phase_changed_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter); cdecl;
procedure progress_changed_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter; AValue: Integer); cdecl;
procedure finished_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter; AValue: Integer); cdecl;

implementation

var
  FwkhtmltopdfProgress: TwkhtmltopdfProgress;

procedure warning_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter; AValue: PAnsiChar);
begin
  if Assigned(FwkhtmltopdfProgress) then
    FwkhtmltopdfProgress('Предупреждение: '+String(AValue), 0);
end;

procedure error_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter; AValue: PAnsiChar);
begin
  if Assigned(FwkhtmltopdfProgress) then
    FwkhtmltopdfProgress('Ошибка: '+AValue, 0);
end;

procedure phase_changed_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter);
begin
  if Assigned(FwkhtmltopdfProgress) then
    FwkhtmltopdfProgress('Фаза...', 0);
end;

procedure progress_changed_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter; AValue: Integer);
begin
  if Assigned(FwkhtmltopdfProgress) then
    FwkhtmltopdfProgress('Прогресс...', AValue);
end;

procedure finished_callback(const Awkhtmltopdf_converter: Twkhtmltopdf_converter; AValue: Integer);
begin
  if Assigned(FwkhtmltopdfProgress) then
    FwkhtmltopdfProgress('Завершение...', AValue);
end;

function ConvertHTMLToPDF(AInputHTML, AOutPDF: String; AProgress: TwkhtmltopdfProgress): Boolean;
var
  h: TcsWkhtmltopdfHeader;
  gs: Twkhtmltopdf_global_settings;
	os: Twkhtmltopdf_object_settings;
	c: Twkhtmltopdf_converter;
begin
  h := TcsWkhtmltopdfHeader.Create();
  try
    h.Initialize;
    h.init(0);
    try
      FwkhtmltopdfProgress := AProgress;
      os := h.create_object_settings();
      h.set_object_setting(os, 'page', PAnsiChar(PAnsiString(AnsiString(AInputHTML))));
      gs := h.create_global_settings();
      h.set_global_setting(gs, 'out', PAnsiChar(PAnsiString(AnsiString(AOutPDF))));
      c := h.create_converter(gs);
      h.add_object(c, os, nil);
      h.set_warning_callback(c, warning_callback);
      h.set_error_callback(c, error_callback);
      h.set_phase_changed_callback(c, phase_changed_callback);
      h.set_progress_changed_callback(c, progress_changed_callback);
      h.set_finished_callback(c, finished_callback);
      h.convert(c);
    finally
      h.destroy_global_settings(gs);
      h.destroy_object_settings(os);
      h.destroy_converter(c);
      h.deinit;
    end;
  finally
    FreeAndNil(h);
  end;
end;

{ TcsWkhtmltopdfHeader }

procedure TcsWkhtmltopdfHeader.LoadAddress;
begin
  inherited;
  @Fwkhtmltopdf_init := IntGenericGetProcAddress('wkhtmltopdf_init', 0);
  @Fwkhtmltopdf_deinit := IntGenericGetProcAddress('wkhtmltopdf_deinit', 0);
  @Fwkhtmltopdf_version := IntGenericGetProcAddress('wkhtmltopdf_version', 0);
  @Fwkhtmltopdf_create_global_settings := IntGenericGetProcAddress('wkhtmltopdf_create_global_settings', 0);
  @Fwkhtmltopdf_destroy_global_settings := IntGenericGetProcAddress('wkhtmltopdf_destroy_global_settings', 0);
  @Fwkhtmltopdf_create_object_settings := IntGenericGetProcAddress('wkhtmltopdf_create_object_settings', 0);
  @Fwkhtmltopdf_destroy_object_settings := IntGenericGetProcAddress('wkhtmltopdf_destroy_object_settings', 0);
  @Fwkhtmltopdf_set_global_setting := IntGenericGetProcAddress('wkhtmltopdf_set_global_setting', 0);
  @Fwkhtmltopdf_set_object_setting := IntGenericGetProcAddress('wkhtmltopdf_set_object_setting', 0);
  @Fwkhtmltopdf_create_converter := IntGenericGetProcAddress('wkhtmltopdf_create_converter', 0);
  @Fwkhtmltopdf_destroy_converter := IntGenericGetProcAddress('wkhtmltopdf_destroy_converter', 0);
  @Fwkhtmltopdf_convert := IntGenericGetProcAddress('wkhtmltopdf_convert', 0);
  @Fwkhtmltopdf_add_object := IntGenericGetProcAddress('wkhtmltopdf_add_object', 0);

  @Fwkhtmltopdf_set_warning_callback := IntGenericGetProcAddress('wkhtmltopdf_set_warning_callback', 0);
  @Fwkhtmltopdf_set_error_callback := IntGenericGetProcAddress('wkhtmltopdf_set_error_callback', 0);
  @Fwkhtmltopdf_set_phase_changed_callback := IntGenericGetProcAddress('wkhtmltopdf_set_phase_changed_callback', 0);
  @Fwkhtmltopdf_set_progress_changed_callback := IntGenericGetProcAddress('wkhtmltopdf_set_progress_changed_callback', 0);
  @Fwkhtmltopdf_set_finished_callback := IntGenericGetProcAddress('wkhtmltopdf_set_finished_callback', 0);
end;

procedure TcsWkhtmltopdfHeader.error_callback(
  const Awkhtmltopdf_converter: Twkhtmltopdf_converter; AValue: PAnsiChar);
begin

end;

procedure TcsWkhtmltopdfHeader.finished_callback(
  const Awkhtmltopdf_converter: Twkhtmltopdf_converter; AValue: Integer);
begin
  if Assigned(FProgress) then
    FProgress('phase_changed_callback', AValue);
end;

procedure TcsWkhtmltopdfHeader.warning_callback(
  const Awkhtmltopdf_converter: Twkhtmltopdf_converter; AValue: PAnsiChar);
begin
  if Assigned(FProgress) then
    FProgress('phase_changed_callback: '+AValue, 0);
end;

procedure TcsWkhtmltopdfHeader.phase_changed_callback(
  const Awkhtmltopdf_converter: Twkhtmltopdf_converter);
begin
  if Assigned(FProgress) then
    FProgress('phase_changed_callback', 0);
end;

procedure TcsWkhtmltopdfHeader.progress_changed_callback(
  const Awkhtmltopdf_converter: Twkhtmltopdf_converter; AValue: Integer);
begin
  if Assigned(FProgress) then
    FProgress('progress_changed_callback', AValue);
end;

procedure TcsWkhtmltopdfHeader.SetProgress(const Value: TwkhtmltopdfProgress);
begin
  FProgress := Value;
end;

procedure TcsWkhtmltopdfHeader.destroy_converter(
  Awkhtmltopdf_converter: Twkhtmltopdf_converter);
begin
  Fwkhtmltopdf_destroy_converter(Awkhtmltopdf_converter);
end;

procedure TcsWkhtmltopdfHeader.destroy_global_settings(
  Awkhtmltopdf_global_settings: Twkhtmltopdf_global_settings);
begin
  Fwkhtmltopdf_destroy_global_settings(Awkhtmltopdf_global_settings);
end;

procedure TcsWkhtmltopdfHeader.destroy_object_settings(
  Awkhtmltopdf_object_settings: Twkhtmltopdf_object_settings);
begin
  Fwkhtmltopdf_destroy_object_settings(Awkhtmltopdf_object_settings);
end;

function TcsWkhtmltopdfHeader.GetLibraryName: string;
begin
  Result := 'wkhtmltox.dll';
end;

procedure TcsWkhtmltopdfHeader.add_object(
  Awkhtmltopdf_converter: Twkhtmltopdf_converter;
  ATwkhtmltopdf_object_settings: Twkhtmltopdf_object_settings;
  AValue: PAnsiChar);
begin
  Fwkhtmltopdf_add_object(Awkhtmltopdf_converter, ATwkhtmltopdf_object_settings, AValue);
end;

function TcsWkhtmltopdfHeader.convert(
  Awkhtmltopdf_converter: Twkhtmltopdf_converter): Integer;
begin
  Result := Fwkhtmltopdf_convert(Awkhtmltopdf_converter);
end;

function TcsWkhtmltopdfHeader.create_converter(
  Awkhtmltopdf_global_settings: Twkhtmltopdf_global_settings): Twkhtmltopdf_converter;
begin
  Result := Fwkhtmltopdf_create_converter(Awkhtmltopdf_global_settings);
end;

function TcsWkhtmltopdfHeader.create_global_settings: Twkhtmltopdf_global_settings;
begin
  Result := Fwkhtmltopdf_create_global_settings();
end;

function TcsWkhtmltopdfHeader.create_object_settings: Twkhtmltopdf_object_settings;
begin
  Result := Fwkhtmltopdf_create_object_settings();
end;

procedure TcsWkhtmltopdfHeader.set_error_callback(
  Awkhtmltopdf_converter: Twkhtmltopdf_converter;
  Awkhtmltopdf_str_callback: Twkhtmltopdf_str_callback);
begin
  Fwkhtmltopdf_set_error_callback(Awkhtmltopdf_converter, Awkhtmltopdf_str_callback);
end;

procedure TcsWkhtmltopdfHeader.set_finished_callback(
  Awkhtmltopdf_converter: Twkhtmltopdf_converter;
  Awkhtmltopdf_int_callback: Twkhtmltopdf_int_callback);
begin
  Fwkhtmltopdf_set_finished_callback(Awkhtmltopdf_converter, Awkhtmltopdf_int_callback);
end;

function TcsWkhtmltopdfHeader.set_global_setting(
  Awkhtmltopdf_global_settings: Twkhtmltopdf_global_settings; const AName,
  AValue: PAnsiChar): Integer;
begin
  Result := Fwkhtmltopdf_set_global_setting(Awkhtmltopdf_global_settings, AName, AValue);
end;

function TcsWkhtmltopdfHeader.set_object_setting(
  ATwkhtmltopdf_object_settings: Twkhtmltopdf_object_settings; const AName,
  AValue: PAnsiChar): Integer;
begin
  Result := Fwkhtmltopdf_set_object_setting(ATwkhtmltopdf_object_settings, AName, AValue);
end;

procedure TcsWkhtmltopdfHeader.set_phase_changed_callback(
  Awkhtmltopdf_converter: Twkhtmltopdf_converter;
  Awkhtmltopdf_void_callback: Twkhtmltopdf_void_callback);
begin
  Fwkhtmltopdf_set_phase_changed_callback(Awkhtmltopdf_converter, Awkhtmltopdf_void_callback);
end;

procedure TcsWkhtmltopdfHeader.set_progress_changed_callback(
  Awkhtmltopdf_converter: Twkhtmltopdf_converter;
  Awkhtmltopdf_int_callback: Twkhtmltopdf_int_callback);
begin
  Fwkhtmltopdf_set_progress_changed_callback(Awkhtmltopdf_converter, Awkhtmltopdf_int_callback);
end;

procedure TcsWkhtmltopdfHeader.set_warning_callback(
  Awkhtmltopdf_converter: Twkhtmltopdf_converter;
  Awkhtmltopdf_str_callback: Twkhtmltopdf_str_callback);
begin
  Fwkhtmltopdf_set_warning_callback(Awkhtmltopdf_converter, Awkhtmltopdf_str_callback);
end;

function TcsWkhtmltopdfHeader.deinit: Integer;
begin
  Result := Fwkhtmltopdf_deinit();
end;

function TcsWkhtmltopdfHeader.init(
  wkhtmltopdf_init: Integer): Integer;
begin
  Result := Fwkhtmltopdf_init(wkhtmltopdf_init);
end;

function TcsWkhtmltopdfHeader.version: String;
var
  p: PAnsiChar;
begin
  p := Fwkhtmltopdf_version();
  Result := String(p);
end;

begin
  FSetExceptMask(femALLEXCEPT);
end.
