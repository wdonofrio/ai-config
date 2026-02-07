# API Design Guidelines (Language-Agnostic)

## Core Principles

- **Consistency**: Use the same patterns, naming, and conventions across all endpoints.
- **Predictability**: Clients should be able to guess how an unfamiliar endpoint works based on other endpoints.
- **Minimal surface area**: Only expose what's needed. Adding is easy; removing is a breaking change.

## Naming and Structure

- **Use nouns for resources**: `/users`, `/orders`, not `/getUsers`, `/createOrder`.
- **Use plural nouns**: `/users/123`, not `/user/123`.
- **Nest for relationships**: `/users/123/orders` for a user's orders.
- **Keep URLs shallow**: Avoid nesting deeper than two levels. Use query parameters or flat endpoints instead.
- **Use kebab-case**: `/user-profiles`, not `/userProfiles` or `/user_profiles` (for URL paths).

## HTTP Methods (for REST)

| Method   | Purpose                | Idempotent | Response          |
|----------|------------------------|------------|-------------------|
| `GET`    | Read a resource        | Yes        | 200 with body     |
| `POST`   | Create a resource      | No         | 201 with location |
| `PUT`    | Replace a resource     | Yes        | 200 with body     |
| `PATCH`  | Partial update         | No*        | 200 with body     |
| `DELETE` | Remove a resource      | Yes        | 204 no body       |

*PATCH can be made idempotent with careful design.

## Request Design

- **Accept only what you need**: Don't require fields that aren't used.
- **Validate at the boundary**: Check types, ranges, and formats before processing.
- **Use query parameters for filtering**: `GET /users?role=admin&active=true`.
- **Use request bodies for complex input**: Don't encode structured data in URLs.
- **Support pagination for lists**: Use cursor-based or offset-based pagination consistently.

## Response Design

### Success Responses

- **Return the created/updated resource**: Clients shouldn't need a follow-up GET.
- **Use consistent envelope structure**: Either always wrap or never wrap. Pick one.
- **Include pagination metadata**: Total count, next/previous cursors or page numbers.

### Error Responses

Use a consistent error format across all endpoints:

```
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Human-readable description",
    "details": [
      { "field": "email", "issue": "Invalid email format" }
    ]
  }
}
```

- **Use appropriate HTTP status codes**: Don't return 200 for errors.
- **Include machine-readable error codes**: Clients can switch on codes, not message strings.
- **Include actionable messages**: Tell the caller what to fix.
- **Don't leak internals**: No stack traces, SQL errors, or internal paths.

### Common Status Codes

| Code | Meaning               | Use for                              |
|------|-----------------------|--------------------------------------|
| 200  | OK                    | Successful read or update            |
| 201  | Created               | Successful creation                  |
| 204  | No Content            | Successful deletion                  |
| 400  | Bad Request           | Invalid input, malformed request     |
| 401  | Unauthorized          | Missing or invalid authentication    |
| 403  | Forbidden             | Authenticated but not authorized     |
| 404  | Not Found             | Resource doesn't exist               |
| 409  | Conflict              | Duplicate resource, state conflict   |
| 422  | Unprocessable Entity  | Valid syntax but semantic errors      |
| 429  | Too Many Requests     | Rate limit exceeded                  |
| 500  | Internal Server Error | Unexpected server failure            |

## Versioning

- **Version your API**: Breaking changes need a new version.
- **Use URL path versioning** (`/v1/users`) or header versioning (`Accept: application/vnd.api.v1+json`). Pick one.
- **Define what's breaking**: Removing fields, changing types, altering behavior.
- **Define what's not breaking**: Adding optional fields, adding new endpoints.
- **Deprecate before removing**: Announce deprecation, provide migration window, then remove.

## Pagination

### Cursor-Based (Preferred)

```
GET /users?cursor=abc123&limit=20

{
  "data": [...],
  "pagination": {
    "next_cursor": "def456",
    "has_more": true
  }
}
```

### Offset-Based

```
GET /users?offset=40&limit=20

{
  "data": [...],
  "pagination": {
    "total": 150,
    "offset": 40,
    "limit": 20
  }
}
```

Cursor-based is more performant for large datasets and avoids issues with concurrent inserts.

## Rate Limiting

- **Communicate limits in headers**: `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`.
- **Return 429 with retry information**: Include `Retry-After` header.
- **Apply per-client or per-key**: Not globally.

## Documentation

- **Document every endpoint**: Method, URL, parameters, request body, response body, error cases.
- **Include examples**: Real request/response pairs, not just schemas.
- **Document authentication requirements**: Per-endpoint, not just globally.
- **Keep docs in sync with code**: Stale documentation is worse than no documentation.

## Checklist for New Endpoints

- [ ] Uses correct HTTP method
- [ ] URL follows naming conventions
- [ ] Input is validated
- [ ] Error responses use consistent format
- [ ] Authentication and authorization are enforced
- [ ] Rate limiting is applied
- [ ] Response doesn't leak internal details
- [ ] Pagination is implemented for list endpoints
- [ ] Endpoint is documented with examples
