# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a static website project called "oblique.computer" that presents software development strategies inspired by Brian Eno's Oblique Strategies. The site contains a collection of aphorisms and wisdom for software development practices.

## Build System

The project uses a custom bash-based build system:

- **Build command**: `./build.sh`
- **Source directory**: `content/` - Contains HTML fragments for individual pages
- **Output directory**: `build/` - Generated complete HTML files with boilerplate

The build process:
1. Creates `build/` directory if it doesn't exist
2. Processes all files in `content/` 
3. Wraps content fragments with HTML boilerplate (DOCTYPE, head, body)
4. Adds navigation (back links for non-index pages)
5. Generates complete HTML files in appropriate subdirectories

## Architecture

```
content/
├── index.html              # Main page content fragment
└── strategies/
    ├── index.html          # Strategies listing page
    ├── kill-a-dependency.html
    └── same.html
```

- Content files contain only the inner HTML (no DOCTYPE, head, or body tags)
- The build script wraps each content fragment with standard HTML boilerplate
- Page titles are derived from filenames
- Navigation is automatically generated (back links for sub-pages)

## Content Structure

- Main page introduces the concept
- Strategies section contains individual software development strategies
- Each strategy includes references and links to related resources
- Content follows the stylistic approach of the original Oblique Strategies

## Development Workflow

To make changes:
1. Edit HTML fragments in `content/` directory
2. Run `./build.sh` to regenerate the site
3. Check output in `build/` directory

The project has no package.json, dependencies, or test framework - it's a simple static site generator built with bash.