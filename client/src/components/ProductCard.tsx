import { Product } from "@shared/schema";
import { Card } from "@/components/ui/card";

interface ProductCardProps {
  product: Product;
}

export function ProductCard({ product }: ProductCardProps) {
  return (
    <Card
      className="overflow-hidden hover-elevate transition-all duration-300 hover:scale-105"
      data-testid={`card-product-${product.id}`}
    >
      <div className="aspect-square overflow-hidden bg-muted">
        <img
          src={product.image}
          alt={product.name}
          className="w-full h-full object-cover"
        />
      </div>
      <div className="p-6 space-y-3">
        <div className="flex items-start justify-between gap-2">
          <h3 className="font-serif text-xl font-semibold" data-testid={`text-product-name-${product.id}`}>
            {product.name}
          </h3>
          <span className="font-semibold text-primary text-lg whitespace-nowrap" data-testid={`text-product-price-${product.id}`}>
            {product.price.toFixed(2)} €
          </span>
        </div>
        <p className="text-sm text-muted-foreground line-clamp-2" data-testid={`text-product-description-${product.id}`}>
          {product.description}
        </p>
      </div>
    </Card>
  );
}
