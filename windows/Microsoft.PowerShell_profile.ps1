# git aliasing
function Get-GitStatus {
	git status
}
Set-Alias gst Get-GitStatus

New-Alias l Get-ChildItem
New-Alias which get-command
# New-Alias chromeNone 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe --bwsi'
del alias:cat -Force
Set-Alias cat bat
del alias:gc -Force
Set-Alias gc "gcloud"

# posh-git stuff
if (Get-Module -ListAvailable -Name posh-git) {
  Import-Module posh-git
  $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = "~"
  $GitPromptSettings.AfterText = "]`n"
}
else {
  PowerShellGet\Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
}

Set-Location ~
