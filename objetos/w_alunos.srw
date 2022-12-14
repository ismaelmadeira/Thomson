$PBExportHeader$w_alunos.srw
forward
global type w_alunos from window
end type
type cb_salvar from commandbutton within w_alunos
end type
type cb_excluir from commandbutton within w_alunos
end type
type cb_adicionar from commandbutton within w_alunos
end type
type dw_sheet from datawindow within w_alunos
end type
end forward

global type w_alunos from window
string tag = "Cadastro de Alunos"
integer width = 3159
integer height = 1312
boolean titlebar = true
string title = "Cadastro de Alunos"
boolean controlmenu = true
windowtype windowtype = child!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "DataWindow5!"
boolean clientedge = true
cb_salvar cb_salvar
cb_excluir cb_excluir
cb_adicionar cb_adicionar
dw_sheet dw_sheet
end type
global w_alunos w_alunos

type variables
uo_aluno iuo_aluno
end variables

on w_alunos.create
this.cb_salvar=create cb_salvar
this.cb_excluir=create cb_excluir
this.cb_adicionar=create cb_adicionar
this.dw_sheet=create dw_sheet
this.Control[]={this.cb_salvar,&
this.cb_excluir,&
this.cb_adicionar,&
this.dw_sheet}
end on

on w_alunos.destroy
destroy(this.cb_salvar)
destroy(this.cb_excluir)
destroy(this.cb_adicionar)
destroy(this.dw_sheet)
end on

event open;Long ll_retorno
iuo_aluno = Create uo_aluno
dw_sheet.SetTransObject(sqlca)

ll_retorno = dw_sheet.Retrieve()
If ll_retorno < 0 Then
	MessageBox('Cadastro de Alunos', 'Ocorreu um Erro ao recuperar os dados de alunos!', StopSign!)
	Return
End If
end event

event close;If IsValid(iuo_aluno) Then Destroy iuo_aluno
end event

type cb_salvar from commandbutton within w_alunos
string tag = "Salvar Dados"
integer x = 2121
integer y = 256
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salvar"
end type

event clicked;Long ll_retorno, ll_nulos

dw_sheet.SetFilter("nome = '' or IsNull(nome)")
dw_sheet.SetRedraw(false)
dw_sheet.Filter()
ll_nulos = dw_sheet.RowCount()
dw_sheet.SetFilter('')
dw_sheet.Filter()
dw_sheet.SetRedraw(true)

If ll_nulos > 0 Then
	MessageBox('Cadastro de Alunos', 'O campo Nome do Aluno é inválido ou não foi preenchido!')
	Return
End If

// Salva os Dados
ll_retorno = dw_sheet.Update(True, True)
If ll_retorno < 0 Then
	MessageBox('Cadastro de Alunos', 'Ocorreu um Erro ao salvar os dados de alunos!', StopSign!)
	Return
End If

// Mensagem de Sucesso
MessageBox('Cadastro de Alunos', 'Dados atualizado com sucesso!')

// Atualiza Linhas
ll_retorno = dw_sheet.Retrieve()
If ll_retorno < 0 Then
	MessageBox('Cadastro de Alunos', 'Ocorreu um Erro ao recuperar os dados de alunos!', StopSign!)
	Return
End If
end event

type cb_excluir from commandbutton within w_alunos
string tag = "Excluir Linha"
integer x = 2121
integer y = 128
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Excluir"
end type

event clicked;Long ll_aluno, ll_notas
String ls_retorno

ll_aluno = dw_sheet.GetItemNumber(dw_sheet.GetRow(), 'id')
If ll_aluno > 0 And Not IsNull(ll_aluno) Then
	ls_retorno = iuo_aluno.uf_busca_notas(ll_aluno, ll_notas)
	If ls_retorno <> '' Then 
		MessageBox('Cadastro de Alunos', 'Ocorreu um erro ao buscar as notas para o aluno ' + String(ll_aluno) + ' - ' + ls_retorno, StopSign!)
		Return
	End If
	
	If ll_notas > 0 Then
		MessageBox('Cadastro de Alunos', 'Há cadastro de Notas para o aluno ' + String(ll_aluno) + '!~r~nNão é possível excluir o aluno.', StopSign!)
		Return
	Else
		dw_sheet.DeleteRow(dw_sheet.GetRow())
	End If
Else	
	dw_sheet.DeleteRow(dw_sheet.GetRow())
End If
end event

type cb_adicionar from commandbutton within w_alunos
string tag = "Adicionar Linha"
integer x = 2121
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Adicionar"
end type

event clicked;dw_sheet.InsertRow(1)
end event

type dw_sheet from datawindow within w_alunos
string tag = "Cadastro de Alunos"
accessiblerole accessiblerole = scrollbarrole!
integer width = 2085
integer height = 1216
integer taborder = 10
string title = "Cadastro de Alunos"
string dataobject = "dw_alunos"
boolean vscrollbar = true
string icon = "Form!"
borderstyle borderstyle = stylelowered!
end type

