function new-translation-line {
    Write-Host "`nWord: " -f Yellow -NoNewline; $newglossaryword = read-host;
    Write-Host "Translation: " -f Yellow -NoNewline; $newglossarytranslation = read-host;
    return $newglossaryword + "-" + $newglossarytranslation
}
function do-glossary([string]$glossary, [string]$mode) {
    $correcttranslations = 0
    $alltranslations = 0
    $atline = 0
    cls
    Write-Host "----= $glossary =----" -f Green;
    Get-Content "glossarys\$glossary.txt" | ForEach-Object {
        if ($mode -eq 1) {
            $atline += 1;
            if ($atline -gt 1) {
                if($_ -match $regex){
                    $word_translation = $_.ToString().Split("-")
                    $word = $word_translation[0]
                    $translation = $word_translation[1]
            
                    Write-Host "Translate '$word': " -f Yellow -NoNewline; $usertranslation = Read-Host;
                    if (-not ($usertranslation.ToLower() -eq $translation)) {
                        Write-Host "Wrong! Correct translation is '" -f Red -NoNewline; Write-Host $translation -f Yellow -NoNewline; Write-Host "'..." -f Red;
                        $alltranslations += 1;
                    }else {
                        Write-Host "Correct!" -f Green;
                        $correcttranslations += 1;
                        $alltranslations += 1;
                    }
                }
            }
        }elseif ($mode -eq 2) {
            $atline += 1;
            if ($atline -gt 1) {
                if($_ -match $regex){
                    $word_translation = $_.ToString().Split("-")
                    $translation = $word_translation[0]
                    $word = $word_translation[1]
            
                    Write-Host "Translate '$word': " -f Yellow -NoNewline; $usertranslation = Read-Host;
                    if (-not ($usertranslation.ToLower() -eq $translation)) {
                        Write-Host "Wrong! Correct translation is '" -f Red -NoNewline; Write-Host $translation -f Yellow -NoNewline; Write-Host "'..." -f Red;
                        $alltranslations += 1;
                    }else {
                        Write-Host "Correct!" -f Green;
                        $correcttranslations += 1;
                        $alltranslations += 1;
                    }
                }
            }
        }elseif ($mode -eq 3) {
            $atline += 1;
            if ($atline -gt 1) {
                if($_ -match $regex){
                    $word_translation = $_.ToString().Split("-")
                    $word = $word_translation[0]
                    $translation = $word_translation[1]
            
                    Write-Host "Translate '$word': " -f Yellow -NoNewline; $usertranslation = Read-Host;
                    if (-not ($usertranslation.ToLower() -eq $translation)) {
                        Write-Host "Wrong! Correct translation is '" -f Red -NoNewline; Write-Host $translation -f Yellow -NoNewline; Write-Host "'..." -f Red;
                        $alltranslations += 1;
                    }else {
                        Write-Host "Correct!" -f Green;
                        $correcttranslations += 1;
                        $alltranslations += 1;
                    }
                }
            }
        }
    }
    $score = [math]::Round($correcttranslations*100/$alltranslations)
    if ($score -lt 50) { Write-Host "`nAlmost! You knew only $score% of the words..." -f Red }
    if ($score -eq 50) { Write-Host "`nDecent! You knew 50% of the words." -f yellow }
    if ($score -ge 50 -and $score -lt 100) { Write-Host "`nGood! You knew $score% of the words!.." -f yellow }
    if ($score -eq 100) { Write-Host "`nGreat! You knew 100% of the words!" -f green }
    Write-Host "`nDo the Glossary Again? [y/n]: " -f yellow -NoNewline; $again = Read-Host;
    if ($again.ToLower() -eq "y") {
        do-glossary $glossary $mode
    }
}

cls
Write-Host "-= Glossarys =-`n" -f Yellow;
Get-ChildItem "glossarys" -Filter *.txt | 
Foreach-Object {
    write-host "-" $_.ToString().TrimEnd("txt").TrimEnd('.') -NoNewline;
    $glossarylanguage = Get-Content "glossarys\$_" -First 1
    Write-Host $glossarylanguage.ToString().Replace("#>", "  (").Replace("<#", ")").Replace("-", " to ") -f DarkGray;

}
Write-Host "`n---------------" -f Yellow;
Write-Host "Start glossary by entering them name from above." -f DarkGray;
Write-Host "new - create an new glossary." -f DarkGray;
Write-Host "del - delete an glossary." -f DarkGray;
Write-Host "Choice: " -f Yellow -NoNewline; $choice = Read-Host;

if ($choice.ToLower() -eq "new") {
    Write-Host "Name of Glossary: " -f Yellow -NoNewline; $newglossaryname = read-host;
    Write-Host "Enter what languages the following glossary will translate between..." -f DarkGray;
    Write-Host "Words are in: " -f Yellow -NoNewline; $newglossarywords_lan = read-host;
    Write-Host "Translations are in: " -f Yellow -NoNewline; $newglossarytranslations_lan = read-host;
        # Save information to file
    Add-Content -path "glossarys\$newglossaryname.txt" "#>$newglossarywords_lan-$newglossarytranslations_lan<#";
    
    while($true) {
        $translationline = new-translation-line;
        if ($translationline -eq "-") {
            Write-Host "`nAre you done? [y/n]: " -f Yellow -NoNewline; $newglossarysaveq = Read-Host;
            if ($newglossarysaveq.toLower() -eq "y") {
                break;
                break;
                break;
            }
        }else {
            # Save new line to file
            Add-Content -path "glossarys\$newglossaryname.txt" "$translationline";
        }
    }

}elseif ($choice.ToLower() -eq "del") {
    Write-Host "Delete Glossary: " -f Yellow -NoNewline; $delglos = Read-Host;
    Remove-Item "glossarys\$delglos.txt"

}else {
    Write-Host "Modes:" -f DarkGray;
    Write-Host "1 - Words to Translations" -f DarkGray;
    Write-Host "2 - Translations to Words" -f DarkGray;
    Write-Host "3 - Read all words in a context  (Under construction...)" -f DarkGray;
    Write-Host "Select: " -f Yellow -NoNewline; $glosmode = Read-Host;
    if ($glosmode -le 3) {
        do-glossary $choice $glosmode
    }
}