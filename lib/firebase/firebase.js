// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDttMpt0HWh7sthzA791RVTXyr3ZS7UjfI",
  authDomain: "capstone-febbd.firebaseapp.com",
  projectId: "capstone-febbd",
  storageBucket: "capstone-febbd.appspot.com",
  messagingSenderId: "938546452578",
  appId: "1:938546452578:web:fab164531082fa17aa993b",
  measurementId: "G-HY11PJY9MX"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);