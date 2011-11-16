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
;  �e��ݒ�͎�ɂ����ōs���D
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
;  Setup �Z�N�V�����́C��{�I�ɂ́C�C�����Ȃ��Ă��ǂ��悤�ɒ�`���Ă���D
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
;  ���{��ȊO�̃C���X�g�[����p�ӂ���ꍇ�͒ǉ�����D
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
japanese.KillProc=�v���O���������s���ł��B�C���X�g�[���𑱍s���邽�߂ɂ́A�v���O�������I��������K�v������܂��B�v���O�������I�������܂����H
japanese.DotNetNotFound=���g���̃R���s���[�^��Microsoft .Net Framework���C���X�g�[������Ă��܂���B�C���X�g�[����ɍĎ��s���ĉ������B������Micosoft .Net Framework�̃_�E�����[�h�y�[�W�ֈړ����܂����H
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
//  �C���X�g�[���̎��s���C�ŏ��ɌĂ΂��֐��D�����ݒ�ł́C
//  �A�v���P�[�V���������s�����ǂ����̃`�F�b�N�̂ݍs���Ă���D
//  Microsoft .NET Framework ���C���X�g�[������Ă��邩�ǂ������`�F�b�N
//  ����ꍇ�́C�Y�������̃R�����g�A�E�g���O���D
//
//  NOTE: KillProc() �֐��́C�Ώۂ̃A�v���P�[�V������ 64bit �A�v���̏ꍇ��
//  ���삵�Ȃ��i�A�v���P�[�V�������������Ȃ��j�D
//
// ------------------------------------------------------------------------- //
function InitializeSetup(): Boolean;
var
    err: Integer;
begin
    // �C���X�g�[������A�v���P�[�V������ Microsoft .NET Framework ���K�v�ȏꍇ
    //if (not IsDotNetDetected('v2.0', 0)) then begin
    //    if (MsgBox(CustomMessage('DotNetNotFound'), mbConfirmation, MB_YESNO) = IDYES) then begin
    //        ShellExec('open', CustomMessage('DotNetURL'), '', '', SW_SHOW, ewNoWait, err);
    //    end;
    //    Result := false;
    //    exit;
    //end;
    
    // �A�b�v�f�[�g�Ȃǂ̗��R�ŏ㏑���C���X�g�[������ꍇ�C�C���X�g�[������
    // �A�v���P�[�V���������s�����ǂ������`�F�b�N����D���ɂ����s���ȉ\��
    // �̂���A�v���P�[�V�����Ɋւ��ẮC�����悤�Ƀ`�F�b�N����D
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
//  ���������p�̊֐��DInitializeSetup() �Ƃ̈Ⴂ�́C����̃_�C�A���O�Q��
//  �����������I�������i�K�ŌĂ΂��ƌ������D�J�X�^�}�C�Y�����_�C�A���O��
//  �ǉ����鏈�����͂�����ɋL�q����D
//
// ------------------------------------------------------------------------- //
procedure InitializeWizard();
begin

end;

// ------------------------------------------------------------------------- //
//
//  PreInstallAction
//
//  CurStepChanged �֐��� CurStep �� ssInstall �̂Ƃ��Ɏ��s���鏈���D
//  ���̊֐��́C�u�C���X�g�[�����������v�̃_�C�A���O�Łu�C���X�g�[���v
//  �{�^������������C[Files] �Z�N�V�����Ŏw�肵���t�@�C�����R�s�[�����
//  �O�Ɏ��s�����D
//
// ------------------------------------------------------------------------- //
procedure PreInstallAction();
begin

end;

// ------------------------------------------------------------------------- //
//
//  PostInstallAction
//
//  CurStepChanged �֐��� CurStep �� ssPostInstall �̂Ƃ��Ɏ��s���鏈���D
//  ���̊֐��́C�u�C���X�g�[�����������v�̃_�C�A���O�Łu�C���X�g�[���v
//  �{�^������������C[Files] �Z�N�V�����Ŏw�肵���t�@�C�����R�s�[���ꂽ
//  ��Ɏ��s�����D
//
// ------------------------------------------------------------------------- //
procedure PostInstallAction();
begin

end;

// ------------------------------------------------------------------------- //
//
//  DoneAction
//
//  CurStepChanged �֐��� CurStep �� ssDone �̏�Ԃ̂Ƃ��Ɏ��s���鏈���D
//  ���̊֐��́C�u�Z�b�g�A�b�v�E�B�U�[�h�̊����v�̃_�C�A���O�Łu�����v
//  �{�^���������ꂽ��Ɏ��s�����D
//
// ------------------------------------------------------------------------- //
procedure DoneAction();
begin

end;

// ------------------------------------------------------------------------- //
//
//  CurStepChanged
//
//  NOTE: ��{�I�ɂ́C���̊֐��͕ҏW���Ȃ��D����ɁCPreInstallAction(),
//  PostInstallAction(), DoneAction() ��ҏW����D
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
//  �A�C���X�g�[���̎��s���C�ŏ��ɌĂ΂��֐��D�����ݒ�ł́C
//  �A�v���P�[�V���������s�����ǂ����̃`�F�b�N�̂ݍs���Ă���D���C
//  �A���C���X�g�[�����́C�A�v���P�[�V���������s���̏ꍇ�C�m�F�_�C�A���O��
//  �\���������ɋ����I�ɏI�������Ă���D�m�F�_�C�A���O��\�����������ꍇ�C
//  KillProc() �֐��̑� 2 ������ true �ɕύX����D
//
//  NOTE: KillProc() �֐��́C�Ώۂ̃A�v���P�[�V������ 64bit �A�v���̏ꍇ��
//  ���삵�Ȃ��i�A�v���P�[�V�������������Ȃ��j�D
//
// ------------------------------------------------------------------------- //
function InitializeUninstall(): Boolean;
begin
    KillProc('{#APP_EXE_NAME}.exe', false);
end;
