DROP DATABASE hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE paciente(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(13) NOT NULL
);

CREATE TABLE consulta(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    sintomas VARCHAR(100) NOT NULL,
    remedio VARCHAR(100) NOT NULL,
    data_consulta DATE NOT NULL,
    observacoes VARCHAR(50),
    status_consulta ENUM('Finalizada', 'Pendente') NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id)
);

INSERT INTO paciente(nome, cpf, data_nascimento, telefone) VALUES
('João Vitor', '145.673.852-17', '2004-04-22', '64 96357-1458'),
('Maria Clara', '254.687.945-30', '1990-11-15', '64 98765-4321'),
('Pedro Henrique', '365.894.176-98', '1985-06-01', '64 91234-5678'),
('Ana Paula', '478.901.237-46', '1975-09-12', '64 92345-6789'),
('Lucas Gabriel', '589.012.348-57', '1999-02-28', '64 93456-7890'),
('Mariana Silva', '690.123.459-68', '2003-07-14', '64 94567-8901'),
('Felipe Alves', '701.234.560-79', '1980-01-05', '64 95678-9012'),
('Camila Santos', '812.345.671-80', '1995-03-22', '64 96789-0123'),
('Guilherme Costa', '923.456.782-91', '2002-08-19', '64 97890-1234'),
('Isabela Oliveira', '034.567.893-02', '1997-12-05', '64 98901-2345');

INSERT INTO consulta(id_paciente, sintomas, remedio, data_consulta, status_consulta, observacoes) VALUES
(1, 'Febre, Dor de Cabeça e Vômito', 'Dipirona', '2024-08-10', 'Finalizada', NULL),
(2, 'Dor de Garganta e Tosse', 'Amoxicilina', '2024-08-12', 'Pendente', 'Beber bastante água'),
(3, 'Dores Abdominais', 'Buscopan', '2024-08-14', 'Pendente', NULL),
(4, 'Cansaço e Falta de Ar', 'Inalação', '2024-08-15', 'Pendente', 'Verificar histórico de asma'),
(5, 'Erupção Cutânea e Coceira', 'Antialérgico', '2024-08-16', 'Finalizada', NULL),
(6, 'Dor no Peito', 'AAS', '2024-08-18', 'Pendente', 'Recomendar ECG'),
(7, 'Náusea e Tontura', 'Plasil', '2024-08-19', 'Pendente', NULL),
(8, 'Inchaço nos Pés', 'Diurético', '2024-08-21', 'Finalizada', 'Investigar insuficiência cardíaca'),
(9, 'Infecção Urinária', 'Ciprofloxacina', '2024-08-23', 'Finalizada', 'Recomendar ingestão de líquidos'),
(10, 'Dores nas Articulações', 'Ibuprofeno', '2024-08-24', 'Pendente', NULL);


#Retorna todos os pacientes que tem uma observação em sua consulta
CREATE VIEW paciente_observacao AS
SELECT pac.id, pac.nome, pac.cpf, con.observacoes, con.data_consulta, con.status_consulta
FROM consulta AS con
INNER JOIN paciente AS pac ON (con.id_paciente = pac.id)
WHERE con.observacoes IS NOT NULL;

#Vai selecionar os dados pedidos antes de inserir novos dados.
SELECT * FROM paciente_observacao;

INSERT INTO paciente(nome, cpf, data_nascimento, telefone) VALUES
('Ricardo Lima', '145.678.904-13', '1965-10-20', '64 99012-3456'),
('Fernanda Rocha', '256.789.015-24', '1988-04-07', '64 90123-4567'),
('Rafael Mendes', '367.890.126-35', '1992-06-18', '64 91234-5678'),
('Beatriz Souza', '478.901.237-46', '1996-01-25', '64 92345-6789'),
('Thiago Moreira', '589.012.348-57', '1994-09-09', '64 93456-7890'),
('Larissa Fernandes', '690.123.459-68', '2001-11-30', '64 94567-8901'),
('Diego Martins', '701.234.560-79', '1982-05-13', '64 95678-9012'),
('Juliana Almeida', '812.345.671-80', '1987-07-28', '64 96789-0123'),
('Eduardo Pereira', '923.456.782-91', '1993-03-15', '64 97890-1234'),
('Carolina Mendes', '034.567.893-02', '1998-02-08', '64 98901-2345');

INSERT INTO consulta(id_paciente, sintomas, remedio, data_consulta, status_consulta, observacoes) VALUES
(11, 'Congestão Nasal', 'Antigripal', '2024-08-25', 'Pendente', 'Verificar histórico de sinusite'),
(12, 'Fadiga e Palidez', 'Suplemento de Ferro', '2024-08-26', 'Finalizada', 'Investigar anemia'),
(13, 'Dor de Ouvido', 'Otossul', '2024-08-27', 'Pendente', NULL),
(14, 'Diarreia e Desidratação', 'Soro Oral', '2024-08-28', 'Pendente', 'Recomendar dieta leve'),
(15, 'Insônia', 'Melatonina', '2024-08-29', 'Pendente', 'Recomendar higiene do sono'),
(16, 'Dificuldade de Urinar', 'Tansulosina', '2024-08-30', 'Finalizada', 'Verificar possível HBP'),
(17, 'Tosse com Catarro', 'Expectorante', '2024-09-01', 'Pendente', NULL),
(18, 'Perda de Apetite', 'Complexo Vitamínico', '2024-09-02', 'Finalizada', 'Reavaliar em 2 semanas'),
(19, 'Queimaduras na Pele', 'Pomada Cicatrizante', '2024-09-03', 'Pendente', 'Recomendar proteção solar'),
(20, 'Dificuldade de Movimento', 'Fisioterapia', '2024-09-05', 'Pendente', 'Encaminhar para especialista');

#Vai selecionar os dados após inserir novos.
SELECT * FROM paciente_observacao;

#Realiza um Update na query e todos os cambos null de observações será alterado para "Sem Observações".
UPDATE paciente_observacao
	SET status_consulta = 'Finalizada'
    WHERE id = '19';
     
SELECT * FROM paciente_observacao;