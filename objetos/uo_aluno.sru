$PBExportHeader$uo_aluno.sru
forward
global type uo_aluno from nonvisualobject
end type
end forward

global type uo_aluno from nonvisualobject
end type
global uo_aluno uo_aluno

forward prototypes
public function string uf_busca_notas (long al_aluno, ref long al_notas)
end prototypes

public function string uf_busca_notas (long al_aluno, ref long al_notas);al_notas = 0

Select Count(1)
	Into :al_notas
From notas
Where id_aluno = :al_aluno;

If sqlca.sqlcode < 0 Then Return sqlca.sqlerrtext

Return ''
end function

on uo_aluno.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_aluno.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

