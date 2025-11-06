import { db } from "./db";
import { products } from "@shared/schema";

const sampleProducts = [
  {
    name: "Expresso",
    category: "coffee",
    description: "Un café intense et aromatique, servi dans une petite tasse.",
    price: "2.50",
    image: "/images/espresso.jpg"
  },
  {
    name: "Cappuccino",
    category: "coffee", 
    description: "Café expresso avec du lait vapeur et de la mousse de lait.",
    price: "3.80",
    image: "/images/cappuccino.jpg"
  },
  {
    name: "Croissant au Beurre",
    category: "pastry",
    description: "Croissant feuilleté au beurre, croustillant et doré.",
    price: "1.80",
    image: "/images/croissant.jpg"
  },
  {
    name: "Pain au Chocolat",
    category: "pastry",
    description: "Viennoiserie feuilletée avec deux barres de chocolat.",
    price: "2.20",
    image: "/images/pain-chocolat.jpg"
  },
  {
    name: "Éclair au Café",
    category: "pastry",
    description: "Pâte à choux garnie de crème pâtissière au café et glaçage fondant.",
    price: "4.50",
    image: "/images/eclair-cafe.jpg"
  },
  {
    name: "Tarte aux Fruits",
    category: "pastry",
    description: "Pâte sablée garnie de crème pâtissière et fruits de saison.",
    price: "5.80",
    image: "/images/tarte-fruits.jpg"
  }
];

async function seedDatabase() {
  try {
    console.log("🌱 Initialisation de la base de données...");
    
    // Insérer les produits de démonstration
    for (const product of sampleProducts) {
      await db.insert(products).values(product);
      console.log(`✅ Produit ajouté: ${product.name}`);
    }
    
    console.log("🎉 Base de données initialisée avec succès !");
  } catch (error) {
    console.error("❌ Erreur lors de l'initialisation:", error);
    process.exit(1);
  }
}

// Exécuter le seeding si ce script est appelé directement
if (import.meta.url === `file://${process.argv[1]}`) {
  seedDatabase();
}

export { seedDatabase };