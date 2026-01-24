# Security Checklist (Language-Agnostic)

Before shipping or committing security-sensitive work:
- No hardcoded secrets; use environment variables or secret stores.
- Validate all external input; apply allowlists and bounds where possible.
- Prevent injection (SQL/command/template); use safe APIs and parameterization.
- Confirm authentication and authorization match requirements.
- Avoid leaking sensitive data in errors or logs.
- Add rate limiting or abuse controls when endpoints are exposed.

If a security issue is found:
- Stop and report the issue clearly.
- Fix the critical issue before proceeding.
- Review nearby code for similar patterns.
