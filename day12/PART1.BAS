CLS

filename$ = "INPUT.DAT"

DIM direction AS STRING
DIM coordx AS LONG
DIM coordy AS LONG

direction$ = "east"
coordx = 0
coordy = 0


DIM code AS STRING
DIM number AS LONG

OPEN filename$ FOR INPUT AS #1
DO WHILE NOT EOF(1)
  LINE INPUT #1, data$
  'PRINT "Read from file: "; data$

  code = MID$(data$, 1, 1)
  number = VAL(MID$(data$, 2, 10))

  IF code = "F" THEN PRINT "FORWARDS", number: GOSUB Forwards
  IF code = "N" THEN PRINT "MOVE NORTH", number: GOSUB North
  IF code = "S" THEN PRINT "MOVE SOUTH", number: GOSUB South
  IF code = "R" THEN PRINT "TURN RIGHT", number: GOSUB Right
  IF code = "L" THEN PRINT "TURN LEFT", number: GOSUB Left
  IF code = "E" THEN PRINT "MOVE EAST", number: GOSUB East
  IF code = "W" THEN PRINT "MOVE WEST", number: GOSUB West

  PRINT "SHIP NOW FACING: " + direction + " AT COORDS (" + STR$(coordx) + "," + STR$(coordy) + ")"
LOOP

CLOSE #1
GOTO Finish

Forwards:
IF direction$ = "east" THEN GOSUB East
IF direction$ = "west" THEN GOSUB West
IF direction$ = "north" THEN GOSUB North
IF direction$ = "south" THEN GOSUB South
RETURN

East:
coordx = coordx + number
RETURN

West:
coordx = coordx - number
RETURN

North:
coordy = coordy + number
RETURN

South:
coordy = coordy - number
RETURN

Right:
WHILE number >= 90
        IF direction = "east" THEN
                direction = "south"
        ELSEIF direction = "south" THEN
                direction = "west"
        ELSEIF direction = "west" THEN
                direction = "north"
        ELSEIF direction = "north" THEN
                direction = "east"
        END IF
        number = number - 90
WEND

RETURN

Left:
WHILE number >= 90
        IF direction = "east" THEN
                direction = "north"
        ELSEIF direction = "north" THEN
                direction = "west"
        ELSEIF direction = "west" THEN
                direction = "south"
        ELSEIF direction = "south" THEN
                direction = "east"
        END IF
        number = number - 90
WEND

RETURN

Finish:
PRINT STR$(ABS(coordx)) + " + " + STR$(ABS(coordy)) + " = "; STR$(ABS(coordx) + ABS(coordy))

