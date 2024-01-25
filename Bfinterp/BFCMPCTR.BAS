DEFINT A-Z
CONST INSTRUCTIONS$ = "+,-.<>[]"

DIM Buffer AS STRING
DIM BufferSize AS INTEGER
DIM Character AS STRING
DIM InFileH AS INTEGER
DIM InPath AS STRING
DIM OutFileH AS INTEGER
DIM OutPath AS STRING

PRINT "Brainf*ck Compacter v1.01 - by: Peter Swinkels, ***2023***"

LINE INPUT "Input file: "; InPath
IF NOT InPath = "" THEN LINE INPUT "Output file: "; OutPath

IF NOT (InPath = "" OR OutPath = "") THEN
 InFileH = FREEFILE
 OPEN InPath FOR INPUT LOCK READ WRITE AS InFileH
 CLOSE InFileH

 BufferSize = 32000
 InFileH = FREEFILE
 OPEN InPath FOR BINARY LOCK READ WRITE AS InFileH
  OutFileH = FREEFILE
  OPEN OutPath FOR OUTPUT LOCK READ WRITE AS OutFileH
   DO UNTIL LOC(InFileH) = LOF(InFileH)
    IF LOC(InFileH) + BufferSize > LOF(InFileH) THEN BufferSize = LOF(InFileH) - LOC(InFileH)
    Buffer = ""
    Buffer = INPUT$(BufferSize, InFileH)
    FOR Position = 1 TO LEN(Buffer)
     Character = MID$(Buffer, Position, 1)
     IF INSTR(INSTRUCTIONS, Character) > 0 THEN
      PRINT #OutFileH, Character;
     END IF
    NEXT Position
   LOOP
  CLOSE OutFileH
 CLOSE InFileH
END IF

