# Design Guidelines – Café & Pâtisserie Showcase Website

## Design Approach
**Reference-Based**: Drawing inspiration from artisanal food brands (Blue Bottle Coffee, local bakery sites) with emphasis on warm, inviting atmosphere and product photography. Clean, modern aesthetic that lets the products shine.

## Typography System
**Font Families** (via Google Fonts):
- Headlines/Display: "Playfair Display" (serif, elegant) - weights 400, 600, 700
- Body/UI: "Inter" (sans-serif, clean) - weights 400, 500, 600

**Hierarchy**:
- Hero headline: text-5xl/text-6xl, Playfair Display, font-bold
- Section titles: text-3xl/text-4xl, Playfair Display, font-semibold
- Product names: text-xl, Inter, font-semibold
- Body text: text-base, Inter, font-normal
- Small text/captions: text-sm, Inter, font-medium

## Layout System
**Spacing**: Use Tailwind units of 4, 6, 8, 12, 16, 20, 24 (e.g., p-4, gap-6, mt-8, py-20)

**Containers**:
- Full-width sections: w-full with inner max-w-7xl mx-auto px-6
- Content sections: max-w-6xl mx-auto
- Forms/text content: max-w-2xl

**Grid Patterns**:
- Product cards: grid-cols-1 md:grid-cols-2 lg:grid-cols-3, gap-8
- About page (optional two-column): md:grid-cols-2, gap-12
- Contact page split: lg:grid-cols-5 (form takes col-span-3, info col-span-2)

## Component Library

### Navigation
**Desktop navbar**: Horizontal layout, max-w-7xl container, py-4, links with underline-on-hover effect
**Mobile navbar**: Hamburger menu (top-right), full-screen overlay menu when opened, smooth transitions
**Logo**: Left-aligned, Playfair Display, text-2xl font-bold

### Hero Section (Home Page)
**Layout**: Full-width, min-h-screen or h-[85vh], flex items-center justify-center
**Content overlay**: Centered text with semi-transparent backdrop-blur background for readability
**CTA Button**: Large (px-8 py-4), rounded-full, backdrop-blur-md bg-white/20 border border-white/30

### Product Cards
**Structure**: 
- Image container with aspect-square or aspect-[4/3], rounded-2xl overflow-hidden
- Content padding: p-6
- Product name, short description (2 lines), price display
- Hover state: subtle scale transform (hover:scale-105), smooth shadow increase, transition-all duration-300

### Footer
**Multi-column layout**: 
- Left: Shop name and tagline
- Center: Quick links (Produits, À propos, Contact)
- Right: Social media icons (Instagram, Facebook)
- Bottom: Copyright and legal mentions
- Padding: py-16, divided sections with gap-8

### Contact Form
**Form fields**: 
- Full-width inputs with border, rounded-lg, p-4, focus:ring-2 effect
- Textarea for message (rows-6)
- Submit button: w-full or w-auto, px-8 py-3
- Success message: Animated fade-in green banner with checkmark icon

### About Page Components
**Two-section layout**:
1. Story section: Large text block (max-w-3xl) with image on side or above
2. Values section: 3-column grid (grid-cols-1 md:grid-cols-3) with icon + title + description cards

## Animations
**Minimal, purposeful animations only**:
- Product card hover: transform scale-105, shadow elevation
- Button hover: subtle brightness/opacity change
- Page transitions: Simple fade-in on mount (optional)
- Form submit: Success message slide-down animation

## Images

**Required Images**:
1. **Hero Image**: Large, atmospheric café interior or close-up of coffee/pastries with warm lighting. Full-width background, high-quality, slightly darkened overlay for text readability
2. **Product Photos (6-8)**: Individual product shots on clean white/neutral backgrounds - coffee cups, croissants, cookies, brownies, etc. Square or 4:3 ratio, consistent lighting
3. **About Page Image**: Café storefront, barista at work, or artisan preparing pastries. Used as supporting visual for brand story
4. **Optional decorative**: Coffee bean patterns, texture overlays (subtle, low opacity)

**Image Treatment**: Rounded corners (rounded-2xl), subtle shadow on cards, consistent aspect ratios across product catalog

## Responsive Breakpoints
- Mobile (base): Single column layouts, stacked navigation, full-width cards
- Tablet (md: 768px): 2-column grids, horizontal navigation appears
- Desktop (lg: 1024px): 3-column product grids, full layouts activated

## Vertical Rhythm
- Section padding: py-16 (mobile) to py-24 (desktop)
- Component spacing: space-y-12 between major sections
- Card grids: gap-6 (mobile) to gap-8 (desktop)