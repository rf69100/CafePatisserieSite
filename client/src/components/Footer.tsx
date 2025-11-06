import { Coffee } from "lucide-react";
import { SiInstagram, SiFacebook } from "react-icons/si";
import { Link } from "wouter";

export function Footer() {
  return (
    <footer className="w-full border-t bg-card mt-auto">
      <div className="max-w-7xl mx-auto px-6 py-16">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-12">
          <div className="space-y-4">
            <div className="flex items-center gap-2">
              <Coffee className="h-6 w-6 text-primary" />
              <span className="font-serif text-xl font-bold">Café & Délices</span>
            </div>
            <p className="text-sm text-muted-foreground">
              Savourez l'excellence artisanale à chaque tasse et chaque bouchée
            </p>
          </div>

          <div className="space-y-4">
            <h3 className="font-semibold text-lg">Liens Rapides</h3>
            <nav className="flex flex-col gap-2">
              <Link 
                href="/produits" 
                className="text-sm text-muted-foreground hover:text-foreground transition-colors" 
                data-testid="link-footer-produits"
              >
                Produits
              </Link>
              <Link 
                href="/a-propos" 
                className="text-sm text-muted-foreground hover:text-foreground transition-colors" 
                data-testid="link-footer-apropos"
              >
                À Propos
              </Link>
              <Link 
                href="/contact" 
                className="text-sm text-muted-foreground hover:text-foreground transition-colors" 
                data-testid="link-footer-contact"
              >
                Contact
              </Link>
            </nav>
          </div>

          <div className="space-y-4">
            <h3 className="font-semibold text-lg">Suivez-nous</h3>
            <div className="flex gap-4">
              <a
                href="https://instagram.com"
                target="_blank"
                rel="noopener noreferrer"
                className="hover-elevate active-elevate-2 rounded-md p-2"
                data-testid="link-instagram"
              >
                <SiInstagram className="h-5 w-5 text-muted-foreground hover:text-foreground transition-colors" />
                <span className="sr-only">Instagram</span>
              </a>
              <a
                href="https://facebook.com"
                target="_blank"
                rel="noopener noreferrer"
                className="hover-elevate active-elevate-2 rounded-md p-2"
                data-testid="link-facebook"
              >
                <SiFacebook className="h-5 w-5 text-muted-foreground hover:text-foreground transition-colors" />
                <span className="sr-only">Facebook</span>
              </a>
            </div>
          </div>
        </div>

        <div className="mt-12 pt-8 border-t">
          <div className="flex flex-col md:flex-row justify-between items-center gap-4">
            <p className="text-sm text-muted-foreground">
              © 2024 Café & Délices. Tous droits réservés.
            </p>
            <div className="flex gap-6">
              <a href="#" className="text-sm text-muted-foreground hover:text-foreground transition-colors">
                Mentions Légales
              </a>
              <a href="#" className="text-sm text-muted-foreground hover:text-foreground transition-colors">
                Politique de Confidentialité
              </a>
            </div>
          </div>
        </div>
      </div>
    </footer>
  );
}
