<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String username=request.getParameter("username");
HttpSession httpSession =request.getSession(true);
httpSession.setAttribute("username",username); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Multi-User Chat</title>
<style type="text/css">
body, html {
  height: 100%;
  margin: 0;
}

.bg {
  /* The image used */
  background-image: url("https://cdn.dribbble.com/users/69156/screenshots/2398680/icq_pttrn3.png");

  /* Full height */
  height: 100%; 

  /* Center and scale the image nicely */
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}
#content {
  width: 700px ;
  margin-left: auto ;
  margin-right: auto ;
}
.textarea{
  background-color: #3CBC8D;
  color: white;
}

.outer-div
{
     padding: 30px;
     text-align: center;
}
.inner-div
{
     display: inline-block;
     padding: 50px;
}
.button {
  background-color: #f44336; /* Green */
  color: white;
  padding: 10px 25px;
  text-align: center;
  font-size: 13px;
  cursor: pointer;
  border-width: 0px;
}
.div 
{ background: #f44336; 
overflow: hidden; 
}
input[type=text] {
  width: 85%;
  padding: 10px 20px;
  margin: 8px 0;
  border-width: 0px;
  box-sizing: border-box;
}
</style>
</head>
<body>
<%if(username!=null) { %>
<div class="bg">
<div class="outer-div">
<div class="inner-div">
<div><h2>Welcome to Chat-Room</h2></div>
<div class="div">
<mark><font size="6">Username:<%=username %></font></mark><br>
</div>
<textarea id="messagesTextArea"  class="textarea" readonly="readonly" rows="20" cols="70"></textarea>
<br>
<div>
<input type="text" placeholder="Type your message here..." id="messageText" size="30"/>
<input type="button"  class="button" id="myBtn" value="Send" onclick="sendMessage();"/>
</div>
</div>
</div>
</div>
<script>
var websocket=new WebSocket("ws:localhost:8080/Chat/chatRoomServerEndpoint");
websocket.onmessage=function processMessage(message) {
	var jsonData=JSON.parse(message.data);
	if (jsonData.message!=null) messagesTextArea.value+= jsonData.message + "\n";
}
function sendMessage() {
	websocket.send(messageText.value);
	messageText.value="";
}
var input = document.getElementById("messageText");
input.addEventListener("keyup", function(event) {
  if (event.keyCode === 13) {
   event.preventDefault();
   document.getElementById("myBtn").click();
  }
});
</script>
<%} %>
</body>
</html>