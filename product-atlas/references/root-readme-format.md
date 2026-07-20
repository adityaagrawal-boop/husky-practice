# Root screens/README.md Format

The `screens/README.md` is the home screen + navigation tree index. Special format, different from per-screen READMEs. Template at `assets/root-readme-template.md`.

## Required sections in order

1. **Title** - "[App Name] - Navigation Tree" as H1
2. **How to navigate this folder** - reader orientation
3. **What you see when you open the app** - home screen description
4. **App navigation tree** - full link tree
5. **How the app's parts work together** - cross-screen connections at app level
6. **Who uses this app** - per-role experience overview

## Section content

### Title and intro
H1 with app name + "Navigation Tree". Brief intro saying this folder mirrors the app's navigation.

### How to navigate this folder
Tell the reader:
- This file = the app's home screen (what you see when you open the app)
- Each folder = a screen or section you can navigate to from here
- Every folder has a README.md explaining that screen

### What you see when you open the app
Describe the home/landing screen:
- Navigation menu items (list all - these match the top-level folders)
- Dashboard widgets or summary info if any
- Primary actions available from home
- Any onboarding or first-time experience

### App navigation tree
Full clickable tree. Markdown nested lists with relative links:

```markdown
- [Home screen elements described in this file]
  - [Menu Item A](./menu-item-a/README.md) - [what this section is about]
    - [Sub-screen 1](./menu-item-a/sub-screen-1/README.md) - [what's there]
    - [Sub-screen 2](./menu-item-a/sub-screen-2/README.md) - [what's there]
  - [Menu Item B](./menu-item-b/README.md) - [what this section is about]
```

Every clickable link must point to a valid path within `product-atlas/`. Every section described in 1 short phrase.

### How the app's parts work together
How different sections of the app connect. What data flows between screens. How using one part makes another more valuable. Write so a leader understands the full value of the app as a connected system.

### Who uses this app
Every user role, what they see, what they can do, how their experience differs. Pulls from OVERVIEW.md Users & Roles section but reframed for navigation context.

## Format rules

- Same writing rules as per-screen READMEs (`references/writing-rules.md`)
- No em dashes
- No technical terms in prose
- Every nav link must work (no 404s within atlas)
- Tree depth matches the actual screens/ folder depth
