$PBExportHeader$w_mdi.srw
$PBExportComments$Janela Principal
forward
global type w_mdi from window
end type
type mdi_1 from mdiclient within w_mdi
end type
end forward

global type w_mdi from window
string tag = "Janela Principal"
integer width = 3168
integer height = 1396
boolean titlebar = true
string title = "Projeto Thomson"
string menuname = "m_mdi"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdi!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "Window!"
boolean center = true
mdi_1 mdi_1
end type
global w_mdi w_mdi

on w_mdi.create
if this.MenuName = "m_mdi" then this.MenuID = create m_mdi
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_mdi.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_mdi
long BackColor=268435456
end type

