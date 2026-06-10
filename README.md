# Sistec HMI Claude Code Rules

Questo repository contiene le regole e le istruzioni di codice per l'agente interno di supporto alla manutenzione del progetto Sistec HMI.

## Contenuto

- `.claude/CLAUDE.md` — project brain: persona, workflow agentico, tech stack, quick reference.
- `.claude/rules/` — linee guida specifiche per file C# e per l'architettura del progetto.
- `.claude/hooks/` — script Python eseguiti da Claude Code prima/dopo ogni tool call.
- `.claude/commands/` — slash commands personalizzati (`add-doc`).
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
- **jq** (`winget install jqlang.jq`) e un **Nerd Font** nel terminale — richiesti dalla statusline.

### Installa Graphify

[website](https://graphifylabs.ai), [github](https://github.com/safishamsi/graphify)

``` bash
winget install astral-sh.uv
uv tool install graphifyy
graphify install
```

> **Nota:** il pacchetto PyPI è `graphifyy` (doppia y, voluto — `graphify` su PyPI non è affiliato); il comando CLI resta `graphify`.

### Installare Claude Mem

[website](https://claude-mem.ai), [github](https://github.com/thedotmack/claude-mem)

``` bash
npx claude-mem install
```

> **Nota (Windows):** dalla **v13.4.1** i fix per connessione MCP, cattura degli hook e avvio del worker sono upstream — aggiornare claude-mem invece di patchare.
> Restano due problemi che si ripresentano a ogni auto-update: `node_modules` mancanti nella cache (`Cannot find module 'zod/v3'`) e flickering di `cmd.exe` a ogni hook.
> Fix: [claude-mem-patch](https://github.com/marc04AM/claude-mem-patch) — clonare la repo ed eseguire lo script (idempotente) dopo ogni auto-update:
>
> ``` powershell
> powershell -ExecutionPolicy Bypass -File <clone>\fix-claude-mem-deps.ps1
> ```
>
> Opzionale: hook di avvio in `~/.claude/settings.json` (timeout 180 s) per eseguirlo automaticamente — istruzioni nella repo della patch.

### Installare OpenSpec

[website](https://openspec.dev), [github](https://github.com/Fission-AI/OpenSpec/)

``` bash
npm install -g @fission-ai/openspec@latest
cd your-project
openspec init
```

### Importare regole aziendali nel progetto

Copia la cartella `.claude` nella root del progetto Sistec.

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
