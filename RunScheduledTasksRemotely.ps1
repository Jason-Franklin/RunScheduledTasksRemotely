<# ***** Run Scheduled Tasks Remotely *****

    07/23/2020 - Jason Franklin
        #Script to run scheduled tasks remotely

********* Add revisions above ********* #>

#Get credentials for service account login
#Change "ServiceAccountName" with desired service account

$cred = Get-Credential ServiceAccountName

#Change this to the path where you placed the script and the .txt file

$path = 'C:\Users\YourDirectory'

#Get content of server list file

$servers = get-content $path\ScheduledTaskHostList.txt

#Show progress of tasks

Write-progress -Activity "Running tasks." -currentoperation "logging into hosts...."

Foreach ($hostName in $servers) {

$sess = New-PSSession -Credential $cred -ComputerName $hostname

#Run scheduled task and write output to powershell window when successful
#Change "Scheduled Task Name" to your desired scheduled task

Invoke-Command -session $sess -scriptblock { 
    Start-ScheduledTask -TaskName "Scheduled Task Name"| get-scheduledtaskinfo
    Write-Host "$Using:hostName > Successful."
 }
Remove-PSSession $sess
}
