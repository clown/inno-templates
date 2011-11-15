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
