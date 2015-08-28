[CmdletBinding()]
Param(
  [Parameter()] [string] $NugetExecutable = "Shared\.nuget\nuget.exe",
  [Parameter()] [string] $Configuration = "Debug",
  [Parameter()] [string] $Version = "0.0.1.0",
  [Parameter()] [string] $NugetPushKey
)

Set-StrictMode -Version 2.0; $ErrorActionPreference = "Stop"; $ConfirmPreference = "None"

. Shared\Build\BuildFunctions

$BuildOutputPath = "Build\Output"
$SolutionFilePath = "SerializationInspections.sln"
$AssemblyVersionFilePath = "Src\SerializationInspections.Plugin\Properties\AssemblyInfo.cs"
$MSBuildPath = "${env:ProgramFiles(x86)}\MSBuild\12.0\Bin\MSBuild.exe"
$NUnitExecutable = "nunit-console-x86.exe"
$NUnitTestAssemblyPaths = @(
    "Src\SerializationInspections.Plugin.Tests\bin.R82\$Configuration\SerializationInspections.Plugin.Tests.R82.dll",
    "Src\SerializationInspections.Plugin.Tests\bin.R91\$Configuration\SerializationInspections.Plugin.Tests.R91.dll",
    "Src\SerializationInspections.Plugin.Tests\bin.R92\$Configuration\SerializationInspections.Plugin.Tests.R92.dll",
    "Src\SerializationInspections.Sample\bin\$Configuration\SerializationInspections.Sample.dll"
)
$NUnitFrameworkVersion = "net-4.5"
$TestCoverageFilter = "+[SerializationInspections*]* -[SerializationInspections*]ReSharperExtensionsShared.* -[SerializationInspections.Sample]*"
$NuspecPath = "Src\SerializationInspections.nuspec"
$PackageBaseVersion = StripLastPartFromVersion $Version
$NugetPackProperties = @(
    "Version=$PackageBaseVersion.82;Configuration=$Configuration;DependencyId=ReSharper;DependencyVer=[8.2,8.3);BinDirInclude=bin.R82;TargetDir=ReSharper\v8.2\plugins",
    "Version=$PackageBaseVersion.91;Configuration=$Configuration;DependencyId=Wave;DependencyVer=[2.0];BinDirInclude=bin.R91;TargetDir=dotFiles",
    "Version=$PackageBaseVersion.92;Configuration=$Configuration;DependencyId=Wave;DependencyVer=[3.0];BinDirInclude=bin.R92;TargetDir=dotFiles"
)
$NugetPushServer = "https://www.myget.org/F/ulrichb/api/v2/package"

Clean
PackageRestore
Build
Test
NugetPack

if ($NugetPushKey) {
    NugetPush
}
