@echo off

:: ########################
:: Declaração de variáveis
:: ########################

set projectName=%1
set projectDir=%projectName%

:: ########################
:: Criando os diretórios
:: ########################

mkdir %projectDir%

:: ########################
:: Acessando o projeto
:: ########################

cd %projectDir%

:: ########################
:: Criando o projeto
:: ########################

REM Criando a solution
dotnet new sln --name %projectName% --output .

REM Criando a webapi
dotnet new webapi --name app --output "./app"

REM Vinculando a webapi a solution
dotnet sln add "./app/app.csproj"

REM Criando camada de configuração
dotnet new classlib --name config --output "./config"

REM Criando camada de dominio
dotnet new classlib --name domain --output "./domain"

REM Criando camada de gateway
dotnet new classlib --name gateway --output "./gateway"

REM referenciando as camadas
dotnet add "./app/app.csproj" reference "./config/config.csproj" "./domain/domain.csproj" "./gateway/gateway.csproj"
dotnet add "./domain/domain.csproj" reference "./config/config.csproj"
dotnet add "./gateway/gateway.csproj" reference "./config/config.csproj" "./domain/domain.csproj"

:: ####################################
:: Apagando arquivos desnecessários
:: ####################################

del /S ".\Class1.cs"
del /S ".\WeatherForecast.cs"
del /S ".\WeatherForecastController.cs"

:: ###############################
:: Copiando os arquivos Docker
:: ###############################

xcopy ..\Dockerfile .
xcopy ..\docker-compose.yml .
xcopy ..\".dockerignore" .

:: ########################
:: Abrindo o vscode
:: ########################

code .

REM Processo finalizado
