const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);

var newData;

exports.newBlogTrigger = functions.firestore.document('blogs/{blogId}').onCreate((snapshot, context) => {

    if (snapshot.empty) {
        console.log('No devices');
        return;
    }


    newData = snapshot.data();


    var payLoad = {
        notification: { title: 'New article published', body: newData['title'], sound: 'default' },
        data: {
            click_action: 'FLUTTER_NOTIFICATION_CLICK ',
            //blog_id: blog_id, 
            title: newData['title'],
            content: newData['content'],
            image_url: newData['image_url'],
        },
    };

    return admin.messaging().sendToTopic('all', payLoad)
        .then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
            return true;    //<- return a value
        })
        .catch((error) => {
            console.log('Error sending message:', error);
            //return.  <- No need to return here
        });


});

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
