# ManipulacaoDados
Manipulação de dados e persistência em base de dados relacional. O aplicativo tem o objetivo de realizar tratamento de arquivos textos, para transformar em arquivo.csv.

1. [Instalação](#1-instalação)
2. [Uso](#2-Uso)
3. [Operação](#3-Operação)

## 1. Instalação

1. Faça o chekout da pasta projetos;
2. Vai conter o aplicativo ManipulacaoETL.exe, somente execute e seguir os demais procedimentos dos itens abaixo;

## 2. Uso

1. Necessário conter um arquivo texto sua base de dados "base_teste.txt";
2. Iremos carregar esse arquivo para o aplicativo;

## 3. Operação

## Script ETL 
Clique em "Script ETL" e aguarde o aplicativo a realizar: 
>> Carregamento de dados;
> Validação de CPF e CNPJ;
> Tratamento para geração de script via SQL para importação de dados via comando StructSQL; 

## Após carregamento
Salve seu arquivo tratado em seu diretório, para poder levar o script ao banco de dados relacional Postgres.

## Coisas a fazer

- [x] Validação de CPF
- [x] Validação de CNPJ
- [x] Tratamento de ETL
- [x] Gerador de scrip para insert
- [ ] Criar parâmetros para deixar dinâmico as posições de campos

## Banco de dados
Estou disponibilizando uma base em Postgres com dados importados. Link para instalação do PGAdmin caso você não tenha: https://www.postgresql.org/download/

## License
This project code is in the public domain.
