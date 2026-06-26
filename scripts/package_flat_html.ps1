param(
  [Parameter(Mandatory=$true)][string]$HtmlPath,
  [Parameter(Mandatory=$true)][string]$AssetsPath,
  [Parameter(Mandatory=$true)][string]$OutputZip,
  [string]$OutputHtmlName = "report.html"
)

$ErrorActionPreference = "Stop"

$htmlItem = Get-Item -LiteralPath $HtmlPath
$assetsItem = Get-Item -LiteralPath $AssetsPath
$workRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("report_generator_" + [System.Guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Force -Path $workRoot | Out-Null

Copy-Item -LiteralPath $htmlItem.FullName -Destination (Join-Path $workRoot $OutputHtmlName)
Copy-Item -LiteralPath $assetsItem.FullName -Destination (Join-Path $workRoot "assets") -Recurse

$packedHtml = Join-Path $workRoot $OutputHtmlName
$content = Get-Content -LiteralPath $packedHtml -Raw -Encoding UTF8
$content = $content.Replace("../assets/", "assets/")
$content = $content.Replace("./assets/", "assets/")
Set-Content -LiteralPath $packedHtml -Value $content -Encoding UTF8

if (Test-Path -LiteralPath $OutputZip) {
  Remove-Item -LiteralPath $OutputZip -Force
}

Compress-Archive -Path (Join-Path $workRoot "*") -DestinationPath $OutputZip -Force
Remove-Item -LiteralPath $workRoot -Recurse -Force

Get-Item -LiteralPath $OutputZip
