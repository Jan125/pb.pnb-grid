;Line-color switch optimization of a 2D array of ASCII characters.

Structure ConArray
  Character.c
  Color.a
EndStructure

Procedure ConArrayPrint(Array Field.ConArray(2), X.i = 0, Y.i = 0)
  ;Multiple of these arrays can be used to render windows and window contents.
  ;Overlapping will create flickering.
  
  Protected a.i
  Protected b.i
  Protected String.s
  Protected Color.a
  
  For b = 0 To ArraySize(Field(), 2)
      ConsoleLocate(X, Y+b) ;Put cursor at start of line.
      For a = 0 To ArraySize(Field(), 1)
        If Field(a, b)\Color <> Color ;Check if color in field is different from preceding color.
          ConsoleColor(Color >> 4, Color & $0F) ;If yes, do color switch to preceding color.
          Print(String) ;Print the string.
          String = "" ;Reset string.
          Color = Field(a, b)\Color ;Set color to current color.
        EndIf
        String + RSet(Chr(Field(a, b)\Character), 1, " ") ;Add the character in the current cell to string, until color change or end of line.
      Next
      ConsoleColor(Color >> 4, Color & $0F) ;If end of line, color switch.
      Print(String) ;Print the string.
      String = "" ;Reset the string.
  Next
  
EndProcedure

Procedure ConArraySet(Array Field.ConArray(2), X.i, Y.i, String.s, Color.a = $F0)
  Protected a.i
  Protected b.i
  Protected c.i
  Protected d.i
  For a = 0 To Len(String)-1
    c = a-d
    If Asc(Mid(String, a+1, 1)) = Asc(#CR$) Or X+c > ArraySize(Field(), 1)
      b+1
      If Y+b > ArraySize(Field(), 2)
        ProcedureReturn
      EndIf
      If X+c > ArraySize(Field(), 1)
        c = 0
        d = a
        Field(X+c, Y+b)\Character = Asc(Mid(String, a+1, 1))
        Field(X+c, Y+b)\Color = Color
      EndIf
    Else
      Field(X+c, Y+b)\Character = Asc(Mid(String, a+1, 1))
      Field(X+c, Y+b)\Color = Color
    EndIf
  Next
EndProcedure