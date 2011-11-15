// ------------------------------------------------------------------------- //
//
//  windows.iss
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
#ifndef INNO_TEMPLATES_WINDOWS_ISS
#define INNO_TEMPLATES_WINDOWS_ISS

// ------------------------------------------------------------------------- //
//
//  IsDotNetDetected
//
//  Indicates whether the specified version and service pack of the
//  .NET Framework is installed.
//
//  version -- required .NET Framework version:
//    'v1.1'          .NET Framework 1.1
//    'v2.0'          .NET Framework 2.0
//    'v3.0'          .NET Framework 3.0
//    'v3.5'          .NET Framework 3.5
//    'v4\Client'     .NET Framework 4.0 Client Profile
//    'v4\Full'       .NET Framework 4.0 Full Installation
//
//  service -- required service pack level:
//    0               No service packs required
//    1, 2, etc.      Service pack 1, 2, etc. required
// ------------------------------------------------------------------------- //
function IsDotNetDetected(version: String; service: Cardinal): Boolean;
var
    key: String;
    install, count: Cardinal;
    success: Boolean;
begin
    if (version = 'v1.1') then version := version + '.4322'
    else if (version = 'v2.0') then version := version + '.50727';
    key := 'SOFTWARE\Microsoft\NET Framework Setup\NDP\' + Version;
    
    // .NET 3.0 uses value InstallSuccess in subkey Setup
    if Pos('v3.0', version) = 1 then success := RegQueryDWordValue(HKLM, key + '\Setup', 'InstallSuccess', install)
    else success := RegQueryDWordValue(HKLM, key, 'Install', install);
    
    // .NET 4.0 uses value Servicing instead of SP
    if Pos('v4', version) = 1 then success := success and RegQueryDWordValue(HKLM, key, 'Servicing', count)
    else success := success and RegQueryDWordValue(HKLM, key, 'SP', count);
    
    Result := success and (install = 1) and (count >= service);
end;

// ------------------------------------------------------------------------- //
//
//  UsingWin2k
//
//  Windows 2000 以降の OS を使用しているかどうかをチェックする．
//
// ------------------------------------------------------------------------- //
function IsWin2k(): Boolean;
begin
    if (InstallOnThisVersion('0,5.0.2195','0,0') = irInstall) then Result := true
    else Result := false;
end;

// ------------------------------------------------------------------------- //
//
//  UsingWin9x
//
//  Windows 9x 系の OS を使用しているかどうかをチェックする．
//
// ------------------------------------------------------------------------- //
function IsWin9x(): Boolean;
begin
    if (InstallOnThisVersion('4.0.950,0','0,0') = irInstall) then Result := true
    else Result := false;
end;

#endif // INNO_TEMPLATES_WINDOWS_ISS
