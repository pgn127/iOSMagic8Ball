# iOSMagic8Ball
Magic 8 Ball for iOS

This Magic 8 Ball app was created to satisfy CSC346- Mobile Applications lab component. 
![Img] (https://raw.github.com/pgn127/iOSMagic8Ball/master/engstart.png)
![Img] (https://raw.github.com/pgn127/iOSMagic8Ball/master/responseimg.png)

##Features
### Auto-layout
This application utilizes Autolayout to fit a variety of screen sizes for iOS devices.

###Localization
This application supports both Spanish and English. The text and audio depend on the language the device is set to.

![Img] (https://raw.github.com/pgn127/iOSMagic8Ball/master/spanishstart.png)

###Audio (VoiceOver)
This application is useable by VoiceOver and uses AVSpeechUtterance. It reads the Magic 8 ball's response aloud in the device's set language (English or Spanish).

###Question/Response History
All questions and responses are sent to a web service via POST requests. Clicking the History button allows the user to view all question, responses, and user images of students using this application.
* users are added to the database through: http://li859-75.members.linode.com/addUser.html
* NOTE: To test the server add an entry with http://li859-75.members.linode.com/addEntryTest.html . If you receive an OK from the server, it works.
![Img] (https://raw.github.com/pgn127/iOSMagic8Ball/master/history.png)




