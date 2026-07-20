# Modules

> This repo has no UI screens or routes, so the usual `screens/` tree doesn't apply (see ATLAS-RULES.md).
> Instead, here's every function/file that exists, documented at module level.

## `math.js`

Four pure utility functions, no side effects, no external dependencies.

| Function | Signature | What it does |
|---|---|---|
| `add` | `add(a, b)` | Returns `a + b`. |
| `multiply` | `multiply(a, b)` | Returns `a * b`. |
| `applyDiscount` | `applyDiscount(price, percent)` | Returns `price` minus `percent`% of `price`. E.g. `applyDiscount(100, 10)` → `90`. |
| `isEven` | `isEven(n)` | Returns `true` if `n` is evenly divisible by 2. |

**Tested by**: `math.test.js` (Vitest). Coverage report generated into `coverage/` (gitignored artifact, not checked in as source).

**Confidence**: HIGH, read directly from source, no ambiguity.

## `index.js`

A single demo script, not imported anywhere else:

```js
const user = { name: 'Drashti', age: 25, city: 'India' };
function sayHi(name) { return 'Hello ' + name; }
const mess = sayHi(user?.name);
console.log(mess);
```

Hardcodes a `user` object, builds a greeting string via `sayHi`, and logs it. No connection to `math.js`. Looks like a standalone syntax/optional-chaining practice snippet rather than part of a cohesive app.

**Confidence**: HIGH, read directly from source.

## Tooling (not application code, but part of what this repo "does")

- **Husky** (`.husky/pre-commit`, `.husky/pre-push`): runs lint/test gates before commits and pushes.
- **ESLint** (`eslint.config.js`): style/lint rules.
- **Prettier** (`.prettierrc.json`, `.prettierignore`): formatting.
- **GitHub Actions** (`.github/workflows/test.yml`): CI test runner, also gates PR merges into `main` via branch protection (the "🧪 Vitest Tests" required check).
