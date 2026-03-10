$files = Get-ChildItem -Filter "*.html" -Recurse

foreach ($file in $files) {
    # We will process each line to be safer, or just do global
    # Let's fix the already messed up tags first globally
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # 1. Fix the swapped tags pattern (if any)
    $content = $content -replace '</b>([^<]+)<b>', '<b>$1</b>'
    
    # 2. Replace **text** with <b>text</b>
    $content = $content -replace '\*\*(.*?)\*\*', '<b>$1</b>'
    
    # 3. Replace *text* with <b>text</b>
    # Using non-greedy and avoiding matching things that shouldn't be matched
    # We use a trick to avoid matching into <b> tags we just added
    # But since we are replacing stars with <b> it's fine
    $content = $content -replace '\*(.*?)\*', '<b>$1</b>'
    
    Set-Content $file.FullName $content -Encoding UTF8
}
