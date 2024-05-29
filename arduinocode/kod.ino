#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <Servo.h>
#include <DHT.h>

const char* ssid = "Tezcan";
const char* password = "Alitezcan98+";

#define DHTPIN D3
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

ESP8266WebServer server(80);
Servo myServo;

const int ledPin = D1;
const int servoPin = D2;

void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);

  myServo.attach(servoPin);
  myServo.write(0);

  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi bağlantısı başarılı!");
  Serial.print("NodeMCU IP Adresi: ");
  Serial.println(WiFi.localIP());

  server.on("/", handleRoot);
  server.begin();
  Serial.println("HTTP sunucusu başladı");
  dht.begin();
}

void loop() {
  server.handleClient();
}

void handleRoot() {
  String command = server.arg("command");
  if (command == "open") {
    digitalWrite(ledPin, HIGH);
    myServo.write(90);
    delay(3000);
    digitalWrite(ledPin, LOW);
    myServo.write(0);
    server.send(200, "text/plain", "Kapi Acildi");
  } else if (command == "getTempHum") {
    float humidity = dht.readHumidity();
    float temperature = dht.readTemperature();
    if (isnan(humidity) || isnan(temperature)) {
      server.send(500, "application/json", "{\"error\":\"Sensor hatasi\"}");
    } else {
      String jsonData = "{\"humidity\":" + String(humidity) + ", \"temperature\":" + String(temperature) + "}";
      server.send(200, "application/json", jsonData);
    }
  } else {
    server.send(200, "application/json", "{\"error\":\"Gecersiz Komut\"}");
  }
}
