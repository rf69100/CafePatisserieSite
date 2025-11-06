export default function About() {
  return (
    <div className="min-h-screen py-16 px-6">
      <div className="max-w-4xl mx-auto space-y-12">
        <div className="text-center space-y-4">
          <h1 className="font-serif text-4xl md:text-5xl font-bold">
            À Propos
          </h1>
          <p className="text-lg text-muted-foreground">
            L'histoire de notre passion pour le café et la pâtisserie
          </p>
        </div>

        <div className="prose prose-lg max-w-none space-y-8">
          <div className="space-y-4">
            <h2 className="font-serif text-3xl font-semibold">Notre Histoire</h2>
            <p className="text-muted-foreground leading-relaxed">
              Fondé en 2020, Café & Délices est né d'une passion commune pour l'art du café 
              et de la pâtisserie artisanale. Notre voyage a commencé dans un petit atelier 
              où nous avons perfectionné nos recettes, exploré les meilleures origines de café, 
              et créé des pâtisseries qui allient tradition et innovation.
            </p>
            <p className="text-muted-foreground leading-relaxed">
              Aujourd'hui, nous sommes fiers d'offrir à notre communauté une expérience 
              authentique, où chaque tasse de café raconte une histoire et chaque pâtisserie 
              est un moment de plaisir pur.
            </p>
          </div>

          <div className="space-y-4">
            <h2 className="font-serif text-3xl font-semibold">Nos Valeurs</h2>
            <div className="grid md:grid-cols-2 gap-6">
              <div className="space-y-2">
                <h3 className="font-serif text-xl font-semibold text-primary">Qualité</h3>
                <p className="text-muted-foreground">
                  Nous sélectionnons rigoureusement nos ingrédients et nos fournisseurs 
                  pour garantir une qualité exceptionnelle à chaque produit.
                </p>
              </div>
              <div className="space-y-2">
                <h3 className="font-serif text-xl font-semibold text-primary">Artisanat</h3>
                <p className="text-muted-foreground">
                  Chaque création est réalisée à la main avec soin et attention aux détails, 
                  dans le respect des méthodes traditionnelles.
                </p>
              </div>
              <div className="space-y-2">
                <h3 className="font-serif text-xl font-semibold text-primary">Durabilité</h3>
                <p className="text-muted-foreground">
                  Nous nous engageons à travailler de manière responsable, en privilégiant 
                  les circuits courts et les pratiques éco-responsables.
                </p>
              </div>
              <div className="space-y-2">
                <h3 className="font-serif text-xl font-semibold text-primary">Convivialité</h3>
                <p className="text-muted-foreground">
                  Nous créons un espace chaleureux où chacun se sent bienvenu, 
                  pour partager des moments de plaisir autour de bonnes saveurs.
                </p>
              </div>
            </div>
          </div>

          <div className="space-y-4">
            <h2 className="font-serif text-3xl font-semibold">Notre Mission</h2>
            <p className="text-muted-foreground leading-relaxed">
              Notre mission est simple : offrir à nos clients une expérience mémorable 
              à travers des produits d'exception. Que ce soit pour un café matinal revigorant 
              ou une pâtisserie gourmande pour accompagner votre pause, nous mettons tout 
              notre savoir-faire et notre passion au service de votre plaisir.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
