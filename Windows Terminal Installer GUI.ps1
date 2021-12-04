#Download and deploy latest Windows Terminal release from github

Write-Host Windows Terminal Installer GUI by Justin Lin

Write-Host Checking Windows Version...
$WinVersion = (Get-ComputerInfo).WindowsVersion
if ($WinVersion -lt 1903){
    [System.Windows.Forms.MessageBox]::Show("You are running Windows Version "+$WinVersion+" ,The minimal requirement is version 1903. Please update your Windows and try again." , "Please update your Windows")
    break
}

#Create Temp Folder
New-Item -Name "WTInstaller" -ItemType "directory"

#Create Windows Forms Window
Add-Type -assembly System.Windows.Forms
$main_window = New-Object System.Windows.Forms.Form
$main_window.Text = "Windows Terminal Installer"
Invoke-WebRequest https://raw.githubusercontent.com/justinlin099/Windows-Terminal-Installer/main/Images/Terminal.ico -Out WTInstaller\icon.ico
$icon = New-Object system.drawing.icon ("WTInstaller\icon.ico")
$main_window.Icon = $icon
$main_window.Width = 600
$main_window.Height =440
$main_window.FormBorderStyle = 'FixedSingle'
$main_window.MaximizeBox = $false
$main_window.StartPosition = "CenterScreen"

#UI Label Elements
$label1 = New-Object System.Windows.Forms.Label
$label1.Location = New-Object System.Drawing.point(30,30)
$label1.Size = New-Object System.Drawing.Size(356,34)
$label1.Text = "Windows Terminal Installer"
$label1.Font = New-Object System.Drawing.Font("Arial", 20)
$main_window.Controls.Add($label1)

$label2 = New-Object System.Windows.Forms.Label
$label2.Location = New-Object System.Drawing.point(33,64)
$label2.Size = New-Object System.Drawing.Size(247,16)
$label2.Text = "Please select the version you want to install"
$label2.Font = New-Object System.Drawing.Font("Arial", 9)
$main_window.Controls.Add($label2)

$label3 = New-Object System.Windows.Forms.Label
$label3.Location = New-Object System.Drawing.point(33,367)
$label3.Size = New-Object System.Drawing.Size(500,16)
$label3.Text = "Ready to Install"
$label3.Font = New-Object System.Drawing.Font("Arial", 9)
$main_window.Controls.Add($label3)

[System.Windows.Forms.Application]::EnableVisualStyles()

#Add WTStable Button
Invoke-WebRequest https://raw.githubusercontent.com/justinlin099/Windows-Terminal-Installer/main/Images/WTIMG.png -Out WTInstaller\WTIMG.png
$wtimg = [System.Drawing.Image]::Fromfile("WTInstaller\WTIMG.png")
$WTStable = New-Object System.Windows.Forms.Button
$WTStable.Location = New-Object System.Drawing.Point(36,97)
$WTStable.Size = New-Object System.Drawing.Size(250,250)
$WTStable.Text = 'Windows Terminal'
$WTStable.Font = New-Object System.Drawing.Font("Arial", 9)
$WTStable.Padding = New-Object System.Windows.Forms.Padding(5)
$WTStable.Image = $wtimg
$WTStable.TextAlign = 'BottomLeft'
$WTStable.FlatStyle = 'Standard'
$main_window.Controls.Add($WTStable)
$WTStable.Add_Click(
    {
        #Download and deploy latest Windows Terminal release from github

        Write-Host Windows Terminal Installer by Justin Lin V1.00

        $WTStable.Enabled = $false
        $WTPre.Enabled = $false
        $label3.Text = "Loading latest stable version"
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

        $label3.Text = "Downloading Latest Version of Windows Terminal"
        Write-Host Downloading Latest Version of Windows Terminal
        Invoke-WebRequest $downloadpath -Out WTInstaller/$file

        $label3.Text = "Installing Windows Terminal $tag"
        Write-Host Installing Windows Terminal $tag
        Add-AppxPackage -Path WTInstaller/$file

        #Complete Message
        $label3.Text = "Installation Complete"
        [System.Windows.Forms.MessageBox]::Show("Windows Terminal "+$tag+" has been successfully installed on your computer." , "Installation Complete")
        $WTStable.Enabled = $true
        $WTPre.Enabled = $true
    }
)

#Add WTPre Button
Invoke-WebRequest https://raw.githubusercontent.com/justinlin099/Windows-Terminal-Installer/main/Images/WTPIMG.png -Out WTInstaller\WTPIMG.png
$wtpimg = [System.Drawing.Image]::Fromfile("WTInstaller\WTPIMG.png")
$WTPre = New-Object System.Windows.Forms.Button
$WTPre.Location = New-Object System.Drawing.Point(292,97)
$WTPre.Size = New-Object System.Drawing.Size(250,250)
$WTPre.Text = 'Windows Terminal Preview'
$WTPre.Font = New-Object System.Drawing.Font("Arial", 9)
$WTPre.Padding = New-Object System.Windows.Forms.Padding(5)
$WTPre.Image = $wtpimg
$WTPre.TextAlign = 'BottomLeft'
$WTPre.FlatStyle = 'Standard'
$main_window.Controls.Add($WTPre)
$WTPre.Add_Click(
    {
        #Download and deploy latest Windows Terminal prerelease from github

        Write-Host Windows Terminal Installer by Justin Lin V1.00

        $WTStable.Enabled = $false
        $WTPre.Enabled = $false
        $label3.Text = "Loading latest preview version"
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

        $label3.Text = "Downloading Latest Version of Windows Terminal Preview"
        Write-Host Downloading Latest Version of Windows Terminal Preview
        Invoke-WebRequest $downloadpath -Out WTInstaller/$file

        $label3.Text = "Installing Windows Terminal Preview $tag"
        Write-Host Installing Windows Terminal Preview $tag
        Add-AppxPackage -Path WTInstaller/$file

        #Complete Message
        $label3.Text = "Installation Complete"
        [System.Windows.Forms.MessageBox]::Show("Windows Terminal Preview "+$tag+" has been successfully installed on your computer." , "Installation Complete")
        $WTStable.Enabled = $true
        $WTPre.Enabled = $true
    }
)


#Show Window
$main_window.ShowDialog()


$wtimg.Dispose()
$wtpimg.Dispose()
Remove-Item 'WTInstaller\' -Recurse -Force
