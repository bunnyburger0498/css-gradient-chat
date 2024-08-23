;author 
;justcop 
;https://www.autohotkey.com/boards/viewtopic.php?style=19&t=101118

;for counter strike source, 15 characters seem to be the max


ColorGradient(proportion,color*){
	color_R := []
	color_G := []
	color_B := []
	colors := color.length()
	
	
	loop, %colors%{
		;Add 0x here instead of user input
		tmpVar := color[A_index]
		tmpVar = 0x%tmpVar%
		;Msgbox % tmpVar
		color_R[A_index] := ((tmpVar  & 0xFF0000) >> 16)
		color_G[A_index] := ((tmpVar  & 0xFF00) >> 8)
		color_B[A_index] := (tmpVar  & 0xFF)
	}
	
	if proportion >= 1
	{
		r := color_R[colors]
		g := color_G[colors]
		b := color_B[colors]
	}
	else
	{
		segments := colors-1
		segment := floor(proportion*segments)+1
		subsegment := ((proportion*segments)-segment+1)
		
		r := round((subsegment * (color_R[segment+1]-color_R[segment]))+color_R[segment])
		g := round((subsegment * (color_G[segment+1]-color_G[segment]))+color_G[segment])
		b := round((subsegment * (color_B[segment+1]-color_B[segment]))+color_B[segment])
	}
	
	hex:=format("{1:02x}{2:02x}{3:02x}", r, g, b)
	return hex
}

;Example
; color := ColorGradient(0,0x2dc937,0x99c140,0xe7b416,0xdb7b2b)
; Gui, Color, %color%
; Gui, Add, Text, w100 Center vGradientText, 0.0
; gui, show
; loop, 10 {
	; Index := A_Index / 10
	; color := ColorGradient(Index,0x2dc937,0x99c140,0xe7b416,0xdb7b2b)
	; Msgbox % color
	; Gui, Color, %color%
	; GuiControl,, GradientText, % Round(Index, 2)
	; Sleep, 50
; }