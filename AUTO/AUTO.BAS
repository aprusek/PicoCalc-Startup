
OPTION CASE UPPER

DRIVE "B:"
CHDIR "\AUTO"

PLAY WAV "Picocalc.wav"
LOAD PNG "Pico_Math.PNG"

REM Neopixels

delay = 300

DIM a%(7)
DIM b%(7)
DIM c%(7)
DIM d%(7)

FOR i = 0 TO 7
  a%(i)=RGB(RED)
  b%(i)=RGB(GREEN)
  c%(i)=RGB(BLUE)
  d%(i)=RGB(BLACK)
NEXT i

SETPIN GP28, DOUT

FOR i = 1 TO 3
  DEVICE ws2812 S, GP28, 8, a%()
  PAUSE delay
  DEVICE ws2812 S, GP28, 8, b%()
  PAUSE delay
  DEVICE ws2812 S, GP28, 8, c%()
  PAUSE delay
  DEVICE ws2812 S, GP28, 8, d%()
  PAUSE delay
NEXT i

PRINT "MMBASIC Version:", MM.VER
PRINT "Launching: MENU.BAS"
PAUSE 1000

DRIVE "B:"
CHDIR "\BASIC"
RUN "B:\AUTO\MENU.BAS"
