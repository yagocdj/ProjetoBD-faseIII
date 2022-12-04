drop database kanto;

select d.iddesafio, l.nome as "Nome do líder", t.nome as "Nome do treinador", d.dia as Dia, d.mes as Mês, d.ano as Ano, d.nomeinsignia as Insígnia
from desafio d
join lider l on d.idlider = l.pokecpf
join treinador t on d.idtreinador = t.pokecpf
order by d.idlider;