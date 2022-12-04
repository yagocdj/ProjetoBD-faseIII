create database kanto;
use kanto;

create table pessoa
(
pokecpf int not null,
nome varchar(45) not null,
datanascimento date not null,
datacomeco date not null,
constraint pk_pokecpf primary key (pokecpf)
);

create table treinador
(
pokecpf int not null,
constraint pk_pokecpf primary key (pokecpf),
constraint fk_t_pessoa foreign key (pokecpf) references pessoa (pokecpf)
);

create table lider
(
pokecpf int not null,
especializao varchar(45) not null,
pokecnpj int not null,
endereco varchar(45) not null,
tema varchar(45) not null,
constraint pk_pokecpf primary key (pokecpf),
constraint ak_pokecnpj unique (pokecnpj),
constraint fk_l_pessoa foreign key (pokecpf) references pessoa (pokecpf)
);

create table desafio
(
iddesafio int not null,
idlider int not null,
idtreinador int not null,
dia int not null,
mes int not null,
ano int not null,
insignia varchar(25),
constraint pk_desafio primary key (iddesafio),
constraint fk_lider foreign key (idlider) references lider (pokecpf),
constraint fk_treinador foreign key (idtreinador) references treinador (pokecpf)
);

create table batalha
(
idbatalha int not null,
idtreinador1 int not null,
idtreinador2 int not null,
constraint pk_batalha primary key(idbatalha),
constraint fk_treinador1 foreign key (idtreinador1) references treinador (pokecpf),
constraint fk_treinador2 foreign key (idtreinador2) references treinador (pokecpf)
);

/* Inserção de dados na tabela pessoa */
insert into pessoa values (1, 'Ash Ketchup', '1997-03-01', '2007-03-01');
insert into pessoa values (2, 'Gary', '1997-03-01', '2007-03-01');
insert into pessoa values (3, 'Brock', '1997-03-29', '2007-03-29');
insert into pessoa values (4, 'Misty', '1997-04-13', '2007-04-13');
insert into pessoa values (5, 'N', '2010-09-18', '2020-09-18');

/* Inserção de dados na tabela treinador */
insert into treinador values (1);
insert into treinador values (2);
insert into treinador values (5);

/* Inserção de dados na tabela lider */
insert into lider values (3, 'Pedra', 1, 'Pewter City', 'Terra');
insert into lider values (4, 'Água', 2, 'Cerulean City', 'Piscina');

/* Inserção de dados na tabela batalha */
insert into batalha values (1, 1, 2);
insert into batalha values (2, 1, 5);
insert into batalha values (3, 1, 2);
insert into batalha values (4, 5, 2);

/* Inserção de dados na tabela desafio */
insert into desafio values (1, 3, 1, 29, 3, 1999, 'Rocha');
insert into desafio values (2, 4, 1, 13, 4, 1999, 'Onda');
insert into desafio values (3, 3, 2, 11, 2, 1999, 'Rocha');
insert into desafio values (4, 4, 2, 16, 3, 1999, 'Onda');
insert into desafio values (5, 3, 5, 16, 3, 2010, 'Rocha');
insert into desafio values (6, 4, 5, 31, 1, 2010, null);

/Exibir treinadores e seus nomes/
select t.pokecpf as Treinador, p.nome as Nome
from treinador t
join pessoa p
on t.pokecpf = p.pokecpf;

select p.*, l.especializao, l.pokecnpj, l.endereco, l.tema
from pessoa p
left join lider l on p.pokecpf = l.pokecpf;

/Exibir batalhas e os nomes dos treinadores envolvidos/
select b.idbatalha as Id, p1.nome as Treinador, p2.nome as Treinador
from batalha b
join treinador t1 on b.idtreinador1 = t1.pokecpf
join treinador t2 on b.idtreinador2 = t2.pokecpf
join pessoa p1 on t1.pokecpf = p1.pokecpf
join pessoa p2 on t2.pokecpf = p2.pokecpf;

/Exibir desafios e os nomes do lider e treinador envolvidos/
select d.iddesafio as Id, pli.nome as Líder, pte.nome as Treinador, d.ano as Ano, d.mes as Mês, d.dia as Dia, d.insignia as Insígnia
from desafio d
join lider l on d.idlider = l.pokecpf
join treinador t on d.idtreinador = t.pokecpf
join pessoa pli on pli.pokecpf = l.pokecpf
join pessoa pte on pte.pokecpf = t.pokecpf
order by id, d.ano, d.mes, d.dia;
