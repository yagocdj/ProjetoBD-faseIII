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
    constraint chk_datanasc_l check (datanascimento <= curdate()),
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
    idInsignia int null,
    nomeInsignia varchar(25) null,
    constraint pk_desafio primary key (iddesafio),
    constraint fk_lider foreign key (idlider) references lider (pokecpf),
    constraint fk_treinador foreign key (idtreinador) references treinador (pokecpf),
    constraint chk_insignia check ((idInsignia is not null and nomeInsignia is not null) or (idInsignia is null and nomeInsignia is null))
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
    constraint chk_vencedor check((vencedor in (1, 2)) or (vencedor is null))
);

create table pokemon
(
    idpokemon int not null,
    fk_pokecpf int not null,
    especie varchar(45) not null,
    datacaptura date not null default today,
    localcaptura varchar(45) not null,
    pokebola varchar(45) not null,
    sexo char(1) default "f",
    apelido varchar(45),
    constraint fk_pokecpf foreign key (pokecpf) references treinador (pokecpf),
    constraint chk_sexo check (sexo in ('m','f')),
    constraint chk_data_cap check (datacaptura <= curdate())
);

create table golpe
(
    fk_idTipo int not null
    idGolpe int not null 
    nome varchar(45) not null
    poder int not null
    precisao decimal(2,1) not null
    constraint fk_idTipo foreign key (fk_idTipo) references tipo (idTipo)
    constraint pk_idGolpe primary key (idGolpe)
    constraint chk_precisao check (precisao <= 100 and precisao > 1) /* 0 < precisao <= 100 */
);

create table pokemon_possui_tipo
(
    fk_tipo varchar(45) not null,
    fk_id_pokemon int not null,
    constraint pk_pokemon_possui_tipo primary key (fk_tipo,fk_id_pokemon),
    constraint fk_tipo foreign key (fk_tipo) references tipo (idTipo),
    constraint fk_id_pokemon foreign key (fk_id_pokemon) references pokemon (idPokemon)  
);

create table tipo
(
    idTipo int not null,
    nome varchar(45) not null,
    constraint pk_idTipo primary key (idTipo)
);

/* Inserção de dados na tabela treinador */
insert into treinador values (1, 'Ash Ketchup', 'm', '1997-03-01', '2007-03-01');
insert into treinador values (2, 'Gary', 'm', '1997-03-01', '2007-03-01');
insert into treinador values (3, 'N', 'f', '2010-09-18', '2020-09-18');

/* Inserção de dados na tabela lider */
insert into lider values (1, 'Brock', 'm', '1997-03-29', '2007-03-29', 'Pedra', 1, 'Pewter City', 'Cadeia de montanhas');
insert into lider values (2, 'Misty', 'f', '1997-04-13', '2007-04-13', 'Água', 2, 'Cerulean City', 'Piscina olímpica');

/* Inserção de dados na tabela batalha */
insert into batalha values (1, 1, 2, 2);
insert into batalha values (2, 1, 3, 1);
insert into batalha values (3, 1, 2, null);
insert into batalha values (4, 3, 2, 3);

/* Inserção de dados na tabela desafio */
insert into desafio values (1, 1, 1, 29, 3, 1999, 1, 'Montanha');
insert into desafio values (2, 2, 1, 13, 4, 1999, 2, 'Onda');
insert into desafio values (3, 1, 2, 11, 2, 1999, 3, 'Montanha');
insert into desafio values (4, 2, 2, 16, 3, 1999, 4, 'Onda');
insert into desafio values (5, 1, 2, 16, 3, 2010, 5, 'Montanha');
insert into desafio values (6, 2, 3, 31, 1, 2010, null, null);

select * from treinador;
select * from lider;
select * from desafio;
select * from batalha;