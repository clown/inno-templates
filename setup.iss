; --------------------------------------------------------------------------- ;
;
;  setup.iss
;
;  Copyright (c) 2011 clown.
;
;  Redistribution and use in source and binary forms, with or without
;  modification, are permitted provided that the following conditions
;  are met:
;
;    - Redistributions of source code must retain the above copyright
;      notice, this list of conditions and the following disclaimer.
;    - Redistributions in binary form must reproduce the above copyright
;      notice, this list of conditions and the following disclaimer in the
;      documentation and/or other materials provided with the distribution.
;    - No names of its contributors may be used to endorse or promote
;      products derived from this software without specific prior written
;      permission.
;
;  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
;  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
;  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
;  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;  
; --------------------------------------------------------------------------- ;

; --------------------------------------------------------------------------- ;
;
;  PreProcessor
;
;  各種設定は主にここで行う．
;
; --------------------------------------------------------------------------- ;
#define X64_INSTALL_MODE        1
#define GUID_VALUE              "please, generate GUID"
#define ROOT_PATH               "C:\myproject"
#define RESOURCE_DIR            "release"
#define APP_NAME                "MyApplication"
#define APP_EXE_NAME            "myapp"
#define APP_VERSION             "1.0.0"
#define APP_RELEASE_YEAR        "2011"
#define APP_PUBLISHER           "CubeSoft"
#define APP_URL                 "http://cielquis.net/"
#define APP_LICENSE             "License.txt"
#define APP_README              "Readme.txt"
#define APP_ICON                "myapp.ico"
#if (X64_INSTALL_MODE > 0)
#define APP_EDITION             "x64"
#else
#define APP_EDITION             "x86"
#endif

