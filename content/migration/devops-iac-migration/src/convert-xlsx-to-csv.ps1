[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$fullFilePath
)
# full file path name of the xlsx document
$excelFileName = $fullFilePath

Function WorksheetToCSV ($excelFileName)
{
    $excelFile = $fullFilePath
    $excelObj = New-Object -ComObject Excel.Application
    $excelObj.Visible = $false
    $excelObj.DisplayAlerts = $false
    $workbooks = $excelObj.Workbooks.Open($excelFile)
    foreach ($worksheets in $workbooks.Worksheets)
    {
        $csvName = $worksheets.Name
        if ($worksheets.Name -eq "All_Assessed_Disks" -or $worksheets.Name -eq "All_Assessed_Machines") {
            $worksheets.SaveAs($pwd.Path + "\" + $csvName + ".csv", 6)
        }
    }
    $excelObj.Quit()
}
WorksheetToCSV -excelFileName $excelFileName
