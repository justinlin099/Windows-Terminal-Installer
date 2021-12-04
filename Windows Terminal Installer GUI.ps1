#Download and deploy latest Windows Terminal release from github

Write-Host Windows Terminal Installer GUI by Justin Lin

#建立檔案暫存資料夾
New-Item -Name "WTInstaller" -ItemType "directory"

#建立Windows Forms視窗
Add-Type -assembly System.Windows.Forms
$main_window = New-Object System.Windows.Forms.Form
$main_window.Text = "Windows Terminal Installer"
Invoke-WebRequest https://raw.githubusercontent.com/justinlin099/Windows-Terminal-Installer/main/Images/Terminal.ico -Out WTInstaller\icon.ico
$icon = New-Object system.drawing.icon ("WTInstaller\icon.ico")
$main_window.Icon = $icon
$main_window.Width = 600
$main_window.Height =425
$main_window.FormBorderStyle = 'FixedSingle'
$main_window.MaximizeBox = $false

#UI Elements
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

#Show Window
$main_window.ShowDialog()
