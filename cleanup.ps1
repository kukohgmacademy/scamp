$dir = "c:\Users\saeto\Downloads\website Sunrise"
$files = Get-ChildItem -Path $dir -Filter "*.html"

foreach ($file in $files) {
    if ($file.Name -match "README") { continue }
    
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $modified = $false

    # Clean up duplicate Font Awesome references
    $faDup1 = "<link rel=`"stylesheet`" href=`"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css`"`r`n        media=`"print`" onload=`"this.media='all'`">`r`n    <link rel=`"preload`" href=`"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css`" as=`"style`" onload=`"this.onload=null;this.rel='stylesheet'`">"
    $faClean1 = "<link rel=`"preload`" href=`"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css`" as=`"style`" onload=`"this.onload=null;this.rel='stylesheet'`">"
    
    if ($content.Contains($faDup1)) {
        $content = $content.Replace($faDup1, $faClean1)
        $modified = $true
    }

    # Add defer attribute to bootstrap bundle script just in case it was missed
    $bsSync = '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>'
    $bsAsync = '<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" defer></script>'
    
    if ($content.Contains($bsSync)) {
        $content = $content.Replace($bsSync, $bsAsync)
        $modified = $true
    }

    if ($modified) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Cleaned: $($file.Name)"
    }
}
Write-Host "Done!"
