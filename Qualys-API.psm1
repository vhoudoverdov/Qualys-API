$Global:Session
$Global:X_Requested_With = 'Qualys API, MyCorp.Local'
$Global:ApiRootRoute = 'https://qualysapi.qualys.com/api/2.0/fo'

<# 
 .Synopsis
  Authenticate to the Qualys API and store the resulting session variable for later use.

 .Description
  Provide an X-Requested-With header with a call to this function, and also every subsequent function call within this module.
  The session variable returned from a successful authentication will be stored for later use in subsequent function calls.

 .Example
  Login-Qualys
#>
function Login-Qualys 
{
    $Headers = @{}
    $Headers.Add("X-Requested-With",$X_Requested_With)
    $PostParameters = @{action='login';username='vh';password='password'}
    Invoke-WebRequest -Method POST -Body $PostParameters -SessionVariable $Session -Uri "$ApiRootRoute/session/"
}

<# 
 .Synopsis
  End an existing Qualys API session.

 .Description
  This function should be the last function called in any sequence of function calls from this module.  
  This prevents the user account configured for Qualys API access from being locked out.

 .Example
  Logout-Qualys
#>
function Logout-Qualys
{
    $PostParameters = @{action='logout'}
    Invoke-WebRequest -Method POST -Body $PostParameters -SessionVariable $Session -Uri "$ApiRootRoute/session/"
}

<# 
 .Synopsis
  Extract the set of IP addresses configured under a given Qualys account for ETL purposes.

 .Description
  ETL function for use with the Qualys API.  For the given Qualys account, pull a list of IP addresses which Qualys is allowed to scan.

 .Example
  Extract-AccountIPAddresses
#>
function Extract-AccountIPAddresses
{
    $Headers = @{}
    $Headers.Add("X-Requested-With",$X_Requested_With)
    $PostParameters = @{action='list'}
    Invoke-WebRequest -Method POST -Body $PostParameters -SessionVariable $Session -Uri "$ApiRootRoute/asset/ip/"
}

<# 
 .Synopsis
  Extract the set of host assets configured within the given Qualys accounts.

 .Description
  ETL function for use with the Qualys API.  For the given Qualys account, pull a list of host assets defined.

 .Example
  Extract-HostAssets
#>
function Extract-HostAssets
{
    $Headers = @{}
    $Headers.Add("X-Requested-With",$X_Requested_With)
    $PostParameters = @{action='list';echo_request=1;show_args=1;show_op=1}
    Invoke-WebRequest -Method POST -Body $PostParameters -SessionVariable $Session -Uri "$ApiRootRoute/scan/"
}

<# 
 .Synopsis
  Extract the set of historical vulnerability scans performed for a given Qualys account.

 .Description
  ETL function for use with the Qualys API.  For the given Qualys account, pull a list of historical vulnerability scans which have taken place.

 .Example
  Extract-Scans
#>
function Extract-Scans
{
    $Headers = @{}
    $Headers.Add("X-Requested-With",$X_Requested_With)
    $PostParameters = @{action='list'}
    Invoke-WebRequest -Method POST -Body $PostParameters -SessionVariable $Session -Uri "$ApiRootRoute/asset/host/"
}

<# 
 .Synopsis
  Extract the set of scheduled vulnerability scans configured for a given Qualys account.

 .Description
  ETL function for use with the Qualys API.  For the given Qualys account, pull a list of scheduled vulnerability scans.

 .Example
  Extract-ScheduledScans
#>
function Extract-ScheduledScans
{
    $Headers = @{}
    $Headers.Add("X-Requested-With",$X_Requested_With)
    Invoke-WebRequest -Method GET -SessionVariable $Session -Uri "$ApiRootRoute/schedule/scan/?action=list"
}

<# 
 .Synopsis
  Extract the set of Unix authentnication records for a given Qualys account.

 .Description
  ETL function for use with the Qualys API.  For the given Qualys account, pull a list of configured Unix authentication records.

 .Example
  Extract-UnixAuthRecords
