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
'objShell.Exec "cmd /K cd C:\Python27 & python C:\Python27\opc_get_values.py > values.txt"
Set f = CreateObject("Scripting.FileSystemObject" )            
Set f = f.OpenTextFile("C:\Python27\values.txt")
s=Split(f.read(100), vbCrLf)
response.write("<input type='hidden' id='relay1_breaker' value='" & s(0) & "'>" & vbCrLf)
response.write("<input type='hidden' id='relay1_load' value='" & s(1) & "'>" & vbCrLf)
response.write("<input type='hidden' id='relay1_flow' value='" & s(2) & "'>" & vbCrLf)
response.write("<input type='hidden' id='relay2_breaker' value='" & s(3) & "'>" & vbCrLf)
response.write("<input type='hidden' id='relay2_load' value='" & s(4) & "'>" & vbCrLf)
response.write("<input type='hidden' id='relay2_flow' value='" & s(5) & "'>" & vbCrLf)
response.write("<input type='hidden' id='gen1_breaker' value='" & s(6) & "'>" & vbCrLf)
response.write("<input type='hidden' id='gen1_generation' value='" & s(7) & "'>" & vbCrLf)
response.write("<input type='hidden' id='gen2_breaker' value='" & s(8) & "'>" & vbCrLf)
response.write("<input type='hidden' id='gen2_generation' value='" & s(9) & "'>" & vbCrLf & vbCrLf)
%>

<!--#include file="footer.inc"-->
</body>
</html>
