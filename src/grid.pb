XIncludeFile ".\conarray.pbi"


Structure GRIDCELL_EXP
  Formula.s
  X.i
  Y.i
EndStructure

Structure GRIDCELL Extends GRIDCELL_EXP
  Content.s
  *P
EndStructure


Structure GRIDORDER
  X.i
  Y.i
  S.s
EndStructure

ImportC "msvcrt.lib"
  system(str.p-ascii)
EndImport


Procedure.s AlphabetCount(Value.i, Max.i = 26)
  Protected ReturnString.s
  If Value/Max
    ReturnString = AlphabetCount(Value/Max-1, Max)
  EndIf
    ReturnString = ReturnString+Chr(Value%Max+65)
  ProcedureReturn ReturnString
EndProcedure

Procedure ConsoleSizeSet(X.i, Y.i)
  system("MODE CON COLS="+Str(X)+" LINES="+Str(Y))
EndProcedure

Procedure GridDrawBase(Array Field.ConArray(2))
  ConArraySet(Field(), 0, 0,  "File │ ? │                                                                      ")
  ConArraySet(Field(), 0, 1,  "╔╦╦╦╦╦╦╦════════╦════════╦════════╦════════╦════════╦════════╦════════╦════════╗")
  ConArraySet(Field(), 0, 2,  "╠ ╬  ╬ ║        ║        ║        ║        ║        ║        ║        ║        ║")
  ConArraySet(Field(), 0, 3,  "╠╩╩╩╩╩╩╬════════╩════════╩════════╩════════╩════════╩════════╩════════╩════════╣")
  ConArraySet(Field(), 0, 4,  "║      ║        │        │        │        │        │        │        │        ║")
  ConArraySet(Field(), 0, 5,  "╠══════╣────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────║")
  ConArraySet(Field(), 0, 6,  "║      ║        │        │        │        │        │        │        │        ║")
  ConArraySet(Field(), 0, 7,  "╠══════╣────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────║")
  ConArraySet(Field(), 0, 8,  "║      ║        │        │        │        │        │        │        │        ║")
  ConArraySet(Field(), 0, 9,  "╠══════╣────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────║")
  ConArraySet(Field(), 0, 10, "║      ║        │        │        │        │        │        │        │        ║")
  ConArraySet(Field(), 0, 11, "╠══════╣────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────║")
  ConArraySet(Field(), 0, 12, "║      ║        │        │        │        │        │        │        │        ║")
  ConArraySet(Field(), 0, 13, "╠══════╣────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────║")
  ConArraySet(Field(), 0, 14, "║      ║        │        │        │        │        │        │        │        ║")
  ConArraySet(Field(), 0, 15, "╠══════╣────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────║")
  ConArraySet(Field(), 0, 16, "║      ║        │        │        │        │        │        │        │        ║")
  ConArraySet(Field(), 0, 17, "╠══════╣────────┼────────┼────────┼────────┼────────┼────────┼────────┼────────║")
  ConArraySet(Field(), 0, 18, "║      ║        │        │        │        │        │        │        │        ║")
  ConArraySet(Field(), 0, 19, "╚══════╩═══════════════════════════════════════════════════════════════════════╝")
  ConArraySet(Field(), 0, 20, "                                                                                ")
  ConArraySet(Field(), 0, 21, "                                                                                ")
  ConArraySet(Field(), 0, 22, "                                                                                ")
  ConArraySet(Field(), 0, 23, "                                                                                ")
  
EndProcedure
Procedure GridDrawNumbering(Array Field.ConArray(2), X.i, Y.i)
  Protected a.i
  For a = 0 To 7
    ConArraySet(Field(), 8+a*9, 2, RSet(AlphabetCount(a+x), 8))
  Next
  
  For a = 0 To 7
    ConArraySet(Field(), 1, 4+a*2, RSet(Str(a+y), 6))
  Next
  
  If X > 0
    ConArraySet(Field(), 7, 11, "◄")
  EndIf
  If Y > 0
    ConArraySet(Field(), 43, 3, "▲")
  EndIf
  
    ConArraySet(Field(), 79, 11, "►")
    ConArraySet(Field(), 43, 19, "▼")
  