#>
function Extract-UnixAuthRecords
{
    $Headers = @{}
    $Headers.Add("X-Requested-With",$X_Requested_With)
    $PostParameters = @{action='list'}
    Invoke-WebRequest -Method POST -Body $PostParameters -SessionVariable $Session -Uri "$ApiRootRoute/auth/unix/"
}

<# 
 .Synopsis
  Extract the set of Windows authentnication records for a given Qualys account.

 .Description
  ETL function for use with the Qualys API.  For the given Qualys account, pull a list of configured Windows authentication records.

 .Example
  Extract-WindowsAuthRecords
#>
function Extract-WindowsAuthRecords
{
    $Headers = @{}
    $Headers.Add("X-Requested-With",$X_Requested_With)
    $PostParameters = @{action='list'}
    Invoke-WebRequest -Method POST -Body $PostParameters -SessionVariable $Session -Uri "$ApiRootRoute/auth/windows/"
}

<# 
 .Synopsis
  Extract the set of asset groups for a given Qualys account.

 .Description
  ETL function for use with the Qualys API.  For the given Qualys account, pull a list of configured asset groups.

 .Example
  Extract-AssetGroups
#>
function Extract-AssetGroups
{
    $Headers = @{}
    $Headers.Add("X-Requested-With",$X_Requested_With)
    $PostParameters = @{action='list'}
    Invoke-WebRequest -Method POST -Body $PostParameters -SessionVariable $Session -Uri "$ApiRootRoute/asset/group/"
}

<# 
 .Synopsis
  Launch a vulnerability scan.

 .Description
  Within a given Qualys account, launch a vulnerability scan.

 .Example
  Launch-VulnerabilityScan
#>
function Launch-VulnerabilityScan
{
    $Headers = @{}
    $Headers.Add("X-Requested-With",$X_Requested_With)
    $PostParameters = @{action='launch';scan_title=$ScanTitle;ip=$TargetIP;option_title=$OptionTitle;iscanner_name=$ScannerName}
    Invoke-WebRequest -Method POST -Body $PostParameters -SessionVariable $Session -Uri "$ApiRootRoute/scan/"
}

<# 
 .Synopsis
  Cancel a vulnerability scan.

 .Description
  For a given Qualys vulnerability scan, cancel the scan.

 .Example
  Cancel-VulnerabilityScan
#>
function Cancel-VulnerabilityScan
{
    $Headers = @{}
    $Headers.Add("X-Requested-With",$X_Requested_With)
    $PostParameters = @{action='cancel';scan_ref=$ScanReference}
    Invoke-WebRequest -Method POST -Body $PostParameters -SessionVariable $Session -Uri "$ApiRootRoute/scan/"
}

<# 
 .Synopsis
  Pause a vulnerability scan.

 .Description
  For a given Qualys vulnerability scan, pause the scan.

 .Example
  Pause-VulnerabilityScan
#>
function Pause-VulnerabilityScan
{
    $Headers = @{}
    $Headers.Add("X-Requested-With",$X_Requested_With)
    $PostParameters = @{action='pause';scan_ref=$ScanReference}
    Invoke-WebRequest -Method POST -Body $PostParameters -SessionVariable $Session -Uri "$ApiRootRoute/scan/"
}

<# 
 .Synopsis
  Resume a vulnerability scan.

 .Description
  For a given Qualys vulnerability scan, resume the scan.

 .Example
  Resume-VulnerabilityScan
#>
function Resume-VulnerabilityScan
{
    $Headers = @{}
    $Headers.Add("X-Requested-With",$X_Requested_With)
    $PostParameters = @{action='resume';scan_ref=$ScanReference}
    Invoke-WebRequest -Method POST -Body $PostParameters -SessionVariable $Session -Uri "$ApiRootRoute/scan/"
}