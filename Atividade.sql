Halloween:
CREATE TABLE tabela_halloween (
	id int auto_increment not null primary key,
	fantasia varchar(100),
	email varchar(100),
	idade int(3)
);
DELIMITER $$
CREATE PROCEDURE InsereUsuariosAleatorios()
BEGIN
DECLARE i INT DEFAULT 0;
WHILE i < 10000 DO
SET @fantasia := CONCAT('Fantasia', i);
SET @email := CONCAT('usuario', i, '@exemplo.com');
SET @idade := FLOOR(RAND() * 80) + 18; 
INSERT INTO tabela_halloween (fantasia , email, idade) VALUES (@fantasia, @email, @idade);
SET i = i + 1;
END WHILE;
END$$
DELIMITER ;
CALL InsereUsuariosAleatorios();
select * from tabela_halloween;
----------------------------------------------------------------------------------------
Peça Teatro:

create table pecas_teatro (
	id_peca int primary key not null auto_increment,
    	nome_peca varchar(200),
    	descricao varchar(500),
    	duracao int,
    	data_hora datetime,
    	diretor varchar(100),
    	local_peca varchar(100),
    	categoria varchar(100)
);
INSERT INTO pecas_teatro (nome_peca, descricao, duracao, data_hora, diretor, local_peca, categoria)
VALUES ("Cinderela", "Peça sobre a princesa", 110, "2024-09-11 15:30:00", "João Bonifácio", "Jacareí", "Infantil");
INSERT INTO pecas_teatro (nome_peca, descricao, duracao, data_hora, diretor, local_peca, categoria)
VALUES ("1917", "Peça sobre a guerra", 60, "2024-09-13 20:00:00", "Vitor de Almeida", "Mogi das Cruzes", "História");
-- Função para calcular media de duração das peças
SELECT AVG(duracao) AS media_duracao
FROM pecas_teatro;
DELIMITER $$
CREATE FUNCTION verificar_disponibilidade(data_hora DATETIME)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE resultado INT;
    -- Verifica se há alguma peça agendada para o horário fornecido
    SELECT COUNT(*)
    INTO resultado
    FROM pecas_teatro
    WHERE data_hora = data_hora;
    -- Retorna FALSE se já houver uma peça agendada, TRUE caso contrário
    IF resultado > 0 THEN
        RETURN FALSE; -- Horário não disponível
    ELSE
        RETURN TRUE; -- Horário disponível
    END IF;
END $$
DELIMITER ;
SET @horario_verificar = '2024-09-11 15:30:00';
SELECT 
    CASE WHEN verificar_disponibilidade(@horario_verificar) THEN 'disponível' ELSE 'indisponível' END AS disponibilidade;
-----------------------------------------------------------------------------------------------------------
Biblioteca:
 
create table autor (
 
	id int not null auto_increment primary key,
    nome varchar(100),
    sobrenome varchar(100)
 
);
 
create table livro (
 
	id int not null auto_increment primary key,
    nome varchar(100),
    ano_publicacao date
 
);
 
create table autor_livro (
 
	id int not null auto_increment primary key,
    id_autor int,
    id_livro int,
    foreign key (id_autor) references autor (id),
    foreign key (id_livro) references livro (id)
 
);
 
create table reserva (
 
id int not null auto_increment primary key,
id_livro int,
foreign key (id_livro) references livro (id),
data_inicio date,
data_fim date
 
);