; --------------------------------------------------------------------------- ;
;
;  Setup
;
;  Setup セクションは，基本的には，修正しなくても良いように定義している．
;
; --------------------------------------------------------------------------- ;
[Setup]
AppID={{{#GUID_VALUE}}
AppName={#APP_NAME}
AppVersion={#APP_VERSION}
AppVerName={#APP_NAME} {#APP_VERSION}
AppPublisher={#APP_PUBLISHER}
AppPublisherURL={#APP_URL}
AppSupportURL={#APP_URL}
AppUpdatesURL={#APP_URL}
DefaultDirName={pf}\{#APP_NAME}
DefaultGroupName={#APP_PUBLISHER}\{#APP_NAME}
AllowNoIcons=true
#ifdef APP_LICENSE
LicenseFile={#ROOT_PATH}\{#RESOURCE_DIR}\{#APP_LICENSE}
#endif
OutputDir={#ROOT_PATH}
OutputBaseFilename={#APP_EXE_NAME}-setup-{#APP_VERSION}-{#APP_EDITION}
#ifdef APP_ICON
SetupIconFile={#ROOT_PATH}\{#RESOURCE_DIR}\{#APP_ICON}
#endif
Compression=lzma
SolidCompression=true
InternalCompressLevel=ultra
VersionInfoVersion={#APP_VERSION}
VersionInfoCompany={#APP_PUBLISHER}
VersionInfoDescription={#APP_NAME}
VersionInfoCopyright=Copyright (c) {#APP_RELEASE_YEAR} {#APP_PUBLISHER}
VersionInfoProductName={#APP_NAME}
AlwaysRestart=false
RestartIfNeededByRun=false
PrivilegesRequired=admin
#if (X64_INSTALL_MODE > 0)
ArchitecturesInstallIn64BitMode=x64
ArchitecturesAllowed=x64
#endif

; --------------------------------------------------------------------------- ;
;
;  Languages
;
;  日本語以外のインストーラを用意する場合は追加する．
;
; --------------------------------------------------------------------------- ;
[Languages]
Name: japanese; MessagesFile: compiler:Languages\Japanese.isl

; --------------------------------------------------------------------------- ;
;  Dirs
; --------------------------------------------------------------------------- ;
[Dirs]

; --------------------------------------------------------------------------- ;
;  Files
; --------------------------------------------------------------------------- ;
[Files]
Source: {#ROOT_PATH}\{#RESOURCE_DIR}\{#APP_EDITION}\{#APP_EXE_NAME}.exe; DestDir: {app}
#ifdef APP_README
Source: {#ROOT_PATH}\{#RESOURCE_DIR}\{#APP_README}; DestDir: {app}; Flags: isreadme
#endif

; --------------------------------------------------------------------------- ;
;  Registry
; --------------------------------------------------------------------------- ;
[Registry]
Root: HKLM; Subkey: Software\{#APP_PUBLISHER}\{#APP_NAME}; Flags: uninsdeletekey
Root: HKLM; Subkey: Software\{#APP_PUBLISHER}\{#APP_NAME}; ValueType: string; ValueName: InstallDirectory; ValueData: {app}; Flags: uninsdeletevalue
Root: HKLM; Subkey: Software\{#APP_PUBLISHER}\{#APP_NAME}; ValueType: string; ValueName: Version; ValueData: {#APP_VERSION}; Flags: uninsdeletevalue

; --------------------------------------------------------------------------- ;
;  Icons
; --------------------------------------------------------------------------- ;
[Icons]
Name: {group}\{#APP_NAME}; Filename: {app}\{#APP_EXE_NAME}.exe
Name: {group}\{cm:ProgramOnTheWeb,{#APP_NAME}}; Filename: {#APP_URL}
Name: {group}\{cm:UninstallProgram,{#APP_NAME}}; Filename: {uninstallexe}
Name: {commondesktop}\{#APP_NAME}; Filename: {app}\{#APP_EXE_NAME}.exe; Tasks: desktopicon
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\{#APP_NAME}; Filename: {app}\{#APP_EXE_NAME}.exe; Tasks: quicklaunchicon

; --------------------------------------------------------------------------- ;
;  UninstallDelete
; --------------------------------------------------------------------------- ;
[UninstallDelete]
Name: {app}\*; Type: filesandordirs
Name: {app}; Type: dirifempty

; --------------------------------------------------------------------------- ;
;  Tasks
; --------------------------------------------------------------------------- ;
[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked
Name: quicklaunchicon; Description: {cm:CreateQuickLaunchIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked; OnlyBelowVersion: 0,6.1

; --------------------------------------------------------------------------- ;
;  Run
; --------------------------------------------------------------------------- ;
[Run]

; --------------------------------------------------------------------------- ;
;  CustomMessages
; --------------------------------------------------------------------------- ;
[CustomMessages]
japanese.KillProc=プログラムが実行中です。インストールを続行するためには、プログラムを終了させる必要があります。プログラムを終了させますか？
japanese.DotNetNotFound=お使いのコンピュータにMicrosoft .Net Frameworkがインストールされていません。インストール後に再実行して下さい。今すぐMicosoft .Net Frameworkのダウンロードページへ移動しますか？
japanese.DotNetURL=http://www.microsoft.com/downloads/ja-jp/details.aspx?FamilyId=0856eacb-4362-4b0d-8edd-aab15c5e04f5

; --------------------------------------------------------------------------- ;
;  Code
; --------------------------------------------------------------------------- ;
[Code]
#include "process.iss"
#include "windows.iss"

// ------------------------------------------------------------------------- //
//
//  InitializeSetup
//
//  インストーラの実行時，最初に呼ばれる関数．初期設定では，
//  アプリケーションが実行中かどうかのチェックのみ行っている．
//  Microsoft .NET Framework がインストールされているかどうかをチェック
//  する場合は，該当部分のコメントアウトを外す．
//
//  NOTE: KillProc() 関数は，対象のアプリケーションが 64bit アプリの場合は
//  動作しない（アプリケーションを見つけられない）．
//
// ------------------------------------------------------------------------- //
function InitializeSetup(): Boolean;
var
    err: Integer;
begin
    // インストールするアプリケーションが Microsoft .NET Framework が必要な場合
    //if (not IsDotNetDetected('v2.0', 0)) then begin
    //    if (MsgBox(CustomMessage('DotNetNotFound'), mbConfirmation, MB_YESNO) = IDYES) then begin
    //        ShellExec('open', CustomMessage('DotNetURL'), '', '', SW_SHOW, ewNoWait, err);
    //    end;
    //    Result := false;
    //    exit;
    //end;
    
    // アップデートなどの理由で上書きインストールする場合，インストールする
    // アプリケーションが実行中かどうかをチェックする．他にも実行中な可能性
    // のあるアプリケーションに関しては，同じようにチェックする．
    if (not KillProc('{#APP_EXE_NAME}.exe', true)) then begin
        Result := false;
        exit;
    end;
    
    Result := true;
end;

// ------------------------------------------------------------------------- //
//
//  InitializeWizard
//
//  初期処理用の関数．InitializeSetup() との違いは，既定のダイアログ群の
//  初期処理が終了した段階で呼ばれると言う事．カスタマイズしたダイアログを
//  追加する処理等はこちらに記述する．
//
// ------------------------------------------------------------------------- //
procedure InitializeWizard();
begin

end;

// ------------------------------------------------------------------------- //
//
//  PreInstallAction
//
//  CurStepChanged 関数で CurStep が ssInstall のときに実行する処理．
//  この関数は，「インストール準備完了」のダイアログで「インストール」
//  ボタンを押した後，[Files] セクションで指定したファイルがコピーされる
//  前に実行される．
//
// ------------------------------------------------------------------------- //
procedure PreInstallAction();
begin

end;

// ------------------------------------------------------------------------- //
//
//  PostInstallAction
//
//  CurStepChanged 関数で CurStep が ssPostInstall のときに実行する処理．
//  この関数は，「インストール準備完了」のダイアログで「インストール」
//  ボタンを押した後，[Files] セクションで指定したファイルがコピーされた
//  後に実行される．
//
// ------------------------------------------------------------------------- //
procedure PostInstallAction();
begin

end;

// ------------------------------------------------------------------------- //
//
//  DoneAction
//
//  CurStepChanged 関数で CurStep が ssDone の状態のときに実行する処理．
//  この関数は，「セットアップウィザードの完了」のダイアログで「完了」
//  ボタンが押された後に実行される．
//
// ------------------------------------------------------------------------- //
procedure DoneAction();
begin

end;

// ------------------------------------------------------------------------- //
//
//  CurStepChanged
//
//  NOTE: 基本的には，この関数は編集しない．代わりに，PreInstallAction(),
//  PostInstallAction(), DoneAction() を編集する．
//
// ------------------------------------------------------------------------- //
procedure CurStepChanged(CurStep: TSetupStep);
begin
    case CurStep of
        ssInstall:     PreInstallAction();
        ssPostInstall: PostInstallAction();
        ssDone:        DoneAction();
    end;
end;

// ------------------------------------------------------------------------- //
//
//  InitializeUninstall
//
//  アインストーラの実行時，最初に呼ばれる関数．初期設定では，
//  アプリケーションが実行中かどうかのチェックのみ行っている．尚，
//  アンインストール時は，アプリケーションが実行中の場合，確認ダイアログを
//  表示させずに強制的に終了させている．確認ダイアログを表示させたい場合，
//  KillProc() 関数の第 2 引数を true に変更する．
//
//  NOTE: KillProc() 関数は，対象のアプリケーションが 64bit アプリの場合は
//  動作しない（アプリケーションを見つけられない）．
//
// ------------------------------------------------------------------------- //
function InitializeUninstall(): Boolean;
begin
    KillProc('{#APP_EXE_NAME}.exe', false);
end;
