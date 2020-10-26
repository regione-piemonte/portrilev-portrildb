/*
*SPDX-FileCopyrightText: Copyright 2020 | Regione Piemonte
*SPDX-License-Identifier: EUPL-1.2
*/
--
-- PostgreSQL database dump
--

-- Dumped from database version 9.0.4
-- Dumped by pg_dump version 9.0.3
-- Started on 2012-09-04 17:00:41

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;



CREATE SEQUENCE portalerilevazioni.pr_t_colonne_modulo_id_colonna_modulo_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 178
  CACHE 1;
  
CREATE SEQUENCE portalerilevazioni.pr_t_enti_compilatori_id_ente_compilatore_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 19
  CACHE 1;

CREATE SEQUENCE portalerilevazioni.pr_t_moduli_id_modulo_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 72
  CACHE 1;
  
  CREATE SEQUENCE portalerilevazioni.pr_t_modulo_mail_inviti_id_modulo_mail_invito_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
  
  CREATE SEQUENCE portalerilevazioni.pr_t_righe_id_riga_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1074
  CACHE 1;
  
  CREATE SEQUENCE portalerilevazioni.pr_t_utenti_compilatori_id_utente_compilatore_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 51
  CACHE 1;
  
  CREATE SEQUENCE portalerilevazioni.pr_t_utenti_gestori_id_utente_gestore_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 12
  CACHE 1;



CREATE TABLE portalerilevazioni.pr_t_enti_compilatori(
  id_ente_compilatore numeric(10,0) NOT NULL DEFAULT nextval('portalerilevazioni.pr_t_enti_compilatori_id_ente_compilatore_seq'::regclass),
  ragione_sociale character varying(500) NOT NULL,
  partita_iva character varying(11) NOT NULL,
  codice_fiscale character varying(16) NOT NULL,
  mail character varying(50) NOT NULL,
  stato character varying(50) NOT NULL DEFAULT 'ATTIVO'::character varying,
  classificazione character varying(50),
  provincia character varying(50),
  comune character varying(50) NOT NULL,
  data_agg timestamp without time zone NOT NULL DEFAULT now(),
  id_ente_gestore numeric(10,0) NOT NULL,
  CONSTRAINT pk_ente_compilatore PRIMARY KEY (id_ente_compilatore),
  CONSTRAINT "UK_ENTI_COMPILATORI_CODICE_FISCALE" UNIQUE (codice_fiscale)
);



CREATE TABLE portalerilevazioni.pr_t_profili_utenti
(
  id_profilo_utente numeric(10,0) NOT NULL,
  descrizione character varying(500) NOT NULL,
  flg_gest_enti_compilatori character varying(2) NOT NULL,
  flg_gest_utenti_compilatori character varying(2) NOT NULL,
  flg_gest_utenti_gestori character varying NOT NULL,
  flg_gest_definizione_moduli character varying(2) NOT NULL,
  flg_gest_risultati character varying(2) NOT NULL,
  flg_gest_profilo_compilatore character varying(2) NOT NULL,
  flg_gest_compilazione_moduli character varying(2) NOT NULL,
  tipo character varying(20) NOT NULL,
  CONSTRAINT pk_profilo_utente PRIMARY KEY (id_profilo_utente)
);


CREATE TABLE portalerilevazioni.pr_t_utenti_gestori
(
  id_utente_gestore numeric(10,0) NOT NULL DEFAULT nextval('portalerilevazioni.pr_t_utenti_gestori_id_utente_gestore_seq'::regclass),
  codice_fiscale character varying(16) NOT NULL,
  nome character varying(50) NOT NULL,
  cognome character varying(50) NOT NULL,
  mail character varying(50) NOT NULL,
  telefono character varying(50),
  stato character varying(50) NOT NULL DEFAULT 'ATTIVO'::character varying,
  id_profilo_utente integer NOT NULL,
  data_agg timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT pk_utente_gestore PRIMARY KEY (id_utente_gestore),
  CONSTRAINT pr_t_profili_utenti_pr_t_utenti_gestori_fk FOREIGN KEY (id_profilo_utente)
      REFERENCES portalerilevazioni.pr_t_profili_utenti (id_profilo_utente) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "UK_UTENTI_GESTORI_CODICE_FISCALE" UNIQUE (codice_fiscale)
);


