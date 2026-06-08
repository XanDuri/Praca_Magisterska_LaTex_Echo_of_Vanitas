$ErrorActionPreference = "Continue"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

# Ensure MiKTeX is on PATH for this session.
$miktexBin = "C:\Users\foxto\AppData\Local\Programs\MiKTeX\miktex\bin\x64"
if (Test-Path $miktexBin) {
    $env:Path = "$miktexBin;" + $env:Path
}

$main      = "MBZUAI-main"
$buildDir  = "build"
$logFile   = Join-Path $scriptDir "build.log"
if (Test-Path $logFile) { Remove-Item $logFile }
if (-not (Test-Path $buildDir)) { New-Item -ItemType Directory -Path $buildDir | Out-Null }

# Wyrzuć wszystkie pomocnicze pliki z katalogu głównego (mogą blokować budowę).
foreach ($ext in @("aux","toc","lof","lot","out","bbl","blg","idx","ilg","ind","nlo","nls")) {
    Get-ChildItem -Filter "*.$ext" -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
}
Get-ChildItem -Path "Chapters" -Filter "*.aux" -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue

# Stary PDF (jeśli zablokowany przez podgląd, ostrzeżenie, ale nie przerywamy).
if (Test-Path "$main.pdf") {
    try { Remove-Item "$main.pdf" -Force -ErrorAction Stop }
    catch { Write-Host "Uwaga: stary $main.pdf jest zablokowany. Zamknij podgląd i uruchom ponownie." -ForegroundColor Yellow }
}

function Invoke-Stage {
    param([string]$Name, [scriptblock]$Block)
    Write-Host "==[ $Name ]==" -ForegroundColor Cyan
    "==[ $Name ]==" | Out-File -Append -FilePath $logFile -Encoding utf8
    & $Block *>&1 | Out-File -Append -FilePath $logFile -Encoding utf8
    Start-Sleep -Milliseconds 800
}

# Zapewnij subkatalog dla podrozdziałów .aux (Chapters/, jeśli używamy --output-directory).
if (-not (Test-Path "$buildDir/Chapters")) { New-Item -ItemType Directory -Path "$buildDir/Chapters" | Out-Null }

$pdfArgs = "-interaction=nonstopmode -shell-escape -output-directory=$buildDir"

Invoke-Stage "pdflatex (pass 1)" { pdflatex $pdfArgs.Split(" ") "$main.tex" }
# bibtex musi być uruchomiony z poziomu katalogu build/, żeby widział Chapters/*.aux
Invoke-Stage "bibtex" {
    Push-Location $buildDir
    $env:BIBINPUTS = "..;..\bibliography;"
    $env:BSTINPUTS = "..;"
    bibtex "$main"
    Pop-Location
}
$nloPath = Join-Path $buildDir "$main.nlo"
if (Test-Path $nloPath) {
    Invoke-Stage "makeindex (nomenclature)" { makeindex "$nloPath" -s nomencl.ist -o "$buildDir/$main.nls" }
}
Invoke-Stage "pdflatex (pass 2)" { pdflatex $pdfArgs.Split(" ") "$main.tex" }
Invoke-Stage "pdflatex (pass 3)" { pdflatex $pdfArgs.Split(" ") "$main.tex" }

# Skopiuj PDF do katalogu głównego.
$builtPdf = Join-Path $buildDir "$main.pdf"
$finalPdf = Join-Path $scriptDir "$main.pdf"
if (Test-Path $builtPdf) {
    try { Copy-Item -Path $builtPdf -Destination $finalPdf -Force -ErrorAction Stop }
    catch { Write-Host "Nie mogę skopiować PDF do katalogu głównego (zablokowany?). PDF jest w $builtPdf" -ForegroundColor Yellow }
}

if (Test-Path $finalPdf) {
    $size = (Get-Item $finalPdf).Length / 1KB
    $tlog = Join-Path $buildDir "$main.log"
    $errCount  = 0
    $warnCount = 0
    if (Test-Path $tlog) {
        $errCount  = @(Select-String -Path $tlog -Pattern "^! ").Count
        $warnCount = @(Select-String -Path $tlog -Pattern "^LaTeX Warning|^Package .* Warning|Citation .* undefined|Reference .* undefined").Count
    }
    Write-Host ""
    Write-Host ("OK -> {0}  ({1} KB)" -f $finalPdf, [math]::Round($size,1)) -ForegroundColor Green
    Write-Host ("Errors: {0}  Warnings: {1}  (details in build.log)" -f $errCount, $warnCount) -ForegroundColor DarkGray
    if ($errCount -gt 0) { exit 2 }
}
else {
    Write-Host "PDF was not produced. Inspect build.log and $buildDir/$main.log." -ForegroundColor Red
    exit 1
}
