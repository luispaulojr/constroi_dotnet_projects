@echo off
setlocal

REM Definir o nome do projeto
set /p project_name=Digite o nome do projeto: 

REM Criar o diretório do projeto
md %project_name%
cd %project_name%

REM Inicializar o Git
git init

REM Criar a solution
dotnet new sln -n %project_name%

REM Criar o projeto da API
dotnet new webapi -n %project_name%.API

REM Adicionar o projeto da API à solution
dotnet sln add %project_name%.API\%project_name%.API.csproj

REM Criar o projeto de domínio
dotnet new classlib -n %project_name%.Domain

REM Adicionar o projeto de domínio à solution
dotnet sln add %project_name%.Domain\%project_name%.Domain.csproj

REM Adicionar pacotes NuGet aos projetos
cd %project_name%.API
dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL
dotnet add package Microsoft.EntityFrameworkCore.Tools
dotnet add package AWSSDK.SecretsManager
dotnet add package AWSSDK.CloudWatch
dotnet add package Swashbuckle.AspNetCore
cd ..

REM Voltar ao diretório raiz do projeto
cd ..

echo Template de corpo do projeto %project_name% criado com sucesso!

endlocal
