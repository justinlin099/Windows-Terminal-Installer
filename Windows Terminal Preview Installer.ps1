#Download and deploy latest Windows Terminal Prerelease from github

Write-Host Windows Terminal Preview Installer by Justin Lin V1.00

$repo = "microsoft/terminal"
$releases = "https://api.github.com/repos/$repo/releases"
$taglst = (Invoke-WebRequest $releases | ConvertFrom-Json).tag_name
$prereleaselst = (Invoke-WebRequest $releases | ConvertFrom-Json).prerelease

for (($i = 0); $i -lt $prereleaselst.count ; $i++ )
{
	if ($prereleaselst[$i] -match "True"){
		$prereleaseindex = $i
		break
	}
}

$tag = $taglst[$prereleaseindex]
$file =  "Microsoft.WindowsTerminalPreview_"+$tag.Remove(0,1)+"_8wekyb3d8bbwe.msixbundle"
$downloadpath = "https://github.com/$repo/releases/download/$tag/$file"

Write-Host Downloading Latest Version of Windows Terminal Preview
Invoke-WebRequest $downloadpath -Out $file

Write-Host Installing Windows Terminal $tag
Add-AppxPackage -Path $file