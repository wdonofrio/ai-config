# Performance Guidelines (Language-Agnostic)

## Core Principles

- **Measure first**: Don't optimize without profiling. Intuition about bottlenecks is often wrong.
- **Optimize the right thing**: Focus on the hot path. 80% of time is spent in 20% of code.
- **Clarity over cleverness**: Readable code is easier to optimize later. Premature optimization obscures intent.
- **Set targets**: Define acceptable latency, throughput, and resource usage before optimizing.

## When to Optimize

### Do Optimize

- **Measured bottlenecks**: Profiling shows this code is the problem
- **User-facing latency**: Response times affecting user experience
- **Resource constraints**: Memory, CPU, or cost limits being hit
- **Scaling issues**: Performance degrades with load or data size

### Don't Optimize (Yet)

- **Theoretical concerns**: "This might be slow" without evidence
- **Micro-benchmarks**: 10μs vs 15μs rarely matters in context
- **Cold paths**: Code that runs rarely or during startup
- **Before it works**: Get it correct first, then make it fast

## Common Optimizations

### Reduce Work

- **Cache expensive computations**: Don't recalculate what hasn't changed
- **Batch operations**: One query for 100 items beats 100 queries for 1 item
- **Lazy evaluation**: Don't compute until the result is needed
- **Early termination**: Stop processing when you have the answer

### Reduce I/O

- **Minimize network calls**: Combine requests, use batch APIs
- **Reduce database queries**: N+1 queries are a common antipattern
- **Buffer I/O**: Read/write in chunks, not byte by byte
- **Use appropriate storage**: Memory > SSD > HDD > Network

### Use Appropriate Data Structures

| Operation          | Consider           |
|--------------------|-------------------|
| Frequent lookups   | Hash map/set      |
| Ordered iteration  | Sorted array/tree |
| Frequent inserts   | Linked list/tree  |
| Memory efficiency  | Arrays over maps  |

### Concurrency

- **Parallelize independent work**: Use multiple cores for CPU-bound tasks
- **Async I/O**: Don't block threads waiting for network/disk
- **Avoid contention**: Minimize shared state and locking
- **Batch and pipeline**: Process streams efficiently

## Anti-Patterns

### Premature Optimization

```
# Bad: Optimizing before measuring
# Using complex bit manipulation to save a few cycles
flags = (a << 0) | (b << 1) | (c << 2)

# Good: Clear code that can be optimized if needed
flags = {"a": a, "b": b, "c": c}
```

### Pessimization

```
# Bad: Accidentally quadratic
result = ""
for item in large_list:
  result += str(item)  # O(n²) string building

# Good: Linear
result = "".join(str(item) for item in large_list)
```

### Over-Caching

- Cache invalidation is hard; only cache what you must
- Memory usage can become a problem
- Stale data causes subtle bugs

## Measurement

### What to Measure

- **Latency**: Time to complete an operation (p50, p95, p99)
- **Throughput**: Operations per second
- **Resource usage**: CPU, memory, disk, network
- **Scalability**: How metrics change with load

### How to Measure

- **Profile in production-like conditions**: Dev environments lie
- **Use realistic data**: Empty databases are fast
- **Measure under load**: Single-user performance differs from concurrent
- **Measure over time**: Watch for degradation, memory leaks

### Tools

- **Profilers**: CPU and memory profiling for hotspots
- **Tracing**: Distributed tracing for request flow
- **Metrics**: Time series data for trends
- **Load testing**: Simulate production traffic

## Documentation

When optimizing, document:
- What was the problem (with measurements)
- What solution was chosen and why
- What trade-offs were made (memory vs speed, complexity vs performance)
- Before and after measurements
