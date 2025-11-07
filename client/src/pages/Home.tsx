import { Link } from "wouter";
import { Button } from "@/components/ui/button";
import { ArrowRight, Coffee, Cookie, Heart } from "lucide-react";
import heroImage from "@assets/generated_images/Cozy_artisanal_café_interior_822c3d84.png";

export default function Home() {
  return (
    <div className="min-h-[calc(100vh-4rem)]">
      <section className="relative h-[85vh] flex items-center justify-center overflow-hidden">
        <div
          className="absolute inset-0 bg-cover bg-center"
          style={{
            backgroundImage: `linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(${heroImage})`,
          }}
        />
        
        <div className="relative z-10 max-w-4xl mx-auto px-6 text-center space-y-8">
          <h1 className="font-serif text-5xl md:text-6xl lg:text-7xl font-bold text-white">
            L'Art du Café & de la Pâtisserie
          </h1>
          <p className="text-xl md:text-2xl text-white/90 max-w-2xl mx-auto">
            Découvrez notre sélection de cafés artisanaux et pâtisseries fraîches, 
            préparés avec passion chaque jour
          </p>
          <Link href="/produits">
            <Button
              size="lg"
              variant="default"
              className="text-lg"
              data-testid="button-voir-produits"
            >
              Voir nos Produits
              <ArrowRight className="ml-2 h-5 w-5" />
            </Button>
          </Link>
        </div>
      </section>

      <section className="py-24 px-6">
        <div className="max-w-6xl mx-auto">
          <div className="text-center space-y-4 mb-16">
            <h2 className="font-serif text-4xl md:text-5xl font-bold">
              Pourquoi Café & Délices ?
            </h2>
            <p className="text-lg text-muted-foreground max-w-2xl mx-auto">
              Notre engagement envers la qualité et l'authenticité fait toute la différence
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div className="text-center space-y-4 p-6">
              <div className="w-16 h-16 mx-auto bg-primary/10 rounded-full flex items-center justify-center">
                <Coffee className="h-8 w-8 text-primary" />
              </div>
              <h3 className="font-serif text-2xl font-semibold">Café Premium</h3>
              <p className="text-muted-foreground">
                Grains sélectionnés avec soin, torréfiés localement pour un arôme exceptionnel
              </p>
            </div>

            <div className="text-center space-y-4 p-6">
              <div className="w-16 h-16 mx-auto bg-primary/10 rounded-full flex items-center justify-center">
                <Cookie className="h-8 w-8 text-primary" />
              </div>
              <h3 className="font-serif text-2xl font-semibold">Fait Maison</h3>
              <p className="text-muted-foreground">
                Pâtisseries préparées chaque matin avec des ingrédients de qualité
              </p>
            </div>

            <div className="text-center space-y-4 p-6">
              <div className="w-16 h-16 mx-auto bg-primary/10 rounded-full flex items-center justify-center">
                <Heart className="h-8 w-8 text-primary" />
              </div>
              <h3 className="font-serif text-2xl font-semibold">Avec Passion</h3>
              <p className="text-muted-foreground">
                Notre équipe passionnée met tout son cœur dans chaque création
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
