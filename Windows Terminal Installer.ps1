#Download and deploy latest Windows Terminal release from github

Write-Host Windows Terminal Installer by Justin Lin V1.00
$repo = "microsoft/terminal"
$releases = "https://api.github.com/repos/$repo/releases"
$taglst = (Invoke-WebRequest $releases | ConvertFrom-Json).tag_name
$prereleaselst = (Invoke-WebRequest $releases | ConvertFrom-Json).prerelease

for (($i = 0); $i -lt $prereleaselst.count ; $i++ )
{
	if ($prereleaselst[$i] -match "False"){
		$stablereleaseindex = $i
		break
	}
}

$tag = $taglst[$stablereleaseindex]
$file =  "Microsoft.WindowsTerminal_"+$tag.Remove(0,1)+"_8wekyb3d8bbwe.msixbundle"
$downloadpath = "https://github.com/$repo/releases/download/$tag/$file"

Write-Host Downloading Latest Version of Windows Terminal
Invoke-WebRequest $downloadpath -Out $file

Write-Host Installing Windows Terminal $tag
Add-AppxPackage -Path $file