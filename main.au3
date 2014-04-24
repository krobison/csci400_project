call("main")

func main()
   ;Open paint
   initialize()
   ;Set drawing size
   setPaintWidth()
   ;draw welcome text
   drawWelcome()
   ;draw board
   drawBoard()

   for $i = 0 To 8 Step 1
	  if (Mod($i,2) == 0) then
		 drawCircle($i)
	  Else
		 drawX($i)
	  EndIf
   Next
EndFunc


func initialize()
   ;Execute Paint
   Run("mspaint.exe","C:/windows")

   ;Wait for the pain window to exist and store into handle
   $paintHandle = WinWait("Paint")

   ;Activate the paint window
   WinActivate("Paint")

   ;window maximize
   WinSetState($paintHandle,"",@SW_MAXIMIZE)
EndFunc

func setPaintWidth()
   ;Press alt to access menu
   Send("{ALT}")
   ;wait for command
   Sleep(100)
   ;Press 'F' to access file menu
   Send("f")
   Sleep(100)
   ;Press 'e' for properties window
   Send("e")
   Sleep(100)
   ;send width and height separated by tabs
   Sleep(300)
   send("800")
   send("{TAB}")
   send("600")
   Sleep(300)
   ;send the 'enter' command
   Send("{ENTER}")
EndFunc

func drawWelcome()
   getColor("red")
   setTool("text")
   MouseClick("left",128,192)
   setFontSize("14")
   MouseClick("left",134,196)

   ;set stroke delay for emphasis
   opt("SendKeyDelay",100)
   Send("Welcome to Tic Tac Toe!")
   opt("SendKeyDelay",5)

   setTool("brush")
EndFunc

func drawBoard()
   $speed = 10
   MouseMove(128,256,$speed)
   MouseDown("left")
   MouseMove(128,512,$speed)
   MouseUp("left")

   MouseMove(192,256,$speed)
   MouseDown("left")
   MouseMove(192,512,$speed)
   MouseUp("left")

   MouseMove(64,340,$speed)
   MouseDown("left")
   MouseMove(256,340,$speed)
   MouseUp("left")

   MouseMove(64,430,$speed)
   MouseDown("left")
   MouseMove(256,430,$speed)
   MouseUp("left")

   drawNumbers()
EndFunc

func drawNumbers()
   $count = 1

   For $i = 0 To 8 Step 1
	  setTool("text")
	  $cell = getCell($i)
	  MouseClick("left",$cell[0],$cell[1])
	  send($count)
	  $count += 1
   Next

EndFunc

func setTool($tool)
   if $tool == "text" Then
	  $key = "t"
   EndIf
   if $tool == "brush" Then
	  $key = "b{ENTER}"
   EndIf
   ;select home ribbon
   Send("{ALT}h")
   ;set tool
   send($tool)
   if ($tool == "brush") Then
	  send("{ENTER}")
   EndIf
EndFunc

func setShape($shape)
   if $shape == "circle" Then
	  send("{ALT}hsh{HOME}{RIGHT}{RIGHT}")
	  send("{ENTER}")
   EndIf
EndFunc

func setFontSize($size)
   Send("{ALT}")
   send("t")
   send("fs")
   send($size)
   send("{ENTER}")
EndFunc

func getColor($color)
   if $color == "green" Then
	  $searchColor = 0x22B14C
   ElseIf $color == "blue" then
	  $searchColor = 0x3F48CC
   ElseIf $color == "red" then
	  $searchColor = 0xED1C24
   EndIf

   ;get position of color in pallette
   $position = PixelSearch(400,0,@desktopWidth-100,@desktopHeight-100,$searchColor)
   ;move to color and select
   MouseMove($position[0],$position[1],10)
   MouseClick("left")
EndFunc

func getCell($index)
   Dim $pos[2]

   $y = 270
   $x = 70
   $stepx = 64
   $stepy = 92

   $row = Floor($index /3)
   $col = Mod($index,3)

   $pos[0] = $x + $col*$stepx
   $pos[1] = $y + $row*$stepy

   return $pos
EndFunc

func drawCircle($index)
   getColor("green")
   setShape("circle")
   $pos = getCell($index)

   MouseMove($pos[0]+8,$pos[1]+8,5)
   MouseDown("left")
   MouseMove($pos[0]+48,$pos[1]+48,5)
   MouseUp("left")
   Send("{ENTER}")
EndFunc

func drawX($index)
   setTool("brush")
   getColor("blue")
   $pos = getCell($index)

   MouseMove($pos[0]+8,$pos[1]+8,5)
   MouseDown("left")
   MouseMove($pos[0]+48,$pos[1]+48,5)
   MouseUp("left")
   MouseMove($pos[0]+48,$pos[1]+8,5)
   MouseDown("left")
   MouseMove($pos[0]+8,$pos[1]+48,5)
   MouseUp("left")
EndFunc