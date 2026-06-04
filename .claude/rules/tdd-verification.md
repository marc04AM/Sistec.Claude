---
paths:
  - "**/*.cs"
  - "**/*.csproj"
  - "**/*.sln"
---

## Fidelity, TDD & Verification

Companion to `tests.md` (conventions) and `workflow.md` (commands). `tests.md` says *how* to write a test; this file says *when* and *why*, and what makes a change "done".

### 1. Prompt & Data Fidelity

- The prompt and the supplied data are the immutable spec. Implement exactly what was asked — never widen, narrow, "improve", or reinterpret it.
- Never invent or alter input data, parameters, method signatures, types, or file contents. Unknown shape ⇒ read the real source (e.g. `PopLogic.cs`); never assume it.
- Every assumption, hypothesis, and plan step is proven against the prompt and the real code it touches, cited `file.cs:line`. Unverified ⇒ stop and verify before writing code.
- Counter-proof rule: for each conclusion, state what would falsify it, then confirm the real code/data does not.

### 2. Test-First Gate (Red → Green → Refactor)

Order is mandatory; production code never precedes its test.

1. **Red** — Write the failing test(s) first. They encode the prompt's exact inputs and expected outputs, plus one case per guard clause (`tests.md`). Confirm they fail for the right reason (no production code yet).
2. **Green** — Write the minimum production code that makes the locked tests pass. No extra behaviour.
3. **Refactor** — Remove duplication and restore OOP/functional/DDD shape (`csharp-idioms.md`, `design-patterns.md`) with the tests still green.

### 3. Locked-Test Contract

Tests are a contract, not scratch work.

- **DO NOT** weaken, delete, skip, comment out, or rewrite a test to make failing code pass.
- A red test means the **production code** is wrong — fix the code, re-run, repeat until green.
- A test changes only when the **prompt's requirement itself** changes; such a change is called out explicitly in the `claude-archive` note with the reason.
- Follow the tests to the letter: the asserted expected values are the target, not a suggestion.

### 4. Sandbox Spike (verify before you commit to it)

For unfamiliar APIs, risky mechanics, or non-obvious math/logic, prove the approach in a throwaway minimal example first.

- Scratch location: session outputs / a `*.Spikes` throwaway — never shipped, never committed to a production project.
- A spike answers one question ("does this OPC UA / Dapper / LINQ shape behave as I assume?"). Once answered, discard the spike and promote the verified behaviour into a real locked test in `<Project>.Tests`.
- Spikes never substitute for the real test suite; they de-risk it.

### 5. Run & Verify (definition of done)

Per `workflow.md`: `dotnet build <ProjectName>.sln` then `dotnet test <ProjectName>.Tests.csproj`.

- Execute every test. For each, compare the actual result against the **starting parameters** and the **expected output** — not just `IsSuccess`/exit code.
- On failure: fix production code (never the test), re-run, repeat until all green.
- A change is **done** only when: build clean, every locked test green, results match expectations, and no boundary violations introduced (`architecture.md`).
- Use real/in-memory DB and only the mocks allowed by `tests.md`; never mock the data layer to force a pass.
