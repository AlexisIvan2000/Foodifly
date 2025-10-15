import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final List<Map<String, dynamic>> items = [
//The Happy Camper ZuJPX7ZpwXRGlqPTBmTy
  {
    'nom': 'Pizza Margherita',
    'prix': 12.99,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/PizzaMargherita.jpeg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },
  {
    'nom': 'Pizza BBQ Poulet',
    'prix': 15.99,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/PizzaBBQPoulet.jpeg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },
  {
    'nom': 'Pizza Végétarienne',
    'prix': 13.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/PizzaVegetarienne.jpeg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },
  {
    'nom': 'Pizza Pepperoni',
    'prix': 14.75,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/PizzaPepperoni.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },
  {
    'nom': 'Pizza 4 Fromages',
    'prix': 16.25,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/Pizza4fromages.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },
  {
    'nom': 'Frites',
    'prix': 4.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/frittes.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  }, // correspond à Classic Fries
  {
    'nom': 'Boisson au choix',
    'prix': 3.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/cocacola.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  }, // ex: Tamarind Juice
  {
    'nom': 'Sauce BBQ maison',
    'prix': 1.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/SauceBBQMaison.jpeg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },
  {
    'nom': 'Milkshake vanille',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/MilshakeVanille.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },
  {
    'nom': 'Salade fraîche',
    'prix': 3.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/SaladesFraiche.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },
  {
    'nom': 'Jus naturel',
    'prix': 3.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/JusNaturel.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },
  {
    'nom': 'Sauce piquante',
    'prix': 1.20,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/SaucePiquante.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },
  {
    'nom': 'Milkshake chocolat',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/MilshakeChocolat.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },
  {
    'nom': 'Sauce blanche à l’ail',
    'prix': 1.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/SauceBlancheAil.jpeg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },
  {
    'nom': 'Pizza',
    'prix': 12.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/HappyCamper/Items/Pizza.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('ZuJPX7ZpwXRGlqPTBmTy'),
  },

//Butter Tart Truck 2
  {
    'nom': 'Butter Tart Classique',
    'prix': 3.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/ButterTarteClassique.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Café filtre',
    'prix': 1.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/Caf%C3%A9Filtr%C3%A9.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Fruits frais',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/FruisFrais.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Butter Tart aux Pacanes',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/ButterTartPacanes.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Lait chaud',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/LaitChaud.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Butter Tart au Chocolat',
    'prix': 4.25,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/ButterTartChocolat.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Chocolat chaud',
    'prix': 2.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/Chocolatchaud.jpeg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Noix grillées',
    'prix': 1.75,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/Noixgrill%C3%A9es.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Butter Tart Érable',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/ButterTart%C3%89rable.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Thé vert',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/Th%C3%A9Vert.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Butter Tart Vegan',
    'prix': 4.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/ButterTartVegan.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Smoothie fruits rouges',
    'prix': 3.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/SmoothieFruitsRouges.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Amandes grillées',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Items/AmandesGrill%C3%A9es.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('usOYijfQ2W9SVm2fdEEK'),
  },

  //The Poutine Club 3 EojjGC7s1TgnswFQirkU

  {
    'nom': 'Poutine Classique',
    'prix': 6.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Items/PoutineClassique.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Poutine BBQ Poulet',
    'prix': 8.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Items/chicken-poutines.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Poutine Italienne',
    'prix': 7.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Items/Poutine%20Italienne.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Poutine Végétarienne',
    'prix': 7.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Items/Poutine%20v%C3%A9g%C3%A9tarienne.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Poutine Deluxe',
    'prix': 9.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Items/poutine%20deluxe.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Frites supplémentaires',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Items/Frites%20suppl%C3%A9mentaires.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Salade verte',
    'prix': 2.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Items/Salade%20verte.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Eau minérale',
    'prix': 1.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Items/Eau%20min%C3%A9rale.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Jus naturel',
    'prix': 2.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Items/Jus%20naturel.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Sauce au choix',
    'prix': 1.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Items/Sauce%20au%20choix.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },

  // Churos 4 JnNI4Srhd7ENF951CpBN

  {
    'nom': 'Churros Classiques',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/Churros%20Classiques.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Sauce chocolat',
    'prix': 1.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/Sauce%20chocolat.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Churros au Chocolat',
    'prix': 5.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/Churros%20au%20Chocola.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Churros Fourrés au Dulce de Leche',
    'prix': 6.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/Churros%20Fourr%C3%A9s%20au%20Dulce%20de%20Leche.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Churros Glacés',
    'prix': 6.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/Churros%20Glac%C3%A9s.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Churros Party Box',
    'prix': 8.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/Churros%20Party%20Box.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Jus d\'orange',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        "https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/Jus%20d'orange.jpg'",
    'foodTruck':
        _firestore.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Jus de pomme',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/Jus%20de%20pomme.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Jus de fraise',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/Jus%20de%20fraise.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Jus de mangue',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/Jus%20de%20mangue.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },

  //Tacofino 4 CC9e4wwG7QlZEbmHuIfB

  {
    'nom': 'Taco au Poulet Grillé',
    'prix': 6.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Items/TacoCarnitas.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('CC9e4wwG7QlZEbmHuIfB'),
  },
  {
    'nom': 'Frites',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Items/Frites.jpg ',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('CC9e4wwG7QlZEbmHuIfB'),
  },
  {
    'nom': 'Boissons gazeuses',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Items/QuesadillaV%C3%A9g%C3%A9tarienne.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('CC9e4wwG7QlZEbmHuIfB'),
  },
  {
    'nom': 'Bowl Végétarien Californien',
    'prix': 9.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Items/QuesadillaV%C3%A9g%C3%A9tarienne.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('CC9e4wwG7QlZEbmHuIfB'),
  },
  {
    'nom': 'Tarte au Citron',
    'prix': 2.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Items/QuesadillaV%C3%A9g%C3%A9tarienne.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('CC9e4wwG7QlZEbmHuIfB'),
  },
  {
    'nom': 'Taco au Poisson',
    'prix': 7.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Items/TacoauPoisson.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('CC9e4wwG7QlZEbmHuIfB'),
  },
  {
    'nom': 'Crème Brûlée',
    'prix': 2.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Items/TacoauPoisson.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('CC9e4wwG7QlZEbmHuIfB'),
  },
  {
    'nom': 'Salade Lime & Avocat',
    'prix': 8.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Items/ComboBurritoauPoulet.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('CC9e4wwG7QlZEbmHuIfB'),
  },
  {
    'nom': 'Brownie au Chocolat',
    'prix': 2.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Items/ComboBurritoauPoulet.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('CC9e4wwG7QlZEbmHuIfB'),
  },

  //The Grilled Cheese 5 p6zMpSagx1rX2kyskBkX
  {
    'nom': 'Sandwich au Brisket Fumé',
    'prix': 12.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheGrilledCheese/Items/sandwichAuBrisketFume.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('p6zMpSagx1rX2kyskBkX'),
  },
  {
    'nom': 'Frites à la Graisse de Canard',
    'prix': 6.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheGrilledCheese/Items/FritesGraisseCanard.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('p6zMpSagx1rX2kyskBkX'),
  },
  {
    'nom': 'Boissons gazeuses',
    'prix': 1.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/pepsi.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('p6zMpSagx1rX2kyskBkX'),
  },
  {
    'nom': 'Ribs de Porc BBQ',
    'prix': 14.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheGrilledCheese/Items/RibsPorcBBQ.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('p6zMpSagx1rX2kyskBkX'),
  },
  {
    'nom': 'Mac & Cheese Fumé',
    'prix': 8.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheGrilledCheese/Items/MacCheeseFume.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('p6zMpSagx1rX2kyskBkX'),
  },
  {
    'nom': 'Burger Fumé au Fromage',
    'prix': 11.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheGrilledCheese/Items/burgerFromage.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('p6zMpSagx1rX2kyskBkX'),
  },

  //Rolling Pin 6 y5xvoNEtEbos52THLPfB
  {
    'nom': 'Beignet à l’Érable et Bacon',
    'prix': 4.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Items/beignetsErables.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('y5xvoNEtEbos52THLPfB'),
  },
  {
    'nom': 'Milkshake Vanille',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Items/milshakeVanille.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('y5xvoNEtEbos52THLPfB'),
  },
  {
    'nom': 'Cruller Vanille Bourbon',
    'prix': 3.75,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Items/crullerVanilleBourbon.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('y5xvoNEtEbos52THLPfB'),
  },
  {
    'nom': 'Milkshake Chocolat',
    'prix': 4.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Items/milshakeChocolat.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('y5xvoNEtEbos52THLPfB'),
  },
  {
    'nom': 'Donut au Chocolat Noir et Piment',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Items/donutsChocolat.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('y5xvoNEtEbos52THLPfB'),
  },
  {
    'nom': 'Milkshake Fraise',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Items/milshakeFraise.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('y5xvoNEtEbos52THLPfB'),
  },
  {
    'nom': 'Cookie Sandwich Glacé',
    'prix': 5.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Items/cookieSandwich.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('y5xvoNEtEbos52THLPfB'),
  },
  {
    'nom': 'Milkshake Vanille',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Items/milshakeVanille.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('y5xvoNEtEbos52THLPfB'),
  },
  {
    'nom': 'Cupcake Framboise et Citron',
    'prix': 3.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Items/cupcakeFrambroise.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('y5xvoNEtEbos52THLPfB'),
  },
  {
    'nom': 'Milkshake Citron',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Items/milshakeCitron.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('y5xvoNEtEbos52THLPfB'),
  },

  //La Paloma 7 jdTVXyrMGj0L3ZhbSPdv
  {
    'nom': 'Taco au Poisson',
    'prix': 5.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Paloma/Items/tacoPoisson.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('jdTVXyrMGj0L3ZhbSPdv'),
  },
  {
    'nom': 'Burrito au Poulet Épicé',
    'prix': 9.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Paloma/Items/burritoPoulet.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('jdTVXyrMGj0L3ZhbSPdv'),
  },
  {
    'nom': 'Nachos Suprêmes',
    'prix': 7.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Paloma/Items/Nachos-Supreme.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('jdTVXyrMGj0L3ZhbSPdv'),
  },
  {
    'nom': 'Quesadilla Végétarienne',
    'prix': 6.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Paloma/Items/quesadillaVegetarienne.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('jdTVXyrMGj0L3ZhbSPdv'),
  },
  {
    'nom': 'Taco Carnitas',
    'prix': 5.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Paloma/Items/tacosCarnita.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('jdTVXyrMGj0L3ZhbSPdv'),
  },
  {
    'nom': 'Frites',
    'prix': 3.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Paloma/Items/frites.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('jdTVXyrMGj0L3ZhbSPdv'),
  },
  {
    'nom': 'Boisson Gazeuse',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Paloma/Items/crush.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('jdTVXyrMGj0L3ZhbSPdv'),
  },

  //The Migthy cob 8 W4ceaMAXF05MhNppSfdf
  {
    'nom': 'Maïs Grillé Classique',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMigthyCob/Items/Maïs%20Grillé%20Classique.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('W4ceaMAXF05MhNppSfdf'),
  },
  {
    'nom': 'Maïs au Fromage et Paprika',
    'prix': 5.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMigthyCob/Items/Maïs%20au%20Fromage%20et%20Paprika.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('W4ceaMAXF05MhNppSfdf'),
  },
  {
    'nom': 'Maïs à la Mexicaine (Elote)',
    'prix': 6.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMigthyCob/Items/Maïs%20à%20la%20Mexicaine%20(Elote).jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('W4ceaMAXF05MhNppSfdf'),
  },
  {
    'nom': 'Maïs BBQ Doux',
    'prix': 5.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMigthyCob/Items/Maïs%20BBQ%20Doux.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('W4ceaMAXF05MhNppSfdf'),
  },
  {
    'nom': 'Salade de Maïs Grillé',
    'prix': 6.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMigthyCob/Items/Salade%20de%20Maïs%20Grillé.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('W4ceaMAXF05MhNppSfdf'),
  },
  {
    'nom': 'Boisson Gazeuse',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/Churos/Items/pepsi.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('W4ceaMAXF05MhNppSfdf'),
  },

  //The MeatBall Shoppe 9 by3pCGbQdzQxJ8k1SNhc
  {
    'nom': 'Boulettes Classiques à la Sauce Tomate',
    'prix': 9.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Items/Boulettes%20Classiques%20%C3%A0%20la%20Sauce%20Tomate.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('by3pCGbQdzQxJ8k1SNhc'),
  },
  {
    'nom': 'Boulettes au Fromage Fondant',
    'prix': 10.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Items/Boulettes%20au%20Fromage%20Fondant.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('by3pCGbQdzQxJ8k1SNhc'),
  },
  {
    'nom': 'Boulettes Végétariennes',
    'prix': 8.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Items/Boulettes%20V%C3%A9g%C3%A9tariennes.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('by3pCGbQdzQxJ8k1SNhc'),
  },
  {
    'nom': 'Sub Boulettes',
    'prix': 11.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Items/Sub%20Boulettes.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('by3pCGbQdzQxJ8k1SNhc'),
  },
  {
    'nom': 'Spaghetti aux Boulettes',
    'prix': 12.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Items/Spaghetti%20aux%20Boulettes.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('by3pCGbQdzQxJ8k1SNhc'),
  },
  {
    'nom': 'Piña Colada',
    'prix': 5.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Items/Pi%C3%B1a%20Colada%20png.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('by3pCGbQdzQxJ8k1SNhc'),
  },
  {
    'nom': 'Mojito Fraise',
    'prix': 5.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Items/Spaghetti%20aux%20Boulettes.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('by3pCGbQdzQxJ8k1SNhc'),
  },
  {
    'nom': 'Margarita Tropicale',
    'prix': 6.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Items/Margarita%20Tropicale.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('by3pCGbQdzQxJ8k1SNhc'),
  },
  {
    'nom': 'Daiquiri à la Mangue',
    'prix': 5.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Items/Daiquiri%20%C3%A0%20la%20Mangue.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('by3pCGbQdzQxJ8k1SNhc'),
  },
  {
    'nom': 'Smoothie à la Coco',
    'prix': 5.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Items/Smoothie%20%C3%A0%20la%20Coco.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('by3pCGbQdzQxJ8k1SNhc'),
  },

  // Zilford's Fried Chicken 10 Tn8ekdC7BSrDCrcVzo9K
  {
    'nom': 'Poulet Frit Classique',
    'prix': 11.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ZilfordsFriedChicken/Items/Poulet%20Frit%20Classique.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('Tn8ekdC7BSrDCrcVzo9K'),
  },
  {
    'nom': 'Sandwich au Poulet Frit Épicé',
    'prix': 10.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ZilfordsFriedChicken/Items/Sandwich%20au%20Poulet%20Frit%20%C3%89pic%C3%A9.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('Tn8ekdC7BSrDCrcVzo9K'),
  },
  {
    'nom': 'Ailes de Poulet BBQ',
    'prix': 9.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ZilfordsFriedChicken/Items/Ailes%20de%20Poulet%20BBQ.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('Tn8ekdC7BSrDCrcVzo9K'),
  },
  {
    'nom': 'Tenders de Poulet',
    'prix': 8.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ZilfordsFriedChicken/Items/Tenders%20de%20Poulet.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('Tn8ekdC7BSrDCrcVzo9K'),
  },
  {
    'nom': 'Poulet Frit et Gaufres',
    'prix': 13.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ZilfordsFriedChicken/Items/Poulet%20Frit%20et%20Gaufres.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('Tn8ekdC7BSrDCrcVzo9K'),
  },
  {
    'nom': 'Soda',
    'prix': 2.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/ZilfordsFriedChicken/Items/Soda.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('Tn8ekdC7BSrDCrcVzo9K'),
  },

  // Randy's Roti and Doubles 13 X7QfbdBzKrpi4CTKYn5A
  {
    'nom': 'Roti de Poulet',
    'prix': 9.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RandyRoti/Items/RotiPoulet.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('X7QfbdBzKrpi4CTKYn5A'),
  },
  {
    'nom': 'Doubles au Curry',
    'prix': 6.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RandyRoti/Items/DoublesCurry.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('X7QfbdBzKrpi4CTKYn5A'),
  },
  {
    'nom': 'Roti de Bœuf',
    'prix': 10.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RandyRoti/Items/rotiBoeuf.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('X7QfbdBzKrpi4CTKYn5A'),
  },
  {
    'nom': 'Doubles Végétarien',
    'prix': 5.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RandyRoti/Items/DoublesVegetarien.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('X7QfbdBzKrpi4CTKYn5A'),
  },
  {
    'nom': 'Tamarind Juice',
    'prix': 3.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RandyRoti/Items/tamarin_juice.jpeg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('X7QfbdBzKrpi4CTKYn5A'),
  },
  {
    'nom': 'Passion Mojito',
    'prix': 5.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RandyRoti/Items/Passion-Fruit-Mojito.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('X7QfbdBzKrpi4CTKYn5A'),
  },
  {
    'nom': 'Ginger Sunrise',
    'prix': 6.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RandyRoti/Items/GingerSunrise.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('X7QfbdBzKrpi4CTKYn5A'),
  },
  {
    'nom': 'Tropical Breeze',
    'prix': 3.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RandyRoti/Items/Tropical-Breeze.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('X7QfbdBzKrpi4CTKYn5A'),
  },
  {
    'nom': 'Hibiscus Fizz',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/RandyRoti/Items/Tropical-Breeze.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('X7QfbdBzKrpi4CTKYn5A'),
  },

  // Buster's Sea Cove 14 uz4ZVQpjfIkiiIzVpyxI
  {
    'nom': 'Poisson Frit',
    'prix': 12.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/BusterSeaCove/Items/PoissonFris.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('uz4ZVQpjfIkiiIzVpyxI'),
  },
  {
    'nom': 'Lobster Roll',
    'prix': 18.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/BusterSeaCove/Items/lobster_rolls.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('uz4ZVQpjfIkiiIzVpyxI'),
  },
  {
    'nom': 'Fish Tacos',
    'prix': 10.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/BusterSeaCove/Items/fish_tacos.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('uz4ZVQpjfIkiiIzVpyxI'),
  },
  {
    'nom': 'Chowder de Fruits de Mer',
    'prix': 8.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/BusterSeaCove/Items/ChowderFruits.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('uz4ZVQpjfIkiiIzVpyxI'),
  },
  {
    'nom': 'Lemonade',
    'prix': 2.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/BusterSeaCove/Items/Lemonade.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('uz4ZVQpjfIkiiIzVpyxI'),
  },
  {
    'nom': 'Iced Tea',
    'prix': 3.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/BusterSeaCove/Items/IcedTea.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('uz4ZVQpjfIkiiIzVpyxI'),
  },
  {
    'nom': 'Mango Mojito',
    'prix': 4.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/BusterSeaCove/Items/MangoMojito.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('uz4ZVQpjfIkiiIzVpyxI'),
  },
  {
    'nom': 'Pina Colada',
    'prix': 5.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/BusterSeaCove/Items/PinaCollada.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('uz4ZVQpjfIkiiIzVpyxI'),
  },
  {
    'nom': 'Green Smoothie',
    'prix': 4.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/BusterSeaCove/Items/GreenSmoothie.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('uz4ZVQpjfIkiiIzVpyxI'),
  },

  // Crack On 11

  {
    'nom': 'Croissant',
    'prix': 1.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/CrackOn/Items/Croissant.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('rvpPmtl4hQIAqMLAbvfv'),
  },
  {
    'nom': 'Avocado Egg Toast',
    'prix': 7.20,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/CrackOn/Items/AvocadoEggToast.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('rvpPmtl4hQIAqMLAbvfv'),
  },
  {
    'nom': 'Smoothie',
    'prix': 1.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/CrackOn/Items/Smoothie.png',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('rvpPmtl4hQIAqMLAbvfv'),
  },
  {
    'nom': 'Breakfast Burrito',
    'prix': 7.90,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/CrackOn/Items/BreakfastBurrito.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('rvpPmtl4hQIAqMLAbvfv'),
  },
  {
    'nom': 'Pain grillé',
    'prix': 1.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/CrackOn/Items/PainGrill%C3%A9.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('rvpPmtl4hQIAqMLAbvfv'),
  },
  {
    'nom': 'Truffled Scrambled Eggs',
    'prix': 8.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/CrackOn/Items/TruffledScrambled%20Eggs.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('rvpPmtl4hQIAqMLAbvfv'),
  },
  {
    'nom': 'Toast brioché',
    'prix': 1.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/CrackOn/Items/Toast%20brioch%C3%A9.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('rvpPmtl4hQIAqMLAbvfv'),
  },

//   //The Frying Dutchmen 12

  {
    'nom': 'Classic Fries',
    'prix': 4.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/FryingDutchMen/Items/Classic%20Fries.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('NTuOenvQOCxBN68ImgxA'),
  },
  {
    'nom': 'Cheese Fries',
    'prix': 5.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/FryingDutchMen/Items/Cheese%20Fries.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('NTuOenvQOCxBN68ImgxA'),
  },
  {
    'nom': 'Truffle Fries',
    'prix': 6.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/FryingDutchMen/Items/Truffle%20Fries.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('NTuOenvQOCxBN68ImgxA'),
  },
  {
    'nom': 'Fried Shrimp Basket',
    'prix': 8.00,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/FryingDutchMen/Items/Fried%20Shrimp%20Basket.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('NTuOenvQOCxBN68ImgxA'),
  },
  {
    'nom': 'Soda',
    'prix': 1.50,
    'disponible': true,
    'imageUrl':
        'https://foodifly.college-dev.com/Foodifly/Images/FryingDutchMen/Items/Soda2.jpg',
    'foodTruck':
        _firestore.collection('foodTrucks').doc('NTuOenvQOCxBN68ImgxA'),
  },
];

Future<void> addItems() async {
  try {
    // Iterate through the list and add each food truck to Firestore
    for (var menu in items) {
      await _firestore.collection('items').add(menu);
    }
    print('Items added successfully');
  } catch (e) {
    print('Error adding items: $e');
  }
}
