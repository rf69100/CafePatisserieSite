import { Product } from "@shared/schema";

import latteImage from "@assets/generated_images/Café_latte_with_art_affbc38f.png";
import cappuccinoImage from "@assets/generated_images/Perfect_cappuccino_close-up_cf011788.png";
import cookieImage from "@assets/generated_images/Artisanal_chocolate_chip_cookies_9ec74c0f.png";
import croissantImage from "@assets/generated_images/Perfect_French_croissant_c4e49dae.png";
import brownieImage from "@assets/generated_images/Fudgy_chocolate_walnut_brownie_3d410892.png";
import mochaImage from "@assets/generated_images/Café_mocha_with_cream_0aa464cb.png";
import espressoImage from "@assets/generated_images/Perfect_espresso_shot_ef210020.png";
import painAuChocolatImage from "@assets/generated_images/French_pain_au_chocolat_af5e4651.png";

export const products: Product[] = [
  {
    id: "1",
    name: "Café Latte",
    category: "coffee",
    description: "Espresso onctueux accompagné de lait vapeur et couronné d'une mousse légère",
    price: 4.50,
    image: latteImage,
  },
  {
    id: "2",
    name: "Cappuccino",
    category: "coffee",
    description: "Équilibre parfait entre espresso intense et mousse de lait veloutée",
    price: 4.20,
    image: cappuccinoImage,
  },
  {
    id: "3",
    name: "Cookie Artisanal",
    category: "pastry",
    description: "Cookie maison aux pépites de chocolat, croustillant à l'extérieur et moelleux à l'intérieur",
    price: 3.00,
    image: cookieImage,
  },
  {
    id: "4",
    name: "Croissant Pur Beurre",
    category: "pastry",
    description: "Croissant traditionnel au beurre, feuilleté et doré à la perfection",
    price: 2.80,
    image: croissantImage,
  },
  {
    id: "5",
    name: "Brownie Chocolat Noix",
    category: "pastry",
    description: "Brownie ultra-fondant au chocolat noir et éclats de noix croquantes",
    price: 4.00,
    image: brownieImage,
  },
  {
    id: "6",
    name: "Café Moka",
    category: "coffee",
    description: "Mélange gourmand d'espresso, chocolat et crème fouettée généreuse",
    price: 5.20,
    image: mochaImage,
  },
  {
    id: "7",
    name: "Espresso",
    category: "coffee",
    description: "Shot d'espresso pur, corsé et aromatique pour les amateurs de café intense",
    price: 2.50,
    image: espressoImage,
  },
  {
    id: "8",
    name: "Pain au Chocolat",
    category: "pastry",
    description: "Viennoiserie feuilletée garnie de deux barrettes de chocolat fondant",
    price: 3.20,
    image: painAuChocolatImage,
  },
];
