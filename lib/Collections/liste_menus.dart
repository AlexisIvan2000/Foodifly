import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final List<Map<String, dynamic>> menus = [

  //jdTVXyrMGj0L3ZhbSPdv La Paloma 
 {
  'nom': 'Combo Taco au Poisson',
  'description': 'Taco au Poisson + Frites + Boisson Gazeuse',
  'prix': 10.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Paloma/Menus/Combo%20Taco%20au%20Poisson.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('jdTVXyrMGj0L3ZhbSPdv'),
},
{
  'nom': 'Combo Burrito au Poulet Épicé',
  'description': 'Burrito au Poulet Épicé + Frites + Boisson Gazeuse',
  'prix': 13.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Paloma/Menus/Combo%20Burrito%20au%20Poulet%20Épicé.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('jdTVXyrMGj0L3ZhbSPdv'),
},
{
  'nom': 'Combo Nachos Suprêmes',
  'description': 'Nachos Suprêmes + Frites + Boisson Gazeuse',
  'prix': 11.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Paloma/Menus/Combo%20Nachos%20Suprêmes.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('jdTVXyrMGj0L3ZhbSPdv'),
},
{
  'nom': 'Combo Quesadilla Végétarienne',
  'description': 'Quesadilla Végétarienne + Frites + Boisson Gazeuse',
  'prix': 11.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Paloma/Menus/Combo%20Quesadilla%20Végétarienne.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('jdTVXyrMGj0L3ZhbSPdv'),
},
{
  'nom': 'Combo Taco Carnitas',
  'description': 'Taco Carnitas + Frites + Boisson Gazeuse',
  'prix': 9.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Paloma/Menus/Combo%20Taco%20Carnitas.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('jdTVXyrMGj0L3ZhbSPdv'),
},
  //W4ceaMAXF05MhNppSfdf The MigtyCob
  {
  'nom': 'Combo Maïs Grillé Classique',//
  'description': 'Maïs Grillé Classique + Boisson Gazeuse',
  'prix': 6.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheMigthyCob/Menus/ComboMaisGrilléClassique.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('W4ceaMAXF05MhNppSfdf'),
},
{
  'nom': 'Combo Maïs au Fromage et Paprika',
  'description': 'Maïs au Fromage et Paprika + Boisson Gazeuse',
  'prix': 7.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheMigthyCob/Menus/ComboMaïs%20au%20Fromage%20et%20Paprika.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('W4ceaMAXF05MhNppSfdf'),
},
{
  'nom': 'Combo Maïs à la Mexicaine (Elote)',
  'description': 'Maïs à la Mexicaine (Elote) + Boisson Gazeuse',
  'prix': 8.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheMigthyCob/Menus/Maïs%20à%20la%20Mexicaine%20(Elote).jpeg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('W4ceaMAXF05MhNppSfdf'),
},
{
  'nom': 'Combo Maïs BBQ Doux',
  'description': 'Maïs BBQ Doux + Boisson Gazeuse',
  'prix': 7.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheMigthyCob/Menus/Maïs%20BBQ%20Doux.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('W4ceaMAXF05MhNppSfdf'),
},
{
  'nom': 'Combo Salade de Maïs Grillé',
  'description': 'Salade de Maïs Grillé + Boisson Gazeuse',
  'prix': 8.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheMigthyCob/Menus/Salade%20de%20Maïs%20Grillé.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('W4ceaMAXF05MhNppSfdf'),
},
  //by3pCGbQdzQxJ8k1SNhc The MeatBall Shoppe
 {
  'nom': 'Combo Boulettes Classiques à la Sauce Tomate',
  'description': 'Boulettes Classiques à la Sauce Tomate + Piña Colada',
  'prix': 12.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Menus/Boulettes%20Classiques%20à%20la%20Sauce%20Tomate.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('by3pCGbQdzQxJ8k1SNhc'),
},
{
  'nom': 'Combo Boulettes au Fromage Fondant',
  'description': 'Boulettes au Fromage Fondant + Mojito Fraise',
  'prix': 12.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Menus/Boulettes%20au%20Fromage%20Fondant.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('by3pCGbQdzQxJ8k1SNhc'),
},
{
  'nom': 'Combo Boulettes Végétariennes',
  'description': 'Boulettes Végétariennes + Margarita Tropicale',
  'prix': 11.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Menus/Boulettes%20Végétariennes.jpeg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('by3pCGbQdzQxJ8k1SNhc'),
},
{
  'nom': 'Combo Sub Boulettes',
  'description': 'Sub Boulettes + Daiquiri à la Mangue',
  'prix': 13.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Menus/SubBoulettes.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('by3pCGbQdzQxJ8k1SNhc'),
},
{
  'nom': 'Combo Spaghetti aux Boulettes',
  'description': 'Spaghetti aux Boulettes + Smoothie à la Coco',
  'prix': 14.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheMeatBallShoppe/Menus/SpaghettiauxBoulettes.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('by3pCGbQdzQxJ8k1SNhc'),
},

  //CC9e4wwG7QlZEbmHuIfB Tacofino
  {
    'nom': 'Combo Taco au Poulet Grillé',
    'description': 'Taco au Poulet Grillé + Frites + Boissons gazeuses',
    'prix': 10.50,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Menus/Combo%20Bowl%20V%C3%A9g%C3%A9tarien%20Californien.jpg',
    'foodTruck': FirebaseFirestore.instance
      .collection('foodTrucks')
      .doc('CC9e4wwG7QlZEbmHuIfB'),
  },
  {
    'nom': 'Combo Bowl Végétarien Californien',
    'description': 'Bowl Végétarien Californien + Tarte au Citron + Boissons gazeuses',
    'prix': 12.00,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Menus/ComboSalade.jpg',
    'foodTruck': FirebaseFirestore.instance
      .collection('foodTrucks')
      .doc('CC9e4wwG7QlZEbmHuIfB'),
  },
  {
    'nom': 'Combo Taco au Poisson',
    'description': 'Taco au Poisson + Frites + Crème Brûlée + Boissons gazeuses',
    'prix': 11.00,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Menus/ComboTacoauPoisson.jpg',
    'foodTruck': FirebaseFirestore.instance
      .collection('foodTrucks')
      .doc('CC9e4wwG7QlZEbmHuIfB'),
  },
  {
    'nom': 'Combo Salade Lime & Avocat',
    'description': 'Salade Lime & Avocat + Brownie au Chocolat + Boissons gazeuses',
    'prix': 12.50,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Tacofino/Menus/ComboTacoauPouletGrill%C3%A9.jpg',
    'foodTruck': FirebaseFirestore.instance
      .collection('foodTrucks')
      .doc('CC9e4wwG7QlZEbmHuIfB'),
  },

  //p6zMpSagx1rX2kyskBkX The Grilled Cheese
  {
  'nom': 'Combo Burger Fumé au Fromage',
  'description': 'Burger Fumé au Fromage + Frites à la Graisse de Canard + Boissons gazeuses',
  'prix': 19.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheGrilledCheese/Menus/ComboBrisketFum%C3%A9.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('p6zMpSagx1rX2kyskBkX'),
},
{
  'nom': 'Combo Ribs de Porc BBQ',
  'description': 'Ribs de Porc BBQ + Mac & Cheese Fumé + Boissons gazeuses',
  'prix': 24.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheGrilledCheese/Menus/ComboBurgerFum%C3%A9auFromage.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('p6zMpSagx1rX2kyskBkX'),
},
{
  'nom': 'Combo Brisket Fumé',
  'description': 'Sandwich au Brisket Fumé + Frites à la Graisse de Canard + Boissons gazeuses',
  'prix': 18.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheGrilledCheese/Menus/ComboFritesalaGraissedeCanard.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('p6zMpSagx1rX2kyskBkX'),
},
{
  'nom': 'Combo Mac & Cheese Fumé',
  'description': 'Mac & Cheese Fumé + Frites à la Graisse de Canard + Boissons gazeuses',
  'prix': 15.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheGrilledCheese/Menus/ComboMac.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('p6zMpSagx1rX2kyskBkX'),
},
{
  'nom': 'Combo Frites à la Graisse de Canard',
  'description': 'Frites à la Graisse de Canard + Boissons gazeuses',
  'prix': 7.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/TheGrilledCheese/Menus/ComboRibsdePorcBBQ.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('p6zMpSagx1rX2kyskBkX'),
},

//OK y5xvoNEtEbos52THLPfB Rolling Pin
  {
  'nom': 'Combo Beignet à l’Érable et Bacon',
  'description': 'Beignet à l’Érable et Bacon + Milkshake Vanille',
  'prix': 8.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Menus/ComboBeignetBacon.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('y5xvoNEtEbos52THLPfB'),
},
{
  'nom': 'Combo Cruller Vanille Bourbon',
  'description': 'Cruller Vanille Bourbon + Milkshake Chocolat',
  'prix': 8.25,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Menus/ComboSandwichGlace.jpeg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('y5xvoNEtEbos52THLPfB'),
},
{
  'nom': 'Combo Donut au Chocolat Noir et Piment',
  'description': 'Donut au Chocolat Noir et Piment + Milkshake Fraise',
  'prix': 8.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Menus/ComboCrullerVanilleBourbon.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('y5xvoNEtEbos52THLPfB'),
},
{
  'nom': 'Combo Cookie Sandwich Glacé',
  'description': 'Cookie Sandwich Glacé + Milkshake Vanille',
  'prix': 9.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Menus/ComboCupcakeFramboiseCitron.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('y5xvoNEtEbos52THLPfB'),
},
{
  'nom': 'Combo Cupcake Framboise et Citron',
  'description': 'Cupcake Framboise et Citron + Milkshake Citron',
  'prix': 7.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/RollingPin/Menus/ComboDonutauChocolatNoire.png',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('y5xvoNEtEbos52THLPfB'),
},

//The Poutine
  {
    'nom': 'Combo Poutine Classique',
    'description': 'Poutine Classique + Frites supplémentaires + Boisson gazeuse',
    'prix': 9.00,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Menus/poutine%20classique%20large.jpg',
    'foodTruck': FirebaseFirestore.instance.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Combo Poutine BBQ Poulet',
    'description': 'Poutine BBQ Poulet + Frites + Boisson gazeuse',
    'prix': 11.00,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Menus/poutine%20bbq%20poulet.jpg',
    'foodTruck': FirebaseFirestore.instance.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Combo Poutine Italienne',
    'description': 'Poutine Italienne + Salade verte + Eau minérale',
    'prix': 10.00,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Menus/poutine%20italienne.jpg',
    'foodTruck': FirebaseFirestore.instance.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Combo Poutine Végétarienne',
    'description': 'Poutine Végétarienne + Jus naturel + Fruits frais',
    'prix': 9.50,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Menus/PoutineLegumesRacines.png',
    'foodTruck': FirebaseFirestore.instance.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
  },
  {
    'nom': 'Combo Poutine Deluxe',
    'description': 'Poutine Deluxe + Frites + Sauce au choix',
    'prix': 12.50,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ThePoutineClub/Menus/poutineDeluxe.jpg',
    'foodTruck': FirebaseFirestore.instance.collection('foodTrucks').doc('EojjGC7s1TgnswFQirkU'),
    },



// OK usOYijfQ2W9SVm2fdEEK Butter Tart Truck
  {
    'nom': 'Combo Butter Classique',
    'description': 'Butter Tart Classique + Café filtre + Fruits frais',
    'prix': 7.50,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Menus/ComboButterClassic.jpg',
    'foodTruck': FirebaseFirestore.instance
        .collection('foodTrucks')
        .doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Combo Pacanes Douces',
    'description': 'Butter Tart aux Pacanes + Lait chaud + Fruits frais',
    'prix': 8.00,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Menus/ComboPacaneDouces.jpg',
    'foodTruck': FirebaseFirestore.instance
        .collection('foodTrucks')
        .doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Combo Choco Gourmand',
    'description': 'Butter Tart au Chocolat + Chocolat chaud + Noix grillées',
    'prix': 8.75,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Menus/ComboChocoGourmand.jpg',
    'foodTruck': FirebaseFirestore.instance
        .collection('foodTrucks')
        .doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Combo Érable Pur',
    'description': 'Butter Tart Érable + Thé vert + Noix grillées',
    'prix': 8.25,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Menus/ComboErablePur.jpg',
    'foodTruck': FirebaseFirestore.instance
        .collection('foodTrucks')
        .doc('usOYijfQ2W9SVm2fdEEK'),
  },
  {
    'nom': 'Combo Vegan Douceur',
    'description':
        'Butter Tart Vegan + Smoothie fruits rouges + Amandes grillées',
    'prix': 9.25,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ButterTartTruck/Menus/ComboVeganDouceur.jpg',
    'foodTruck': FirebaseFirestore.instance
        .collection('foodTrucks')
        .doc('usOYijfQ2W9SVm2fdEEK'),
},

//OK JnNI4Srhd7ENF951CpBN The churro
{
    'nom': 'Combo Churros Classiques',
    'description': 'Churros Classiques + Sauce chocolat + Jus d\'orange',
    'prix': 6.50,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Churos/Menus/Churro%20classique.jpg',
    'foodTruck': FirebaseFirestore.instance.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Combo Churros au Chocolat',
    'description': 'Churros au Chocolat + Sauce caramel + Jus de pomme',
    'prix': 7.50,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Churos/Menus/churro%20chocolat.jpg',
    'foodTruck': FirebaseFirestore.instance.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Combo Churros Fourrés au Dulce de Leche',
    'description': 'Churros Fourrés au Dulce de Leche + Sauce chocolat + Jus de fraise',
    'prix': 8.00,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Churos/Menus/churro%20dulche%20de%20la%20leche.jpg',
    'foodTruck': FirebaseFirestore.instance.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Combo Churros Glacés',
    'description': 'Churros Glacés + Boule de glace vanille + Jus d\'orange frais',
    'prix': 8.50,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Churos/Menus/churro%20glace.jpg',
    'foodTruck': FirebaseFirestore.instance.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
  },
  {
    'nom': 'Combo Churros Party Box',
    'description': 'Mini churros + 3 sauces au choix + Jus de pomme frais',
    'prix': 9.00,
    'disponible': true,
    'categorieId': 'id_categorie_combo',
    'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/Churos/Menus/churro%20party%20box.jpg',
    'foodTruck': FirebaseFirestore.instance.collection('foodTrucks').doc('JnNI4Srhd7ENF951CpBN'),
},

 //ZilfordFriedChiken

 {
  'nom': 'Combo Poulet Frit Classique',
  'description': 'Poulet Frit Classique + Soda (Coca-Cola)',
  'prix': 13.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ZilfordsFriedChicken/Menus/PouletFritClassiqueFrite.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('Tn8ekdC7BSrDCrcVzo9K'),
},
{
  'nom': 'Combo Sandwich au Poulet Frit Épicé',
  'description': 'Sandwich au Poulet Frit Épicé + Soda (Pepsi)',
  'prix': 12.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ZilfordsFriedChicken/Menus/SandwichPouletFrites.jpeg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('LTn8ekdC7BSrDCrcVzo9K'),
},
{
  'nom': 'Combo Ailes de Poulet BBQ',
  'description': 'Ailes de Poulet BBQ + Soda (Sprite)',
  'prix': 11.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ZilfordsFriedChicken/Menus/AilesdePouletBBQ.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('Tn8ekdC7BSrDCrcVzo9K'),
},
{
  'nom': 'Combo Tenders de Poulet',
  'description': 'Tenders de Poulet + Soda (Fanta)',
  'prix': 10.50,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ZilfordsFriedChicken/Menus/TendersdePoulet.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('Tn8ekdC7BSrDCrcVzo9K'),
},
{
  'nom': 'Combo Poulet Frit et Gaufres',
  'description': 'Poulet Frit et Gaufres + Soda (7UP)',
  'prix': 15.00,
  'disponible': true,
  'categorieId': 'id_categorie_combo',
  'imageUrl': 'https://foodifly.college-dev.com/Foodifly/Images/ZilfordsFriedChicken/Menus/PouletFritetGaufres.jpg',
  'foodTruck': FirebaseFirestore.instance
    .collection('foodTrucks')
    .doc('Tn8ekdC7BSrDCrcVzo9K'),
},
];

Future<void> addMenus() async {
  try {
    // Iterate through the list and add each food truck to Firestore
    for (var menu in menus) {
      await _firestore.collection('menus').add(menu);
    }
    print('Menus added successfully');
  } catch (e) {
    print('Error adding menus: $e');
  }
}

