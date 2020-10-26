/*
*SPDX-FileCopyrightText: Copyright 2020 | Regione Piemonte
*SPDX-License-Identifier: EUPL-1.2
*/
ALTER TABLE pr_t_enti_compilatori ALTER COLUMN mail TYPE character varying(150);
ALTER TABLE pr_t_enti_gestori ALTER COLUMN mail TYPE character varying(150);
ALTER TABLE pr_t_utenti_compilatori ALTER COLUMN mail TYPE character varying(150);
ALTER TABLE pr_t_utenti_gestori ALTER COLUMN mail TYPE character varying(150);