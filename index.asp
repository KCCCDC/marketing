<!DOCTYPE html>
<html>
<head>

<!--#include file="header.inc"-->
<script src="static/Chart.min.js"></script>
</head>
<body>

<!--#include file="navbar.inc"-->
<br /><br />
<h1>Welcome to National Commodity D Corporation!</h1>

<h2>Recent News</h2>
<p>There's nothing here yet!</p>

<h2>Real-Time Data</h2>

<canvas id="relay_chart" width="400" height="400"></canvas>
<canvas id="gen_chart" width="400" height="400"></canvas>
<br /><br /><br /><br /><br /><br />

<% 
Dim objShell
Set objShell = CreateObject( "WScript.Shell" )
'If there aren't 10 value files, you will get errors on the page. Just refresh the page until all 10 files are created.
For i=10 To 1 Step -1
    objShell.Exec "cmd /K cd C:\inetpub\wwwroot\marketing & copy /y values" & i - 1 & ".txt values" & i & ".txt"
    'Seriously? http://stackoverflow.com/a/13099520
    CreateObject("WScript.Shell").Run "cmd /c ping 127.0.0.1 -n " _
    & 1, 0, True
Next

'Seriously? http://stackoverflow.com/a/13099520
CreateObject("WScript.Shell").Run "cmd /c ping 127.0.0.1 -n " _
    & 1, 0, True
objShell.Exec "cmd /K cd C:\inetpub\wwwroot\marketing & C:\Python27\python opc_get_values.py > values0.txt"
'Seriously? http://stackoverflow.com/a/13099520
CreateObject("WScript.Shell").Run "cmd /c ping 127.0.0.1 -n " _
    & 3, 0, True
%>



<%
For i=0 To 10   
    filename = "C:\inetpub\wwwroot\marketing\values" & i & ".txt"
    Set f = CreateObject("Scripting.FileSystemObject" )
    Set fs = f.GetFile(filename)
    'Make sure the file isn't empty to avoid errors
    if fs.Size > 0 Then
    Set f = f.OpenTextFile(filename)   
    'I guess 100 is a good length? 
    s=Split(f.read(100), vbCrLf)
    response.write("<input type='hidden' id='relay1_breaker" & i & "' value='" & s(0) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='relay1_load" & i & "' value='" & s(1) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='relay1_flow" & i & "' value='" & s(2) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='relay2_breaker" & i & "' value='" & s(3) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='relay2_load" & i & "' value='" & s(4) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='relay2_flow" & i & "' value='" & s(5) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='gen1_breaker" & i & "' value='" & s(10) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='gen1_generation" & i & "' value='" & s(7) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='gen2_breaker" & i & "' value='" & s(8) & "'>" & vbCrLf)
    response.write("<input type='hidden' id='gen2_generation" & i & "' value='" & s(9) & "'>" & vbCrLf & vbCrLf)
    End if
Next
response.write("<script>" & vbCrLf)
%>

var relay_data = {
    labels: ['-10', '-9', '-8', '-7', '-6', '-5', '-4', '-3', '-2', '-1', 'Now'],
    datasets: [
        {
            label: "relay1_load",
            fillColor: "rgba(242,255,0,0.2)",
            strokeColor: "rgba(242,255,0,1)",
            pointColor: "rgba(242,255,0,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [
<%
For i=0 To 10
    response.write("document.getElementById('relay1_load" & i & "').value,")
Next
%>

]},
    {
        label: "relay2_load",
        fillColor: "rgba(151,187,205,0.2)",
        strokeColor: "rgba(151,187,205,1)",
        pointColor: "rgba(151,187,205,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(151,187,205,1)",
        data: [<% 
For i=0 To 10
    response.write("document.getElementById('relay2_load" & i & "').value,")
Next
%>
    ],
    },
     {
        label: "relay1_flow",
        fillColor: "rgba(151,255,205,0.2)",
        strokeColor: "rgba(151,255,205,1)",
        pointColor: "rgba(151,255,205,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(151,187,205,1)",
        data: [<% 
For i=0 To 10
    response.write("document.getElementById('relay2_flow" & i & "').value,")
Next
%>
     ],
     },
     {
        label: "relay2_flow",
        fillColor: "rgba(255,187,205,0.2)",
        strokeColor: "rgba(255,187,205,1)",
        pointColor: "rgba(255,187,205,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(151,187,205,1)",
        data: [<% 
For i=0 To 10
    response.write("document.getElementById('relay2_flow" & i & "').value,")
Next
%>
    ]}]}
    var gen_data = {
    labels: ['-10', '-9', '-8', '-7', '-6', '-5', '-4', '-3', '-2', '-1', 'Now'],
    datasets: [
        {
            label: "gen1_gen",
            fillColor: "rgba(0,0,255,0.2)",
            strokeColor: "rgba(0,0,255,1)",
            pointColor: "rgba(0,0,255,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [
<%
For i=0 To 10
    response.write("document.getElementById('gen1_generation" & i & "').value,")
Next
%>

]},
    {
        label: "gen2_gen",
        fillColor: "rgba(255,0,0,0.2)",
        strokeColor: "rgba(255,0,0,1)",
        pointColor: "rgba(255,0,0,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(151,187,205,1)",
        data: [<% 
For i=0 To 10
    response.write("document.getElementById('gen2_generation" & i & "').value,")
Next
%>
    ]}]}
Chart.defaults.global.scaleFontColor = "#FFFFFF";
Chart.defaults.global.scaleLineColor = "rgba(255,255,255,.5)";
var relay_chart = new Chart(document.getElementById("relay_chart").getContext("2d")).Line(relay_data, {scaleGridLineColor: "rgba(255,255,255,.25)"});
var gen_chart = new Chart(document.getElementById("gen_chart").getContext("2d")).Line(gen_data, {scaleGridLineColor: "rgba(255,255,255,.25)"});
</script>
<!--#include file="footer.inc"-->
</body>
</html>
