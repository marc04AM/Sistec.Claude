# Sistec HMI Claude Code Rules

Questo repository contiene le regole e le istruzioni di codice per l'agente interno di supporto alla manutenzione del progetto Sistec HMI.

## Contenuto

- `.claude/rules/` — linee guida specifiche per file C# e per l'architettura del progetto.
- `.claude/settings.json` — configurazione delle autorizzazioni e dei modelli.
- `README.md` — descrizione del repository.

## Scopo

Fornire un insieme centralizzato di regole e best practice per lo sviluppo e la revisione del codice all'interno dell'ambiente Sistec HMI.

## Utilizzo

### Installa Graphyfy

[website](https://graphifylabs.ai), [github](https://github.com/safishamsi/graphify)

``` bash
winget install astral-sh.uv
uv tool install graphifyy
graphyfy install
```

### Installare Claude Mem

[website](https://claude-mem.ai), [github](https://github.com/thedotmack/claude-mem)

``` bash
npx claude-mem install
```

> **Nota (Node.js v24+):** `npm install` fallisce a causa di `tree-sitter` incompatibile con Node.js v24.
> Se dopo l'installazione `npx claude-mem start` non avvia il worker, eseguire:
>
> ``` bash
> cd "%USERPROFILE%\.claude\plugins\marketplaces\thedotmack\plugin"
> bun install
> npx claude-mem start
> ```

### Installare OpenSpec

[website](https://openspec.dev), [github](https://github.com/Fission-AI/OpenSpec/)

``` bash
npm install -g @fission-ai/openspec@latest
cd your-project
openspec init
```

### Imporare regole aziendali nel progetto

Copia la cartella `.claude` e nella root del progetto Sistec.

Esempio di struttura del progetto:

``` text
530X_AAA
├─ .claude
├─ Sistec.Core
├─ Sistec.530X
└─ ...
```
