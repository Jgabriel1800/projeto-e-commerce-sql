# 📊 Projeto de Análise de Vendas com MySQL e Power BI

Este projeto foi desenvolvido como parte do meu portfólio para demonstrar habilidades em **SQL (MySQL)** e **visualização de dados com Power BI**. O foco está em simular um cenário de e-commerce, criando um banco de dados relacional, realizando análises exploratórias e entregando dashboards interativos.

---

## 🧱 Estrutura do Projeto

O banco de dados é composto por 6 tabelas principais:

- `clientes`
- `pedidos`
- `itens_pedido`
- `produtos`
- `avaliacoes`
- `entregas`

Cada uma representa uma parte do processo de compra, da realização do pedido até a entrega e avaliação do cliente.

---

## 🛠️ Tecnologias Utilizadas

- **MySQL**: criação e manipulação do banco de dados.
- **Power BI**: conexão direta com o MySQL para criação de dashboards.
- **DAX / Power Query**: tratamento de dados e criação de colunas como `faixa_etaria`, `regiões`, entre outras.
- **Git e GitHub**: versionamento e publicação do projeto.

---

## ⚙️ Principais Procedures SQL

Durante o projeto, foram criadas diversas *Stored Procedures* para consolidar análises:

- `media_entrega_estado`: calcula a média de entrega por estado.
- `produtos_mais_vendidos`: lista os produtos mais vendidos.
- `categoria_mais_vendida`: soma vendas por categoria com total de valor movimentado.
- `produtos_cancelados`: analisa o total de pedidos cancelados.

---

## 📈 Análises no Power BI

No Power BI, foram criados dashboards com as seguintes informações:

- Vendas por estado e região.
- Distribuição de pedidos por status.
- Faixas etárias de clientes.
- Tempo médio de entrega.
- Avaliações dos pedidos.
- Produtos e categorias mais vendidas.

---

## 💡 Destaques Técnicos

- Uso de **subqueries** para identificar clientes acima da média de compra.
- Criação de colunas derivadas como `faixa_etaria` e `região` usando **Power Query** e **DAX**.
- Conexão bem-sucedida entre Power BI e MySQL.
- Tratamento de valores nulos (`BLANK()`) e erros de escrita com `TRIM`, `REPLACE`, `COALESCE` etc.

---

## 🧪 Como Reproduzir

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/seu-repo.git
