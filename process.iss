// ------------------------------------------------------------------------- //
//
//  cubepdf-utility.iss
//
//  Copyright (c) 2011 clown.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions
//  are met:
//
//    - Redistributions of source code must retain the above copyright
//      notice, this list of conditions and the following disclaimer.
//    - Redistributions in binary form must reproduce the above copyright
//      notice, this list of conditions and the following disclaimer in the
//      documentation and/or other materials provided with the distribution.
//    - No names of its contributors may be used to endorse or promote
//      products derived from this software without specific prior written
//      permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
//  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
//  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
//  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
//  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
// ------------------------------------------------------------------------- //
#ifndef CUBESOFT_PROCESS_ISS
#define CUBESOFT_PROCESS_ISS

#ifndef MESSAGE_PROCESS_LOCK
#define MESSAGE_PROCESS_LOCK \
    "プログラムが実行中です。インストールを続行するためには、プログラムを終了させる必要があります。プログラムを終了させますか？"
#endif

// ------------------------------------------------------------------------- //
//  Type definitions
// ------------------------------------------------------------------------- //
type
   PHMODULE = Array[0..255] of LongInt;
   PDWORD   = Array[0..255] of Cardinal;

// ------------------------------------------------------------------------- //
//  Constant variables
// ------------------------------------------------------------------------- //
const
   PROCESS_QUERY_INFORMATION = $400;
   PROCESS_VM_READ           = $10;
   PROCESS_TERMINATE         = $1;
   LIST_MODULES_32BIT        = $1;
   LIST_MODULES_64BIT        = $2;
   LIST_MODULES_ALL          = $3;
   MAX_LENGTH                = 255;

// ------------------------------------------------------------------------- //
//  OpenProcess
// ------------------------------------------------------------------------- //
function OpenProcess(dwDesiredAccess: Cardinal; bInheritHandle: Boolean; dwProcessId: Cardinal): LongInt;
external 'OpenProcess@kernel32.dll stdcall';

// ------------------------------------------------------------------------- //
//  CloseHandle
// ------------------------------------------------------------------------- //
function CloseHandle(hObject: LongInt): Boolean;
external 'CloseHandle@kernel32.dll stdcall';

// ------------------------------------------------------------------------- //
//  EnumProcesses
// ------------------------------------------------------------------------- //
function EnumProcesses(var pProcessIds: PDWORD; cb: Cardinal; var pBytesReturned: Cardinal): Boolean;
external 'EnumProcesses@psapi.dll stdcall';

// ------------------------------------------------------------------------- //
//  EnumProcessModules
// ------------------------------------------------------------------------- //
function EnumProcessModules(hProcess: LongInt; var lphModule: PHMODULE; cb: Cardinal; var lpcbNeeded: Cardinal): Boolean;
external 'EnumProcessModules@psapi.dll stdcall';

// ------------------------------------------------------------------------- //
//  GetModuleFileNameExA
// ------------------------------------------------------------------------- //
function GetModuleFileNameEx(hProcess: LongInt; hModule: LongInt; lpFilename: String; nSize: Cardinal): Cardinal;
external 'GetModuleFileNameExW@psapi.dll stdcall';

// ------------------------------------------------------------------------- //
//  TerminateProcess
// ------------------------------------------------------------------------- //
function TerminateProcess(hProcess: LongInt; uExitCode: Integer) : Boolean;
external 'TerminateProcess@kernel32.dll stdcall';

// ------------------------------------------------------------------------- //
//
//  KillProc
//
//  指定したプロセスが実行中の場合は TeminateProcess() で終了させる．
//  confirm に true が指定された場合は，終了させるかどうかを尋ねる
//  メッセージボックスを表示する．
//
// ------------------------------------------------------------------------- //
function KillProc(name: String; confirm: Boolean): Boolean;
var
    i, n, needed: Cardinal;
    found: Boolean;
    last: Integer;
    filename, buffer: String;
    processes: PDWORD;
    process: LongInt;
    modules: PHMODULE;
begin
    if (not EnumProcesses(processes, SizeOf(processes), n)) then begin
        Result := false;
        exit;
    end;
    
    n := n / SizeOf(n);
    i := 0;
    found := false;
    SetLength(buffer, MAX_LENGTH);
    while ((not found) and (i < n)) do begin
        i := i + 1;
        process := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ or PROCESS_TERMINATE, false, processes[i]);
        if (process = 0) then continue;
        if (EnumProcessModules(process, modules, SizeOf(modules), needed)) then begin
            if (GetModuleFileNameEx(process, modules[0], buffer, Length(buffer)) > 0) then begin
                last := Pos(#0, buffer);
                filename := ExtractFileName(Copy(buffer, 1, last - 1));
                if (LowerCase(filename) = LowerCase(name)) then begin
                    found := true;
                    if ((not confirm) or (MsgBox('{#MESSAGE_PROCESS_LOCK}', mbConfirmation, MB_YESNO) = IDYES)) then TerminateProcess(process, 0)
                    else begin
                        Result := false;
                        CloseHandle(process);
                        exit;
                    end;
                end;
            end;
        end;
        CloseHandle(process);
    end;
    Result := true;
end;

#endif // CUBESOFT_PROCESS_ISS
