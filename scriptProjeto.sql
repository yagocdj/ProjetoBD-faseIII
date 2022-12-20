drop database kanto;
create database kanto;
use kanto;

create table treinador
(
    pokecpf int not null,
    nome varchar(45) not null,
    sexo char(1),
    datanascimento date not null,
    datacomeco date default (sysdate()) not null,
    constraint pk_pokecpf primary key (pokecpf),
    constraint chk_gender_t check (sexo in ('m','f')),
    constraint chk_datanasc_t check (datanascimento <= sysdate()),
    constraint chk_datacomeco_t check (datanascimento <= datacomeco and datacomeco <= sysdate())
);

create table lider
(
    pokecpf int not null,
    nome varchar(45) not null,
    sexo char(1),
    datanascimento date not null,
    datacomeco date default (sysdate()) not null,
    especializao varchar(45) not null,
    pokecnpj int not null,
    endereco varchar(45) not null,
    tema varchar(45) not null,
    constraint pk_pokecpf primary key (pokecpf),
    constraint chk_gender_l check (sexo in ('m','f')),
    constraint chk_datanasc_l check (datanascimento <= sysdate()),
    constraint chk_datacomeco_l check (datanascimento <= datacomeco and datacomeco <= sysdate()),
    constraint ak_pokecnpj unique (pokecnpj),
    constraint ak_endereco unique (endereco)
);

