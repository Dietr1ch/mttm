---
name: web-workflow
description: Use when building web interfaces with vanilla HTML, CSS, and JavaScript (no frameworks).
---

# Web Workflow

## Structure

- `index.html` — entry point
- `style.css` — styles
- `script.js` — behavior (modular, ES module)
- `assets/` — images, fonts, etc.

## Best practices

- Semantic HTML5 (`<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<footer>`)
- CSS Grid for page layout, Flexbox for components
- CSS custom properties for theming
- ES modules (`type="module"`) for JS organization
- `fetch()` / `async` / `await` for API calls
- `localStorage` for client-side persistence

## Accessibility

- ARIA labels on interactive elements
- Keyboard navigation (`tabindex`, `onkeydown`)
- Sufficient color contrast (WCAG AA)
- `prefers-reduced-motion` for animations
