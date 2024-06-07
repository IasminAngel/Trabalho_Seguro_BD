-- -----------------------------------------------------
-- SELECT
-- -----------------------------------------------------
-- Informativo de mensagens para analisar ;
SELECT Forum_topicos, mensagem, hr_dt_mensagem from mensagens;

-- Informando tempo de trabalho do funcionário ;
SELECT matricula, nome_funcionario, sobrenome_funcionario, tempoTrabalho FROM funcionario
WHERE nome_funcionario = 'Carlos';

-- -----------------------------------------------------
-- VIEWS
-- -----------------------------------------------------
-- Informando incidentes em "Análise" ;
 CREATE VIEW  incidentes_analise AS
 SELECT dt_hr_incidente, status, descricao_incidente from incidentes
 WHERE status = 'Em Análise';
 
 -- Informando incidentes "Resolvido" ; 
 CREATE VIEW incidentes_resolvido AS
 SELECT dt_hr_incidente, status, descricao_incidente from incidentes
 WHERE status = 'Resolvido';
 
 SELECT * FROM incidentes_resolvido;
 
-- -----------------------------------------------------
-- PROCEDURES
-- -----------------------------------------------------
-- Forma rápida de adição de incidentes

DELIMITER //

CREATE PROCEDURE AddIncidente(
    IN p_dt_hr_incidente DATETIME,
    IN p_status VARCHAR(30),
    IN p_descricao_incidente VARCHAR(45),
    IN p_local_incidente VARCHAR(45)
)
BEGIN
    INSERT INTO Incidentes (dt_hr_incidente, status, descricao_incidente, local_incidente)
    VALUES (p_dt_hr_incidente, p_status, p_descricao_incidente, p_local_incidente);
END //

DELIMITER ;

CALL AddIncidente('2024-06-01 15:45:00', 'Aberto', 'Explosão da fonte', 'Fonte Energia O');


-- Adicionando afetados por algum incidente 
DELIMITER //
CREATE PROCEDURE AddAfetados (
    IN p_matricula_afetados VARCHAR(45),
    IN p_incidentes_idIncidentes INT,
    IN p_lesao VARCHAR(45)
)
BEGIN
    INSERT INTO Afeta (Funcionario_matricula, Incidentes_idIncidentes, lesao) 
    VALUES (p_matricula_afetados, p_incidentes_idIncidentes, p_lesao);
END //

DELIMITER ;

CALL AddAfetados('003','3','Corte no braço');

-- Adicionando funcionários
DELIMITER //

CREATE PROCEDURE AddFuncionarios (
    IN p_matricula VARCHAR(45),
    IN p_CPF VARCHAR(11),
    IN p_formacao VARCHAR(45),
    IN p_nome_funcionario VARCHAR(45),
    IN p_dt_nascimento DATE,
    IN p_sobrenome_funcionario VARCHAR(45),
    IN p_ddd VARCHAR(4),
    IN p_numero VARCHAR(14),
    IN p_ddd_emergencial VARCHAR(4),
    IN p_telefoneEmergencial VARCHAR(14),
    IN p_logradouro VARCHAR(45),
    IN p_bairro VARCHAR(45),
    IN p_cidade VARCHAR(45),
    IN p_tempoTrabalho VARCHAR(15),
    IN p_Cargo_idCargo INT
)
BEGIN
    INSERT INTO Funcionario (matricula, CPF, formacao, nome_funcionario, dt_nascimento, sobrenome_funcionario, ddd, numero, ddd_emergencial, telefoneEmergencial, logradouro, bairro, cidade, tempoTrabalho, Cargo_idCargo) 
    VALUES (p_matricula, p_CPF, p_formacao, p_nome_funcionario, p_dt_nascimento, p_sobrenome_funcionario, p_ddd, p_numero, p_ddd_emergencial, p_telefoneEmergencial, p_logradouro, p_bairro, p_cidade, p_tempoTrabalho, p_Cargo_idCargo);
END //

DELIMITER ;

CALL AddFuncionario(); 

DELIMITER //

CREATE PROCEDURE AtualizacaoIncidenteStatus(
    IN p_id_incidente INT,
    IN p_novo_status VARCHAR(30)
)
BEGIN
    UPDATE Incidentes
    SET status = p_novo_status
    WHERE idIncidentes = p_id_incidente;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE AtualizacaoIncidenteDescricao(
    IN p_id_incidente INT,
    IN p_nova_descricao VARCHAR(30)
)
BEGIN
    UPDATE Incidentes
	SET descricao_incidente = p_nova_descricao
    WHERE idIncidentes = p_id_incidente;
