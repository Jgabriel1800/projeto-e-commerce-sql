SELECT * FROM pedidos;

ALTER TABLE pedidos
RENAME COLUMN `status` TO status_pedido;


UPDATE pedidos 
SET status_pedido='Transição'
	WHERE status_pedido='Em trÃ¢nsito';
    
    
-- Vamos analisar o prejuizo com os produtos cancelados 
DELIMITER //

CREATE PROCEDURE produtos_cancelados()
BEGIN
    SELECT 
        p.status_pedido,
        ROUND(SUM(p.valor_total),2) AS total_por_status
    FROM pedidos p
    GROUP BY p.status_pedido;
END //
DELIMITER ;

CALL produtos_cancelados(); -- TIVEMOS UM PREJUÍZO DE MAIS DE 200.000 MIL REAIS POR PRODUTOS CANCELADOS

DROP PROCEDURE produtos_cancelados;

DELIMITER //
CREATE PROCEDURE regioes_cancelamento()
BEGIN
SELECT c.regioes,p.status_pedido,ROUND(SUM(p.valor_total)) AS valor_estado_cancelado FROM pedidos p
LEFT JOIN clientes c
ON p.id_cliente=c.id_cliente
WHERE p.status_pedido='Cancelado'
GROUP BY c.regioes
ORDER BY valor_estado_cancelado  DESC;
END //
DELIMITER ;

CALL regioes_cancelamento; -- O estado com maior prejuízo de cancelamentos é o Nordeste com quase 3 vezes o número das outras regiões 


-- ANALISANDO OS CLIENTES QUE FIZERAM PEDIDOS ACIMA DA MÉDIA GERAL
SELECT 
    c.nome,
    p.id_cliente,
    COUNT(p.id_pedido) AS total_pedidos,
    ROUND(SUM(p.valor_total),2) AS total_gasto
FROM pedidos p
LEFT JOIN clientes c
    ON c.id_cliente = p.id_cliente
GROUP BY c.nome, p.id_cliente
HAVING total_gasto > (
    SELECT AVG(valor_total)

    FROM pedidos
)
ORDER BY total_pedidos DESC;

-- AJUSTANDO NOME DOS CLIENTES 
SELECT * FROM clientes;
UPDATE clientes 
SET nome ='Joao Miguel Silva'
WHERE nome='JoÃ£o Miguel Silva';

UPDATE clientes
SET nome = REPLACE(nome, 'Srta. ', '');
UPDATE clientes
SET nome = REPLACE(nome, 'Sra. ', '');
UPDATE clientes
SET nome = REPLACE(nome, 'Sr. ', '');

UPDATE clientes
SET nome = REPLACE(nome, 'Dr. ', '');

-- ESTADOS QUE TEM O TEMPO DE ENTREGA MAIOR QUE A MÉDIA 
SELECT estado,media_estado 
FROM (
    SELECT c.estado, AVG(e.tempo_entrega_dias) AS media_estado 
    FROM avaliacoes a
    JOIN pedidos p ON a.id_pedido = p.id_pedido
    JOIN clientes c ON p.id_cliente = c.id_cliente
    JOIN entregas e ON p.id_pedido = e.id_pedido
    GROUP BY c.estado
) AS medias_estado
WHERE media_estado > (
    SELECT AVG(tempo_entrega_dias)
    FROM entregas
)
ORDER BY media_estado DESC;

SELECT * FROM pedidos;
SELECT * FROM entregas;

