# Railway Cartesian Product Generator

$class = "S_CHAIR"

Write-Host "=============================="
Write-Host "   AVAILABLE DATES"
Write-Host "=============================="
$dates = @{}
for ($i = 0; $i -le 10; $i++) {
    $dateStr = (Get-Date).AddDays($i).ToString('dd-MMM-yyyy')
    $idx = $i + 1
    $dates[$idx] = $dateStr
    Write-Host "$idx = $dateStr"
}
Write-Host ""

Write-Host "=============================="
Write-Host "   AVAILABLE GROUPS"
Write-Host "=============================="

# Read groups
$groups = @{}
$stations = @()
$groupLines = Get-Content -Path "groups.txt"
$count = 1
foreach ($line in $groupLines) {
    if (-not [string]::IsNullOrWhiteSpace($line)) {
        $groups[$count] = $line -split "," | ForEach-Object { $_.Trim() }
        Write-Host "$count = $line"
        
        foreach ($st in $groups[$count]) {
            if ($st -notin $stations) {
                $stations += $st
            }
        }
        $count++
    }
}
Write-Host ""

$inputStr = Read-Host "Enter date index and combination (example 1 2x3) or 'cm' for custom"

if ($inputStr.Trim().ToLower() -eq 'cm') {
    Write-Host ""
    Write-Host "=============================="
    Write-Host "   ALL STATIONS"
    Write-Host "=============================="
    
    # Display stations column-wise, 5 per column (5 rows)
    $rowCount = 5
    $colCount = [math]::Ceiling($stations.Count / $rowCount)
    for ($r = 0; $r -lt $rowCount; $r++) {
        $rowStr = ""
        for ($c = 0; $c -lt $colCount; $c++) {
            $idx = $c * $rowCount + $r
            if ($idx -lt $stations.Count) {
                $stIdx = $idx + 1
                $rowStr += "{0,-2}: {1,-18}" -f $stIdx, $stations[$idx]
            }
        }
        Write-Host $rowStr
    }
    
    Write-Host ""
    $cmInput = Read-Host "Enter station indices (e.g. 1 3 5,6 7) using comma"
    $parts = $cmInput -split ","
    if ($parts.Length -lt 2) {
        Write-Host "Invalid format. Expected comma."
        exit
    }
    
    $g1Idxs = @()
    foreach ($t in ($parts[0].Trim() -split "\s+")) {
        if ($t -match "^(\d+)-(\d+)$") { $g1Idxs += [int]$matches[1]..[int]$matches[2] }
        elseif ($t -match "^\d+$") { $g1Idxs += [int]$t }
    }
    
    $g2Idxs = @()
    foreach ($t in ($parts[1].Trim() -split "\s+")) {
        if ($t -match "^(\d+)-(\d+)$") { $g2Idxs += [int]$matches[1]..[int]$matches[2] }
        elseif ($t -match "^\d+$") { $g2Idxs += [int]$t }
    }
    
    $customGroup1 = @()
    foreach ($idx in $g1Idxs) {
        $customGroup1 += $stations[[int]$idx - 1]
    }
    
    $customGroup2 = @()
    foreach ($idx in $g2Idxs) {
        $customGroup2 += $stations[[int]$idx - 1]
    }
    
    Write-Host ""
    Write-Host "Custom Group 1: $($customGroup1 -join ', ')"
    Write-Host "Custom Group 2: $($customGroup2 -join ', ')"
    Write-Host ""
    
    $inputStr = Read-Host "Enter date index and combo for custom groups (e.g. 2 1x2)"
    
    # Override groups dictionary mapping to custom 1 and 2
    $groups = @{}
    $groups[1] = $customGroup1
    $groups[2] = $customGroup2
}

# Parse final input like "1 2x3"
$regex = '(\d+)\s+(\d+)[xX](\d+)'
if ($inputStr -match $regex) {
    $dateIdx = [int]$matches[1]
    $g1 = [int]$matches[2]
    $g2 = [int]$matches[3]
    
    $selectedDate = $dates[$dateIdx]
    $list1 = $groups[$g1]
    $list2 = $groups[$g2]
    
    Write-Host ""
    Write-Host "Opening Cartesian Product for $selectedDate..."
    Write-Host ""
    
    foreach ($from in $list1) {
        foreach ($to in $list2) {
            Write-Host "$from -> $to"
            $url = "https://eticket.railway.gov.bd/booking/train/search?fromcity=$from&tocity=$to&doj=$selectedDate&class=$class"
            Write-Host $url
            Start-Process "msedge" -ArgumentList $url
            Start-Sleep -Seconds 1
        }
    }
    
    Write-Host "`nDone."
} else {
    Write-Host "Invalid input format."
}
