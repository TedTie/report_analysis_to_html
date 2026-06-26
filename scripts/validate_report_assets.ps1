param(
  [Parameter(Mandatory=$true)][string]$HtmlPath,
  [Parameter(Mandatory=$true)][string]$AssetsPath
)

$ErrorActionPreference = "Stop"

$htmlItem = Get-Item -LiteralPath $HtmlPath
$assetsItem = Get-Item -LiteralPath $AssetsPath
$html = Get-Content -LiteralPath $htmlItem.FullName -Raw -Encoding UTF8
$issues = New-Object System.Collections.Generic.List[string]

if ($html -match "https?://") {
  $issues.Add("HTML contains external URL references. Confirm whether external dependencies are allowed.")
}

$matches = [regex]::Matches($html, '(?:src|href)=["'']([^"'']+)["'']')
foreach ($match in $matches) {
  $path = $match.Groups[1].Value
  if ($path -match '^(#|mailto:|tel:|data:|javascript:|https?://)') {
    continue
  }
  if ($path -match '\.(png|jpg|jpeg|gif|webp|svg|css|js|woff|woff2|ttf)$') {
    $normalized = $path.Replace("/", "\")
    $candidate = Join-Path $htmlItem.DirectoryName $normalized
    if (-not (Test-Path -LiteralPath $candidate)) {
      $issues.Add("Missing local asset: $path")
    }
  }
}

$internalTerms = @(
  "TODO",
  "FIXME",
  "internal note",
  "production note",
  "draft note",
  "leader needs to see",
  "this page is for"
)
foreach ($term in $internalTerms) {
  if ($html.Contains($term)) {
    $issues.Add("Possible internal note remains in HTML: $term")
  }
}

if (-not (Test-Path -LiteralPath $assetsItem.FullName)) {
  $issues.Add("Assets path does not exist.")
}

if ($issues.Count -gt 0) {
  $issues | ForEach-Object { Write-Output $_ }
  exit 1
}

Write-Output "Validation passed."
