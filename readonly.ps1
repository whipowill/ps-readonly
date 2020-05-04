## directory to watch
$dir = "C:\path\to\your\folder"

## filename to watch
$file = "name_of_your_file_in_that_folder"

#######

## report
Write-Host "[$(Get-Date -Format "yyyy-MM-dd hh:mm")] READONLY is running."

## backup
Write-Host "[$(Get-Date -Format "yyyy-MM-dd hh:mm")] Backing up original file."
$temp = "READONLY.store"
cd "$($dir)"
cp "$($file)" "$($temp)"

## hash function
function md5hash($path)
{
    $fullPath = Resolve-Path $path
    $md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
    $file = [System.IO.File]::Open($fullPath,[System.IO.Filemode]::Open, [System.IO.FileAccess]::Read)
    try {
        [System.BitConverter]::ToString($md5.ComputeHash($file))
    } finally {
        $file.Dispose()
    }
}

## hash
$hash_original = md5hash($temp)

## loop
Write-Host "[$(Get-Date -Format "yyyy-MM-dd hh:mm")] Scanning for file changes..."
while($true)
{
    try
    {
        ## hash
        $hash = md5hash($file)

        ## if no match...
        if($hash -ne $hash_original)
        {
            ## restore
            Write-Host "[$(Get-Date -Format "yyyy-MM-dd hh:mm")] Change detected! File restored."
            cp "$($temp)" "$($file)"
        }
    }
    catch {}

    ## sleep
    Start-Sleep -Seconds 5
}