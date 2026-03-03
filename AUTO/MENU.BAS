REM MENU.BAS

DIM A$(99)

'------------------------------------------------------------------
' Load the array
F$ = DIR$("*.BAS", FILE)
IF F$="" THEN PRINT "No Files"
IF F$="" THEN EXIT

N=1
A$(N)=F$

DO
   F$ = DIR$()
   IF F$="" THEN EXIT
   N=N+1
   A$(N)=F$
LOOP

MAXP=INT((N-1)/9)+1

'------------------------------------------------------------------
' Sort the array
FOR I = 1 TO N - 1
    FOR J = 1 TO N - I
        IF A$(J) > A$(J + 1) THEN
            ' Swap the two elements
            TEMP$ = A$(J)
            A$(J) = A$(J + 1)
            A$(J + 1) = TEMP$
        END IF
    NEXT J
NEXT I

'------------------------------------------------------------------
' Print a Page
PAGE=0

DO
  PAGE=PAGE+1
  IF PAGE > MAXP THEN END

  GOSUB HEADER
  GOSUB BODY
  GOSUB FOOTER
LOOP

END

'------------------------------------------------------------------
HEADER:
  CLS
  COLOUR RGB(YELLOW),0
  PRINT
  PRINT "Basic Programs Menu",
  PRINT "   Page: ";
'  PRINT LEFT$(TIME$,5)
  PRINT PAGE; " of "; MAXP

  FOR i = 1 TO 40
    PRINT CHR$(196);
  NEXT i

  PRINT
RETURN

'------------------------------------------------------------------
BODY:
  COLOUR RGB(GREEN)

  FOR I=1 TO 9
    IDX=(PAGE-1)*9+i
    IF IDX>N THEN EXIT FOR

    PRINT I, A$(IDX)
  NEXT I

  PRINT
  IF PAGE < MAXP THEN PRINT " 0", "Next Page     ---->"
RETURN

'------------------------------------------------------------------
FOOTER:
  COLOUR RGB(yellow),0

  FOR i = 1 TO 40
    PRINT CHR$(196);
  NEXT i

  COLOUR RGB(yellow)
  PRINT
400  PRINT "Select Program #";
  INPUT I
  IF I = 0 THEN RETURN        ' just loop back for next pag
  IF I < 0 OR I > 9 THEN PRINT "Invalid" : GOTO 400
  SEL = (PAGE-1)*9 + I
  IF SEL > N THEN PRINT "Invalid" : GOTO 400

  GOSUB LAUNCH

RETURN

'------------------------------------------------------------------
LAUNCH:
  PRINT
  COLOUR RGB(cyan)
  PRINT : PRINT "Running:",A$(SEL)
  PAUSE 2000
  RUN A$(SEL)
  PRINT
RETURN
