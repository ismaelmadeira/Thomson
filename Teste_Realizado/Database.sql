Drop DataBase projeto_thomson

GO

Create DataBase projeto_thomson

GO

Use projeto_thomson

GO

CREATE SEQUENCE id_alunos
START WITH 1
INCREMENT BY 1

GO

CREATE SEQUENCE id_notas
    START WITH 1
    INCREMENT BY 1

GO 

Create Table alunos (
	id Int Not Null Default Next Value For id_alunos, 
	nome Varchar(50) Not Null,
	Constraint pk_alunos Primary Key (id)
)

GO

Create Table notas (
	id Int Not Null Default Next Value For id_notas, 
	id_aluno Int Not Null, 
	nota_01 Numeric(8,2) Not Null, 
	nota_02 Numeric(8,2) Not Null, 
	nota_03 Numeric(8,2) Not Null, 
	nota_04 Numeric(8,2) Not Null,
	Constraint pk_notas Primary Key (id, id_aluno),
	Constraint fk_aluno Foreign Key (id_aluno) References alunos (id)
)

GO

Insert Into alunos (nome) Values ('Ismael Madeira')

GO

Insert Into alunos (nome) Values ('Raquel Berns')

GO

Insert Into alunos (nome) Values ('Priscila Silva')

GO

Insert Into alunos (nome) Values ('Diego Mello')

GO

Insert Into notas (id, id_aluno, nota_01, nota_02, nota_03, nota_04) Values (1, 1, 10.0, 9.50, 8.35, 6.0)

GO

Insert Into notas (id, id_aluno, nota_01, nota_02, nota_03, nota_04) Values (1, 2, 0.0, 3.50, 7.35, 4.0)

GO

Insert Into notas (id, id_aluno, nota_01, nota_02, nota_03, nota_04) Values (1, 3, 3.0, 1.50, 9.35, 2.0)

GO

Insert Into notas (id, id_aluno, nota_01, nota_02, nota_03, nota_04) Values (1, 4, 9.0, 10.0, 6.33, 7.5)