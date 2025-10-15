# Foodifly
Application mobile moderne de commande et de retrait  dédiée aux food trucks. Développée avec Flutter et Firebase.

## Stack technique
* Front-end / Client	**Flutter (Dart)**	Développement mobile multiplateforme (Android/iOS) avec une interface utilisateur unique et performante.
* Authentification	**Firebase Auth**	Gestion des utilisateurs (clients) et des administrateurs (food trucks).
* Base de Données	**Cloud Firestore**	Base de données NoSQL temps réel pour les menus, les plats et les mises à jour instantanées du statut des commandes.
* Stockage Fichiers	**Firebase Storage**	Stockage des images des plats et des logos des food trucks.
* Administration	**Flutter** (Admin Panel)	Interface de gestion des menus (CRUD) pour les propriétaires de food trucks.

## Fonctionnalités
### Côté client
* Authentification : Connexion et inscription classiques.
* Catalogue: Liste des foodtrucks et de leurs menus
* Commande: Ajout au panier et soumission de la commande
* Suivi du statut de la commande 
  - L'application utilise une minuterie (timer) pour l'affichage de la progression ( Reçu -> En préparation -> terminée).
* Paiement fictif: La logique de paiement est implémentée, mais le système est simulé pour des raisons de prototypage.

### Côté Admin (Food Truck)
* Gestion des Menus (CRUD) : Ajouter, modifier ou supprimer des plats et leurs descriptions.
* Gestion des Commandes : Réception et mise à jour des statuts des commandes entrantes.
* Confirmation Finale : Seul le serveur côté admin peut confirmer les étapes critiques du statut de commande (par exemple, Prête pour retrait et Ramassée), garantissant la précision de la dernière étape.

### Apercu 
Vous trouverez une démo de Foodifly en cliquant sur ce lien.
https://drive.google.com/file/d/1fiRSJYCjAYNojmjlZkofIyDMllV1GNP1/view?usp=sharing