EndProcedure

Procedure GridDrawElement(Array Field.ConArray(2), X.i, Y.i, CX.i, CY.i, Map TABLE.GRIDCELL(), Color.i = $F0, ContentOverride.i = 0, Content$ = "", Expand.i = 0)
  Protected String.s
  ConsoleColor(FColor, BColor)
  ConsoleLocate(8+X*9, 4+Y*2)
  If ContentOverride
    String = Content$
  Else
    If FindMapElement(TABLE(), AlphabetCount(CX)+Str(CY))
      String = TABLE()\Content
    EndIf
  EndIf
  If FindMapElement(TABLE(), AlphabetCount(CX)+Str(CY))
    
    If Asc(TABLE()\Formula) = Asc("=") And ContentOverride = 0
      If Expand = 1
        String = TABLE()\Formula
        If Len(String) < 8
          ConArraySet(Field(), 8+X*9, 4+Y*2, RSet(String, 8), Color)
        Else
          ConArraySet(Field(), 8+X*9, 4+Y*2, String, Color)
        EndIf
      Else
        If Len(String) > 7
          ConArraySet(Field(), 8+X*9, 4+Y*2, "="+RSet(String, 6)+"►", Color)
        Else
          ConArraySet(Field(), 8+X*9, 4+Y*2, "="+RSet(String, 7), Color)
        EndIf
      EndIf
    Else
      If Expand = 1
        If Len(String) < 8
          ConArraySet(Field(), 8+X*9, 4+Y*2, RSet(String, 8), Color)
        Else
          ConArraySet(Field(), 8+X*9, 4+Y*2, String, Color)
        EndIf
      Else
        If Len(String) > 8
          ConArraySet(Field(), 8+X*9, 4+Y*2, RSet(String, 7)+"►", Color)
        Else
          ConArraySet(Field(), 8+X*9, 4+Y*2, RSet(String, 8), Color)
        EndIf
      EndIf
    EndIf
  Else
    If Expand = 1
      If Len(String) < 8
        ConArraySet(Field(), 8+X*9, 4+Y*2, RSet(String, 8), Color)
      Else
        ConArraySet(Field(), 8+X*9, 4+Y*2, String, Color)
      EndIf
    Else
      If Len(String) > 8
        ConArraySet(Field(), 8+X*9, 4+Y*2, RSet(String, 7)+"►", Color)
      Else
        ConArraySet(Field(), 8+X*9, 4+Y*2, RSet(String, 8), Color)
      EndIf
    EndIf
  EndIf
EndProcedure

Procedure GridDrawContent(Array Field.ConArray(2), X.i, Y.i, Map TABLE.GRIDCELL())
  Protected a.i
  Protected b.i
  Protected String.s
  
  For b = 0 To 7
    For a = 0 To 7
      GridDrawElement(Field(), a, b, X+a, Y+b, TABLE())
    Next
  Next
  
EndProcedure

Procedure GridDrawSelector(Array Field.ConArray(2), X.i, Y.i, CX.i, CY.i, Map TABLE.GRIDCELL())
  GridDrawElement(Field(), X, Y, CX, CY, TABLE(), $8F, 0, "", 1)
  
  
  
  If FindMapElement(TABLE(), AlphabetCount(CX)+Str(CY))
    Select Asc(TABLE()\Formula)
      Case Asc("=")
        ConArraySet(Field(), 0, 20, "Formula: "+TABLE()\Formula)
        ConArraySet(Field(), 0, 22, "Content: "+TABLE()\Content)
        
        
      Default
        ConArraySet(Field(), 0, 20, "Content: "+TABLE()\Content)
        
        
    EndSelect
  EndIf
  
  
EndProcedure

