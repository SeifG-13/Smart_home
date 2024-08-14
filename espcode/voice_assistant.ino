int SoundSensor=5;
int LED=3; 
boolean LEDStatus=false;
int SensorData=0;
void setup() {
Serial.begin(115200);

 pinMode(SoundSensor,INPUT);
 pinMode(LED,OUTPUT);
}
void loop() {
 SensorData=digitalRead(SoundSensor);
 delay(100); 
  Serial.println(SensorData);
   if((micvalu==743)||(micvalu==724)||(micvalu==746)||(micvalu==721)||
(micvalu==761)||(micvalu==718)||(micvalu==758)||(micvalu==746)||(micvalu==742))
{
  (LEDStatus==true);
  digitalWrite(led,HIGH);
  Serial.println("light off");
  myDFPlayer.play(2);
}else if((micvalu==721)||(micvalu==761)||(micvalu==718)||(micvalu==751)||
(micvalu==740)||(micvalu==749))
{
  digitalWrite(led,LOW);
  Serial.println("light ON");
  myDFPlayer.play(1);
}
}