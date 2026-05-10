# sidra-pipelines: Catálogo de pipelines ETL para o SIDRA

![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square) ![Python](https://img.shields.io/badge/python-3.12+-blue.svg?style=flat-square)

**O catálogo oficial de pipelines ETL para o motor [sidra-sql](https://github.com/Quantilica/sidra-sql).**

Este repositório contém o conjunto padrão de definições (fetch + transform) para baixar, normalizar e carregar as principais pesquisas do IBGE (SIDRA) diretamente em um banco de dados PostgreSQL.

---

## Índice

- [O que é este repositório?](#o-que-é-este-repositório)
- [Pipelines Disponíveis](#pipelines-disponíveis)
  - [Contas Nacionais](#contas-nacionais)
  - [Preços](#preços)
  - [Indústria](#indústria)
  - [Comércio e Serviços](#comércio-e-serviços)
  - [Trabalho](#trabalho)
  - [Agropecuária e Florestal](#agropecuária-e-florestal)
  - [Demografia](#demografia)
- [Instalação](#instalação)
- [Como Usar](#como-usar)
- [Estrutura de uma Pipeline](#estrutura-de-uma-pipeline)
- [Desenvolvimento](#desenvolvimento)
- [Licença](#licença)

---

## O que é este repositório?

O `sidra-pipelines` funciona como um **hub de plugins** para o motor `sidra-sql`. Ele separa a lógica de execução (o motor) da declaração dos dados (os metadados das tabelas do IBGE e as queries SQL de transformação).

Ao instalar este repositório como um plugin, você ganha acesso imediato a uma série de tabelas analíticas prontas para uso em ferramentas como Power BI, Metabase ou Excel, sem precisar escrever uma única linha de código Python.

---

## Pipelines Disponíveis

O catálogo cobre **33 pipelines** distribuídas em 7 grandes temas:

### Contas Nacionais

| ID da Pipeline | Pesquisa | Tabelas SIDRA | Destino Analítico |
|---|---|---|---|
| `pib_municipal` | **PIB dos Municípios** | 5938 | `analytics.pib_municipal` |
| `contas_nacionais_anual` | **Contas Nacionais Anuais** | 6784 | `analytics.cna` |
| `contas_nacionais_trimestral` | **Contas Nacionais Trimestrais (CNT)** | 5932, 1620, 1621, 1846, 6612, 6613, 2072, 2205 | `analytics.cnt_taxas`, `cnt_indices`, `cnt_valores`, `cnt_contas_economicas`, `cnt_conta_financeira` |

### Preços

| ID da Pipeline | Pesquisa | Tabelas SIDRA | Destino Analítico |
|---|---|---|---|
| `ipca` | **IPCA** (Inflação) | 7060, 1419, etc. | `analytics.ipca` |
| `ipca15` | **IPCA-15** | 7062, 1705, etc. | `analytics.ipca15` |
| `inpc` | **INPC** | 7063, 1100, etc. | `analytics.inpc` |
| `ipp_categoria_economica` | **IPP** por Categorias Econômicas | — | `analytics.ipp_categoria_economica` |
| `ipp_cnae` | **IPP** por CNAE | — | `analytics.ipp_cnae` |
| `ipp_grupo_industrial` | **IPP** por Grupos Industriais | — | `analytics.ipp_grupo_industrial` |
| `sinapi_custo_medio` | **SINAPI** - Custo médio m² | — | `analytics.sinapi_custo_medio` |
| `sinapi_custo_projeto` | **SINAPI** - Custo de projeto | — | `analytics.sinapi_custo_projeto` |

### Indústria

| ID da Pipeline | Pesquisa | Tabelas SIDRA | Destino Analítico |
|---|---|---|---|
| `pim_pf_brasil` | **PIM-PF Brasil** - Produção Física Industrial Nacional | 8885, 8886, 8887, 8888, 8889 | `analytics.pim_pf_brasil` |
| `pim_pf_regional` | **PIM-PF Regional** - Produção Física por Região | 8888 | `analytics.pim_pf_regional` |

### Comércio e Serviços

| ID da Pipeline | Pesquisa | Tabelas SIDRA | Destino Analítico |
|---|---|---|---|
| `pmc` | **PMC** - Pesquisa Mensal do Comércio | 8190, 8757, 8880, 8881, 8882, 8883, 8884 | `analytics.pmc_agregado`, `pmc_por_atividade` |
| `pms` | **PMS** - Pesquisa Mensal de Serviços | 5906, 8163, 8688, 8693, 8694 | `analytics.pms_agregado`, `pms_por_segmento`, `pms_por_atividade` |

### Trabalho

| ID da Pipeline | Pesquisa | Tabelas SIDRA | Destino Analítico |
|---|---|---|---|
| `pnadcm` | **PNAD Contínua Mensal** - Mercado de Trabalho | 6022, 6318, 5944, 6379, 6380 | `analytics.pnadcm_populacao`, `pnadcm_pia`, `pnadcm_ocupada`, `pnadcm_rendimento`, `pnadcm_massa_rendimento` |

### Agropecuária e Florestal

| ID da Pipeline | Pesquisa | Tabelas SIDRA | Destino Analítico |
|---|---|---|---|
| `pam_lavouras_temporarias` | **PAM** (Lavouras Temporárias) | 839, 1000, etc. | `analytics.pam_lavouras_temporarias` |
| `pam_lavouras_permanentes` | **PAM** (Lavouras Permanentes) | 1613 | `analytics.pam_lavouras_permanentes` |
| `lspa` | **LSPA** - Levantamento Sistemático da Produção Agrícola | 6588 | `analytics.lspa` |
| `ppm_rebanhos` | **PPM** (Efetivos dos Rebanhos) | 73, 3939 | `analytics.ppm_rebanhos` |
| `ppm_producao` | **PPM** (Produção de Origem Animal) | 74, 3940 | `analytics.ppm_producao` |
| `ppm_exploracao` | **PPM** (Vacas Ordenhadas e Ovinos Tosquiados) | 94, 95 | `analytics.ppm_exploracao` |
| `abate` | **Abate** (Bovinos, Suínos e Frangos) | 1092, 1093, 1094 | `analytics.abate` |
| `leite` | **Pesquisa Trimestral do Leite** | 1086 | `analytics.leite` |
| `couro` | **Pesquisa Trimestral do Couro** | 1088, 1089, 1090 | `analytics.couro_adquirido`, `couro_terceiros_total`, `couro_curtido` |
| `pog` | **POG** - Galinhas Poedeiras e Ovos | 7524 | `analytics.pog` |
| `estoques` | **Pesquisa de Estoques** de Grãos | 254, 255, 259, 278, 911 | `analytics.estoques_estoque`, `estoques_capacidade_*` |
| `pevs_producao` | **PEVS** (Extração Vegetal e Silvicultura) | 289, 291 | `analytics.pevs_producao` |
| `pevs_area_florestal` | **PEVS** (Área de Florestas Plantadas) | 5930 | `analytics.pevs_area_florestal` |

### Demografia

| ID da Pipeline | Pesquisa | Tabelas SIDRA | Destino Analítico |
|---|---|---|---|
| `estimativa_populacao` | **Estimativas de População** | 6579 | `analytics.estimativa_populacao` |
| `censo_populacao` | **Censo Demográfico** | 200 | `analytics.censo_populacao` |
| `contagem_populacao` | **Contagem de População** | 305, 793 | `analytics.contagem_populacao` |
| `populacao` | **População** — união de censo, contagem e estimativas | — | `analytics.populacao` |

---

## Instalação

Para utilizar estas pipelines, você deve ter o `sidra-sql` instalado. Com ele pronto, instale este catálogo usando a CLI:

```bash
# Instala o catálogo oficial com o alias 'std'
sidra-sql plugin install https://github.com/Quantilica/sidra-pipelines.git --alias std
```

Para verificar se as pipelines foram registradas corretamente:

```bash
sidra-sql plugin list
```

---

## Como Usar

Para executar uma pipeline (baixar os dados + transformar em tabela analítica), use o comando `run`:

```bash
# Executar a pipeline de PIB Municipal
sidra-sql run std pib_municipal

# Executar a pipeline de IPCA
sidra-sql run std ipca
```

O `sidra-sql` cuidará automaticamente de:

1. Consultar os metadados da tabela no IBGE.
2. Baixar os dados em paralelo (com retry e cache).
3. Carregar os dados brutos no schema `ibge_sidra`.
4. Executar a transformação SQL e criar a tabela no schema `analytics`.

---

## Estrutura de uma Pipeline

Cada pipeline dentro deste repositório segue o padrão exigido pelo motor:

```text
id-da-pipeline/
├── fetch.toml      # Define quais tabelas, variáveis e períodos baixar
├── transform.toml  # Define o nome da tabela destino e índices
└── transform.sql   # Query SQL denormalizada para consumo final
```

- **Fetch:** Utiliza o motor de download inteligente que evita requisições duplicadas.
- **Transform:** Gera tabelas no formato wide (pivot), onde cada variável SIDRA vira uma coluna. Valores como `"..."`, `"-"` ou `"X"` são convertidos para `NULL`.

Para um guia detalhado de como criar novas pipelines, consulte o **[Guia de Criação de Pipelines](https://github.com/Quantilica/sidra-sql/blob/main/CREATING_PIPELINES.md)** no repositório principal.

---

## Desenvolvimento

```bash
git clone https://github.com/Quantilica/sidra-pipelines.git
cd sidra-pipelines
uv sync --dev
uv run pytest
```

## Licença

MIT — veja [LICENSE](LICENSE).
