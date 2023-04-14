CREATE SCHEMA dbo AUTHORIZATION postgres;

-- Creation of "Aluno" Table;

CREATE TABLE dbo.aluno (
	codigo serial4 NOT NULL,
	nome varchar(50) NOT NULL,
	CONSTRAINT aluno_pkey PRIMARY KEY (codigo)
);

-- Creation of "Curso" Table;

CREATE TABLE dbo.curso (
	codigo serial4 NOT NULL,
	descricao varchar(50) NOT NULL,
	ementa text NOT NULL,
	CONSTRAINT curso_pkey PRIMARY KEY (codigo)
);

-- Creation of "Curso_Aluno" Table;

CREATE TABLE dbo.curso_aluno (
	codigo serial4 NOT NULL,
	codigo_aluno int4 NOT NULL,
	codigo_curso int4 NOT NULL,
	CONSTRAINT curso_aluno_pkey PRIMARY KEY (codigo_aluno, codigo_curso)
);

CREATE OR REPLACE PROCEDURE dbo.add_aluno(IN nomearg character varying)
 LANGUAGE sql
AS $procedure$
	insert into dbo.aluno (nome) values (nomeArg);
$procedure$
;

CREATE OR REPLACE PROCEDURE dbo.add_curso(IN _descricao character varying, IN _ementa text)
 LANGUAGE sql
AS $procedure$
	insert into dbo.curso(descricao,ementa) 
	values (_descricao, _ementa);
$procedure$
;

CREATE OR REPLACE PROCEDURE dbo.add_matricula(IN codcurso integer, IN codaluno integer)
 LANGUAGE sql
AS $procedure$
	insert into dbo.curso_aluno (codigo_curso,codigo_aluno) values (codCurso,codAluno);
$procedure$
;

CREATE OR REPLACE PROCEDURE dbo.del_aluno(IN codigoarg integer)
 LANGUAGE sql
AS $procedure$
	delete from dbo.aluno where codigo = codigoArg;
$procedure$
;

CREATE OR REPLACE PROCEDURE dbo.del_curso(IN codigoarg integer)
 LANGUAGE sql
AS $procedure$
	delete from dbo.curso where codigo = codigoArg;
$procedure$
;

CREATE OR REPLACE PROCEDURE dbo.del_matricula(IN codigoarg integer)
 LANGUAGE sql
AS $procedure$
	delete from dbo.curso_aluno where codigo = codigoArg;
$procedure$
;

CREATE OR REPLACE FUNCTION dbo.sel_aluno(codigoarg integer DEFAULT 0)
 RETURNS TABLE(vcodigo integer, vnome character varying)
 LANGUAGE plpgsql
AS $function$
begin 
return query
	select * from dbo.aluno 
where codigo = case when codigoarg = 0 then codigo else codigoarg end;
end;
$function$
;

CREATE OR REPLACE FUNCTION dbo.sel_curso(codigoarg integer DEFAULT 0)
 RETURNS TABLE(vcodigo integer, vdescricao character varying, vementa text)
 LANGUAGE plpgsql
AS $function$
begin 
return query
	select * from dbo.curso 
	where codigo = case when codigoarg = 0 then codigo else codigoarg end;
end;
$function$
;

CREATE OR REPLACE FUNCTION dbo.sel_matricula()
 RETURNS TABLE(codmatricula integer, codcurso integer, codaluno integer, curso character varying, aluno character varying)
 LANGUAGE plpgsql
AS $function$
begin 
return query
	select ca.codigo,ca.codigo_curso,ca.codigo_aluno,curso.descricao,aluno.nome  
from dbo.curso_aluno ca left join dbo.aluno on ca.codigo_aluno = aluno.codigo left join dbo.curso on ca.codigo_curso = curso.codigo;
end;
$function$
;

CREATE OR REPLACE PROCEDURE dbo.upd_aluno(IN codigoarg integer, IN nomearg character varying)
 LANGUAGE sql
AS $procedure$
	update dbo.aluno
	set nome = case when nomeArg = '' then nome else nomeArg end
	where codigo = codigoArg;
$procedure$
;

CREATE OR REPLACE PROCEDURE dbo.upd_curso(IN codigoarg integer, IN descricaoarg character varying, IN ementaarg text)
 LANGUAGE sql
AS $procedure$
	update dbo.curso 
	set descricao = case when descricaoArg = '' then descricao else descricaoArg end, 
		ementa = case when ementaArg = '' then ementa else ementaArg end
	where codigo = codigoArg;
$procedure$
;
