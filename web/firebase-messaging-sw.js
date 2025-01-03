importScripts('https://www.gstatic.com/firebasejs/9.6.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.6.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyDBrkVY9KrhSpPuQkdm2nk8zFW0qhCuGEM",
  authDomain: "tripura-news-officials.firebaseapp.com",
  projectId: "tripura-news-officials",
  storageBucket: "tripura-news-officials.appspot.com",
  messagingSenderId: "511513642938",
  appId: "1:511513642938:web:6f00a6f3a9f78d352cbf83",
  measurementId: "G-T8M7K2QXEY"
});
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const messaging = firebase.messaging();

self.addEventListener('push', function (event) {
  if (event.data) {
    const data = event.data.json();
    const title = data.notification.title;
    const options = {
      body: data.notification.body,
      icon: data.notification.icon
    };
    event.waitUntil(self.registration.showNotification(title, options));
  }
});
