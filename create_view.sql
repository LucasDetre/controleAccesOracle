CREATE OR REPLACE VIEW VCalendrier_Evenement_Contact_ADMIN30 AS 
SELECT * 
FROM ADMIN30.Calendrier_ADMIN30 Calendrier
JOIN ADMIN30.Contact_ADMIN30 Contact ON Calendrier.id_contact = Contact.id
JOIN ADMIN30.Evenement_ADMIN30 Evenement ON Calendrier.id_evenement = Evenement.id;

COMMIT;