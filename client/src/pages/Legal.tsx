export default function Legal() {
  return (
    <div className="min-h-screen py-16 px-6">
      <div className="max-w-3xl mx-auto space-y-8">
        <h1 className="font-serif text-4xl font-bold mb-6">Mentions Légales</h1>
        <p className="text-muted-foreground text-lg">
          Ce site est édité par Café & Délices. Toutes les informations légales concernant l'entreprise, l'hébergement, la propriété intellectuelle et la protection des données sont disponibles sur cette page.
        </p>
        <ul className="list-disc pl-6 space-y-2">
          <li>Éditeur : Café & Délices</li>
          <li>Adresse : 123 Rue du Café, 75001 Paris, France</li>
          <li>Contact : contact@cafedelices.fr</li>
          <li>Hébergeur : OVH</li>
          <li>Numéro SIRET : 123 456 789 00012</li>
        </ul>
        <h2 className="font-serif text-2xl font-semibold mt-8 mb-4">Propriété intellectuelle</h2>
        <p className="text-muted-foreground">
          Tous les contenus présents sur ce site (textes, images, logos, etc.) sont la propriété exclusive de Café & Délices. Toute reproduction ou utilisation sans autorisation est interdite.
        </p>
      </div>
    </div>
  );
}