Procedure.i GridCompute(Library.i, X.i, Y.i, Map TABLE.GRIDCELL())
  Protected String.s
  Protected Changed.i
  If FindMapElement(TABLE(), AlphabetCount(X)+Str(Y))
    String = TABLE()\Formula
    Select Asc(String)
      Case Asc("=")
        String = Mid(String, 2)
        String = PeekS(CallFunction(Library, "EvalString", @String))
        If String <> TABLE()\Content
          TABLE()\Content = String
          Changed = 1
        EndIf
      Default
        If String <> TABLE()\Content
          TABLE()\Content = String
          Changed = 1
        EndIf
    EndSelect
    
    String = "(Set "+AlphabetCount(X)+Str(Y)+" "+TABLE()\Content+")"
    CallFunction(Library, "EvalString", @String)
    
  EndIf
  ProcedureReturn Changed
EndProcedure

Import ""
  GetConsoleWindow()
EndImport

OpenConsole()
SetStdHandle_(#STD_ERROR_HANDLE, 0)
DeleteMenu_(GetSystemMenu_(GetConsoleWindow(), 0), #SC_MAXIMIZE, #MF_BYCOMMAND)
DeleteMenu_(GetSystemMenu_(GetConsoleWindow(), 0), #SC_SIZE, #MF_BYCOMMAND)
EnableGraphicalConsole(1)
ConsoleSizeSet(80, 24)
ConsoleCursor(0)

Define Library.i = 0
CompilerSelect #PB_Compiler_Processor 
  CompilerCase #PB_Processor_x86
    Library = OpenLibrary(#PB_Any, "pnb.dll")
  CompilerCase #PB_Processor_x64
    Library = OpenLibrary(#PB_Any, "pnb64.dll")
  CompilerDefault
    CompilerError "Only x86 and x64 supported."
CompilerEndSelect


If Not Library
  PrintN("Required library pnb.dll/pnb64.dll not found in directory. This program will terminate.")
  system("pause")
EndIf

Dim ISOPC.ConArray(79, 23)



NewMap TABLE.GRIDCELL()
NewMap EXPORT.GRIDCELL_EXP()
NewList ORDER.GRIDORDER()

TX.i = 0
TY.i = 0
X.i = 0
Y.i = 0
m.i = 0
msel.i = 0

json.i = 0
file.s 
Repeat
  TX = (X/8)*8
  TY = (Y/8)*8
  GridDrawBase(ISOPC())
  GridDrawNumbering(ISOPC(), TX, TY)
  GridDrawContent(ISOPC(), TX, TY, TABLE())
  GridDrawSelector(ISOPC(), X-TX, Y-TY, X, Y, TABLE())
  Repeat
    a$ = Inkey()
    b = RawKey()
    Select b
      Case #VK_ESCAPE
        m = 0
        msel = 0
        TX = (X/8)*8
        TY = (Y/8)*8
        GridDrawBase(ISOPC())
        GridDrawNumbering(ISOPC(), TX, TY)
        GridDrawContent(ISOPC(), TX, TY, TABLE())
        Repeat
          Select m
            Case 0
              ConArraySet(ISOPC(), 0, 0, "File │", $07)
              ConArraySet(ISOPC(), 0, 1, "─────┴─────┐", $07)
              ConArraySet(ISOPC(), 0, 2, "New        │", Bool(msel<>0)*$07+Bool(msel=0)*$8F)
              ConArraySet(ISOPC(), 0, 3, "Open...    │", Bool(msel<>1)*$07+Bool(msel=1)*$8F)
              ConArraySet(ISOPC(), 0, 4, "Save as... │", Bool(msel<>2)*$07+Bool(msel=2)*$8F)
              ConArraySet(ISOPC(), 0, 5, "Exit       │", Bool(msel<>3)*$07+Bool(msel=3)*$8F)
              ConArraySet(ISOPC(), 0, 6, "───────────┘", $07)
              
            Case 1
              ConArraySet(ISOPC(), 6, 0, " ? │", $07)
              ConArraySet(ISOPC(), 6, 1, "───┴────┐", $07)
              ConArraySet(ISOPC(), 6, 2, "Help... │", Bool(msel<>0)*$07+Bool(msel=0)*$8F)
              ConArraySet(ISOPC(), 6, 3, "About...│", Bool(msel<>1)*$07+Bool(msel=1)*$8F)
              ConArraySet(ISOPC(), 6, 4, "────────┘", $07)
              
          EndSelect
          ConArrayPrint(ISOPC())
          
          Repeat
            a$ = Inkey()
            b = RawKey()
            Select b
              Case #VK_ESCAPE
                Break 2
              Case #VK_UP
                msel-1
                If msel = -1
                  Select m
                    Case 0
                      msel = 3
                    Case 1
                      msel = 1
                  EndSelect
                EndIf
                
                
              Case #VK_DOWN
                msel+1
                Select m
                  Case 0
                    If msel = 4
                      msel = 0
                    EndIf
                  Case 1
                    If msel = 2
                      msel = 0
                    EndIf
                EndSelect
                
              Case #VK_LEFT
                m-1
                If m = -1
                  m = 1
                EndIf
                msel = 0
                TX = (X/8)*8
                TY = (Y/8)*8
                GridDrawBase(ISOPC())
                GridDrawNumbering(ISOPC(), TX, TY)
                GridDrawContent(ISOPC(), TX, TY, TABLE())
              Case #VK_RIGHT
                m+1
                If m = 2
                  m = 0
                EndIf
                msel = 0
                TX = (X/8)*8
                TY = (Y/8)*8
                GridDrawBase(ISOPC())
                GridDrawNumbering(ISOPC(), TX, TY)
                GridDrawContent(ISOPC(), TX, TY, TABLE())
              Case #VK_RETURN
                Select m
                  Case 0
                    Select msel
                      Case 0 ;new
                        ClearMap(TABLE())
                        ClearList(ORDER())
                        CallFunction(Library, "EvalString", @"(Function (All) Do (Clear))")
                        CallFunction(Library, "EvalString", @"(Set All Clear)")
                        TX = 0
                        TY = 0
                        X = 0
                        Y = 0
                        m = 0
                        msel = 0
                        Break 2
                      Case 1 ;open
                        ClearMap(TABLE())
                        ClearList(ORDER())
                        CallFunction(Library, "EvalString", @"(Function (All) Do (Clear))")
                        CallFunction(Library, "EvalString", @"(Set All Clear)")
                        json = LoadJSON(#PB_Any, OpenFileRequester("Open...", "", "*.*", 0))
                        If json
                        ExtractJSONMap(JSONValue(json), EXPORT())
                        FreeJSON(json)
                        EndIf
                        ForEach EXPORT()
                          AddMapElement(TABLE(), MapKey(EXPORT()))
                          TABLE()\X = EXPORT()\X
                          TABLE()\Y = EXPORT()\Y
                          TABLE()\Formula = EXPORT()\Formula
                          TABLE()\P = AddElement(ORDER())
                          
                          ORDER()\X = TABLE()\X
                          ORDER()\Y = TABLE()\Y
                          ORDER()\S = AlphabetCount(TABLE()\X)+Str(TABLE()\Y)
                          
                          GridCompute(Library, TABLE()\X, TABLE()\Y, TABLE())
                          
                        Next
                        ClearMap(EXPORT())
                        
                        TX = 0
                        TY = 0
                        X = 0
                        Y = 0
                        m = 0
                        msel = 0
                        Break 2
                      Case 2 ;save as
                        json = CreateJSON(#PB_Any)
                        ForEach TABLE()
                          AddMapElement(EXPORT(), MapKey(TABLE()))
                          EXPORT()\X = TABLE()\X
                          EXPORT()\Y = TABLE()\Y
                          EXPORT()\Formula = TABLE()\Formula
                        Next
                        
                        InsertJSONMap(JSONValue(json), EXPORT())
                        ClearMap(EXPORT())
                        SaveJSON(json, SaveFileRequester("Save as...", "", "*.*", 0))
                        FreeJSON(json)
                        m = 0
                        msel = 0
                        Break 2
                      Case 3 ;exit
                        End
                    EndSelect
                    
                  Case 1
                    Select msel
                      Case 0 ;help
                        ShellExecute_(#Null, #Null, ".\help.txt", #Null, #Null, #SW_SHOWNORMAL)
                        m = 0
                        msel = 0
                        Break 2
                      Case 1 ;about
                        ;╔═╦╗ ║╣╠╝╚
                        ConArraySet(ISOPC(), 17, 2,  "╔═══════════════════════════════════════════════════╗")
                        ConArraySet(ISOPC(), 17, 3,  "║                     PNB\grid                      ║")
                        ConArraySet(ISOPC(), 17, 4,  "║───────────────────────────────────────────────────║")
                        ConArraySet(ISOPC(), 17, 5,  "║ This software is released under CC0.              ║")
                        ConArraySet(ISOPC(), 17, 6,  "║ Please see license.md for additional information. ║")
                        ConArraySet(ISOPC(), 17, 7,  "║                                                   ║")
                        ConArraySet(ISOPC(), 17, 8,  "║ VERSION: 1.1                                      ║")
                        ConArraySet(ISOPC(), 17, 9,  "║ BRANCH: STABLE                                    ║")
                        ConArraySet(ISOPC(), 17, 10, "╚═══════════════════════════════════════════════════╝")
                        ConArrayPrint(ISOPC())
                        system("pause > nul")
                        m = 0
                        msel = 0
                        Break 2
                    EndSelect
                    
                EndSelect
                
            EndSelect
          Until b
        ForEver
      Case #VK_UP
        If Y > 0
          Y-1
        EndIf
      Case #VK_DOWN
        Y+1
      Case #VK_LEFT
        If X > 0
          X-1
        EndIf
      Case #VK_RIGHT
        X+1
      Case #VK_RETURN
        GridDrawBase(ISOPC())
        GridDrawNumbering(ISOPC(), TX, TY)
        GridDrawContent(ISOPC(), TX, TY, TABLE())
        
        GridDrawElement(ISOPC(), X-TX, Y-TY, X, Y, TABLE(), $07, 1, "        ")
        
        
        
        ConArrayPrint(ISOPC())
        
        ConsoleLocate(8+(X-TX)*9, 4+(Y-TY)*2)
        ConsoleCursor(1)
        ConsoleColor(15, 7)
        EnableGraphicalConsole(0)
        If Not FindMapElement(TABLE(), AlphabetCount(X)+Str(Y))
          AddMapElement(TABLE(), AlphabetCount(X)+Str(Y)) 
          TABLE()\P = AddElement(ORDER())
        Else
          ChangeCurrentElement(ORDER(), TABLE()\P)
        EndIf
        TABLE(AlphabetCount(X)+Str(Y))\Formula = Input()
        TABLE()\X = X
        TABLE()\Y = Y
        
        ORDER()\X = X
        ORDER()\Y = Y
        ORDER()\S = AlphabetCount(X)+Str(Y)
        
        SortStructuredList(ORDER(), #PB_Sort_Ascending, OffsetOf(GRIDORDER\X), #PB_Integer)
        SortStructuredList(ORDER(), #PB_Sort_Ascending, OffsetOf(GRIDORDER\Y), #PB_Integer)
        
        EnableGraphicalConsole(1)
        ConsoleCursor(0)
        If TABLE()\Formula
          GridCompute(Library, X, Y, TABLE())
        Else
          DeleteMapElement(TABLE())
          DeleteElement(ORDER())
          EndIf
        LastElement(ORDER())
    EndSelect
    If NextElement(ORDER())
      FindMapElement(TABLE(), ORDER()\S)
      If GridCompute(Library, TABLE()\X, TABLE()\Y, TABLE())
        
        GridDrawContent(ISOPC(), TX, TY, TABLE())
        GridDrawSelector(ISOPC(), X-TX, Y-TY, X, Y, TABLE())
      EndIf
    Else
      ResetList(ORDER())
      CallFunction(Library, "EvalString", @"(Function (All) Do (Clear))")
      CallFunction(Library, "EvalString", @"(Set All Clear)")
    
    EndIf
    ConArrayPrint(ISOPC())
  Until b
ForEver

