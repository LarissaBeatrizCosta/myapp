# 🚗 SS Automóveis App - Projeto Final 🚗

Projeto final do curso de Flutter e Dart da **Lince Tech Academy**! 🚀 Este projeto visa desenvolver um aplicativo móvel para a empresa SS Automóveis, focada em aluguel de veículos para pessoa jurídica.

## 📋 Situação Problema

Desenvolva um aplicativo móvel que permita a Saulo, proprietário da SS Automóveis, gerenciar clientes, gerentes, veículos e aluguéis, simplificando o processo de repasse de clientes aos gerentes e melhorando a rastreabilidade dos aluguéis realizados.

## ✨ Funcionalidades Principais

### 📇 Cadastrar Clientes
- **Automação:** Carregar automaticamente o gerente responsável pelo estado do cliente.
- **Integração:** Consultar dados do cliente em uma fonte de dados segura (BrasilAPI).

### 👨‍💼 Cadastrar Gerentes

### 🚗 Cadastrar Veículos
- **Integração:** Consultar dados dos veículos via API da FIPE.
- **Plugin:** Utilizar o plugin `image_picker` para cadastro de imagens.

### 📆 Gerenciar Aluguéis
- **Informações:** Cliente, data de início, data de término, número de dias, valor total a pagar.
- **Cálculo Automático:** Calcular número de dias, valor total do aluguel e comissão do gerente.
- **Relatório:** Gerar comprovante em formato PDF com todas as informações do aluguel.


## 🔗 Links Úteis

- [Protótipo no Figma](https://www.figma.com/proto/ISZrorv3DeWMUzswchy3fW/Lince?t=E2OEzZZm0hIV0bqa-1)
- [Fluxo no Miro](https://miro.com/app/board/uXjVKBOOyZY=/?share_link_id=289101564944)

## 🛠 Requisitos Técnicos

- **Framework:** Flutter
- **Navegação:** Utilizar rotas nomeadas.
- **Gerenciamento de Dados:** Utilizar `sqflite`.
- **Gerenciamento de Estados:** Utilizar `provider`.
- **Preferências:** Utilizar `shared_preferences` para:
  - Idioma da aplicação (português ou inglês)
  - Tema da aplicação (claro, escuro, automático)
- **Imagens:** Utilizar o plugin `image_picker` para cadastro de imagens.
- **Análise de Código:** Utilizar `flutter_lints` com regras do arquivo `analysis_options.yaml`.
- **PDF:** Utilizar a biblioteca `pdf` para geração de relatórios.
- **Internacionalização:** Utilizar a biblioteca `intl`.
- **Integração de APIs:**
  - **BrasilAPI:** Carregamento de dados de cliente.
  - **FipeAPI:** Carregamento de dados de veículos.
