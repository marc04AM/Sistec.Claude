---
paths:
  - "**/*.cs"
  - "**/*.csproj"
  - "**/*.sln"
---

## Essential Commands & Workflow

Always use these exact commands from the solution root (`/`) via the Visual Studio Integrated Terminal.

| Task | Command |
|------|---------|
| Build | `dotnet build SolutionName.sln` |
| Unit Tests | `dotnet test tests/UnitTests/UnitTests.csproj` |
| Integration Tests | `dotnet test tests/IntegrationTests/IntegrationTests.csproj` |
| Code Formatting | `dotnet format SolutionName.sln` |
| Add Migration | `dotnet ef migrations add <Name> --project src/Infrastructure --startup-project src/Api` |
| Update DB | `dotnet ef database update --project src/Infrastructure --startup-project src/Api` |

**Workflow Rule:** If you modify `src/Domain` or `src/Application`, you MUST run `dotnet test` before declaring the task complete.

---

## Team Guides & References
- **Diff Reviews:** Claude Code stages changes. Human engineers must use Visual Studio's Git Changes window to manually review diffs before committing.
- **Context Management:** Use `/compact` every 5-10 interactions to preserve context window limits and maintain architectural memory. Use `/clear` when switching to a completely new feature.
