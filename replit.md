# Café & Délices - Artisanal Café & Pastry Showcase

## Overview

Café & Délices is a modern, responsive showcase website for a fictional artisanal café and pastry shop. Built as a portfolio demonstration project, it presents coffee and pastry products through an elegant, user-friendly interface. The application is a static site with client-side routing, form validation, and product filtering capabilities.

**Core Purpose**: Portfolio/demonstration project showcasing React development skills, responsive design, and clean code architecture.

**Tech Stack**: React + TypeScript, Vite, Tailwind CSS, shadcn/ui components, React Hook Form with Zod validation, Wouter for routing.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture

**Framework**: React 18 with TypeScript running on Vite for fast development and optimized builds.

**Routing**: Client-side routing implemented with Wouter (lightweight alternative to React Router). Routes defined in `client/src/App.tsx`:
- `/` - Home page with hero section
- `/produits` - Products catalog with filtering
- `/a-propos` - About page with company story and values  
- `/contact` - Contact form with validation

**State Management**: 
- React Hook Form for form state management
- Local component state (useState) for UI interactions like mobile menu toggle and product filtering
- No global state management needed (static showcase site)

**Component Architecture**:
- UI components from shadcn/ui library located in `client/src/components/ui/`
- Custom application components in `client/src/components/` (Navbar, Footer, ProductCard)
- Page components in `client/src/pages/`
- Reusable product data in `client/src/data/products.ts`

**Design System**:
- Tailwind CSS for utility-first styling
- Custom design tokens in `tailwind.config.ts` and `client/src/index.css`
- Typography: Playfair Display (serif) for headings, Inter (sans-serif) for body text (loaded via Google Fonts)
- Design guidelines documented in `design_guidelines.md` specifying layout patterns, spacing system, and component specifications
- Responsive breakpoints: mobile-first with md (768px) and lg (1024px) breakpoints

### Backend Architecture

**Server Setup**: Express.js server configured for development with Vite middleware and production static file serving.

**Current State**: Minimal backend implementation - server exists primarily to serve the React application. Routes file (`server/routes.ts`) is a placeholder with no API endpoints currently implemented.

**Storage Layer**: In-memory storage interface defined (`server/storage.ts`) with user CRUD methods as boilerplate. Not currently utilized by the application since it's a static showcase without backend persistence needs.

**Database**: Drizzle ORM configured for PostgreSQL (via `@neondatabase/serverless`), but no actual database schema or usage implemented. Configuration exists in `drizzle.config.ts` and schema boilerplate in `shared/schema.ts`.

### Data Layer

**Product Data**: Static product catalog defined as TypeScript array in `client/src/data/products.ts`. Contains 8 products (4 coffees, 4 pastries) with properties: id, name, category, description, price, image path.

**Form Validation**: Zod schemas defined in `shared/schema.ts` for contact form validation (name min 2 chars, valid email, message min 10 chars).

**Type Safety**: Shared TypeScript interfaces in `shared/schema.ts` for Product and ContactFormData types used across the application.

### Build and Development

**Build Process**: 
- Vite builds client React application to `dist/public`
- esbuild bundles Express server to `dist/index.js`
- Production: serves pre-built static files
- Development: Vite dev server with HMR

**Path Aliases**: TypeScript path mapping configured for clean imports:
- `@/*` → `client/src/*`
- `@shared/*` → `shared/*`
- `@assets/*` → `attached_assets/*`

## External Dependencies

### UI Component Library

**shadcn/ui**: Comprehensive collection of accessible, customizable React components built on Radix UI primitives. Configured with "new-york" style preset. Components include forms, buttons, cards, dialogs, navigation menus, and more.

**Radix UI**: Headless UI component primitives (@radix-ui/react-*) providing accessible, unstyled foundations for shadcn components.

### Styling and Design

**Tailwind CSS**: Utility-first CSS framework with custom configuration for design tokens, responsive breakpoints, and theme variables.

**class-variance-authority (CVA)**: Utility for building type-safe component variants used in shadcn/ui components.

**clsx + tailwind-merge**: Utilities for conditional className composition with proper Tailwind class merging.

### Form Management

**React Hook Form**: Form state management and validation library (@hookform/resolvers provides Zod integration).

**Zod**: TypeScript-first schema validation library used for contact form validation.

### Routing and Navigation

**Wouter**: Minimalist client-side routing library (~1.5KB) as lightweight React Router alternative.

### Icons and Visual Elements

**Lucide React**: Icon library providing Coffee, Menu, X, ArrowRight, MapPin, Phone, Mail, CheckCircle and other icons used throughout the UI.

**React Icons**: Additional icon sets (SiInstagram, SiFacebook) used in footer social links.

### Data Fetching (Configured but Unused)

**@tanstack/react-query**: Data fetching and caching library configured in the app but not actively used (no API calls in current implementation).

### Backend Dependencies (Minimal Usage)

**Express**: Web server framework serving the application.

**Drizzle ORM + @neondatabase/serverless**: PostgreSQL ORM configured but not implemented with actual schema or database operations.

**connect-pg-simple**: PostgreSQL session store (configured but unused).

### Development Tools

**Vite**: Build tool and dev server with React plugin.

**TypeScript**: Type safety across client and server code.

**@replit/vite-plugin-***: Replit-specific plugins for runtime error overlay, cartographer navigation, and dev banner (development only).

**esbuild**: JavaScript bundler used for server-side code compilation.

### Asset Management

Product images referenced from `@assets/generated_images/` directory containing PNG files for coffee and pastry products, plus hero image.