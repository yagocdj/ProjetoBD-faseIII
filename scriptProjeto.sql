create database kanto;
use kanto;

create table treinador
(
    pokecpf int not null,
    nome varchar(45) not null,
    sexo char(1),
    datanascimento date not null,
    datacomeco date not null,
    constraint pk_pokecpf primary key (pokecpf),
    constraint chk_gender_t check (sexo in ('m','f'))
);

create table lider
(
    pokecpf int not null,
    nome varchar(45) not null,
    sexo char(1),
    datanascimento date not null,
    datacomeco date not null,
    especializao varchar(45) not null,
    pokecnpj int not null,
    endereco varchar(45) not null,
    tema varchar(45) not null,
    constraint pk_pokecpf primary key (pokecpf),
    constraint chk_gender_l check (sexo in ('m','f')),
    #constraint chk_datanasc_l check (datanascimento <= now()),
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
    idinsignia int null,
    nomeinsignia varchar(25) null,
    constraint pk_desafio primary key (iddesafio),
    constraint fk_lider foreign key (idlider) references lider (pokecpf),
    constraint fk_treinador foreign key (idtreinador) references treinador (pokecpf),
    constraint chk_insignia check ((idinsignia is not null and nomeinsignia is not null) or (idinsignia is null and nomeinsignia is null))
);

create table batalha
(
    idbatalha int not null,
    idtreinador1 int not null,
    idtreinador2 int not null,
    vencedor int,
    constraint pk_batalha primary key(idbatalha),
    constraint fk_treinador1 foreign key (idtreinador1) references treinador (pokecpf),
    constraint fk_treinador2 foreign key (idtreinador2) references treinador (pokecpf),
    /*constraint chk_vencedor check((vencedor in (1, 2)) or (vencedor is null))*/
    constraint chk_vencedor check((vencedor in (idtreinador1, idtreinador2)) or (vencedor is null))
);

/* valor default só cabe para colunas opicionais */

create table pokemon
(
    idpokemon int not null,
    fk_pokecpf int not null,
    especie varchar(45) not null,
    datacaptura date null, 
    localcaptura varchar(45) not null,
    pokebola varchar(45) not null,
    sexo char(1) default "f",
    apelido varchar(45),
    constraint pk_pokemon primary key (idpokemon),
    constraint fk_pokecpf foreign key (fk_pokecpf) references treinador (pokecpf),
    constraint chk_sexo check (sexo in ('m','f'))
    #constraint chk_data_cap check (datacaptura <= today())
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
    poder int not null,
    precisao decimal(2,1) not null,
    constraint fk_idtipo foreign key (fk_idtipo) references tipo (idtipo),
    constraint pk_idgolpe primary key (idgolpe),
    constraint chk_precisao check (0 < precisao <= 100) /* 0 < precisao <= 100 */
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
insert into treinador values (3, 'Playerbarbie socafofo', 'm', '2004-10-23', '2022-01-01');
insert into treinador values (4, 'Renatinhosensação', 'm', '1988-09-23', '2022-02-02');
insert into treinador values (5, 'Leon', 'm', '2019-09-18', '2020-09-18');
insert into treinador values (6, 'Cynthia', 'f', '2007-09-18', '2017-09-18');
insert into treinador values (7, 'Steven Stone', 'm', '2003-09-18', '2013-09-18');
insert into treinador values (8, 'Diantha', 'f', '2013-09-18', '2020-09-18');
insert into treinador values (9, 'Lance', 'm', '1997-09-18', '2007-09-18');


/* Inserção de dados na tabela lider */
insert into lider values (1, 'Brock', 'm', '1997-03-29', '2007-03-29', 'Pedra', 1, 'Pewter City', 'Cadeia de montanhas');
insert into lider values (2, 'Misty', 'f', '1997-04-13', '2007-04-13', 'Água', 2, 'Cerulean City', 'Piscina olímpica');
insert into lider values (3, 'Lt. Surge', 'm', '1997-03-29', '2007-03-29', 'Elétrico', 3, 'Vermillion City', 'Usina elétrica');
insert into lider values (4, 'Erika', 'f', '1997-04-13', '2007-04-13', 'Grama', 4, 'Celadon City', 'Jardim');
insert into lider values (5, 'Koga', 'm', '1997-03-29', '2007-03-29', 'Tóxico', 5, 'Fuchsia City', 'Dojo');
insert into lider values (6, 'Sabrinna', 'f', '1997-04-13', '2007-04-13', 'Psíquico', 6, 'Saffron City', 'Cyberpunk');
insert into lider values (7, 'Blaine', 'm', '1997-03-29', '2007-03-29', 'Fogo', 7, 'Ilha Cinnabar', 'Show de trivia');
insert into lider values (8, 'Giovanni', 'm', '1997-04-13', '2007-04-13', 'Terra', 8, 'Viridian City', 'Piscina olímpica');

/* Inserção de dados na tabela batalha:(idbatalha,fk_idtreinador1,fk_treinador2,vencededor) */
insert into batalha values (1, 1, 2, 2);
insert into batalha values (2, 1, 3, 1);
insert into batalha values (3, 1, 2, null);
insert into batalha values (4, 3, 2, 2);
insert into batalha values (5, 8, 9, 8);

/* Inserção de dados na tabela desafio */
insert into desafio values (1, 1, 1, 29, 3, 1999, 1, 'Montanha');
insert into desafio values (2, 2, 1, 13, 4, 1999, 2, 'Cascata');
insert into desafio values (3, 1, 2, 11, 2, 1999, 3, 'Montanha');
insert into desafio values (4, 2, 2, 16, 3, 1999, 4, 'Cascata');
insert into desafio values (5, 1, 2, 16, 3, 2010, 5, 'Montanha');
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
insert into pokemon values (1, 1, "Pikachu", "2009-04-15", "Rota 1", "Pokeball", default, "Stroenheim");
insert into pokemon values (12, 3, "Butterfree", "2022-11-13", "Atrás do armário", "Master ball", "f", "Sem manteiga");
insert into pokemon values (94, 4, "Gengar", "2022-12-03", "Lavender","Bola mestra", "f", "ValterZap");
insert into pokemon values (121, 6, "Starmie", "2012-01-21", "Floresta de Viridian", "Ultra bola", default, "Jubileu");
insert into pokemon values (135, 9, "Jolteon", "2000-06-20", "Ilha de Cinnabar", "Bola pesada", "m", "Joelton");

/* Inserção de dados na tabela Pokemon possui tipo: (fk_tipo,fk_idpokemon) */
insert into pokemon_possui_tipo values(10,1);
insert into pokemon_possui_tipo values(3,12);
insert into pokemon_possui_tipo values(7,12);
insert into pokemon_possui_tipo values(8,94);
insert into pokemon_possui_tipo values(4,94);
insert into pokemon_possui_tipo values(11,121);
insert into pokemon_possui_tipo values(14,121);
insert into pokemon_possui_tipo values(13,135);

select * from treinador;
select * from lider;

/* Exibir a tabela desafio com os nomes do líder desafiado e treinador desafiante, ordenados pelo líder */
select d.iddesafio, l.nome, t.nome, d.dia as Dia, d.mes as Mês, d.ano as Ano, d.nomeinsignia as Insígnia
from desafio d
join lider l on d.idlider = l.pokecpf
join treinador t on d.idtreinador = t.pokecpf
order by d.idlider;

select * from batalha;
select * from pokemon;
select * from pokemon_possui_tipo;
select * from tipo;
select * from golpe;


/* treinador.pokeCpf = batalha.vencedor */