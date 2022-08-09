# Description of what this script does along with the scripts author and date of creation
Write-Host("-----------------------------------------------------------------------------------------------")
Write-Host("List AD Users by last logon - Author: NTeakle - Date: 26/07/2022")
Write-Host("")
Write-Host("This script will generate a list of AD Users, filtering by last password reset or last logon timestamp")
Write-Host("")


# Asks the User whether or not they wish to proceed, can proceed by inputting either 'Yes' or 'No'
$title = 'something'
$question = "Are you sure you want to proceed?"


# Users choices on their inputs
$choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))


# Prompts the User with a UI, then takes the User's input and writes an output, confirming their input value
$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
    if ($decision -eq 0) {
        Write-Host 'confirmed'
    } else {
        Write-Host 'cancelled'
    }


# Sets the dats that the script will be checking for
$d = [DateTime]::Today.AddDays(-365)


# Filters AD Users by last password set/resert or their last logon timestamp
Get-ADUser -Filter '(PasswordLastSet -lt $d) -or (LastLogonTimeStamp -lt $d)' -Properties PasswordLastSet,LastLogonTimestamp | ft Name,PasswordLastSet,@{N="LastLogonTimestamp";E={[datetime]::FromFileTime($_.LastLogonTimestamp)}}


# Ensures that the script won't automatically close, will only close when the User decides.
powershell -noexit