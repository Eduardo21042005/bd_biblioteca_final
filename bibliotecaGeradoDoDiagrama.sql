-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblioteca` ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`editora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`editora` (
  `ideditora` INT NOT NULL,
  `nome_editora` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `endereco` VARCHAR(45) NULL,
  PRIMARY KEY (`ideditora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`autores` (
  `idautores` INT NOT NULL,
  `nome_autor` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `endereco` VARCHAR(45) NULL,
  PRIMARY KEY (`idautores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Biblioteca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Biblioteca` (
  `idBiblioteca` INT NOT NULL,
  ` nome` VARCHAR(25) NULL,
  `cnpj` VARCHAR(25) NULL,
  `endereco` VARCHAR(25) NULL,
  `telefone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `editora_id` INT NOT NULL,
  `autores_id` INT NOT NULL,
  PRIMARY KEY (`idBiblioteca`, `autores_id`, `editora_id`),
  INDEX `fk_Biblioteca_editora1_idx` (`editora_id` ASC) VISIBLE,
  INDEX `fk_Biblioteca_autores1_idx` (`autores_id` ASC) VISIBLE,
  CONSTRAINT `fk_Biblioteca_editora1`
    FOREIGN KEY (`editora_id`)
    REFERENCES `mydb`.`editora` (`ideditora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Biblioteca_autores1`
    FOREIGN KEY (`autores_id`)
    REFERENCES `mydb`.`autores` (`idautores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);


-- -----------------------------------------------------
-- Table `mydb`.`livros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`livros` (
  `idlivros` INT NOT NULL,
  `nome_livros` VARCHAR(45) NULL,
  `descricao` VARCHAR(45) NULL,
  `autores_id` INT NOT NULL,
  PRIMARY KEY (`idlivros`, `autores_id`),
  INDEX `fk_livros_autores1_idx` (`autores_id` ASC),
  CONSTRAINT `fk_livros_autores1`
    FOREIGN KEY (`autores_id`)
    REFERENCES `mydb`.`autores` (`idautores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`registro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`registro` (
  `idregistro` INT NOT NULL,
  `livro_id` VARCHAR(45) NULL,
  `area_conhecimento` VARCHAR(45) NULL,
  `data_fab` DATE NULL,
  `livros_id` INT NOT NULL,
  PRIMARY KEY (`idregistro`, `livros_id`),
  INDEX `fk_registro_livros1_idx` (`livros_id` ASC),
  CONSTRAINT `fk_registro_livros1`
    FOREIGN KEY (`livros_id`)
    REFERENCES `mydb`.`livros` (`idlivros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cod_emprestimo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cod_emprestimo` (
  `idcod_emprestimo` INT NOT NULL,
  `livros_id` INT NOT NULL,
  `registro_id` INT NOT NULL,
  PRIMARY KEY (`idcod_emprestimo`, `livros_id`, `registro_id`),
  INDEX `fk_cod_emprestimo_livros1_idx` (`livros_id` ASC),
  INDEX `fk_cod_emprestimo_registro1_idx` (`registro_id` ASC) VISIBLE,
  CONSTRAINT `fk_cod_emprestimo_livros1`
    FOREIGN KEY (`livros_id`)
    REFERENCES `mydb`.`livros` (`idlivros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cod_emprestimo_registro1`
    FOREIGN KEY (`registro_id`)
    REFERENCES `mydb`.`registro` (`idregistro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios` (
  `idusuarios` INT NOT NULL,
  `tipo_usuario` ENUM('Professor', 'Aluno', 'Funcionário') NULL,
  `nome` VARCHAR(45) NULL,
  `cpf` VARCHAR(45) NULL,
  `data_nasc` DATE NULL,
  `telefone` VARCHAR(50) NULL,
  `endereco` VARCHAR(45) NULL,
  `cidade` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `cod_emprestimo` INT GENERATED ALWAYS AS () VIRTUAL,
  PRIMARY KEY (`idusuarios`, `cod_emprestimo`),
  INDEX `fk_usuarios_cod_emprestimo1_idx` (`cod_emprestimo` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_cod_emprestimo1`
    FOREIGN KEY (`cod_emprestimo`)
    REFERENCES `mydb`.`cod_emprestimo` (`idcod_emprestimo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cod_fornecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cod_fornecimento` (
  `idcod_fornecimento` INT NOT NULL,
  `editora_id` INT NOT NULL,
  PRIMARY KEY (`idcod_fornecimento`, `editora_id`),
  INDEX `fk_cod_fornecimento_editora_idx` (`editora_id` ASC),
  CONSTRAINT `fk_cod_fornecimento_editora`
    FOREIGN KEY (`editora_id`)
    REFERENCES `mydb`.`editora` (`ideditora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `biblioteca` ;

-- -----------------------------------------------------
-- Table `biblioteca`.`biblioteca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`biblioteca` (
  `id_biblioteca` INT NULL DEFAULT NULL AUTO_INCREMENT,
  `nome` VARCHAR(25) NULL DEFAULT NULL,
  `cnpj` VARCHAR(25) NULL DEFAULT NULL,
  `endereco` VARCHAR(25) NULL DEFAULT NULL,
  `telefone` VARCHAR(25) NULL DEFAULT NULL,
  `email` VARCHAR(25) NULL DEFAULT NULL,
  `estado` VARCHAR(2) NULL DEFAULT NULL,
  `autor_id` INT NULL DEFAULT NULL,
  `editora_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_biblioteca`))
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteca`.`autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`autores` (
  `id_autor` INT NULL DEFAULT NULL AUTO_INCREMENT,
  `nome_autor` VARCHAR(25) NULL DEFAULT NULL,
  `telefone` VARCHAR(25) NULL DEFAULT NULL,
  `endereco` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`id_autor`))
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteca`.`editora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`editora` (
  `id_editora` INT NULL DEFAULT NULL AUTO_INCREMENT,
  `nome_editora` VARCHAR(25) NULL DEFAULT NULL,
  `telefone` VARCHAR(25) NULL DEFAULT NULL,
  `endereco` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`id_editora`))
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteca`.`livros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`livros` (
  `id_livro` INT NULL DEFAULT NULL AUTO_INCREMENT,
  `nome_livro` VARCHAR(25) NULL DEFAULT NULL,
  `descricao` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`id_livro`))
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteca`.`registro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`registro` (
  `id_registro` INT NULL DEFAULT NULL AUTO_INCREMENT,
  `livro_id` INT NULL DEFAULT NULL,
  `area_conhecimento` VARCHAR(60) NULL DEFAULT NULL,
  `data_fab` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_registro`))
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteca`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`usuarios` (
  `id_usuario` INT NULL DEFAULT NULL AUTO_INCREMENT,
  `tipo_usuario` ENUM('Professor', 'Aluno', 'Funcionário') NULL DEFAULT NULL,
  `nome` VARCHAR(50) NULL DEFAULT NULL,
  `cpf` VARCHAR(11) NULL DEFAULT NULL,
  `data_nasc` DATE NULL DEFAULT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  `endereco` VARCHAR(50) NULL DEFAULT NULL,
  `cidade` VARCHAR(30) NULL DEFAULT NULL,
  `estado` VARCHAR(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`))
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteca`.`cod_fornecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`cod_fornecimento` (
  `id_cod_fornecimento` INT NULL DEFAULT NULL AUTO_INCREMENT,
  `editora_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_cod_fornecimento`))
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `biblioteca`.`cod_emprestimo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`cod_emprestimo` (
  `id_cod_emprestimo` INT NULL DEFAULT NULL AUTO_INCREMENT,
  `registro_id` INT NULL DEFAULT NULL,
  `livro_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_cod_emprestimo`))
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
