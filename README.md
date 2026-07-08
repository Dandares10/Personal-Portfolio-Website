# Dani Joshua — Personal Portfolio

A single-page developer portfolio styled like a code editor: tab bar, file-explorer sidebar, line-numbered sections, and a typing hero line. No build tools, no dependencies — just one HTML file.

## Structure

```
portfolio.html   → everything: markup, styles, and script in one file
```

The page is split into five "files" you navigate via the top tabs or sidebar:

- `hero.js` — intro line and call-to-action buttons
- `about.js` — bio and tech stack
- `projects.js` — project cards
- `experience.js` — work history timeline
- `contact.js` — email and social links

## Running it locally

No install needed. Just open the file in a browser:

```
open portfolio.html
```

Or, to serve it like a real site during development:

```
python3 -m http.server 8000
```

Then visit `http://localhost:8000/portfolio.html`.

## Customizing

All content lives directly in `portfolio.html` — search for these sections and edit the text in place:

| What to change | Where |
|---|---|
| Name, tagline, résumé link | `<section id="hero">` |
| Bio and skill tags | `<section id="about">` |
| Project cards (title, description, tags, links) | `<section id="projects">` |
| Work history | `<section id="experience">` |
| Email, GitHub, LinkedIn, location | `<section id="contact">` |

Colors, fonts, and spacing are controlled by CSS custom properties at the top of the `<style>` block (`:root { ... }`) — change values there to retheme the whole page at once.

## Deploying

This is a static file, so any static host works:

- **GitHub Pages** — push to a repo, enable Pages in settings, point it at the file (rename to `index.html`)
- **Netlify / Vercel** — drag and drop the file into their deploy UI, or connect a repo
- **Any web host** — upload `portfolio.html` (renamed to `index.html`) via FTP or file manager

## License

Free to use and modify for your own portfolio.
