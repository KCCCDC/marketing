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
    <h3>Power:</h3>
<canvas id="relay_chart" width="400" height="400"></canvas>
<canvas id="gen_chart" width="400" height="400"></canvas>
<h3>Reliability:</h3>
<canvas id="breaker_chart" width="400" height="400"></canvas>
<canvas id="pump_chart" width="400" height="400"></canvas>
<br /><br /><br /><br /><br /><br />

<% 
Dim objShell
Set objShell = CreateObject( "WScript.Shell" )
'If there aren't 10 value files, you will get errors on the page. Just refresh the page until all 10 files are created, or create them by hand...
For i=11 To 1 Step -1
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
up=CInt(0)
pump_health=CInt(0)
For i=1 To 11
    filename = "C:\inetpub\wwwroot\marketing\values" & i & ".txt"
    Set f = CreateObject("Scripting.FileSystemObject" )
    Set fs = f.GetFile(filename)
    'Make sure the file isn't empty to avoid errors
    if fs.Size > 0 Then
        Set f = f.OpenTextFile(filename)   
        'I guess 100 is a good length? 
        s=Split(f.read(100), vbCrLf)
        up = up + CInt(s(0)) + CInt(s(3)) + CInt(s(6))
        pump_health = pump_health + CInt(s(10)) + CInt(s(11)) + CInt(s(12)) + CInt(s(13)) + CInt(s(14)) + CInt(s(15)) + CInt(s(16)) + CInt(s(17)) + CInt(s(18)) + CInt(s(19)) + CInt(s(20)) + CInt(s(21)) + CInt(s(22)) + CInt(s(23)) + CInt(s(24)) + CInt(s(25)) + CInt(s(26)) + CInt(s(27)) + CInt(s(28))
        response.write("<input type='hidden' id='relay1_load" & i & "' value='" & s(1) & "'>" & vbCrLf)
        response.write("<input type='hidden' id='relay1_flow" & i & "' value='" & s(2) & "'>" & vbCrLf)
        response.write("<input type='hidden' id='relay2_load" & i & "' value='" & s(4) & "'>" & vbCrLf)
        response.write("<input type='hidden' id='relay2_flow" & i & "' value='" & s(5) & "'>" & vbCrLf)
        response.write("<input type='hidden' id='gen1_generation" & i & "' value='" & s(7) & "'>" & vbCrLf)
        response.write("<input type='hidden' id='gen2_generation" & i & "' value='" & s(9) & "'>" & vbCrLf)       
    Else
        response.write("<input type='hidden' id='relay1_load" & i & "' value='" & 0 & "'>" & vbCrLf)
        response.write("<input type='hidden' id='relay1_flow" & i & "' value='" & 0 & "'>" & vbCrLf)
        response.write("<input type='hidden' id='relay2_load" & i & "' value='" & 0 & "'>" & vbCrLf)
        response.write("<input type='hidden' id='relay2_flow" & i & "' value='" & 0 & "'>" & vbCrLf)
        response.write("<input type='hidden' id='gen1_generation" & i & "' value='" & 0 & "'>" & vbCrLf)
        response.write("<input type='hidden' id='gen2_generation" & i & "' value='" & 0 & "'>" & vbCrLf & vbCrLf)
    End if
Next
response.write("<input type='hidden' id='breaker_up' value='" & 100 * up / 33 & "'>" & vbCrLf)
response.write("<input type='hidden' id='breaker_down' value='" & 100 * (33 - up) / 33 & "'>" & vbCrLf)
response.write("<input type='hidden' id='pump_health' value='" & 100 * pump_health / 209 & "'>" & vbCrLf)
response.write("<input type='hidden' id='pump_unhealth' value='" & 100 * (209 - pump_health) / 209 & "'>" & vbCrLf)
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
For i=1 To 11
    response.write("document.getElementById('relay1_load" & i & "').value," & vbCrLf)
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
For i=1 To 11
    response.write("document.getElementById('relay2_load" & i & "').value," & vbCrLf)
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
For i=1 To 11
    response.write("document.getElementById('relay2_flow" & i & "').value," & vbCrLf)
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
For i=1 To 11
    response.write("document.getElementById('relay2_flow" & i & "').value," & vbCrLf)
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
For i=1 To 11
    response.write("document.getElementById('gen1_generation" & i & "').value," & vbCrLf)
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
For i=1 To 11
    response.write("document.getElementById('gen2_generation" & i & "').value," & vbCrLf)
Next
%>
    ]}]}
var breaker_data = [
    {
        value: document.getElementById('breaker_up').value,
        color: "#00FF05",
        highlight: "#A6FFA6",
        label: "% Breakers On"
    },
     {
        value: document.getElementById('breaker_down').value,
        color: "#FF0000",
        highlight: "#FFA6A6",
        label: "% Breakers Off"
    }
]

var pump_data = [
    {
        value: document.getElementById('pump_health').value,
        color: "#0005FF",
        highlight: "#D6D6FF",
        label: "% Pump Components On"
    },
     {
        value: document.getElementById('pump_unhealth').value,
        color: "#FFA6A6",
        highlight: "#FFD6D6",
        label: "% Pump Components Off"
    }
]

Chart.defaults.global.scaleFontColor = "#FFFFFF";
Chart.defaults.global.scaleLineColor = "rgba(255,255,255,.5)";
new Chart(document.getElementById("relay_chart").getContext("2d")).Line(relay_data, {scaleGridLineColor: "rgba(255,255,255,.25)"});
new Chart(document.getElementById("gen_chart").getContext("2d")).Line(gen_data, {scaleGridLineColor: "rgba(255,255,255,.25)"});
new Chart(document.getElementById("breaker_chart").getContext("2d")).Doughnut(breaker_data);
new Chart(document.getElementById("pump_chart").getContext("2d")).Doughnut(pump_data);
</script>

<!--#include file="footer.inc"-->
</body>
</html>
