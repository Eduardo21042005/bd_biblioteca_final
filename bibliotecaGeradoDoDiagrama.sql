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
CREATE SCHEMA `mydb8` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
USE `mydb8` ;

-- -----------------------------------------------------
-- Table `mydb`.`editora`
-- -----------------------------------------------------
CREATE TABLE `mydb8`.`editora` (
  `ideditora` INT NOT NULL,
  `nome_editora` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `endereco` VARCHAR(45) NULL,
  PRIMARY KEY (`ideditora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`autores`
-- -----------------------------------------------------
CREATE TABLE `mydb8`.`autores` (
  `idautores` INT NOT NULL,
  `nome_autor` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `endereco` VARCHAR(45) NULL,
  PRIMARY KEY (`idautores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Biblioteca`
-- -----------------------------------------------------
CREATE TABLE `mydb8`.`Biblioteca` (
  `idBiblioteca` INT NOT NULL,
  ` nome` VARCHAR(25) NULL,
  `cnpj` VARCHAR(25) NULL,
  `endereco` VARCHAR(25) NULL,
  `telefone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `editora_id` INT NOT NULL,
  `autores_id` INT NOT NULL,
  PRIMARY KEY (`idBiblioteca`, `autores_id`, `editora_id`),
  INDEX `fk_Biblioteca_editora1_idx` (`editora_id` ASC),
  INDEX `fk_Biblioteca_autores1_idx` (`autores_id` ASC),
  CONSTRAINT `fk_Biblioteca_editora1`
    FOREIGN KEY (`editora_id`)
    REFERENCES `mydb8`.`editora` (`ideditora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Biblioteca_autores1`
    FOREIGN KEY (`autores_id`)
    REFERENCES `mydb8`.`autores` (`idautores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE `mydb8`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);


-- -----------------------------------------------------
-- Table `mydb`.`livros`
-- -----------------------------------------------------
CREATE TABLE `mydb8`.`livros` (
  `idlivros` INT NOT NULL,
  `nome_livros` VARCHAR(45) NULL,
  `descricao` VARCHAR(45) NULL,
  `autores_id` INT NOT NULL,
  PRIMARY KEY (`idlivros`, `autores_id`),
  INDEX `fk_livros_autores1_idx` (`autores_id` ASC),
  CONSTRAINT `fk_livros_autores1`
    FOREIGN KEY (`autores_id`)
    REFERENCES `mydb8`.`autores` (`idautores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`registro`
-- -----------------------------------------------------
CREATE TABLE `mydb8`.`registro` (
  `idregistro` INT NOT NULL,
  `livro_id` VARCHAR(45) NULL,
  `area_conhecimento` VARCHAR(45) NULL,
  `data_fab` DATE NULL,
  `livros_id` INT NOT NULL,
  PRIMARY KEY (`idregistro`, `livros_id`),
  INDEX `fk_registro_livros1_idx` (`livros_id` ASC),
  CONSTRAINT `fk_registro_livros1`
    FOREIGN KEY (`livros_id`)
    REFERENCES `mydb8`.`livros` (`idlivros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cod_emprestimo`
-- -----------------------------------------------------
CREATE TABLE `mydb8`.`cod_emprestimo` (
  `idcod_emprestimo` INT NOT NULL,
  `livros_id` INT NOT NULL,
  `registro_id` INT NOT NULL,
  PRIMARY KEY (`idcod_emprestimo`, `livros_id`, `registro_id`),
  INDEX `fk_cod_emprestimo_livros1_idx` (`livros_id` ASC),
  INDEX `fk_cod_emprestimo_registro1_idx` (`registro_id` ASC),
  CONSTRAINT `fk_cod_emprestimo_livros1`
    FOREIGN KEY (`livros_id`)
    REFERENCES `mydb`.`livros` (`idlivros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cod_emprestimo_registro1`
    FOREIGN KEY (`registro_id`)
    REFERENCES `mydb8`.`registro` (`idregistro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE `mydb8`.`usuarios` (
  `idusuarios` INT NOT NULL,
  `tipo_usuario` ENUM('Professor', 'Aluno', 'Funcionário') NULL,
  `nome` VARCHAR(45) NULL,
  `cpf` VARCHAR(45) NULL,
  `data_nasc` DATE NULL,
  `telefone` VARCHAR(50) NULL,
  `endereco` VARCHAR(45) NULL,
  `cidade` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `cod_emprestimo` INT,
  PRIMARY KEY (`idusuarios`, `cod_emprestimo`),
  INDEX `fk_usuarios_cod_emprestimo1_idx` (`cod_emprestimo` ASC) ,
  CONSTRAINT `fk_usuarios_cod_emprestimo1`
    FOREIGN KEY (`cod_emprestimo`)
    REFERENCES `mydb`.`cod_emprestimo` (`idcod_emprestimo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cod_fornecimento`
-- -----------------------------------------------------
CREATE TABLE `mydb8`.`cod_fornecimento` (
  `idcod_fornecimento` INT NOT NULL,
  `editora_id` INT NOT NULL,
  PRIMARY KEY (`idcod_fornecimento`, `editora_id`),
  INDEX `fk_cod_fornecimento_editora_idx` (`editora_id` ASC),
  CONSTRAINT `fk_cod_fornecimento_editora`
    FOREIGN KEY (`editora_id`)
    REFERENCES `mydb8`.`editora` (`ideditora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
