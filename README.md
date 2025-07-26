# oblique.computer

A static website presenting software development strategies inspired by Brian Eno's Oblique Strategies. This collection of aphorisms and wisdom provides guidance for software development practices.

## Quick Start

Build the site:
```bash
./build.sh
```

The generated site will be available in the `build/` directory.

## Project Structure

```
content/                    # Source HTML fragments
├── index.html             # Main page content
└── strategies/            # Development strategies
    ├── index.html         # Strategies listing
    ├── kill-a-dependency.html
    └── same.html

build/                     # Generated complete HTML files (created by build)
```

## How It Works

This project uses a custom bash-based build system:

1. **Content files** in `content/` contain only the inner HTML (no DOCTYPE, head, or body tags)
2. **Build script** wraps each fragment with standard HTML boilerplate
3. **Page titles** are automatically derived from filenames
4. **Navigation** is generated automatically (back links for sub-pages)

## Development

To add new content:

1. Create HTML fragments in the `content/` directory
2. Run `./build.sh` to regenerate the site
3. Check the output in the `build/` directory

No dependencies, package managers, or test frameworks required - just edit HTML and run the build script.

## Deployment

The site is automatically deployed to GitHub Pages when changes are pushed to the main branch. The GitHub Actions workflow:

1. Checks out the repository
2. Runs `./build.sh` to generate the site
3. Uploads the `build/` directory as a Pages artifact
4. Deploys to GitHub Pages

You can also trigger deployment manually from the Actions tab in the GitHub repository.

## Content Philosophy

Following the approach of the original Oblique Strategies, each strategy includes references and links to related resources, providing practical wisdom for software development challenges.