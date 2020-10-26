/*
*SPDX-FileCopyrightText: Copyright 2020 | Regione Piemonte
*SPDX-License-Identifier: EUPL-1.2
*/

INSERT INTO portalerilevazioni.pr_t_profili_utenti(
            id_profilo_utente, descrizione, flg_gest_enti_compilatori, flg_gest_utenti_compilatori, 
            flg_gest_utenti_gestori, flg_gest_definizione_moduli, flg_gest_risultati, 
            flg_gest_profilo_compilatore, flg_gest_compilazione_moduli,tipo)
    VALUES (1,'super-amministratore', 'SI', 'SI','SI','SI','SI','SI','SI','gestore');

INSERT INTO portalerilevazioni.pr_t_profili_utenti(
            id_profilo_utente, descrizione, flg_gest_enti_compilatori, flg_gest_utenti_compilatori, 
            flg_gest_utenti_gestori, flg_gest_definizione_moduli, flg_gest_risultati, 
            flg_gest_profilo_compilatore, flg_gest_compilazione_moduli,tipo)
    VALUES (2,'amministratore', 'SI', 'SI','SI','SI','SI','SI','SI','gestore');

INSERT INTO portalerilevazioni.pr_t_profili_utenti(
            id_profilo_utente, descrizione, flg_gest_enti_compilatori, flg_gest_utenti_compilatori, 
            flg_gest_utenti_gestori, flg_gest_definizione_moduli, flg_gest_risultati, 
            flg_gest_profilo_compilatore, flg_gest_compilazione_moduli,tipo)
    VALUES (3,'validatore', 'SI', 'SI','SI','SI','SI','SI','SI','gestore');

INSERT INTO portalerilevazioni.pr_t_profili_utenti(
            id_profilo_utente, descrizione, flg_gest_enti_compilatori, flg_gest_utenti_compilatori, 
            flg_gest_utenti_gestori, flg_gest_definizione_moduli, flg_gest_risultati, 
            flg_gest_profilo_compilatore, flg_gest_compilazione_moduli,tipo)
    VALUES (4,'compilatore', 'SI', 'SI','SI','SI','SI','SI','SI','compilatore');

    insert into portalerilevazioni.pr_t_utenti_gestori values(1,'AAAAAA00A11C000K','Antonino','Benedetto','antonino.benedetto@csi.it"','0000','ATTIVO',1,'2014-05-12 09:36:20.261');





  INSERT INTO portalerilevazioni.pr_t_enti_gestori(
            id_ente_gestore, ragione_sociale, partita_iva, codice_fiscale, 
            mail, stato, regione, provincia, comune, data_agg)
    VALUES (1,'Regione Piemonte',null,null,'regione.piemonte@csi.it','ATTIVO','PIEMONTE','TORINO','TORINO',now());
            
  INSERT INTO portalerilevazioni.pr_r_enti_utenti_gestori(
            id_utente_gestore, id_ente_gestore)
    VALUES (1, 1);
    
-- inserimento ente/utente fittizio    
INSERT INTO portalerilevazioni.pr_t_enti_COMPILATORI values( 0,'Ente Compilatore Fittizio','00000000000','00000000000','antonino.benedetto@csi.it','ATTIVO', '','TO','Torino','2014-01-01 00:00:00', 1);
    
INSERT INTO portalerilevazioni.pr_t_utenti_compilatori(
            id_utente_compilatore, codice_fiscale, nome, cognome, mail, telefono, 
            "login", "password", stato, id_profilo_utente, data_agg, id_ente_gestore)
    VALUES (0, '0000000000000000', 'Regione','Piemonte','antonino.benedetto@csi.it', '011', 
            '****_*','****_*', 'ATTIVO', '4', now(), 1);    
