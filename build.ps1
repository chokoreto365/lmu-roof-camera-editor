# Build LMU Roof Camera Studio with the Windows built-in C# compiler.
# No Visual Studio or .NET SDK required (uses .NET Framework 4.x).

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

$csc = Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
if (-not (Test-Path -LiteralPath $csc)) {
    $csc = Join-Path $env:WINDIR 'Microsoft.NET\Framework\v4.0.30319\csc.exe'
}
if (-not (Test-Path -LiteralPath $csc)) {
    throw '找不到 csc.exe：需要 Windows 自带的 .NET Framework 4.x。'
}

$dist = Join-Path $root 'dist'
New-Item -ItemType Directory -Force -Path $dist | Out-Null
$output = Join-Path $dist 'LMU可视化车顶相机编辑器.exe'

& $csc /nologo /target:winexe /optimize+ /platform:anycpu /out:$output `
    /reference:System.dll /reference:System.Core.dll /reference:System.Drawing.dll /reference:System.Windows.Forms.dll `
    (Join-Path $root 'src\LMUCamStudio.cs')

if ($LASTEXITCODE -ne 0) { throw "编译失败，退出码 $LASTEXITCODE" }
Write-Host "已生成：$output"

$log = Join-Path $env:TEMP ('lmu-roof-camera-selftest-' + [Guid]::NewGuid().ToString('N') + '.txt')
$p = Start-Process -FilePath $output -ArgumentList '--self-test', $log -Wait -PassThru
Get-Content -LiteralPath $log -Raw
Remove-Item -LiteralPath $log -Force -ErrorAction SilentlyContinue
if ($p.ExitCode -ne 0) { throw "自测失败，退出码 $($p.ExitCode)" }
Write-Host '自测通过。'