END //

DELIMITER ;

CALL AtualizacaoIncidenteStatus('2','Resolvido', 'Incêndio na área de armazenamento');
CALL AtualizacaoIncidenteIncidentes('2','Resolvido', 'Incêndio na área de armazenamento');

SELECT idIncidentes, status, descricao_incidente FROM incidentes;

-- -----------------------------------------------------
-- FUNCTIONS
-- -----------------------------------------------------
-- Função para saber o nome completo do funcionário 

DELIMITER //

CREATE FUNCTION nome_Completo(p_matricula VARCHAR(45))
RETURNS VARCHAR(90)
BEGIN
    DECLARE nome_inteiro VARCHAR(90);
    SELECT CONCAT(nome_funcionario, ' ', sobrenome_funcionario)
    INTO nome_inteiro
    FROM Funcionario
    WHERE matricula = p_matricula;
    RETURN nome_inteiro;
END //

DELIMITER ;

SELECT nome_Completo('001') AS nome_inteiro;

-- Função para saber a idade do funcionário

DELIMITER //

CREATE FUNCTION Idade (p_dt_nascimento DATE)
RETURNS INT
BEGIN
    DECLARE idade INT;
    SET idade = TIMESTAMPDIFF(YEAR, p_dt_nascimento, CURDATE());
    
    IF (MONTH(p_dt_nascimento) > MONTH(CURDATE()) OR 
       (MONTH(p_dt_nascimento) = MONTH(CURDATE()) AND DAY(p_dt_nascimento) > DAY(CURDATE()))) THEN
        SET idade = idade - 1;
    END IF;
    
    RETURN idade;
END //

DELIMITER ;

SELECT nome_funcionario, Idade(dt_nascimento) AS idade
FROM Funcionario
WHERE matricula = '002';


DELIMITER //


DELIMITER //

CREATE FUNCTION RelatorioFinalTrabalhoSeguro()
RETURNS VARCHAR(100)
BEGIN
    DECLARE Resolvidos INT DEFAULT 0;
    DECLARE EmAnalise INT DEFAULT 0;
    DECLARE resultado VARCHAR(100);
    DECLARE Aberto INT DEFAULT 0;

    SELECT COUNT(*)
    INTO Resolvidos
    FROM Incidentes
    WHERE status = 'Resolvido';

    SELECT COUNT(*)
    INTO EmAnalise
    FROM Incidentes
    WHERE status = 'Em Análise';

	SELECT COUNT(*)
    INTO Aberto
	FROM Incidentes
	WHERE status = 'Aberto';

    SET resultado = CONCAT(
        'Incidentes Resolvidos: ', Resolvidos, ', ',
        'Incidentes Em Análise: ', EmAnalise, ', ',
        'Incidentes Em Aberto: ', Aberto, '.'
    );

    RETURN resultado;
END //

DELIMITER ;

SELECT RelatorioFinalTrabalhoSeguro();

-- -----------------------------------------------------
-- 	TRIGGER
-- -----------------------------------------------------


DELIMITER //

CREATE TRIGGER log_alteracao_incidente
BEFORE UPDATE ON Incidentes
FOR EACH ROW
BEGIN
    IF OLD.descricao_incidente <> NEW.descricao_incidente THEN
        SET NEW.descricao_incidente = CONCAT('Modificado: ', NEW.descricao_incidente);
    END IF;
END //

DELIMITER ;

-- -----------------------------------------------------
-- SELECT GERAIS
-- -----------------------------------------------------
SELECT * FROM afeta;
SELECT * FROM cargo;
SELECT * FROM categoria;
SELECT * FROM contem;
SELECT * FROM epi;
SELECT * FROM forum;
SELECT * FROM funcao;
SELECT * FROM funcionario;
SELECT * FROM incidentes;
SELECT * FROM mensagens;
SELECT * FROM registra;
SELECT * FROM tem;

SELECT COUNT(*)
FROM Incidentes
WHERE status = 'Resolvido';

SELECT COUNT(*)
FROM Incidentes
WHERE status = 'Em Análise';

SELECT COUNT(*)
FROM Incidentes
WHERE status = 'Aberto';

-- -----------------------------------------------------
-- DELETES
-- -----------------------------------------------------
DELETE FROM `trabalho_seguro`.`afeta` WHERE (`Funcionario_matricula` = '003') and (`Incidentes_idIncidentes` = '3');
