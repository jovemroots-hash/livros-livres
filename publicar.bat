@echo off
chcp 65001 >nul
echo ========================================================
echo   LIVROS LIVRES (Tabatinga Le e Brinca) - Publicador
echo ========================================================
echo.

set "PATH=%PATH%;C:\Program Files\nodejs;C:\Program Files\Git\cmd;%LOCALAPPDATA%\Programs\Git\cmd;%APPDATA%\npm;C:\Program Files\GitHub CLI"

echo [1/3] Salvando versao no Git local...
git add index.html netlify.toml .gitignore publicar.bat
git commit -m "Atualizacao automatica do portal Livros Livres" 2>nul

echo [2/3] Sincronizando com o GitHub (jovemroots-hash)...
git push -u origin main 2>nul

echo [3/3] Enviando direto para producao no Netlify...
call npx --yes netlify-cli deploy --prod --dir="."

echo.
echo ========================================================
echo   Processo concluido!
echo ========================================================
pause
