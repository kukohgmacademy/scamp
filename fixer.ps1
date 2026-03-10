$dir = "c:\Users\saeto\Downloads\website Sunrise"
$files = Get-ChildItem -Path $dir -Filter "*.html"

foreach ($file in $files) {
    if ($file.Name -match "README") { continue }
    
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $modified = $false

    # Fix the literal backticks
    if ($content.Contains("``r``n")) {
        $content = $content.Replace("``r``n", "`r`n")
        $modified = $true
    }
    
    # Fix the nested noscript in index.html specifically or others
    $nestedNoscript = "<noscript>`r`n        <link rel=`"preload`" href=`"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css`" as=`"style`" onload=`"this.onload=null;this.rel='stylesheet'`">`r`n    <noscript><link rel=`"stylesheet`" href=`"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css`"></noscript>`r`n    </noscript>"
    $fixedNoscript = "<link rel=`"preload`" href=`"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css`" as=`"style`" onload=`"this.onload=null;this.rel='stylesheet'`">`r`n    <noscript><link rel=`"stylesheet`" href=`"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css`"></noscript>"
    
    if ($content.Contains($nestedNoscript)) {
        $content = $content.Replace($nestedNoscript, $fixedNoscript)
        $modified = $true
    }

    if ($modified) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Fixed: $($file.Name)"
    }
}
Write-Host "Done!"
