CLS

filename$ = "INPUT.DAT"

DIM direction AS STRING
DIM coordx AS LONG
DIM coordy AS LONG
DIM shipx AS LONG
DIM shipy AS LONG

direction$ = "east"
coordx = 10
coordy = 1
shipx = 0
shipy = 0


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

  PRINT "SHIP NOW AT COORDS (" + STR$(shipx) + "," + STR$(shipy) + ")"
LOOP

CLOSE #1
GOTO Finish

Forwards:
shipx = shipx + (coordx * number)
shipy = shipy + (coordy * number)
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
DIM tmp AS LONG
WHILE number >= 90
        tmp = coordy
        coordy = -coordx
        coordx = tmp
        number = number - 90
WEND

RETURN

Left:
WHILE number >= 90
        tmp = coordy
        coordy = coordx
        coordx = -tmp
        number = number - 90
WEND

RETURN

Finish:
PRINT STR$(ABS(shipx)) + " + " + STR$(ABS(shipy)) + " = "; STR$(ABS(shipx) + ABS(shipy))

