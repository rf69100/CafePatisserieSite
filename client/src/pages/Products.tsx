import { ProductCard } from "@/components/ProductCard";
import { products } from "@/data/products";
import { Button } from "@/components/ui/button";
import { useState } from "react";

export default function Products() {
  const [filter, setFilter] = useState<"all" | "coffee" | "pastry">("all");

  const filteredProducts = products.filter((product) => {
    if (filter === "all") return true;
    return product.category === filter;
  });

  return (
    <div className="min-h-screen py-16 px-6">
      <div className="max-w-6xl mx-auto space-y-12">
        <div className="text-center space-y-4">
          <h1 className="font-serif text-4xl md:text-5xl font-bold">
            Nos Produits
          </h1>
          <p className="text-lg text-muted-foreground max-w-2xl mx-auto">
            Explorez notre sélection de cafés et pâtisseries artisanales
          </p>
        </div>

        <div className="flex justify-center gap-2 flex-wrap">
          <Button
            variant={filter === "all" ? "default" : "outline"}
            onClick={() => setFilter("all")}
            data-testid="button-filter-all"
          >
            Tous
          </Button>
          <Button
            variant={filter === "coffee" ? "default" : "outline"}
            onClick={() => setFilter("coffee")}
            data-testid="button-filter-coffee"
          >
            Cafés
          </Button>
          <Button
            variant={filter === "pastry" ? "default" : "outline"}
            onClick={() => setFilter("pastry")}
            data-testid="button-filter-pastry"
          >
            Pâtisseries
          </Button>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {filteredProducts.map((product) => (
            <ProductCard key={product.id} product={product} />
          ))}
        </div>

        {filteredProducts.length === 0 && (
          <div className="text-center py-12">
            <p className="text-muted-foreground">Aucun produit trouvé</p>
          </div>
        )}
      </div>
    </div>
  );
}
