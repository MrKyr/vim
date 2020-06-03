/* 
 * Author :  <<name>>
 * Date   :  <<date>>
 */
#define F_CPU 1000000UL

#include <avr/eeprom.h>
#include <avr/io.h>
#include <util/delay.h>
#include <uart/uart.c> // Serial DEBUG Monitor

uint8_t num= 255; // max value for uint8_t '255';

int main(void) {
  OSCCAL = eeprom_read_byte(0);
  DDRB |= 1<<PB0;     // enable PORTB for output
  PORTB |= 1<<PORTB0; // Turn on PB0
  _delay_ms(1000);
  PORTB &= ~1<<PB0;   // Turn OFF PB0

  for(;;) {
    PINB |= 1<<PB0; // Toggle ON/OFF PB0
    uart_puts("Hello World!\n"); // Strings
    uart_putu(num); // number or variable
    _delay_ms(500);
  }
}
