#include <ESP8266WiFi.h>

//SSID of your network
const char ssid[] = "<wifi-ssid>";
//password of your WPA Network
const char pass[] = "<wifi-pass>";


const char WIFI_STATUS[][20]  = {
	"WL_IDLE_STATUS", 
	"WL_NO_SSID_AVAIL", 
	"WL_SCAN_COMPLETED", 
	"WL_CONNECTED", 
	"WL_CONNECT_FAILED", 
	"WL_CONNECTION_LOST", 
	"WL_DISCONNECTED", 
	"OTHER"
	};
	
  
void printWifiStatus(int status)
{
	Serial.print("WiFi status ");
	Serial.print(status);
	Serial.print(": ");
	Serial.println(WIFI_STATUS[status > 6 ? 7 : status]);  
}


void setup()
{
	Serial.begin(115200);
	Serial.print("\r\n\r\nAttempting to connect WiFi: ");
	Serial.println(ssid);

	int status = WiFi.begin(ssid, pass);

	for(int i = 0; i < 10000/200; i++)
	{
		// poll WiFi status expecting WL_CONNECTED
		status = WiFi.status();
		printWifiStatus(status);
		if(status == WL_CONNECTED)
		{
			break;
		}
		delay(200);
	}

	if (WiFi.status() != WL_CONNECTED) {
		Serial.println("Couldn't establish network connection.");
	} else {
		Serial.println("connected.");
	}
}


void loop () 
{
	if (WiFi.status() == WL_CONNECTED)
	{
		// periodically log RSSI
		long rssi = WiFi.RSSI();
		Serial.print("RSSI:");
		Serial.println(rssi);
		delay(200);
	} else {
		Serial.println("No wifi connection.");
		// end program.
		while(true)
		{
			delay(100); // keep WDT happy
		}
	}
}