create table desafio
(
    iddesafio int not null,
    idlider int not null,
    idtreinador int not null,
    dia int not null,
    mes int not null,
    ano int not null,
    idinsignia int,
    nomeinsignia varchar(25),
    constraint pk_desafio primary key (iddesafio),
    constraint fk_lider foreign key (idlider) references lider (pokecpf),
    constraint fk_treinador foreign key (idtreinador) references treinador (pokecpf),
    constraint chk_insignia check ((idinsignia is not null and nomeinsignia is not null) or (idinsignia is null and nomeinsignia is null)),
    constraint ak_idinsignia unique (idinsignia)
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

/* valor default só cabe para colunas opicionais */

create table pokemon
(
    idpokemon int not null,
    fk_pokecpf int not null,
    especie varchar(45) not null,
    datacaptura date default (sysdate()) not null, 
    localcaptura varchar(45) not null,
    pokebola varchar(45) not null,
    sexo char(1),
    apelido varchar(45),
    constraint pk_pokemon primary key (idpokemon),
    constraint fk_pokecpf foreign key (fk_pokecpf) references treinador (pokecpf),
    constraint chk_sexo check (sexo in ('m','f')),
    constraint chk_data_cap check (datacaptura <= sysdate())
);

/* DEFAULT CURRENT_TIMESTAMP GETDATE CURDATE*/
create table tipo
(
    idtipo int not null,
    nome varchar(45) not null,
    constraint pk_idtipo primary key (idtipo)
);

create table golpe
(
    fk_idtipo int not null,
    idgolpe int not null,
    nome varchar(45) not null,
    poder int default (40) not null,
    precisao decimal(4,1) default (90.0) not null,
    constraint fk_idtipo foreign key (fk_idtipo) references tipo (idtipo),
    constraint pk_idgolpe primary key (idgolpe),
    constraint chk_poder check (0 < poder < 999),
    constraint chk_precisao check (0.1 < precisao <= 100) /* 0 < precisao <= 100 */
);

create table pokemon_possui_tipo
(
    fk_tipo int not null,
    fk_idpokemon int not null,
    constraint pk_pokemon_possui_tipo primary key (fk_tipo,fk_idpokemon),
    constraint fk_tipo foreign key (fk_tipo) references tipo (idtipo),
    constraint fk_idpokemon foreign key (fk_idpokemon) references pokemon (idpokemon)
);

/* Inserção de dados na tabela treinador */
insert into treinador values (1, 'Ash Ketchum', 'm', '1997-03-01', '2007-03-01');
insert into treinador values (2, 'Gary', 'm', '1997-03-01', '2007-03-01');
insert into treinador values (3, 'Gold', 'm', '1999-11-21', '2009-11-21');
insert into treinador values (4, 'Crystal', 'f', '2000-12-14', '2010-12-14');
insert into treinador values (5, 'May', 'f', '2003-11-21', '2013-11-21');
insert into treinador values (6, 'Brendan', 'm', '2003-11-21', '2013-11-21');
insert into treinador values (7, 'Dawn', 'f', '2006-9-28', '2016-9-28');
insert into treinador values (8, 'Steven Stone', 'm', '1989-11-21', '1999-11-21');
insert into treinador values (9, 'Cynthia', 'f', '1996-9-28', '2006-9-28');
insert into treinador values (10, 'Playerbarbie socafofo', 'm', '2004-10-23', '2022-01-01');
insert into treinador values (11, 'Renatinhosensação', 'm', '1988-09-23', '2022-02-02');
insert into treinador values (12, 'Yagostoso', 'm', '2019-09-18', '2020-09-18');
insert into treinador values (13, 'Bigsogga', 'm', '2007-09-18', '2017-09-18');



/* Inserção de dados na tabela lider */
insert into lider values (1, 'Brock', 'm', '1997-03-29', '2007-03-29', 'Pedra', 1, 'Pewter City', 'Cadeia de montanhas');
insert into lider values (2, 'Misty', 'f', '1997-04-13', '2007-04-13', 'Água', 2, 'Cerulean City', 'Piscina olímpica');
insert into lider values (3, 'Lt. Surge', 'm', '1997-03-29', '2007-03-29', 'Elétrico', 3, 'Vermillion City', 'Usina elétrica');
insert into lider values (4, 'Erika', 'f', '1997-04-13', '2007-04-13', 'Grama', 4, 'Celadon City', 'Jardim');
insert into lider values (5, 'Koga', 'm', '1997-03-29', '2007-03-29', 'Tóxico', 5, 'Fuchsia City', 'Dojo');
insert into lider values (6, 'Sabrinna', 'f', '1997-04-13', '2007-04-13', 'Psíquico', 6, 'Saffron City', 'Cyberpunk');
insert into lider values (7, 'Blaine', 'm', '1997-03-29', '2007-03-29', 'Fogo', 7, 'Ilha Cinnabar', 'Show de trivia');
insert into lider values (8, 'Giovanni', 'm', '1997-04-13', '2007-04-13', 'Terra', 8, 'Viridian City', 'Piscina olímpica');

/* Inserção de dados na tabela batalha:(idbatalha,fk_idtreinador1,fk_treinador2) */
insert into batalha values (1, 1, 2);
insert into batalha values (2, 1, 3);
insert into batalha values (3, 1, 2);
insert into batalha values (4, 3, 2);
insert into batalha values (5, 9, 5);

/* Inserção de dados na tabela desafio */
insert into desafio values (1, 1, 1, 29, 3, 1999, null, null);
insert into desafio values (2, 2, 1, 13, 4, 1999, null, null);
insert into desafio values (3, 1, 2, 11, 2, 1999, 3, 'Montanha');
insert into desafio values (4, 2, 2, 16, 3, 1999, 4, 'Cascata');
insert into desafio values (5, 1, 5, 16, 3, 2010, 5, 'Montanha');
insert into desafio values (6, 2, 3, 31, 1, 2010, null, null);

/* Inserção de dados na tabela tipo */
insert into tipo values(1, 'Normal');
insert into tipo values(2, 'Lutador');
insert into tipo values(3, 'Voador');
insert into tipo values(4, 'Venenoso');
insert into tipo values(5, 'Terrestre');
insert into tipo values(6, 'Pedra');
insert into tipo values(7, 'Inseto');
insert into tipo values(8, 'Fantasma');
insert into tipo values(9, 'Metal');
insert into tipo values(10, 'Fogo');
insert into tipo values(11, 'Água');
insert into tipo values(12, 'Planta');
insert into tipo values(13, 'Elétrico');
insert into tipo values(14, 'Psíquico');
insert into tipo values(15, 'Gelo');
insert into tipo values(16, 'Dragão');
insert into tipo values(17, 'Trevas');
insert into tipo values(18, 'Fada');

/* Inserção de dados na tabela pokémon */
/* insert into pokemon values (idpokemon, fk_pokecpf, especie, datacaptura, localcaptura, pokebola, sexo, apelido) */
insert into pokemon values (1, 1, "Pikachu", "2009-04-15", "Rota 1", "Pokeball", null, "Stroenheim");
insert into pokemon values (2, 11, 'Pidgey', '2002-01-14', 'Rota 3', 'Normal', 'f', 'Patinho');
insert into pokemon values (12, 12, "Butterfree", "2022-11-13", "Atrás do armário", "Master ball", "f", "Sem manteiga");
insert into pokemon values (94, 11, "Gengar", "2022-12-03", "Torre de Lavender","Bola mestra", "f", "ValterZap");
insert into pokemon values (121, 13, "Starmie", "2012-01-21", "Floresta de Viridian", "Ultra bola", null, "Jubileu");
insert into pokemon values (135, 10, "Jolteon", "2000-06-20", "Ilha Cinnabar", "Bola pesada", "m", null);
insert into pokemon values (13, 13, "Butterfree", "2022-11-14", "Rota 1", "Pokeball", "m", "Brobuleta");
insert into pokemon values (3, 10, "Charmander", "2022-12-5", "Ilha Cinnabar", "Pokeball", "f", "Charmie");
insert into pokemon values (4, 13, "Charmeleon", "2022-9-9", "Ilha Cinnabar", "Great ball", "m", "Leonidas");
insert into pokemon values (5, 11, "Machoke", "2022-4-4", "Rota 7", "Ultraball", "m", "Edem.B");
insert into pokemon values (77, 11, "Crobat", "2022-3-12", "Mt. Moon", "Dusk ball", "m", "Batleo");


/* Inserção de dados na tabela Pokemon possui tipo: (fk_tipo,fk_idpokemon) */
insert into pokemon_possui_tipo values(13,1);
insert into pokemon_possui_tipo values(3,2);
insert into pokemon_possui_tipo values(1,2);
insert into pokemon_possui_tipo values(3,12);
insert into pokemon_possui_tipo values(7,12);
insert into pokemon_possui_tipo values(8,94);
insert into pokemon_possui_tipo values(4,94);
insert into pokemon_possui_tipo values(11,121);
insert into pokemon_possui_tipo values(14,121);
insert into pokemon_possui_tipo values(13,135);
insert into pokemon_possui_tipo values(3,13);
insert into pokemon_possui_tipo values(7,13);
insert into pokemon_possui_tipo values(10,3);
insert into pokemon_possui_tipo values(10,4);
insert into pokemon_possui_tipo values(2,5);
insert into pokemon_possui_tipo values(3,77);
insert into pokemon_possui_tipo values(4,77);

/* Inserção de dados na tabela Golpe: (fk_idtipo, idgolpe, nome, poder, precisao) */
insert into golpe values(1, 1, "Investida", 35, 95.0);
insert into golpe values(3, 5, "Fly", 90, 95.0);
insert into golpe values(5, 2, "Dig", 80, 100.0);
insert into golpe values(5, 3, "Ataque de Areia", 0, 100.0);
insert into golpe values(10, 6, "Lança Chamas", 90, 100.0);
insert into golpe values(5, 4, "Terremoto", 100, 100.0);
insert into golpe values(10, 7, "Soco de fogo", 75, 100.0);
insert into golpe values(13, 8, "Canhão Zap", 120, 100.0);
insert into golpe values(17, 9, "Mordida", 60, 100.0);
insert into golpe values(3, 10, "Ás Aéreo", 90, 95.0);

/* Exibir a tabela desafio com os nomes do líder desafiado e treinador desafiante, ordenados pelo líder */
select d.iddesafio as ID, l.nome as Líder, t.nome as Treinador, d.dia as Dia, d.mes as Mês, d.ano as Ano, d.nomeinsignia as Insígnia
from desafio d
join lider l on d.idlider = l.pokecpf
join treinador t on d.idtreinador = t.pokecpf
order by d.idlider;

/* Exibir todos os treinadores que nasceram entre 1980 e 2005 */
select * 
from treinador 
where year(datanascimento)
between 1980 and 2005;

/* Exibir o nome dos tipos de pokémon cujas médias do poderes de golpe esteja entre 70.0 e 100.0 */
select t.nome as Tipo, avg(g.poder) as Poder
from golpe g
join tipo t on g.fk_idtipo = t.idtipo
where Poder between 70.0 and 100.0
group by t.idtipo;

/*  Exibir o id, nome do tipo e a espécie do pokémon correspondente da tabela pokemon_possui_tipo */
select p.idpokemon, t.nome as Tipo, p.especie as Pokémon 
from pokemon_possui_tipo pt 
join tipo t on pt.fk_tipo = t.idtipo
join pokemon p on pt.fk_idpokemon = p.idpokemon
order by p.idpokemon;

/* Exibir pokemons que começam com 'Char' */
select * from Pokemon
having especie like 'Char%';

/* Exibir a quantidade de tipos de cada pokemon e seus apelidos */
select p.especie as Pokémon, p.apelido as Nome, count(distinct pt.fk_tipo) as Tipos
from pokemon p
join pokemon_possui_tipo pt on p.idpokemon = pt.fk_idpokemon
group by p.idpokemon;

/* Exibir poder do golpe mais forte do tipo Voador */
select nome, max(poder) AS "Mais forte"
from golpe
where fk_idtipo = 3
group by nome;

/* Exibir todos os pokemons que possuem apelidos */
select idpokemon, especie, apelido from pokemon
where apelido is not null
order by idpokemon;

/* Exibir os pokemons capturados na Rota 1 ou Rota 3*/
select idpokemon, especie from pokemon
where localcaptura in ('Rota 1', 'Rota 3')
order by idpokemon;
