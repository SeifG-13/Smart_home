int SoundSensor=26;
int SensorData=0;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(SoundSensor,INPUT_PULLUP);
}

void loop() {
  // put your main code here, to run repeatedly:
  SensorData=analogRead(SoundSensor);
  delay(50);
  Serial.println(SensorData);
}
