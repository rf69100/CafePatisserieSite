import { z } from "zod";

export interface Product {
  id: string;
  name: string;
  category: "coffee" | "pastry";
  description: string;
  price: number;
  image: string;
}

export interface ContactFormData {
  name: string;
  email: string;
  message: string;
}

export const contactFormSchema = z.object({
  name: z.string().min(2, "Le nom doit contenir au moins 2 caractères"),
  email: z.string().email("Veuillez entrer une adresse email valide"),
  message: z.string().min(10, "Le message doit contenir au moins 10 caractères"),
});

export type ContactFormInput = z.infer<typeof contactFormSchema>;
