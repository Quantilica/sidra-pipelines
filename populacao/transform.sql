SELECT 'censo'      AS fonte, ano, id_municipio, n_pessoas FROM analytics.censo_populacao
UNION ALL
SELECT 'contagem'   AS fonte, ano, id_municipio, n_pessoas FROM analytics.contagem_populacao
UNION ALL
SELECT 'estimativa' AS fonte, ano, id_municipio, n_pessoas FROM analytics.estimativa_populacao
