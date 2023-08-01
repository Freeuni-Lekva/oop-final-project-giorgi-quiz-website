<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 7/29/2023
  Time: 9:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.freeuni.quizwebsite.model.db.NoteMail" %>
<%@ page import="java.util.List" %>
<%@ page import="com.freeuni.quizwebsite.service.NoteMailInformation" %>
<%@ page import="com.freeuni.quizwebsite.service.UsersInformation" %>
<%@ page import="static jdk.javadoc.internal.doclets.formats.html.markup.HtmlStyle.notes" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Notes Mailbox</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5; /* Light gray background */
            margin: 0;
            padding: 0;
            color: #333333;
        }

        /* Container for notes */
        .notes-container {
            max-width: 800px;
            margin: 0 auto; /* change this line */
            padding: 20px;
        }


        .note-item {
             margin-bottom: 20px;
             padding: 20px;
             border: 1px solid #cccccc;
             background-color: #ffffff; /* White background */
             box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
             border-radius: 8px;
             position: relative; /* To accommodate the animation */
             word-wrap: break-word; /* Breaks words to prevent overflow */
        }
    .note-item:hover {
            transform: translateY(-5px); /* Add a slight lift on hover */
            transition: transform 0.2s ease; /* Smooth animation */
        }

        .note-item a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .note-item a:hover {
            text-decoration: underline;
        }

        /* Home button style */
        .home-button {
            background-color: #8BC34A;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }

        .home-button:hover {
            background-color: #0056b3;
        }

        /* Styling for send time */
        .send-time {
            color: #999999;
            font-size: 12px;
        }
        /* The switch - the box around the slider */
        .switch {
            position: relative;
            display: inline-block;
            width: 120px;
            height: 34px;
        }

        /* The switch - hide the default checkbox */
        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        /* The slider */
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #8BC34A;
            -webkit-transition: .4s;
            transition: .4s;
        }
        #toggleLabel {

            color: black;

        }

        .slider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 52px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            -webkit-transition: .4s;
            transition: .4s;
        }

        input:checked + .slider {
            background-color: #2196F3;
        }
        input:checked + .slider #toggleLabel {
            color: white; /* color when checked */
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #2196F3;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(56px);
            -ms-transform: translateX(56px);
            transform: translateX(56px);
        }

        /* Rounded sliders */
        .slider.round {
            border-radius: 34px;
        }

        .slider.round:before {
            border-radius: 50%;
        }
        .receiver-name {
            color: #8BC34A; /* Green color for the receiver name */
        }

        .sender-name {
            color: #007bff; /* Blue color for the sender name */
        }


    </style>
</head>
<body>
<div class="notes-container">
    <h1 style="text-align: center; margin-bottom: 30px;">Notes Mailbox</h1>
    <div style="display: flex; justify-content: space-between; align-items: center;">
        <button class="home-button" onclick="redirectTo('home_page.jsp')">Home</button>
        <label class="switch">
            <input type="checkbox" id="noteToggle">
            <span class="slider round">
            <p id="toggleLabel" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); margin: 0;">Received</p>
        </span>
        </label>
    </div>

    <p></p>
    <div id="received-notes">
        <%
            List<NoteMail> receivedNotes = (List<NoteMail>) request.getAttribute("received");
            if (receivedNotes.isEmpty()) {
        %>
        <p style="text-align: center; margin-top: 50px; font-size: 18px; color: #888;">No received notes in your mailbox.</p>
        <%
        } else {
            for (NoteMail note : receivedNotes) {
        %>
        <div class="note-item">
            <!-- (Your note display logic here) -->
            <p><b>Mail from:</b> <a href="profile?user_id=<%= note.getSenderUserId() %>"><span class="receiver-name"><%= UsersInformation.findUserById(note.getSenderUserId()).getUsername() %></span></a></p>          <p><b>Send Time:</b> <span class="send-time"><%= note.getSendTime().toString().substring(0, 16) %></span></p>
            <p><b></b> <%= note.getNote() %></p>
        </div>
        <%
                }
            }
        %>
    </div>
    <div id="sent-notes" style="display: none;">
        <%
            List<NoteMail> sentNotes = (List<NoteMail>) request.getAttribute("sent");
            if (sentNotes.isEmpty()) {
        %>
        <p style="text-align: center; margin-top: 50px; font-size: 18px; color: #888;">No sent notes in your mailbox.</p>
        <%
        } else {
            for (NoteMail note : sentNotes) {
        %>
        <div class="note-item">
            <!-- (Your note display logic here) -->
            <p><b>Sent to:</b> <a href="profile?user_id=<%= note.getReceiverUserId() %>"><span class="sender-name"><%= UsersInformation.findUserById(note.getReceiverUserId()).getUsername() %></span></a></p>
            <p><b>Send Time:</b> <span class="send-time"><%= note.getSendTime().toString().substring(0, 16) %></span></p>
            <p><b></b> <%= note.getNote() %></p>
        </div>
        <%
                }
            }
        %>
    </div>
</div>
<script>
        window.onload = function() {
        var noteToggle = document.getElementById("noteToggle");
        var homeButton = document.getElementsByClassName("home-button")[0];
        noteToggle.addEventListener('change', function() {
        if (noteToggle.checked) {
        show('sent');
        homeButton.style.backgroundColor = "#2196F3";
    } else {
        show('received');
        homeButton.style.backgroundColor = "#8BC34A";
    }
    });
    }

        function show(type) {
        var label = document.getElementById('toggleLabel');
        if (type === 'received') {
        document.getElementById('received-notes').style.display = 'block';
        document.getElementById('sent-notes').style.display = 'none';
        label.innerHTML = "Received";
        label.style.color = "black";
    } else if (type === 'sent') {
        document.getElementById('received-notes').style.display = 'none';
        document.getElementById('sent-notes').style.display = 'block';
        label.innerHTML = "Sent";
        label.style.color = "Black";
    }
    }

        function redirectTo(url) {
        window.location.href = url;
    }
</script>
</body>
</html>
