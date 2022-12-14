$PBExportHeader$w_notas.srw
$PBExportComments$w_notas
forward
global type w_notas from window
end type
type cb_salvar from commandbutton within w_notas
end type
type cb_excluir from commandbutton within w_notas
end type
type cb_adicionar from commandbutton within w_notas
end type
type dw_sheet from datawindow within w_notas
end type
type dw_1 from datawindow within w_notas
end type
end forward

global type w_notas from window
integer width = 3159
integer height = 1312
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = child!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
cb_salvar cb_salvar
cb_excluir cb_excluir
cb_adicionar cb_adicionar
dw_sheet dw_sheet
dw_1 dw_1
end type
global w_notas w_notas

on w_notas.create
this.cb_salvar=create cb_salvar
this.cb_excluir=create cb_excluir
this.cb_adicionar=create cb_adicionar
this.dw_sheet=create dw_sheet
this.dw_1=create dw_1
this.Control[]={this.cb_salvar,&
this.cb_excluir,&
this.cb_adicionar,&
this.dw_sheet,&
this.dw_1}
end on

on w_notas.destroy
destroy(this.cb_salvar)
destroy(this.cb_excluir)
destroy(this.cb_adicionar)
destroy(this.dw_sheet)
destroy(this.dw_1)
end on

event open;Datawindowchild 	ldwc_datawindow, ldwc

dw_sheet.SetTransObject(sqlca)

dw_1.InsertRow(1)
dw_1.SetItem(1, 'aluno', 'Selecione')
dw_1.GetChild("aluno", ldwc)
ldwc.SetTransObject(sqlca)
ldwc.Retrieve()
ldwc.InsertRow(1)


//ll_retorno = dw_sheet.Retrieve()
//If ll_retorno < 0 Then
//	MessageBox('Cadastro de Alunos', 'Ocorreu um Erro ao recuperar os dados de alunos!', StopSign!)
//	Return
//End If
end event

type cb_salvar from commandbutton within w_notas
integer x = 1829
integer y = 448
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salvar"
end type

event clicked;Long ll_retorno, ll_aluno

ll_aluno = dw_1.GetItemNumber(1, 'aluno')

If ll_aluno > 0 Then
	// Salva os Dados
	ll_retorno = dw_sheet.Update(True, True)
	If ll_retorno < 0 Then
		MessageBox('Cadastro de Alunos', 'Ocorreu um Erro ao salvar os dados de alunos!', StopSign!)
		Return
	End If
	
	// Mensagem de Sucesso
	MessageBox('Cadastro de Alunos', 'Dados atualizado com sucesso!')
	
	// Atualiza Linhas
	ll_retorno = dw_sheet.Retrieve(ll_aluno)
	If ll_retorno < 0 Then
		MessageBox('Cadastro de Alunos', 'Ocorreu um Erro ao recuperar os dados de alunos!', StopSign!)
		Return
	End If
End If
end event

type cb_excluir from commandbutton within w_notas
integer x = 1829
integer y = 320
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Excluir"
end type

event clicked;Long ll_aluno
ll_aluno = dw_1.GetItemNumber(1, 'aluno')

If ll_aluno > 0 Then dw_sheet.DeleteRow(dw_sheet.GetRow())
end event

type cb_adicionar from commandbutton within w_notas
integer x = 1829
integer y = 192
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Adicionar"
end type

event clicked;Long ll_aluno
ll_aluno = dw_1.GetItemNumber(1, 'aluno')

If ll_aluno > 0 Then 
	dw_sheet.InsertRow(1)
	dw_sheet.SetItem(1, 'id_aluno', ll_aluno)
End If
end event

type dw_sheet from datawindow within w_notas
integer y = 192
integer width = 1819
integer height = 832
integer taborder = 30
string title = "none"
string dataobject = "dw_notas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_notas
integer width = 805
integer height = 160
integer taborder = 20
string title = "none"
string dataobject = "dw_sel_alunos"
borderstyle borderstyle = stylelowered!
end type

event itemchanged;Long ll_retorno, ll_aluno

ll_aluno = Long(data)
If ll_aluno > 0 Then
	ll_retorno = dw_sheet.Retrieve(ll_aluno)
	If ll_retorno < 0 Then
		MessageBox('Cadastro de Notas', 'Ocorreu um Erro ao recuperar os dados de notas dos alunos!', StopSign!)
		Return
	End If
End If
end event