CREATE TABLE portalerilevazioni.pr_t_utenti_compilatori
(
  id_utente_compilatore numeric(10,0) NOT NULL DEFAULT nextval('portalerilevazioni.pr_t_utenti_compilatori_id_utente_compilatore_seq'::regclass),
  codice_fiscale character varying(16) NOT NULL,
  nome character varying(50) NOT NULL,
  cognome character varying(50) NOT NULL,
  mail character varying(50) NOT NULL,
  telefono character varying(50) ,
  login character varying(50) NOT NULL,
  password character varying(50) NOT NULL,
  stato character varying(50) NOT NULL DEFAULT 'ATTIVO'::character varying,
  id_profilo_utente numeric(10,0) NOT NULL,
  data_agg timestamp without time zone NOT NULL DEFAULT now(),
  id_ente_gestore numeric(10,0) NOT NULL,
  CONSTRAINT pk_utente_compilatore PRIMARY KEY (id_utente_compilatore),
  CONSTRAINT pr_t_profili_utenti_pr_t_utenti_compilatori_fk FOREIGN KEY (id_profilo_utente)
      REFERENCES portalerilevazioni.pr_t_profili_utenti (id_profilo_utente) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "UK_UTENTI_COMPILATORI_CODICE_FISCALE" UNIQUE (codice_fiscale),
  CONSTRAINT "UK_UTENTI_COMPILATORI_LOGIN" UNIQUE (login),
  CONSTRAINT "UK_UTENTI_COMPILATORI_PW" UNIQUE (password)
);


