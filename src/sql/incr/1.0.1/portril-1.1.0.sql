/*
*SPDX-FileCopyrightText: Copyright 2020 | Regione Piemonte
*SPDX-License-Identifier: EUPL-1.2
*/
alter table pr_t_colonne_modulo add column dimensione_min numeric(10,0)               NOT NULL default 0;
alter table pr_t_colonne_modulo add column valore_fisso   varchar(50);
alter table pr_t_righe          add column data_agg       timestamp without time zone NOT NULL DEFAULT now();
alter table pr_t_modulo_mail_inviti add column id_ente_gestore numeric(10,0);
alter table pr_t_moduli add column obblig_conferma varchar(2) DEFAULT 'NO' ;
alter table pr_t_moduli add column caricamento_da_file varchar(2) NOT NULL DEFAULT 'NO' ;
alter table pr_t_moduli add column codice_gruppo varchar(50) ;



CREATE TABLE portalerilevazioni.pr_t_conferme_moduli
(
  id_conferme_moduli SERIAL,	
  id_ente_compilatore numeric(10,0) NOT NULL,
  id_modulo numeric(10,0) NOT NULL,
  modulo_confermato varchar(2) DEFAULT 'NO' ,
  modulo_validato varchar(2) DEFAULT 'NO' ,
	
  CONSTRAINT pk_conferme_moduli PRIMARY KEY (id_conferme_moduli),
  
	CONSTRAINT pr_t_enti_compilatori_pr_r_moduli_enti_compilatori_fk FOREIGN KEY (id_ente_compilatore)
      REFERENCES portalerilevazioni.pr_t_enti_compilatori (id_ente_compilatore) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  
	CONSTRAINT pr_t_moduli_pr_r_moduli_enti_compilatori_fk FOREIGN KEY (id_modulo)
      REFERENCES portalerilevazioni.pr_t_moduli (id_modulo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);



update pr_t_righe set data_agg = data_modifica_compilatore;
--update pr_r_moduli_enti_compilatori set modulo_confermato = 'NO';
update pr_t_moduli set obblig_conferma = 'NO';

insert into pr_t_conferme_moduli (id_ente_compilatore,id_modulo)
select id_ente_compilatore,id_modulo from pr_r_moduli_enti_compilatori;

----Multiente
CREATE TABLE portalerilevazioni.pr_r_enti_compilatori_gestori
(
  id_ente_compilatori_gestori SERIAL,	
  id_ente_compilatore numeric(10,0) NOT NULL,
  id_ente_gestore numeric(10,0) NOT NULL,
	
  CONSTRAINT pk_id_ente_compilatori_gestori PRIMARY KEY (id_ente_compilatori_gestori),
  
	CONSTRAINT pr_t_enti_compilatori_pr_r_enti_compilatori_gestori_fk FOREIGN KEY (id_ente_compilatore)
      REFERENCES portalerilevazioni.pr_t_enti_compilatori (id_ente_compilatore) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  
	CONSTRAINT pr_t_enti_gestori_pr_r_enti_compilatori_gestori_fk FOREIGN KEY (id_ente_gestore)
      REFERENCES portalerilevazioni.pr_t_enti_gestori (id_ente_gestore) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


delete from pr_r_enti_compilatori_gestori 



insert into pr_r_enti_compilatori_gestori (id_ente_compilatore ,  id_ente_gestore)
select 
distinct (pr_t_enti_compilatori.id_ente_compilatore)
,6
from 
 pr_t_enti_compilatori
where 
pr_t_enti_compilatori.id_ente_gestore = 6;



insert into pr_r_enti_compilatori_gestori (id_ente_compilatore ,  id_ente_gestore)
select 
distinct pr_t_enti_compilatori.id_ente_compilatore
,7
from 
 pr_t_enti_compilatori
,pr_r_moduli_enti_compilatori
,pr_t_moduli
where 
pr_t_enti_compilatori.id_ente_compilatore =  pr_r_moduli_enti_compilatori.id_ente_compilatore
and pr_r_moduli_enti_compilatori.id_modulo =  pr_t_moduli.id_modulo
and pr_t_moduli.id_ente_gestore = 7;


insert into pr_r_enti_compilatori_gestori (id_ente_compilatore ,  id_ente_gestore)
select 
distinct pr_t_enti_compilatori.id_ente_compilatore
,7
from 
 pr_t_enti_compilatori
where 
pr_t_enti_compilatori.id_ente_gestore = 7;


update pr_t_utenti_compilatori set id_ente_gestore = 6,data_agg=now() where id_ente_gestore = 2;

update pr_t_enti_gestori  set stato='DISATTIVO' where id_ente_gestore in(1,2,4);


alter table pr_t_enti_compilatori DROP column id_ente_gestore;
alter table pr_t_utenti_compilatori DROP column id_ente_gestore;


select 
distinct
	pr_t_moduli.id_modulo
	,pr_t_moduli.nome 
	,pr_t_moduli.descrizione 
	,pr_t_moduli.data_inizio_compilazione 
	,pr_t_moduli.data_fine_compilazione 
	,pr_t_moduli.tipo 
	,pr_t_moduli.obblig_conferma 
	,pr_t_utenti_compilatori.codice_fiscale 
	,pr_t_utenti_compilatori.nome 
	,pr_t_utenti_compilatori.cognome 
	,pr_t_utenti_compilatori.mail 
	,pr_t_utenti_compilatori.telefono  
	,pr_t_utenti_compilatori.stato
    ,pr_t_conferme_moduli.modulo_confermato
	,pr_t_conferme_moduli.modulo_validato
from
	 pr_t_moduli
	,pr_t_conferme_moduli 
	,pr_r_moduli_enti_compilatori
	,pr_t_enti_compilatori
	,pr_r_enti_utenti_compilatori
	,pr_t_utenti_compilatori
where 
     pr_t_moduli.id_modulo =  pr_r_moduli_enti_compilatori.id_modulo
 AND pr_r_moduli_enti_compilatori.id_ente_compilatore =  pr_t_enti_compilatori.id_ente_compilatore
 AND pr_t_enti_compilatori.id_ente_compilatore =  pr_r_enti_utenti_compilatori.id_ente_compilatore
 AND pr_r_enti_utenti_compilatori.id_utente_compilatore =  pr_t_utenti_compilatori.id_utente_compilatore
 AND pr_t_moduli.id_modulo =  pr_t_conferme_moduli.id_modulo;



/*
ALTER TABLE pr_t_enti_compilatori ADD COLUMN istat  varchar(15);
ALTER TABLE pr_t_moduli ADD COLUMN file  BYTEA;
ALTER TABLE pr_t_moduli ADD COLUMN contentType  varchar(50);
ALTER TABLE pr_t_moduli ADD COLUMN fileName  varchar(50);
*/
 
 
 
 Xj8QurWf5T