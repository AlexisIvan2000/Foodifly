# Foodifly Admin Dashboard
Ce référentiel contient le code source de l'interface d'administration (Admin Dashboard) de l'application mobile FoodiFly, développée avec Flutter. Cette interface est dédiée à la gestion des food trucks : commandes, menu, profil, et suivi de l'activité.

## Fonctionnalités
1.  **Connexion Sécurisée (`admin_login_page.dart`)**
    * Authentification via un ID de Food Truck et un mot de passe stockés dans Firestore (`foodTrucks` collection).
    * Redirection vers l'interface principale après validation.

2.  **Tableau de Bord Principal (`admin_interface.dart`)**
    * Affichage du profil du Food Truck (nom, image).
    * Navigation rapide vers les différentes sections de gestion.
    * Récupération des données du Food Truck (nom, localisation, horaires, etc.) via Firebase Firestore au chargement.

3.  **Gestion du Menu (`menu.dart`)**
    * Visualisation tabulaire des plats et menus existants.
    * Fonctionnalité d'ajout de nouveaux plats/menus (via `AddMenuItemDialog`).
    * Utilise `collectionGroup` dans Firestore pour récupérer les items et menus associés au `foodTruckId`.

4.  **Historique des Commandes (`order_history.dart`)**
    * Affiche la liste complète des commandes passées pour le Food Truck.
    * Chaque commande est présentée avec un statut, des détails sur les articles, le montant total et la date/heure.
    * Utilise `StreamBuilder` pour une mise à jour en temps réel des commandes.

5.  **Suivi de Commande Client (`order_tracking.dart`)**
    * Page simplifiée pour visualiser l'état actuel d'une commande via un système de coche (étapes : Reçue, Préparation, Prête, Retirée).

6.  **Profil et Sécurité (`profileHomePage.dart`, `securiter.dart`)**
    * **Vue de Profil :** Affiche toutes les informations publiques du Food Truck (description, localisation, horaires, contacts).
    * **Page de Sécurité/Modification :** Permet à l'administrateur de modifier les informations du Food Truck (nom, description, email, téléphone, adresse, horaires).
    * Inclut des validations de format pour l'email et le téléphone.




