/* 
 * Author :  <<name>>
 * Date   :  <<date>>
 */

#define F_CPU 8000000UL // IMPORTANT !! also for Serial DEBUG Monitor

#include <avr/eeprom.h>
#include <avr/io.h>
#include <util/delay.h>
#include <TinySerial2/TinySerial2.h> // Serial DEBUG Monitor

#define LED PB0

uint8_t num= 255; // max value for uint8_t '255';

int main(void) {
    OSCCAL = eeprom_read_byte(0); // FIX CLOCK for 8Mhz

    initSerial(PB3);  // Initialize TinySerial2 ATtiny85 pin2(PB3) for TX for DEBUG

    DDRB |= 1 << LED; // Setup PORTB as output

    PORTB |= 1<<LED;  // LED ON
    _delay_ms(50);
    PORTB &= ~1<<LED; // LED Of

    for(;;) {
        PORTB ^= 1<<LED;                 // Toggle ON/OFF LED 
        myprintf("Teting: %d\r\n", num); // DEBUG: screen -c /dev/null /dev/cu.usbserial-A5XK3RJT 4800
        _delay_ms(1000);
    }
}
