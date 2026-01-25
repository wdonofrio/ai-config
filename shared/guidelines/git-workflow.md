# Git Workflow Guidelines

## Commit Messages

Follow the [Conventional Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/) specification.

### Format

```
type(scope): subject

body (optional)

footer (optional)
```

### Types

| Type       | Purpose                                      |
|------------|----------------------------------------------|
| `feat`     | New feature for users                        |
| `fix`      | Bug fix for users                            |
| `docs`     | Documentation only changes                   |
| `style`    | Formatting, missing semicolons (no code change) |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `perf`     | Performance improvement                      |
| `test`     | Adding or correcting tests                   |
| `chore`    | Maintenance tasks, dependency updates        |
| `ci`       | CI/CD configuration changes                  |
| `build`    | Build system or external dependency changes  |
| `revert`   | Reverts a previous commit                    |

### Subject Line

- Use imperative mood: "add feature" not "added feature" or "adds feature"
- Don't capitalize the first letter
- No period at the end
- Keep under 50 characters

### Breaking Changes

- Add `!` after type/scope: `feat(api)!: change response format`
- Add `BREAKING CHANGE:` in the footer with migration instructions

## Branching

### Branch Naming

```
type/brief-description
```

Examples:
- `feat/user-authentication`
- `fix/login-timeout`
- `refactor/database-queries`

### Branch Hygiene

- Keep branches short-lived
- Rebase on main before merging (or use merge commits per project convention)
- Delete branches after merging

## Before Pushing

1. **Review your changes**: `git diff` against the base branch
2. **Run related tests**: At minimum, tests for changed code
3. **Check for unintended changes**: Debug code, console logs, commented code
4. **Verify commit history**: Clean, logical commits that tell a story

## Pull Requests

### PR Description

Include:
- **What**: Brief summary of changes
- **Why**: Context and motivation
- **How**: Approach taken (if non-obvious)
- **Testing**: How changes were verified

### PR Size

- Prefer small, focused PRs over large ones
- If a change is large, break it into reviewable chunks
- Each PR should be independently mergeable and not break the build

### Review Process

- Respond to feedback promptly
- Explain decisions when disagreeing with feedback
- Don't merge with unresolved discussions

## Handling Conflicts

1. Fetch latest from remote
2. Rebase or merge (per project convention)
3. Resolve conflicts carefully, understanding both changes
4. Run tests after conflict resolution
5. Have someone else review conflict resolution for complex merges

## Commit Hygiene

- **Atomic commits**: Each commit should be a single logical change
- **No broken commits**: Every commit should build and pass tests
- **Squash fixups**: Combine "fix typo" commits before merging
- **Don't rewrite shared history**: Only rebase/amend commits not yet pushed

## Emergency Fixes

For urgent production fixes:
1. Create a hotfix branch from production/main
2. Make minimal change to fix the issue
3. Get expedited review
4. Merge and deploy
5. Cherry-pick or merge back to development branches
