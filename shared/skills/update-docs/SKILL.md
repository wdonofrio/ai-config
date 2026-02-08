---
name: update-docs
description: Use when the user asks to "update documentation for my changes", "check docs for this PR", "what docs need updating", "sync docs with code", "scaffold docs for this feature", "document this feature", "review docs completeness", "add docs for this change", "what documentation is affected", or "docs impact". Provides a guided workflow for updating documentation based on code changes.
metadata:
  short-description: Documentation update workflow
---

# Documentation Update Workflow

Guides you through updating documentation based on code changes on the active branch. Designed for reviewing PRs for documentation completeness.

## Quick Start

1. **Analyze changes**: Run `git diff <base-branch>...HEAD --stat` to see what files changed
2. **Identify affected docs**: Map changed source files to documentation paths
3. **Review each doc**: Walk through updates with user confirmation
4. **Validate**: Run the project's lint/build check
5. **Commit**: Stage documentation changes

## Workflow: Analyze Code Changes

### Step 1: Get the diff

```bash
# See all changed files on this branch (replace <base-branch> with main, master, develop, etc.)
git diff <base-branch>...HEAD --stat

# See changes in specific areas (use the relevant source directory for your project)
git diff <base-branch>...HEAD -- <source-directory>/
```

### Step 2: Identify documentation-relevant changes

Changes that typically require doc updates:

- **Public API changes**: New or modified exports, function signatures, component props
- **Configuration changes**: New options, changed defaults, deprecated settings
- **Behavioral changes**: Different output, changed error messages, new side effects
- **New features**: Entirely new capabilities that users need to know about
- **Breaking changes**: Anything that requires users to change their code

Changes that typically do NOT require doc updates:

- Internal refactoring with no API change
- Test additions/fixes
- Build/CI changes
- Performance improvements with no API change

### Step 3: Map to documentation files

If the project has a code-to-docs mapping (see `references/` directory), use it to find corresponding documentation files.

Otherwise, search for existing documentation that references the changed APIs:

```bash
# Find docs mentioning a specific function or component
grep -r "functionName" docs/
```

## Workflow: Update Existing Documentation

### Step 1: Read the current documentation

Before making changes, read the existing doc to understand:

- Current structure and sections
- Formatting conventions in use
- Whether content is shared across multiple pages

### Step 2: Identify what needs updating

Common updates include:

- **New parameters/options/props**: Add to reference tables and explain usage
- **Changed behavior**: Update descriptions and examples
- **Deprecated features**: Add deprecation notices and migration guidance
- **New examples**: Add code blocks following project conventions

### Step 3: Apply updates with confirmation

For each change:

1. Show the user what you plan to change
2. Wait for confirmation before editing
3. Apply the edit
4. Move to the next change

### Step 4: Check for shared content

Some documentation systems reuse content across pages. Before editing, check if:

- The file pulls content from another source (via includes, imports, or source fields)
- Other files reference this file's content
- Edits should go in the source file, not the consumer

### Step 5: Validate changes

Run the project's documentation validation:

```bash
# Common validation commands (use whatever the project uses)
npm run lint
npm run build
```

## Workflow: Scaffold New Feature Documentation

Use this when adding documentation for entirely new features.

### Step 1: Determine the doc type

| Feature Type       | Typical Doc Type   |
| ------------------ | ------------------ |
| New component/API  | API Reference      |
| New capability     | Guide / How-to     |
| New config option  | Configuration Ref  |
| Architecture topic | Concept / Overview |

### Step 2: Create the file

- Follow the project's naming conventions (kebab-case is common)
- Place in the correct directory based on feature type
- Use existing docs as a template for structure and formatting

### Step 3: Write using project conventions

**API Reference** docs typically include:

- Brief description of what it does
- Function signature or props table
- Parameter descriptions
- Return value
- Code examples
- Error cases or edge cases

**Guide** docs typically include:

- Introduction explaining why this is useful
- Prerequisites
- Step-by-step instructions with code examples
- Next steps / related topics

### Step 4: Cross-link related documentation

- Add links to related docs (API references, guides, configuration)
- Update any index or navigation pages if needed
- Check that existing docs link to the new page where relevant

## Validation Checklist

Before committing documentation changes:

- [ ] Content accurately reflects the code change
- [ ] Commit message follows Conventional Commits (e.g., `docs: update API reference for X`)
- [ ] Code examples are correct and tested
- [ ] Formatting follows project conventions
- [ ] Related links point to valid paths
- [ ] Lint/build passes
- [ ] Changes render correctly (if preview available)

## References

If this skill is used in a project with specific doc conventions, place project-specific references in the `references/` directory:

- `references/DOC-CONVENTIONS.md` - Project-specific formatting rules
- `references/CODE-TO-DOCS-MAPPING.md` - Source code to documentation path mapping
