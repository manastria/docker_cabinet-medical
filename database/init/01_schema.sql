CREATE DATABASE IF NOT EXISTS cabinet_medical_v1;
USE cabinet_medical_v1;

-- 1. Table Adresse (Réutilisable pour Patients et Infirmières)
CREATE TABLE Adresse (
    id_adresse INT AUTO_INCREMENT PRIMARY KEY,
    numero_voie VARCHAR(10),
    libelle_voie VARCHAR(255) NOT NULL,
    complement VARCHAR(255),
    code_postal VARCHAR(10) NOT NULL,
    ville VARCHAR(100) NOT NULL,
    pays VARCHAR(50) DEFAULT 'FRANCE'
) ENGINE=InnoDB;

-- 2. Table Infirmiere 
CREATE TABLE Infirmiere (
    id_infirmiere INT AUTO_INCREMENT PRIMARY KEY,
    matricule VARCHAR(20) UNIQUE NOT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    tel_portable CHAR(10),
    tel_domicile CHAR(10),
    id_adresse INT NOT NULL,
    CONSTRAINT fk_infirmiere_adresse 
        FOREIGN KEY (id_adresse) REFERENCES Adresse(id_adresse)
) ENGINE=InnoDB;

-- 3. Table Patient [cite: 1]
-- Note : id_infirmiere exprime la règle "Un patient est toujours visité par la même infirmière" 
CREATE TABLE Patient (
    id_patient INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    date_naissance DATE NOT NULL,
    num_ss CHAR(15) UNIQUE NOT NULL,
    id_adresse INT NOT NULL,
    id_infirmiere INT NOT NULL,
    CONSTRAINT fk_patient_adresse 
        FOREIGN KEY (id_adresse) REFERENCES Adresse(id_adresse),
    CONSTRAINT fk_patient_infirmiere 
        FOREIGN KEY (id_infirmiere) REFERENCES Infirmiere(id_infirmiere)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- JEU D'ESSAI
-- -----------------------------------------------------

-- Insertion des adresses (Certaines seront partagées)
INSERT INTO Adresse (numero_voie, libelle_voie, code_postal, ville) VALUES
('12', 'Rue des Lilas', '80000', 'Amiens'),      -- Adresse Infirmière 1
('5', 'Avenue de la Paix', '75001', 'Paris'),    -- Adresse Infirmière 2 et Patient 1 (coloc/famille)
('45 bis', 'Route de Rouen', '80000', 'Amiens'); -- Adresse Patient 2

-- Insertion des infirmières 
INSERT INTO Infirmiere (matricule, nom, prenom, tel_portable, id_adresse) VALUES
('INF-001', 'DUPONT', 'Marie', '0601020304', 1),
('INF-002', 'LECLERC', 'Julie', '0611223344', 2);

-- Insertion des patients 
INSERT INTO Patient (nom, prenom, date_naissance, num_ss, id_adresse, id_infirmiere) VALUES
('MARTIN', 'Lucas', '1985-10-12', '185108012345678', 2, 1), -- Vit à la même adresse que l'infirmière 2, visité par l'infirmière 1
('BERNARD', 'Emma', '1992-03-25', '292038098765432', 3, 1); -- Également visitée par l'infirmière 1
