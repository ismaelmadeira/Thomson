$PBExportHeader$w_resultado.srw
forward
global type w_resultado from window
end type
type dw_sheet from datawindow within w_resultado
end type
end forward

global type w_resultado from window
string tag = "Cadastro de Alunos"
integer width = 4517
integer height = 1444
boolean titlebar = true
string title = "Cadastro de Alunos"
boolean controlmenu = true
windowtype windowtype = child!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "DataWindow5!"
boolean clientedge = true
dw_sheet dw_sheet
end type
global w_resultado w_resultado

type variables
uo_aluno iuo_aluno
end variables

on w_resultado.create
this.dw_sheet=create dw_sheet
this.Control[]={this.dw_sheet}
end on

on w_resultado.destroy
destroy(this.dw_sheet)
end on

event open;Decimal{2} ldc_nota_01, ldc_nota_02, ldc_nota_03, ldc_nota_04, ldc_media
Long ll_retorno, ll_linha, ll_linhas
dw_sheet.SetTransObject(sqlca)

ll_retorno = dw_sheet.Retrieve()
If ll_retorno < 0 Then
	MessageBox('Cadastro de Alunos', 'Ocorreu um Erro ao recuperar os dados de alunos e notas!', StopSign!)
	Return
End If

ll_linhas = dw_sheet.RowCount()
For ll_linha = 1 To ll_linhas
	ldc_nota_01 = dw_sheet.GetItemDecimal(ll_linha, 'nota_01')
	ldc_nota_02 = dw_sheet.GetItemDecimal(ll_linha, 'nota_02')
	ldc_nota_03 = dw_sheet.GetItemDecimal(ll_linha, 'nota_03')
	ldc_nota_04 = dw_sheet.GetItemDecimal(ll_linha, 'nota_04')
	
	// Cálculo da Média
	ldc_media = Round(((ldc_nota_01 + ldc_nota_02 + ldc_nota_03 + ldc_nota_04) / 4), 2)
	
	dw_sheet.SetItem(ll_linha, 'media', ldc_media)
	
	// Verifica Status
	If ldc_media > 7 Then
		dw_sheet.SetItem(ll_linha, 'status', 'Aprovado')
	ElseIf ldc_media >= 5 And ldc_media <= 7 Then
		dw_sheet.SetItem(ll_linha, 'status', 'Recuperação')
	ElseIf ldc_media < 5 Then
		dw_sheet.SetItem(ll_linha, 'status', 'Reprovado')
	End If	
Next

end event

type dw_sheet from datawindow within w_resultado
string tag = "Cadastro de Alunos"
accessiblerole accessiblerole = scrollbarrole!
integer width = 4462
integer height = 1216
integer taborder = 10
string title = "Cadastro de Alunos"
string dataobject = "dw_resultado"
boolean vscrollbar = true
boolean resizable = true
string icon = "Form!"
borderstyle borderstyle = stylelowered!
end type

