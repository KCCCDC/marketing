<!DOCTYPE html>
<html>
<head>

<!--#include file="header.inc"-->

</head>
<body>

<!--#include file="navbar.inc"-->

<h1>Welcome to National Commodity D Corporation!</h1>
<p>Look at how pretty it is</p>

<h2>Recent News</h2>
<p>There's nothing here yet!</p>

<% 
Dim objShell
Set objShell = CreateObject( "WScript.Shell" )
For i=6 To 0 Step -1
    objShell.Exec "cmd /K cd C:\inetpub\wwwroot\marketing & move /y values" & i - 1 & ".txt values" & i & ".txt"
Next

objShell.Exec "cmd /K cd C:\inetpub\wwwroot\marketing & C:\Python27\python opc_get_values.py > values0.txt"
'Seriously? http://stackoverflow.com/a/13099520
CreateObject("WScript.Shell").Run "cmd /c ping 127.0.0.1 -n " _
    & 3, 0, True

For i=0 To 6   
    Set f = CreateObject("Scripting.FileSystemObject" )
    response.write("values" & i & ".txt")
    Set f = f.OpenTextFile("C:\inetpub\wwwroot\marketing\values" & i & ".txt")
    s=Split(f.read(100), vbCrLf)
    response.write("<input type='hidden' id='relay1_breaker" & i & "' value='" & s(0) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='relay1_load" & i & "' value='" & s(1) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='relay1_flow" & i & "' value='" & s(2) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='relay2_breaker" & i & "' value='" & s(3) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='relay2_load" & i & "' value='" & s(4) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='relay2_flow" & i & "' value='" & s(5) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='gen1_breaker" & i & "' value='" & s(6) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='gen1_generation" & i & "' value='" & s(7) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='gen2_breaker" & i & "' value='" & s(8) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='gen2_generation" & i & "' value='" & s(9) & "'>" & vbCrLf & vbCrLf)
Next

%>

<!--#include file="footer.inc"-->
</body>
</html>
