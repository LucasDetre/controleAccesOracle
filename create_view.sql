CREATE OR REPLACE VIEW VCal_Evnt_Contact_ADMIN30 AS 
SELECT contact.id as contact_id, Contact.nom, contact.prenom, contact.telephone, contact.courriel, evenement.id as id_evenement, evenement.date_evenement, evenement.lieu, evenement.id_createur, evenement.description  
FROM Calendrier_ADMIN30 Calendrier
JOIN Contact_ADMIN30 Contact ON Calendrier.id_contact = Contact.id
JOIN Evenement_ADMIN30 Evenement ON Calendrier.id_evenement = Evenement.id
ORDER BY Evenement.id;

COMMIT;
