#include <FirebaseESP32.h>
#include <WiFi.h>
#include <addons/TokenHelper.h>
#include <addons/RTDBHelper.h>


FirebaseData firebaseData;

const char* ssid = "TOPNETF8A6425B";
const char* password = "925077788E";

// Pins addressing
#define redPin  22   
#define greenPin  23   

FirebaseConfig config;
FirebaseAuth auth;

void setup() {
  pinMode(redPin, OUTPUT); 
  pinMode(greenPin, OUTPUT); 

  Serial.begin(115200); 
  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  
  Serial.println("");
  Serial.print("WiFi connected. IP: ");
  Serial.println(WiFi.localIP());

  // Set the API key and database URL
  config.api_key = "AIzaSyAW1cIbwgLmq9nGj5JluWpPBBe80Kf3V2M"; 
  config.database_url = "smart-home-a4bbd-default-rtdb.firebaseio.com"; 

  auth.user.email = "sss123@gmail.com";
  auth.user.password = "123456";
  config.token_status_callback = tokenStatusCallback; // see addons/TokenHelper.h
  Firebase.reconnectNetwork(true);
  firebaseData.setBSSLBufferSize(4096 , 1024 );

  // Initialize Firebase
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);

  if (Firebase.ready()) {
    Serial.println("Firebase connection established!");
  } else {
    Serial.println("Failed to establish Firebase connection!");
  }

  // Check if credentials are set correctly
  Serial.println("Firebase API Key: " + String(config.api_key.c_str()));
  Serial.println("Firebase Database URL: " + String(config.database_url.c_str()));

}

void loop() {
  Serial.println("Reading data from Firebase...");

  if (Firebase.getString(firebaseData, "/test/ledr")) {
    String ledRState = firebaseData.stringData();
    Serial.println("ledr: " + ledRState);
    if (ledRState == "1") {
      Serial.println(" ==> Led Red: ON");
      digitalWrite(redPin, HIGH);
    } else {
      Serial.println(" ==> Led Red: OFF");
      digitalWrite(redPin, LOW);
    }
  } else {
    Serial.println("Error reading data for ledr!");
    Serial.println("HTTP Status Code: " + String(firebaseData.httpCode()));
    Serial.println("Error Reason: " + firebaseData.errorReason());
  }

  if (Firebase.getString(firebaseData, "/test/ledv")) {
    String ledVState = firebaseData.stringData();
    Serial.println("ledv: " + ledVState);
    if (ledVState == "1") {
      Serial.println(" ==> Led Green: ON");
      digitalWrite(greenPin, HIGH);
    } else {
      Serial.println(" ==> Led Green: OFF");
      digitalWrite(greenPin, LOW);
    }
  } else {
    Serial.println("Error reading data for ledv!");
    Serial.println("HTTP Status Code: " + String(firebaseData.httpCode()));
    Serial.println("Error Reason: " + firebaseData.errorReason());
  }

  delay(1000); 
}
