
-- -----------------------------------------------------
-- Schema Trabalho_Seguro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Trabalho_Seguro` DEFAULT CHARACTER SET utf8 ;
USE `Trabalho_Seguro` ;

-- -----------------------------------------------------
-- Table `Trabalho_Seguro`.`Cargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Trabalho_Seguro`.`Cargo` (
  `idCargo` INT NOT NULL AUTO_INCREMENT,
  `posicao` VARCHAR(45) NULL,
  `nome_cargo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Trabalho_Seguro`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Trabalho_Seguro`.`Funcionario` (
  `matricula` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(11) NOT NULL,
  `formacao` VARCHAR(45) NOT NULL,
  `nome_funcionario` VARCHAR(45) NOT NULL,
  `dt_nascimento` DATE NOT NULL,
  `sobrenome_funcionario` VARCHAR(45) NOT NULL,
  `ddd` VARCHAR(4) NOT NULL,
  `numero` VARCHAR(14) NOT NULL,
  `ddd_emergencial` VARCHAR(4) NULL,
  `telefoneEmergencial` VARCHAR(14) NULL,
  `logradouro` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `tempoTrabalho` VARCHAR(15) NOT NULL,
  `Cargo_idCargo` INT NOT NULL,
  PRIMARY KEY (`matricula`),
  INDEX `fk_Funcionario_Cargo1_idx` (`Cargo_idCargo`),
  CONSTRAINT `fk_Funcionario_Cargo1`
    FOREIGN KEY (`Cargo_idCargo`)
    REFERENCES `Trabalho_Seguro`.`Cargo` (`idCargo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Trabalho_Seguro`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Trabalho_Seguro`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Trabalho_Seguro`.`Forum`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Trabalho_Seguro`.`Forum` (
  `topicos` VARCHAR(45) NOT NULL,
  `assunto` VARCHAR(45) NOT NULL,
  `dt_hr_criacao` DATETIME NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  `Funcionario_matricula` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`topicos`, `Categoria_idCategoria`, `Funcionario_matricula`),
  INDEX `fk_Forum_Categoria1_idx` (`Categoria_idCategoria`),
  INDEX `fk_Forum_Funcionario1_idx` (`Funcionario_matricula`),
  CONSTRAINT `fk_Forum_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `Trabalho_Seguro`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Forum_Funcionario1`
    FOREIGN KEY (`Funcionario_matricula`)
    REFERENCES `Trabalho_Seguro`.`Funcionario` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Trabalho_Seguro`.`Mensagens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Trabalho_Seguro`.`Mensagens` (
  `mensagem` VARCHAR(45) NOT NULL,
  `hr_dt_mensagem` DATETIME NOT NULL,
  `Forum_topicos` VARCHAR(45) NOT NULL,
  `Funcionario_matricula` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Forum_topicos`, `hr_dt_mensagem`, `Funcionario_matricula`),
  INDEX `fk_Mensagens_Funcionario1_idx` (`Funcionario_matricula`),
  CONSTRAINT `fk_Mensagens_Forum1`
    FOREIGN KEY (`Forum_topicos`)
    REFERENCES `Trabalho_Seguro`.`Forum` (`topicos`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Mensagens_Funcionario1`
    FOREIGN KEY (`Funcionario_matricula`)
    REFERENCES `Trabalho_Seguro`.`Funcionario` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Trabalho_Seguro`.`Funcao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Trabalho_Seguro`.`Funcao` (
  `idFuncao` INT NOT NULL AUTO_INCREMENT,
  `descricao_funcao` VARCHAR(45) NOT NULL,
  `Cargo_idCargo` INT NOT NULL,
  PRIMARY KEY (`idFuncao`, `Cargo_idCargo`),
  INDEX `fk_Funcao_Cargo1_idx` (`Cargo_idCargo`),
  CONSTRAINT `fk_Funcao_Cargo1`
    FOREIGN KEY (`Cargo_idCargo`)
    REFERENCES `Trabalho_Seguro`.`Cargo` (`idCargo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Trabalho_Seguro`.`Incidentes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Trabalho_Seguro`.`Incidentes` (
  `idIncidentes` INT NOT NULL AUTO_INCREMENT,
  `dt_hr_incidente` DATETIME NOT NULL,
  `status` VARCHAR(30) NOT NULL,
  `descricao_incidente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idIncidentes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Trabalho_Seguro`.`EPI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Trabalho_Seguro`.`EPI` (
  `idEPI` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idEPI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Trabalho_Seguro`.`Contem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Trabalho_Seguro`.`Contem` (
  `Funcionario_matricula` VARCHAR(45) NOT NULL,
  `EPI_idEPI` INT NOT NULL,
  `data` DATE NOT NULL,
  PRIMARY KEY (`Funcionario_matricula`, `EPI_idEPI`),
  INDEX `fk_Funcionario_has_EPI_EPI1_idx` (`EPI_idEPI`),
  INDEX `fk_Funcionario_has_EPI_Funcionario_idx` (`Funcionario_matricula`),
  CONSTRAINT `fk_Funcionario_has_EPI_Funcionario`
    FOREIGN KEY (`Funcionario_matricula`)
    REFERENCES `Trabalho_Seguro`.`Funcionario` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Funcionario_has_EPI_EPI1`
    FOREIGN KEY (`EPI_idEPI`)
    REFERENCES `Trabalho_Seguro`.`EPI` (`idEPI`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Trabalho_Seguro`.`Afeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Trabalho_Seguro`.`Afeta` (
  `Funcionario_matricula` VARCHAR(45) NOT NULL,
  `Incidentes_idIncidentes` INT NOT NULL,
  PRIMARY KEY (`Funcionario_matricula`, `Incidentes_idIncidentes`),
  INDEX `fk_Funcionario_has_Incidentes_Incidentes1_idx` (`Incidentes_idIncidentes`),
  CONSTRAINT `fk_Funcionario_has_Incidentes_Funcionario1`
    FOREIGN KEY (`Funcionario_matricula`)
    REFERENCES `Trabalho_Seguro`.`Funcionario` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_has_Incidentes_Incidentes1`
    FOREIGN KEY (`Incidentes_idIncidentes`)
    REFERENCES `Trabalho_Seguro`.`Incidentes` (`idIncidentes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Trabalho_Seguro`.`Registra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Trabalho_Seguro`.`Registra` (
  `Funcionario_matricula` VARCHAR(45) NOT NULL,
  `Incidentes_idIncidentes` INT NOT NULL,
  PRIMARY KEY (`Funcionario_matricula`, `Incidentes_idIncidentes`),
  INDEX `fk_Funcionario_has_Incidentes_Incidentes2_idx` (`Incidentes_idIncidentes`),
  CONSTRAINT `fk_Funcionario_has_Incidentes_Funcionario2`
    FOREIGN KEY (`Funcionario_matricula`)
    REFERENCES `Trabalho_Seguro`.`Funcionario` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Funcionario_has_Incidentes_Incidentes2`
    FOREIGN KEY (`Incidentes_idIncidentes`)
    REFERENCES `Trabalho_Seguro`.`Incidentes` (`idIncidentes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Trabalho_Seguro`.`Tem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Trabalho_Seguro`.`Tem` (
  `Incidentes_idIncidentes` INT NOT NULL,
  `Funcao_idFuncao` INT NOT NULL,
  `Funcao_Cargo_idCargo` INT NOT NULL,
  PRIMARY KEY (`Incidentes_idIncidentes`, `Funcao_idFuncao`, `Funcao_Cargo_idCargo`),
  INDEX `fk_Incidentes_has_Funcao_Funcao1_idx` (`Funcao_idFuncao`, `Funcao_Cargo_idCargo`),
  INDEX `fk_Incidentes_has_Funcao_Incidentes1_idx` (`Incidentes_idIncidentes`),
  CONSTRAINT `fk_Incidentes_has_Funcao_Incidentes1`
    FOREIGN KEY (`Incidentes_idIncidentes`)
    REFERENCES `Trabalho_Seguro`.`Incidentes` (`idIncidentes`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Incidentes_has_Funcao_Funcao1`
    FOREIGN KEY (`Funcao_idFuncao` , `Funcao_Cargo_idCargo`)
    REFERENCES `Trabalho_Seguro`.`Funcao` (`idFuncao` , `Cargo_idCargo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO funcionario values
('52345','923.892.673-56','Engenharia Química', 'Rafael','1990-01-01','Mendes','(71)','99865-9012','(71)','99324-1432','Rua dos Mistérios, 81','Canavial','Salvador','30h','2');

INSERT INTO cargo values
('1','Iniciante', 'Colaborador'),
(default, 'Sênior', 'Gestor de Equipe');

SELECT * FROM funcionario;
SELECT * FROM cargo;
 

