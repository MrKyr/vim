/* 
 * Author :  <<name>>
 * Date   :  <<date>>
 */

#include <Arduino.h>

int main() {
    pinMode(2, OUTPUT); // ESP32 onboard LED

    for (;;) {
        digitalWrite(2, HIGH);
        delay(25);
        digitalWrite(2, LOW);
        delay(1000);
    }
}










// makes arduino-cli happy!! place it at the end of the file
void setup() { main(); }
void loop() {} // empty
