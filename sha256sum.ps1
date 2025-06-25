if($args.Count -eq 0) {
  Write-Host "Usage: .\$($MyInvocation.MyCommand.Name) string to be hashed";
  exit 1
}

$stringAsStream = [System.IO.MemoryStream]::new()
$writer = [System.IO.StreamWriter]::new($stringAsStream)
$writer.write("$args")
$writer.Flush()
$stringAsStream.Position = 0
Get-FileHash -Algorithm SHA256 -InputStream $stringAsStream `
  | Select-Object Hash `
  | ForEach-Object {$_.Hash}