$PBExportHeader$projeto_thomson.sra
$PBExportComments$Generated Application Object
forward
global type projeto_thomson from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
String gs_arquivoini = 'conexao.ini'

transaction sqlca
end variables

global type projeto_thomson from application
string appname = "projeto_thomson"
end type
global projeto_thomson projeto_thomson

on projeto_thomson.create
appname="projeto_thomson"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on projeto_thomson.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;//Conecta com o banco de dados
sqlca.dbms			= ProfileString(gs_arquivoini, "Banco_de_Dados_1", "dbms", "")
sqlca.servername	= ProfileString(gs_arquivoini, "Banco_de_Dados_1", "servername", "")
sqlca.database		= ProfileString(gs_arquivoini, "Banco_de_Dados_1", "database", "")
sqlca.userid			= ProfileString(gs_arquivoini, "Banco_de_Dados_1", "userid", "")
sqlca.dbpass		= ProfileString(gs_arquivoini, "Banco_de_Dados_1", "dbpass", "")
sqlca.logid			= ProfileString(gs_arquivoini, "Banco_de_Dados_1", "logid", "")
sqlca.logpass		= ProfileString(gs_arquivoini, "Banco_de_Dados_1", "logpass", "")
sqlca.dbparm		= ProfileString(gs_arquivoini, "Banco_de_Dados_1", "dbparm", "")
sqlca.lock            = ProfileString(gs_arquivoini,"Banco_de_Dados_1","Lock","")

Connect Using sqlca;
If sqlca.SqlCode <> 0 Then
	MessageBox('Aplicação Thomson', 'Ocorreu um ERRO ao conectar ao Banco de Dados - ' + sqlca.sqlerrtext)
	Return
End If

Open(w_mdi)
end event

event close;Disconnect Using sqlca;
end event

