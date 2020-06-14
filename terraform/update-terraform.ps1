# updates the shared terraform plugins directory with a new aws provider so that
# terraform init doesn't try to download a new copy every dang time

$tmpDir = "$env:TEMP/update-terraform";

Remove-Item -Recurse -Force "$env:AppData/terraform.d/plugins" > $null;
New-Item -ItemType Directory $tmpDir -ErrorAction SilentlyContinue  > $null;
'provider "aws" { region = "us-east-1" }' | Out-File (Join-Path $tmpDir "tmp.tf") -Encoding ASCII > $null;
& terraform init $tmpDir > $null;
Move-Item ".terraform/plugins" "$env:AppData/terraform.d/" > $null;
Remove-Item -Recurse -Force $tmpDir > $null;