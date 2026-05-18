Obiettivo

Integrare MarkItDown in una futura skill per convertire documenti (PDF, DOCX, ecc.) in Markdown.

Setup consigliato (con uv)
1. Inizializzazione progetto
uv init
2. Installazione dipendenza
uv add "markitdown[all]"

✔ scelta corretta perché:

libreria usata nel codice
dipendenze versionate
ambiente riproducibile
Uso base
CLI (test rapido)
uvx markitdown file.pdf -o file.md
Python (uso reale nella skill)
from markitdown import MarkItDown

md = MarkItDown()
result = md.convert("file.pdf")

print(result.text_content)
Wrapper consigliato (riutilizzabile nella skill)
from pathlib import Path
from markitdown import MarkItDown


def convert_to_markdown(input_path: str, output_path: str | None = None) -> str:
    md = MarkItDown()
    result = md.convert(input_path)
    text = result.text_content

    if output_path:
        Path(output_path).write_text(text, encoding="utf-8")

    return text
Struttura progetto suggerita
project/
├── pyproject.toml
├── convert.py
├── skill.md
└── examples/
Modello mentale uv
Quando usare cosa
Caso	Comando
Test veloce CLI	uvx markitdown
Script temporaneo	uv pip install markitdown
Progetto / skill	uv add markitdown
Tool globale CLI	uv tool install markitdown
Regola pratica
Uso nel codice → uv add
Uso da terminale → uvx / uv tool install
Decisione finale per la skill

✔ usare:

uv add "markitdown[all]"

❌ evitare:

uv tool install markitdown
Stato finale

Hai ora:

ambiente Python gestito con uv
libreria installata correttamente
wrapper pronto
base per costruire una skill
Prossimo step logico

Definire:

interfaccia della skill (input/output)
formati supportati
gestione errori
integrazione come tool/agent