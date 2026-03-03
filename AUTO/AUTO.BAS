REM Setup File on SD Card

'------------------------------------------------------------------
' Setup PicoCalc
OPTION CASE UPPER

DRIVE "B:"
CHDIR "\AUTO"

'------------------------------------------------------------------
' Define Function Key to run the MENU
' OPTION escape was considered but could not find a way tp turn it off
Q$=CHR$(34)
L$=CHR$(13)+CHR$(10)
CMD$="RUN "+Q$+"B:\AUTO\MENU.BAS"+Q$+L$

OPTION F5 CMD$

'------------------------------------------------------------------
' Display Splah Screen abd play Startup Sound
LOAD JPG "Pico_Math.JPG"
PAUSE 200
PLAY WAV "Picocalc.wav"

'------------------------------------------------------------------
' Neopixels

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

'------------------------------------------------------------------
PRINT "Launching: MENU.BAS"

DRIVE "B:"
CHDIR "\BASIC"
RUN "B:\AUTO\MENU.BAS"
