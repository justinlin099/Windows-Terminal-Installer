#Download and deploy latest Windows Terminal release from github

Write-Host Windows Terminal Installer GUI by Justin Lin

#建立檔案暫存資料夾
New-Item -Name "WTInstaller" -ItemType "directory"

#建立Windows Forms視窗
Add-Type -assembly System.Windows.Forms
$main_window = New-Object System.Windows.Forms.Form
$main_window.Text = "Windows Terminal Installer"
Invoke-WebRequest https://raw.githubusercontent.com/justinlin099/Windows-Terminal-Installer/main/Terminal.ico -Out WTInstaller\icon.ico
$icon = New-Object system.drawing.icon ("WTInstaller\icon.ico")
$main_window.Icon = $icon
$main_window.Width = 600
$main_window.Height =425
$main_window.ShowDialog()
