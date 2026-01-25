# Security Guidelines (Language-Agnostic)

## Secrets and Credentials

- **No hardcoded secrets**: Never commit API keys, passwords, tokens, or certificates to source control.
- **Use environment variables**: Load secrets from environment variables or dedicated secret managers.
- **Rotate compromised secrets immediately**: If a secret is exposed, rotate it before doing anything else.

## Input Validation

- **Validate all external input**: User input, API responses, file contents, and environment variables are untrusted.
- **Use allowlists over denylists**: Define what's allowed rather than trying to block what's forbidden.
- **Enforce bounds and types**: Check lengths, ranges, and data types before processing.
- **Sanitize for output context**: Escape data appropriately for HTML, SQL, shell, URLs, etc.

## Injection Prevention

- **SQL injection**: Use parameterized queries or ORMs. Never concatenate user input into SQL.
- **Command injection**: Avoid shell execution with user input. Use safe APIs that don't invoke shells.
- **Template injection**: Use auto-escaping templating engines. Be cautious with user-controlled templates.
- **Path traversal**: Validate and canonicalize file paths. Reject paths containing `..` or absolute paths.

## Authentication and Authorization

- **Verify authentication on every request**: Don't trust session state alone.
- **Check authorization for each resource**: Verify the user can access the specific resource, not just the endpoint.
- **Use secure session management**: HTTP-only cookies, secure flags, proper expiration.
- **Implement rate limiting**: Protect authentication endpoints from brute force attacks.

## Data Protection

- **Minimize sensitive data**: Don't collect or store data you don't need.
- **Encrypt sensitive data at rest**: Use strong encryption for PII, credentials, and financial data.
- **Use TLS for data in transit**: Enforce HTTPS. Validate certificates.
- **Avoid logging sensitive data**: Never log passwords, tokens, PII, or full credit card numbers.

## Error Handling

- **Don't leak internal details**: Error messages to users should be helpful but not reveal system internals.
- **Log security events**: Record authentication failures, authorization denials, and suspicious activity.
- **Fail securely**: When in doubt, deny access. Default to the more secure option.

## Dependencies

- **Keep dependencies updated**: Regularly update to patch known vulnerabilities.
- **Audit dependencies**: Review what you're including. Prefer well-maintained, widely-used packages.
- **Pin versions**: Use lockfiles to ensure reproducible builds.

## When a Security Issue Is Found

1. **Stop and assess severity**: Determine if this is actively exploitable.
2. **Report clearly**: Document what the issue is, how it can be exploited, and potential impact.
3. **Fix the root cause**: Don't just patch the symptom.
4. **Check for similar patterns**: Review related code for the same vulnerability.
5. **Add tests**: Prevent regression with security-focused test cases.
