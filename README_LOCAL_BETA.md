# nbmultirag-local-beta

Struttura locale per test su Windows 11 + Python 3.12, orientata a:
- avvio pulito in venv
- estrazione entita finanziarie da testo/CSV/XLSX
- link analysis base per accertamenti bancari
- supporto directory `soggetto/istituto/file`
- supporto dedicato ad American Express
- export CSV per Gephi

## Struttura directory prevista

```text
Caso_001/
├─ Rossi Mario/
│  ├─ American Express/
│  │  ├─ estratto_2025_01.xlsx
│  │  └─ estratto_2025_02.xlsx
│  └─ Intesa Sanpaolo/
│     └─ movimenti.xlsx
└─ Bianchi Luca/
   └─ American Express/
      └─ estratto_2025_03.xlsx
```

## Intestazione riconosciuta per American Express

- `CARTA DI CREDITO AMERICAN EXPRESS`
- `NOME TITOLARE DI CARTA`
- `DATA CONTABILIZZAZIONE SPESA`
- `INSEGNA ESERCIZIO`
- `IMPORTO IN EURO`
- `DATA TRANSAZIONE`

Quando queste colonne sono presenti, il parser normalizza automaticamente i campi in:
- `amex_card`
- `cardholder_name`
- `posting_date`
- `merchant_name`
- `amount_eur`
- `transaction_date`

## Avvio rapido su Windows 11

```bat
python -m venv .venv
.venv\Scripts\activate
python -m pip install --upgrade pip
pip install -r requirements-windows-py312.txt
python -m streamlit run app/streamlit_app.py
```

## Funzioni incluse in questa beta locale

- Upload multiplo di file `.txt`, `.csv`, `.xlsx`, `.pdf`
- Analisi ricorsiva di una directory locale del caso
- Estrazione deterministica di:
  - IBAN
  - BIC/SWIFT
  - email
  - telefoni
  - codici fiscali
  - partite IVA
  - importi
  - date
- Riconoscimento righe American Express e costruzione relazioni:
  - soggetto -> documento
  - documento -> istituto
  - documento -> operazione
  - soggetto -> operazione
  - operazione -> merchant
  - operazione -> payment_card
  - soggetto -> merchant
  - soggetto -> payment_card
- Creazione di `nodes.csv` e `edges.csv`
- Export in `exports/<timestamp>/`

## Note

- Il parser PDF in questa beta prova prima l'estrazione testo con PyMuPDF.
- La validazione IBAN e BIC e fatta con funzioni locali.
- La link analysis e semplice ma gia utile per Gephi.
- Per American Express, il nome directory dell'istituto puo essere esattamente `American Express`.
