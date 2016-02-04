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
objShell.Exec "cmd /K cd C:\Python27 & python C:\Python27\opc_get_values.py > values.txt"
Set f = CreateObject("Scripting.FileSystemObject" )            
Set f = f.OpenTextFile("C:\Python27\values.txt")
response.write(f.read(100))
%>


<!--#include file="footer.inc"-->


</body>
</html>
