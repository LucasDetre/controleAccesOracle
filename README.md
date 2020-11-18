Le seul script a exécuter pour ce projet est lancement_demo.sql.

Le déroulement est contrôlé par l'utilisateur qui est invité à appuyer sur Entrée pour continuer le déroulement.

Si l'utilisateur souhaite exécuter les scripts séparemment, l'ordre à suivre est le suivant :
    - clear_all.sql
    - create_tables.sql
    - create_view.sql
    - create_roles.sql
    - create_context.sql
    - create_vpd.sql

Une fois les différents objets créés, nous pouvons lancer les scripts "test", sans contrainte d'ordre, mais en se connectant au bon utilisateur.

Les rôles des utilisateurs sont les suivant :
    - USER 1 à 3 : Clients
    - USER 4 et 5 : Commercial
    - USER 6 : Informaticien
    - USER 7 : Admin