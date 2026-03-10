$files = Get-ChildItem -Filter "*.html" -Recurse

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 1. Handle double asterisks **text** -> <b>text</b>
    # Using non-greedy match to avoid matching across multiple occurrences
    $content = [regex]::Replace($content, '\*\*([^\*]+)\*\*', '<b>$1</b>')
    
    # 2. Handle single asterisks *text* -> <b>text</b>
    # Be careful not to match things like CSS comments or multiplication
    # We target patterns like (*text*) or just *text* in paragraphs
    $content = [regex]::Replace($content, '\*([^\*\s][^\*]*[^\*\s])\*', '<b>$1</b>')
    # Also handle single characters like *a* if they exist
    $content = [regex]::Replace($content, '\*([^\*\s])\*', '<b>$1</b>')
    
    Set-Content $file.FullName $content -Encoding UTF8
}
