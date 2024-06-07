-- -----------------------------------------------------
-- INSERTS 
-- -----------------------------------------------------
INSERT INTO `Trabalho_Seguro`.`Cargo` (`posicao`, `nome_cargo`) 
VALUES
('Gerente', 'Gerente de Segurança'),
('Técnico', 'Técnico de Segurança'),
('Analista', 'Gestor de Equipe');

INSERT INTO `Trabalho_Seguro`.`Funcionario` (`matricula`, `CPF`, `formacao`, `nome_funcionario`, `dt_nascimento`, `sobrenome_funcionario`, `ddd`, `numero`, `ddd_emergencial`, `telefoneEmergencial`, `logradouro`, `bairro`, `cidade`, `tempoTrabalho`, `Cargo_idCargo`)
VALUES
('001', '12345678901', 'Engenharia', 'João', '1980-01-01', 'Silva', '11', '987654321', '11', '912345678', 'Rua das Glórias, 70', 'Gloria', 'São Paulo', '10 anos', 1),
('002', '23456789012', 'Tecnologia', 'Maria', '1985-02-02', 'Souza', '71', '987654322', '71', '912345679', 'Rua do Terror, 21', 'Valéria', 'Salvador', '8 anos', 2),
('003', '34567890123', 'Administração', 'Carlos', '1990-03-03', 'Pereira', '71', '987654323', '71', '912345680', 'Rua do Tiroteio, 11', 'Mirantes Periperi', 'Salvador', '5 anos', 3);

INSERT INTO `Trabalho_Seguro`.`Categoria` (`tipo`)
VALUES
('Segurança do Trabalho'),
('Ergonomia'),
('Saúde Ocupacional');

INSERT INTO `Trabalho_Seguro`.`Forum` (`assunto`, `dt_hr_criacao`, `Categoria_idCategoria`, `Funcionario_matricula`)
VALUES
('Discussão sobre EPI', '2024-06-01 10:00:00', 1, '001'),
('Melhorias na Ergonomia', '2024-06-02 11:00:00', 2, '002'),
('Programas de Saúde Ocupacional', '2024-06-03 12:00:00', 3, '003');

INSERT INTO `Trabalho_Seguro`.`Mensagens` (`mensagem`, `hr_dt_mensagem`, `Forum_topicos`)
VALUES
('Precisamos revisar os EPIs utilizados.', '2024-06-01 10:30:00', 1),
('Quais são as novas diretrizes de ergonomia?', '2024-06-02 11:30:00', 2),
('Novas campanhas de saúde ocupacional foram lançadas, quando a empresa vai incrementar para auxílio ?.', '2024-06-03 12:30:00', 3);

INSERT INTO `Trabalho_Seguro`.`Incidentes` (`dt_hr_incidente`, `status`, `descricao_incidente`, `local_incidente`)
VALUES
('2024-06-01 09:00:00', 'Aberto', 'Queda de material', 'Fábrica A'),
('2024-06-02 14:00:00', 'Em Análise', 'Incêndio na área de armazenamento', 'Depósito B'),
('2024-06-03 16:00:00', 'Resolvido', 'Deslizamento de terra', 'Construção C');

INSERT INTO `Trabalho_Seguro`.`Funcao` (`descricao_funcao`, `Cargo_idCargo`, `Incidentes_idIncidentes`)
VALUES
('Supervisão', 1, 1),
('Investigação', 2, 2),
('Apoio', 3, 3);

INSERT INTO `Trabalho_Seguro`.`EPI` (`nome`)
VALUES
('Capacete de Segurança'),
('Luvas de Proteção'),
('Botas de Segurança');

INSERT INTO `Trabalho_Seguro`.`Contem` (`Funcionario_matricula`, `EPI_idEPI`, `data`, `data_validade_EPI`)
VALUES
('001', 1, '2024-01-01', '2025-01-01'),
('002', 2, '2024-02-02', '2025-02-02'),
('003', 3, '2024-03-03', '2025-03-03');

INSERT INTO `Trabalho_Seguro`.`Afeta` (`Funcionario_matricula`, `Incidentes_idIncidentes`, `lesao`)
VALUES
('001', 1, 'Escoriações leves'),
('002', 2, 'Queimaduras moderadas'),
('003', 3, 'Fratura no braço');

INSERT INTO `Trabalho_Seguro`.`Registra` (`Funcionario_matricula`, `Incidentes_idIncidentes`)
VALUES
('001', 1),
('002', 2),
('003', 3);

INSERT INTO `Trabalho_Seguro`.`Tem` (`EPI_idEPI`, `Funcao_idFuncao`)
VALUES
(1, 1),
(2, 2),
(3, 3);