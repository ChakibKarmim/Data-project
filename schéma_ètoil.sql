CREATE TABLE Produit (
    Id_Produit NUMBER ,
    nomProduit VARCHAR(100) ,
    Catégorie VARCHAR(100) , 
    RefProduit NUMBER ,
    Déscription VARCHAR(100) ,
    PrixUnitaire VARCHAR(100) ,
    UnitéeCommandées NUMBER , 
    NiveauDeRapprovisionnement VARCHAR(100) , 
    UniteEnStock NUMBER , 
    QuantiteParUnite NUMBER , 
    CONSTRAINT PK_ID_PRODUIT PRIMARY KEY (Id_Produit)
);
    
CREATE TABLE Destinataire (
    Id_Destinataire NUMBER ,
    NomClient VARCHAR(100) , 
    Societé VARCHAR(100) ,
    Fonction VARCHAR(100) , 
    Télèphone VARCHAR(100) , 
    CONSTRAINT PK_ID_Destinataire PRIMARY KEY(Id_Destinataire)
);

CREATE TABLE Periode (
    Id_Periode NUMBER ,
    Mois VARCHAR(100) , 
    Année NUMBER ,
    CONSTRAINT PK_ID_PERIODE PRIMARY KEY(Id_Periode)
);

Create table Commerciaux (
    Id_Commerciaux number ,
    Nom varchar(50) , 
    Age number , 
    Situation varchar(50) , 
    Salaire varchar(50) , 
    CONSTRAINT PK_ID_Commerciaux PRIMARY KEY(Id_Commerciaux)
);

Create table Localisation (
    Id_Localisation number ,
    Adresse VARCHAR(100) , 
    Ville VARCHAR(100) ,
    Region VARCHAR(100) , 
    CodePostal number ,
    Pays VARCHAR(100) , 
    ZoneGeographique VARCHAR(100) , 
    CONSTRAINT PK_ID_Localisation PRIMARY KEY(Id_Localisation)
);

create table Vente (
    Id_Periode number ,
    Id_Commerciaux number ,
    Id_Localisation number , 
    Id_Produit number , 
    Id_Destinataire number , 
    id_vente number , 
    Quantite number , 
    Remise number , 
    Deadline Date , 
    DateEnvoi Date , 
    CONSTRAINT PK_ID_VENTE PRIMARY KEY(id_vente) ,
    CONSTRAINT FK_VENTE_Periode      FOREIGN KEY (Id_Periode)      REFERENCES Periode (Id_Periode) ,
    CONSTRAINT FK_VENTE_Commerciaux  FOREIGN KEY (Id_Commerciaux)  REFERENCES Commerciaux (Id_Commerciaux) ,
    CONSTRAINT FK_VENTE_Localisation FOREIGN KEY (Id_Localisation) REFERENCES Localisation (Id_Localisation) ,
    CONSTRAINT FK_VENTE_PRODUIT      FOREIGN KEY (Id_Produit)      REFERENCES Produit (Id_Produit) ,
    CONSTRAINT FK_VENTE_Destinataire FOREIGN KEY (Id_Destinataire) REFERENCES Destinataire (Id_Destinataire) 
);


create sequence seq_produit;
CREATE TRIGGER TRIG_SEQ_Produit
BEFORE INSERT ON Produit FOR EACH ROW
BEGIN
SELECT SEQ_Produit.NEXTVAL INTO :NEW.Id_Produit FROM DUAL;
END;

create sequence seq_destinataire ;
CREATE TRIGGER TRIG_SEQ_Destinataire
BEFORE INSERT ON Destinataire FOR EACH ROW
BEGIN
SELECT SEQ_DESTINATAIRE.nextval INTO :NEW.Id_Destinataire FROM DUAL;
END;

create sequence seq_periode ; 
CREATE TRIGGER TRIG_SEQ_Periode
BEFORE INSERT ON Periode FOR EACH ROW
BEGIN
SELECT SEQ_Periode.NEXTVAL INTO :NEW.Id_Periode FROM DUAL;
END;

create sequence seq_commerciaux;
CREATE TRIGGER TRIG_SEQ_Commerciaux
BEFORE INSERT ON Commerciaux FOR EACH ROW
BEGIN
SELECT SEQ_Commerciaux.NEXTVAL INTO :NEW.Id_Commerciaux FROM DUAL;
END;

create sequence seq_localisation;
CREATE TRIGGER TRIG_SEQ_Localisation
BEFORE INSERT ON Localisation FOR EACH ROW
BEGIN
SELECT SEQ_Localisation.NEXTVAL INTO :NEW.Id_Localisation FROM DUAL;
END;

create sequence seq_vente;
CREATE TRIGGER TRIG_SEQ_Vente
BEFORE INSERT ON Vente FOR EACH ROW
BEGIN
SELECT SEQ_Vente.NEXTVAL INTO :NEW.Id_Vente FROM DUAL;
END;




