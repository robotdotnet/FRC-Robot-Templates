@echo Off
set config=%1
if "%config%" == "" (
   set config=Release
)

set version=
if not "%PackageVersion%" == "" (
   set version=-Version %PackageVersion%
)

call TemplatePatcher.exe

REM Build
%WINDIR%\Microsoft.NET\Framework\v4.0.30319\msbuild "FRC Robot Templates.sln" /p:Configuration="%config%" /m /v:M /fl /flp:LogFile=msbuild.log;Verbosity=Normal /nr:false

REM Package
mkdir Build
cmd /c %nuget% pack ""FRC Robot Templates.sln" -IncludeReferencedProjects -o Build -p Configuration=%config% %version%