CREATE TABLE portalerilevazioni.pr_r_enti_utenti_compilatori
(
  id_ente_compilatore numeric(10,0) NOT NULL,
  id_utente_compilatore numeric(10,0) NOT NULL,
  CONSTRAINT pk_ente_utente_compilatore PRIMARY KEY (id_ente_compilatore, id_utente_compilatore),
  CONSTRAINT pr_t_enti_compilatori_pr_r_enti_utenti_compilatori_fk FOREIGN KEY (id_ente_compilatore)
      REFERENCES portalerilevazioni.pr_t_enti_compilatori (id_ente_compilatore) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pr_t_utenti_compilatori_pr_r_enti_utenti_compilatori_fk FOREIGN KEY (id_utente_compilatore)
      REFERENCES portalerilevazioni.pr_t_utenti_compilatori (id_utente_compilatore) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE portalerilevazioni.pr_t_righe
(
  id_riga numeric(10,0) NOT NULL DEFAULT nextval('portalerilevazioni.pr_t_righe_id_riga_seq'::regclass),
  id_ente_compilatore numeric(10,0) NOT NULL,
  id_utente_compilatore numeric(10,0) NOT NULL,
  data_modifica_compilatore date NOT NULL,
  id_utente_gestore numeric(10,0),
  data_validazione_gestore date,
  flg_validazione character varying(2) NOT NULL,
  id_modulo numeric(10,0) NOT NULL,
  posizione numeric(10,0) NOT NULL,
  tipo character varying(50) NOT NULL,
  CONSTRAINT pk_riga PRIMARY KEY (id_riga),
  CONSTRAINT pr_t_enti_compilatori_pr_t_righe_fk FOREIGN KEY (id_ente_compilatore)
      REFERENCES portalerilevazioni.pr_t_enti_compilatori (id_ente_compilatore) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE portalerilevazioni.pr_t_enti_gestori
(
  id_ente_gestore numeric(10,0) NOT NULL,
  ragione_sociale character varying(500) NOT NULL,
  partita_iva character varying(11),
  codice_fiscale character varying(16),
  mail character varying(50),
  stato character varying(50) NOT NULL DEFAULT 'ATTIVO'::character varying,
  regione character varying(50),
  provincia character varying(50),
  comune character varying(50) NOT NULL,
  data_agg timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT pk_ente_gestore PRIMARY KEY (id_ente_gestore),
  CONSTRAINT "UK_ENTI_GESTORI_CODICE_FISCALE" UNIQUE (codice_fiscale)
);


CREATE TABLE portalerilevazioni.pr_t_moduli
(
  id_modulo numeric(10,0) NOT NULL DEFAULT nextval('portalerilevazioni.pr_t_moduli_id_modulo_seq'::regclass),
  nome character varying(50) NOT NULL,
  descrizione character varying(255) NOT NULL,
  data_inizio_compilazione date,
  data_fine_compilazione date,
  note character varying(4000),
  istruzioni_compilazione character varying(4000),
  id_utente_gestore numeric(10,0) NOT NULL,
  data_ultima_modifica character varying NOT NULL,
  id_ente_gestore numeric(10,0) NOT NULL,
  tipo character varying(50) NOT NULL,
  CONSTRAINT pk_modulo PRIMARY KEY (id_modulo),
  CONSTRAINT pr_t_enti_gestori_moduli_fk FOREIGN KEY (id_ente_gestore)
      REFERENCES portalerilevazioni.pr_t_enti_gestori (id_ente_gestore) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);



CREATE TABLE pr_t_modulo_mail_inviti
(
  id_modulo_mail_invito numeric(10,0) NOT NULL DEFAULT nextval('portalerilevazioni.pr_t_modulo_mail_inviti_id_modulo_mail_invito_seq'::regclass),
  id_utente_gestore numeric(10,0) ,
  id_modulo numeric(10,0) ,
  mailMittente character varying(255) NOT NULL,
  mailDestinatario character varying(255) NOT NULL,
  mailCC character varying(255) ,
  oggetto character varying(255) ,
  testo character varying(10000) ,
  data_invio date ,
  id_ente_compilatore numeric(10,0) ,
  id_utente_compilatore numeric(10,0),
  CONSTRAINT pk_t_modulo_mail_inviti PRIMARY KEY (id_modulo_mail_invito)
);


CREATE TABLE portalerilevazioni.pr_t_colonne_modulo
(
  id_colonna_modulo numeric(10,0) NOT NULL DEFAULT nextval('portalerilevazioni.pr_t_colonne_modulo_id_colonna_modulo_seq'::regclass),
  id_modulo numeric(10,0) NOT NULL,
  label_colonna character varying(50) NOT NULL,
  flag_obbligatorieta character varying(2) NOT NULL,
  posizione numeric(10,0) NOT NULL,
  editabilita_profilo character varying(20) NOT NULL, -- identifica il profilo abilitato all'editabilità della colonna in esame...
  tipo character varying(50) NOT NULL, -- es Striga o numero etc
  operatore_numerico character varying(50) , -- valore di confonto utile solo se in presenza di tipo numerico...
  valore_confronto_operatore_numerico numeric(10,0) , -- valore di confonto utile solo se in presenza di tipo numerico...
  dimensione numeric(10,0) NOT NULL, -- maxlen solo se in presenza di tipo stringa
  flg_ctrl_contabilita character varying(2) NOT NULL DEFAULT 'NO'::character varying,
  flg_ctrl_bloccante character varying(2) NOT NULL DEFAULT 'NO'::character varying,
  modificabile character varying(2) NOT NULL DEFAULT 'SI'::character varying,
  CONSTRAINT pk_colonne_modulo PRIMARY KEY (id_colonna_modulo),
  CONSTRAINT pr_t_moduli_pr_t_strutture_modulo_fk FOREIGN KEY (id_modulo)
      REFERENCES portalerilevazioni.pr_t_moduli (id_modulo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

COMMENT ON COLUMN portalerilevazioni.pr_t_colonne_modulo.editabilita_profilo IS 'profilo abilitato per editabilit della colonna in esame es GESTORE /COMPILATORE';
COMMENT ON COLUMN portalerilevazioni.pr_t_colonne_modulo.tipo IS 'es Striga o numero etc';
COMMENT ON COLUMN portalerilevazioni.pr_t_colonne_modulo.operatore_numerico IS 'valore di confonto utile solo se in presenza di tipo numerico ';
COMMENT ON COLUMN portalerilevazioni.pr_t_colonne_modulo.valore_confronto_operatore_numerico IS 'valore di confonto utile solo se in presenza di tipo numerico esempio 50';
COMMENT ON COLUMN portalerilevazioni.pr_t_colonne_modulo.dimensione IS 'maxlen solo se in presenza di tipo stringa';



CREATE TABLE portalerilevazioni.pr_t_cella
(
  id_riga numeric(10,0) NOT NULL,
  id_colonna_modulo numeric(10,0) NOT NULL,
  valore character varying(255),
  posizione_riga numeric(10,0) NOT NULL,
  posizione_colonna numeric(10,0) NOT NULL,
  editabilita_profilo character varying(20) NOT NULL,
  CONSTRAINT pk_cella PRIMARY KEY (id_riga, id_colonna_modulo),
  CONSTRAINT pr_t_colonne_modulo_pr_t_cella_fk FOREIGN KEY (id_colonna_modulo)
      REFERENCES portalerilevazioni.pr_t_colonne_modulo (id_colonna_modulo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pr_t_righe_pr_t_cella_fk FOREIGN KEY (id_riga)
      REFERENCES portalerilevazioni.pr_t_righe (id_riga) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE portalerilevazioni.pr_r_utenti_moduli_compilatori
(
  id_modulo numeric(10,0) NOT NULL,
  id_utente_compilatore numeric(10,0) NOT NULL,
  data_inserimento date NOT NULL,
  data_modifica date,
  CONSTRAINT pk_utente_modulo_compilatore PRIMARY KEY (id_modulo, id_utente_compilatore),
  CONSTRAINT pr_t_moduli_pr_r_utenti_moduli_compilatori_fk FOREIGN KEY (id_modulo)
      REFERENCES portalerilevazioni.pr_t_moduli (id_modulo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pr_t_utenti_compilatori_pr_r_utenti_moduli_compilatori_fk FOREIGN KEY (id_utente_compilatore)
      REFERENCES portalerilevazioni.pr_t_utenti_compilatori (id_utente_compilatore) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE portalerilevazioni.pr_r_enti_utenti_gestori
(
  id_utente_gestore numeric(10,0) NOT NULL,
  id_ente_gestore numeric(10,0) NOT NULL,
  CONSTRAINT pk_ente_utente_gestore PRIMARY KEY (id_utente_gestore, id_ente_gestore),
  CONSTRAINT pr_t_enti_gestori_pr_r_enti_utenti_gestori_fk FOREIGN KEY (id_ente_gestore)
      REFERENCES portalerilevazioni.pr_t_enti_gestori (id_ente_gestore) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pr_t_utenti_gestori_pr_r_enti_utenti_gestori_fk FOREIGN KEY (id_utente_gestore)
      REFERENCES portalerilevazioni.pr_t_utenti_gestori (id_utente_gestore) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE portalerilevazioni.pr_r_moduli_enti_compilatori
(
  id_ente_compilatore numeric(10,0) NOT NULL,
  id_modulo numeric(10,0) NOT NULL,
  CONSTRAINT pk_modulo_ente_compilatore PRIMARY KEY (id_ente_compilatore, id_modulo),
  CONSTRAINT pr_t_enti_compilatori_pr_r_moduli_enti_compilatori_fk FOREIGN KEY (id_ente_compilatore)
      REFERENCES portalerilevazioni.pr_t_enti_compilatori (id_ente_compilatore) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT pr_t_moduli_pr_r_moduli_enti_compilatori_fk FOREIGN KEY (id_modulo)
      REFERENCES portalerilevazioni.pr_t_moduli (id_modulo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE CSI_LOG_AUDIT
  (
    DATA_ORA   DATE NOT NULL ,
    ID_APP     character varying(100) NOT NULL,
    IP_ADDRESS character varying(40),
    UTENTE     character varying(100) NOT NULL,
    OPERAZIONE character varying(50) NOT NULL,
    OGG_OPER   character varying(1500) NOT NULL,
    KEY_OPER   character varying(500) NOT NULL
  );
  
/*
ALTER TABLE portalerilevazioni.pr_r_enti_utenti_compilatori ADD CONSTRAINT pr_t_enti_compilatori_pr_r_enti_utenti_compilatori_fk
FOREIGN KEY (id_ente_compilatore)
REFERENCES portalerilevazioni.pr_t_enti_compilatori (id_ente_compilatore)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_r_moduli_enti_compilatori ADD CONSTRAINT pr_t_enti_compilatori_pr_r_moduli_enti_compilatori_fk
FOREIGN KEY (id_ente_compilatore)
REFERENCES portalerilevazioni.pr_t_enti_compilatori (id_ente_compilatore)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_t_righe ADD CONSTRAINT pr_t_enti_compilatori_pr_t_righe_fk
FOREIGN KEY (id_ente_compilatore)
REFERENCES portalerilevazioni.pr_t_enti_compilatori (id_ente_compilatore)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_t_utenti_compilatori ADD CONSTRAINT pr_t_profili_utenti_pr_t_utenti_compilatori_fk
FOREIGN KEY (id_profilo_utente)
REFERENCES portalerilevazioni.pr_t_profili_utenti (id_profilo_utente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_t_utenti_gestori ADD CONSTRAINT pr_t_profili_utenti_pr_t_utenti_gestori_fk
FOREIGN KEY (id_profilo_utente)
REFERENCES portalerilevazioni.pr_t_profili_utenti (id_profilo_utente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_r_enti_utenti_gestori ADD CONSTRAINT pr_t_utenti_gestori_pr_r_enti_utenti_gestori_fk
FOREIGN KEY (id_utente_gestore)
REFERENCES portalerilevazioni.pr_t_utenti_gestori (id_utente_gestore)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_r_enti_utenti_compilatori ADD CONSTRAINT pr_t_utenti_compilatori_pr_r_enti_utenti_compilatori_fk
FOREIGN KEY (id_utente_compilatore)
REFERENCES portalerilevazioni.pr_t_utenti_compilatori (id_utente_compilatore)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_r_utenti_moduli_compilatori ADD CONSTRAINT pr_t_utenti_compilatori_pr_r_utenti_moduli_compilatori_fk
FOREIGN KEY (id_utente_compilatore)
REFERENCES portalerilevazioni.pr_t_utenti_compilatori (id_utente_compilatore)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_t_cella ADD CONSTRAINT pr_t_righe_pr_t_cella_fk
FOREIGN KEY (id_riga)
REFERENCES portalerilevazioni.pr_t_righe (id_riga)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_r_enti_utenti_gestori ADD CONSTRAINT pr_t_enti_gestori_pr_r_enti_utenti_gestori_fk
FOREIGN KEY (id_ente_gestore)
REFERENCES portalerilevazioni.pr_t_enti_gestori (id_ente_gestore)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_t_moduli ADD CONSTRAINT pr_t_enti_gestori_moduli_fk
FOREIGN KEY (id_ente_gestore)
REFERENCES portalerilevazioni.pr_t_enti_gestori (id_ente_gestore)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_r_moduli_enti_compilatori ADD CONSTRAINT pr_t_moduli_pr_r_moduli_enti_compilatori_fk
FOREIGN KEY (id_modulo)
REFERENCES portalerilevazioni.pr_t_moduli (id_modulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_r_utenti_moduli_compilatori ADD CONSTRAINT pr_t_moduli_pr_r_utenti_moduli_compilatori_fk
FOREIGN KEY (id_modulo)
REFERENCES portalerilevazioni.pr_t_moduli (id_modulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_t_colonne_modulo ADD CONSTRAINT pr_t_moduli_pr_t_strutture_modulo_fk
FOREIGN KEY (id_modulo)
REFERENCES portalerilevazioni.pr_t_moduli (id_modulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_t_modulo_mail_inviti ADD CONSTRAINT pr_t_moduli_pr_t_modulo_mail_inviti_fk
FOREIGN KEY (id_modulo)
REFERENCES portalerilevazioni.pr_t_moduli (id_modulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE portalerilevazioni.pr_t_cella ADD CONSTRAINT pr_t_colonne_modulo_pr_t_cella_fk
FOREIGN KEY (id_colonna_modulo)
REFERENCES portalerilevazioni.pr_t_colonne_modulo (id_colonna_modulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
*/