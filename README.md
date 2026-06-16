# Sistec HMI Claude Code Rules

Questo repository contiene le regole e le istruzioni di codice per l'agente interno di supporto alla manutenzione del progetto Sistec HMI.

## Contenuto

- `.claude/CLAUDE.md` — project brain: persona, workflow agentico, tech stack, quick reference.
- `.claude/rules/` — linee guida specifiche per file C# e per l'architettura del progetto.
- `.claude/hooks/` — script Python eseguiti da Claude Code a inizio sessione e prima/dopo le tool call.
- `.claude/commands/` — slash commands personalizzati (`add-doc`, `archive`).
- `.claude/skills/` — skill locali (`graphify`, `openspec-*`, `karpathy-guidelines`).
- `.claude/settings.json` — configurazione permessi, modelli e hooks.
- `.claude/statusline-command.sh` — statusline personalizzata.
- `sync.ps1` — sincronizza `.claude` nei progetti già configurati.
- `README.md` — descrizione del repository.

## Scopo

Fornire un insieme centralizzato di regole e best practice per lo sviluppo e la revisione del codice all'interno dell'ambiente Sistec HMI.

## Utilizzo

### Prerequisiti

- **Git for Windows** (Git Bash) — esegue hooks e statusline.
- **Python 3** nel PATH come `python` — esegue gli script in `.claude/hooks/`.
- **Nerd Font** nel terminale — richiesti dalla statusline.

### Installa Graphify

[website](https://graphifylabs.ai), [github](https://github.com/safishamsi/graphify)

Type /graphify in your AI coding assistant and it maps your entire project — code, docs, PDFs, images, videos — into a knowledge graph you can query instead of grepping through files.

``` bash
winget install astral-sh.uv
uv tool install graphifyy
graphify install
```

### Installare Claude Mem

[website](https://claude-mem.ai), [github](https://github.com/thedotmack/claude-mem)

Claude-Mem seamlessly preserves context across sessions by automatically capturing tool usage observations, generating semantic summaries, and making them available to future sessions. This enables Claude to maintain continuity of knowledge about projects even after sessions end or reconnect.

``` bash
npx claude-mem install
```

### Installare OpenSpec

[website](https://openspec.dev), [github](https://github.com/Fission-AI/OpenSpec/)

A Lightweight framework for SPEC-DRIVEN development

``` bash
npm install -g @fission-ai/openspec@latest
cd your-project
openspec init
```

### Installare Caveman

[website](https://getcaveman.dev/), [github](https://github.com/JuliusBrussee/caveman/tree/main)

A Claude Code skill/plugin that makes agent talk like caveman — cuts ~75% of output tokens, keeps full technical accuracy. Brain still big. Mouth small.

``` bash
# Windows (PowerShell 5.1+)
irm https://raw.githubusercontent.com/JuliusBrussee/caveman/main/install.ps1 | iex
```

~30 seconds. Needs Node ≥18. Skip agent you no have. Safe to re-run.
Trigger: type /caveman or say "talk like caveman". Stop with "normal mode".

### Importare regole aziendali nel progetto

Copia la cartella `.claude` nella root del progetto a cui stai lavorando.

Esempio di struttura del progetto:

``` text
530X_AAA
├─ .claude
├─ Sistec.Core
├─ Sistec.530X
└─ ...
```

### Aggiornare i progetti già configurati

Le copie di `.claude` nei progetti non si aggiornano da sole. Dopo un `git pull` di questa repo:

``` powershell
.\sync.ps1 -Target "D:\Projects\530X_AAA", "D:\Projects\530Y_BBB"
```

`robocopy` in mirror: esclude `settings.local.json` e `claude-archive/` per non toccare lo stato locale del progetto.
