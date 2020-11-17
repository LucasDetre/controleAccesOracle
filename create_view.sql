CREATE OR REPLACE VIEW VCal_Evnt_Contact_ADMIN30 AS 
SELECT * 
FROM Calendrier_ADMIN30 Calendrier
JOIN Contact_ADMIN30 Contact ON Calendrier.id_contact = Contact.id
JOIN Evenement_ADMIN30 Evenement ON Calendrier.id_evenement = Evenement.id
ORDER BY Evenement.id;

COMMIT;