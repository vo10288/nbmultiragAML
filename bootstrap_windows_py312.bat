@echo off
setlocal

echo [1/5] Verifica Python...
python -c "import sys; print(sys.version)" || goto :error

echo [2/5] Creazione venv se assente...
if not exist .venv (
    python -m venv .venv || goto :error
)

echo [3/5] Attivazione venv...
call .venv\Scripts\activate || goto :error

echo [4/5] Upgrade pip...
python -m pip install --upgrade pip || goto :error

echo [5/5] Installazione dipendenze...
pip install -r requirements-windows-py312.txt || goto :error

echo.
echo Ambiente pronto.
echo Avvio con: python -m streamlit run app/streamlit_app.py
exit /b 0

:error
echo Errore durante il bootstrap.
exit /b 1
