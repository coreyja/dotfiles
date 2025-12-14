---
name: rustc-self-profile
description: Profile Rust compilation using rustc self-profiling to identify slow compile times, trait resolution bottlenecks, and monomorphization issues. Use when investigating slow Rust builds.
---

# Rustc Self-Profiling

Profile Rust compilation to identify compilation bottlenecks, especially useful for finding slow trait resolution, excessive monomorphization, and LLVM backend issues.

## Prerequisites

- Rust nightly toolchain (self-profiling requires `-Z` flag)
- `measureme` tools installed: `cargo install --git https://github.com/rust-lang/measureme crox summarize`
- `duckdb` for advanced analysis

## Steps

### 1. Run Build with Self-Profiling

```bash
# Clean the target crate to get fresh profiling data
cargo +nightly clean -p <crate-name>

# Build with self-profiling enabled
RUSTFLAGS="-Zself-profile=/tmp/<project>-profile" \
  cargo +nightly build --bin <binary-name> -p <crate-name>
```

This generates `.mm_profdata` files in `/tmp/<project>-profile/`.

### 2. Generate Summary Report

```bash
# Get high-level summary of where time is spent
summarize summarize /tmp/<project>-profile/<binary>-<pid> | head -100
```

Key metrics to look for:
- **LLVM_module_codegen_emit_obj**: LLVM code generation time
- **LLVM_module_optimize**: LLVM optimization time
- **LLVM_lto_optimize**: Link-time optimization
- **items_of_instance**: Monomorphization (how many function instances)
- **codegen_select_candidate**: Trait resolution during codegen
- **type_op_prove_predicate**: Proving trait bounds
- **typeck**: Type checking
- **mir_borrowck**: Borrow checking

### 3. Convert to Chrome Profiler Format

```bash
cd /tmp/<project>-profile
crox <binary>-<pid>
```

This creates `chrome_profiler.json` (~10x larger than .mm_profdata).

### 4. Analyze with DuckDB

See the `analyze-compile-times-duckdb` skill for detailed queries.

Quick analysis:
```bash
# Top compilation activities
duckdb -c "
SELECT
    name,
    ROUND(SUM(dur) / 1000000.0, 2) as total_seconds,
    COUNT(*) as count,
    ROUND(AVG(dur) / 1000000.0, 3) as avg_seconds
FROM read_json('/tmp/<project>-profile/chrome_profiler.json')
WHERE dur IS NOT NULL
GROUP BY name
ORDER BY SUM(dur) DESC
LIMIT 30
"

# Query events (trait resolution, type checking, etc.)
duckdb -c "
SELECT
    name,
    ROUND(SUM(dur) / 1000000.0, 3) as total_seconds,
    COUNT(*) as invocations,
    ROUND(MAX(dur) / 1000000.0, 3) as max_seconds
FROM read_json('/tmp/<project>-profile/chrome_profiler.json')
WHERE dur IS NOT NULL
  AND cat = 'Query'
GROUP BY name
ORDER BY SUM(dur) DESC
LIMIT 50
"
```

## Interpreting Results

### High LLVM Backend Time (LLVM_*)
- Most time in LLVM optimization and codegen
- Consider: reducing optimization level, using `codegen-units`, or `lto = "thin"`
- Not much you can do about this besides reducing code size

### High Monomorphization (items_of_instance)
- Many generic function instantiations
- Check: number of invocations (43k+ is excessive)
- Consider: fewer generic parameters, `dyn Trait` instead of generics, or consolidating similar types

### High Trait Resolution (codegen_select_candidate, type_op_prove_predicate)
- Complex trait bounds taking time to prove
- Check: overlapping trait impls, complex where clauses
- Consider: simplifying trait bounds, splitting complex traits

### High Type Checking (typeck, mir_borrowck)
- Large functions or complex types
- Consider: splitting large functions, simplifying type signatures

## Viewing in Chrome

Open chrome://tracing and load the `chrome_profiler.json` file for visual timeline analysis.

## Notes

- Use nightly Rust (stable doesn't support `-Zself-profile`)
- Profile in dev mode first (release mode masks some issues with optimizations)
- Profile data files are large (~200MB for .mm_profdata, ~700MB for chrome_profiler.json)
- Focus on the specific binary that's slow to compile, not the entire workspace
