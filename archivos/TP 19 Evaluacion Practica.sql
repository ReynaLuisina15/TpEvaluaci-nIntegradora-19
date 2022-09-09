-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema notes_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema notes_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `notes_db` DEFAULT CHARACTER SET utf8 ;
USE `notes_db` ;

-- -----------------------------------------------------
-- Table `notes_db`.`gestiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `notes_db`.`gestiones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `estado_nota` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `notes_db`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `notes_db`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `id_gestiones` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_usuarios_gestiones_idx` (`id_gestiones` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_gestiones`
    FOREIGN KEY (`id_gestiones`)
    REFERENCES `notes_db`.`gestiones` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `notes_db`.`notas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `notes_db`.`notas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(60) NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `descripcion` TEXT NOT NULL,
  `fecha_ultima_mod` DATE NOT NULL,
  `eliminar` TINYINT NOT NULL,
  `id_usuarios` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_notas_usuarios_idx` (`id_usuarios` ASC) VISIBLE,
  CONSTRAINT `fk_notas_usuarios`
    FOREIGN KEY (`id_usuarios`)
    REFERENCES `notes_db`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `notes_db`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `notes_db`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre_categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `notes_db`.`notas_categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `notes_db`.`notas_categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_notas` INT NOT NULL,
  `id_categorias` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_notas_categorias_idx` (`id_categorias` ASC) VISIBLE,
  INDEX `fk_categorias_notas_idx` (`id_notas` ASC) VISIBLE,
  CONSTRAINT `fk_notas_categorias`
    FOREIGN KEY (`id_categorias`)
    REFERENCES `notes_db`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categorias_notas`
    FOREIGN KEY (`id_notas`)
    REFERENCES `notes_db`.`notas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
