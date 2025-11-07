export default function Privacy() {
  return (
    <div className="min-h-screen py-16 px-6">
      <div className="max-w-3xl mx-auto space-y-8">
        <h1 className="font-serif text-4xl font-bold mb-6">Politique de Confidentialité</h1>
        <p className="text-muted-foreground text-lg">
          Cette page explique comment Café & Délices collecte, utilise et protège vos données personnelles conformément à la réglementation en vigueur.
        </p>
        <h2 className="font-serif text-2xl font-semibold mt-8 mb-4">Données collectées</h2>
        <ul className="list-disc pl-6 space-y-2">
          <li>Nom, email et message via le formulaire de contact</li>
          <li>Cookies de navigation pour améliorer l'expérience utilisateur</li>
        </ul>
        <h2 className="font-serif text-2xl font-semibold mt-8 mb-4">Utilisation des données</h2>
        <p className="text-muted-foreground">
          Les données collectées sont utilisées uniquement pour répondre à vos demandes et améliorer le site. Elles ne sont jamais revendues à des tiers.
        </p>
        <h2 className="font-serif text-2xl font-semibold mt-8 mb-4">Vos droits</h2>
        <p className="text-muted-foreground">
          Vous pouvez demander la modification ou la suppression de vos données à tout moment en nous contactant à l'adresse : contact@cafedelices.fr
        </p>
      </div>
    </div>
  );
}
