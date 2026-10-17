@echo off
chcp 65001 >nul
echo ========================================================
echo   LIVROS LIVRES (Tabatinga Le e Brinca) - Publicador
echo ========================================================
echo.

set "PATH=%PATH%;C:\Program Files\nodejs;%LOCALAPPDATA%\Programs\Git\cmd;C:\Program Files\Git\cmd;%APPDATA%\npm;C:\Program Files\GitHub CLI"

echo [1/4] Salvando alteracoes no Git local...
git add index.html netlify.toml .gitignore publicar.bat
git commit -m "Atualizacao do portal Livros Livres" 2>nul

echo.
echo [2/4] Verificando conexao com o GitHub (jovemroots-hash)...
gh auth status >nul 2>&1
if %errorlevel% neq 0 (
    echo Conectando sua conta do GitHub no navegador...
    gh auth login -h github.com -p https -w
)

git remote get-url origin >nul 2>&1
if %errorlevel% neq 0 (
    echo Criando repositorio 'livros-livres' no GitHub...
    gh repo create livros-livres --public --source=. --remote=origin --push
) else (
    echo Enviando backup para o GitHub...
    git push -u origin main
)

echo.
echo [3/4] Verificando conexao com o Netlify...
if not exist ".netlify\state.json" (
    echo Fazendo login e vinculando ao seu site no Netlify...
    call "%APPDATA%\npm\netlify.cmd" login
    call "%APPDATA%\npm\netlify.cmd" link
)

echo.
echo [4/4] Publicando site ao vivo no Netlify...
call "%APPDATA%\npm\netlify.cmd" deploy --prod --dir="."

echo.
echo ========================================================
echo   Site atualizado com sucesso no GitHub e no Netlify!
echo ========================================================
pause
