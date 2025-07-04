# 📄 README - Teste Manual - API Cinema App

## 🎬 Sobre o Projeto

O **Cinema App** é uma aplicação de gerenciamento de cinema, permitindo cadastro de filmes, sessões, reservas e usuários. Este repositório contém o material necessário para execução de **Testes Manuais da API**.

---

## 🛠️ Tecnologias e Ferramentas Necessárias

- **Node.js** - Backend da aplicação
- **MongoDB** - Banco de dados utilizado
- **Postman** - Ferramenta para execução dos testes manuais
- **Swagger** - Documentação dos endpoints da API

---

## 📋 Pré-requisitos

Antes de iniciar, você precisa ter instalado e configurado:

✔ Node.js  
✔ MongoDB (local ou acesso a um banco remoto)  
✔ Postman  

---

## ⚙️ Configuração do Ambiente

### 1. Suba a API seguindo os passos descritos no repositório oficial:

[https://github.com/juniorschmitz/cinema-challenge-back](https://github.com/juniorschmitz/cinema-challenge-back)

---

## 🧩 Configuração do Postman

1. Importe os arquivos fornecidos:

✔ Coleção de testes: `API Cinema App.postman_collection.json`  
✔ Ambiente: `Cinema app.postman_environment.json`  

2. No ambiente do Postman, configure a variável:

```plaintext
baseUrl = http://localhost:3000/api/v1
```

---

## ▶️ Executando os Testes Manuais

- Abra o Postman
- Selecione o ambiente correto
- Execute as requisições conforme os cenários da coleção



---

## 📁 Documentação Complementar

- **Plano de Testes Completo:** `Plano de Testes – API Cinema App.pdf`  
- **Documentação Swagger:** [http://localhost:3000/api/v1/docs/](http://localhost:3000/api/v1/docs/)  
- **Repositório Backend:** [https://github.com/juniorschmitz/cinema-challenge-back](https://github.com/juniorschmitz/cinema-challenge-back)  

---

## ⚠️ Observações Importantes

- Os testes descritos neste material são exclusivamente **manuais**, executados via Postman.
- Este repositório não contempla testes automatizados.
- Certifique-se que o banco de dados MongoDB está ativo e acessível.
- Em caso de dúvidas, procure o responsável técnico pelo projeto.