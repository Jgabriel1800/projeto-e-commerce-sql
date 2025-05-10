SELECT * FROM produtos;
SELECT * FROM itens_pedido;

-- Ajustando o nome da categoria eletronicos 
UPDATE produtos
SET categoria='Eletronicos'
WHERE categoria ='EletrÃ´nicos';

SELECT 
    it.id_pedido,
    it.quantidade,
    p.nome_produto,
    p.preco,
    p.categoria
FROM itens_pedido it
LEFT JOIN produtos p
    ON it.id_produto = p.id_produto;
    
-- Analisando os produtos mais vendidos
DELIMITER //
CREATE PROCEDURE Produtos_mais_vendidos()
BEGIN
    SELECT 
        p.nome_produto,
        p.categoria,
        p.preco,
        SUM(it.quantidade) AS qtd_vendida
    FROM itens_pedido it
    LEFT JOIN produtos p ON it.id_produto = p.id_produto
    GROUP BY p.nome_produto, p.categoria, p.preco
    ORDER BY qtd_vendida DESC;
END //
DELIMITER ;

CALL Produtos_mais_vendidos(); -- PRODUTO MAIS VENDIDO SE CHAMA IUSTO,LABORE E QUO, O MAIS VENDIDO VENDEU 23 UNIDADES, O PRODUTO MENOS VENDIDO É O MOLLITIA COM 1 VENDA

-- ANALISANDO CATEGORIAS MAIS VENDIDAS 

DELIMITER //
CREATE PROCEDURE categoria_mais_vendida()
BEGIN
SELECT p.categoria,SUM(it.quantidade) AS qtd_categoria ,
ROUND(SUM(it.quantidade * p.preco), 2) AS valor_total_categoria
FROM itens_pedido it
LEFT JOIN produtos p 
ON it.id_produto = p.id_produto
GROUP BY  p.categoria
ORDER BY qtd_categoria  DESC;
END //
DELIMITER 


CALL categoria_mais_vendida(); -- Produtos de casa, Briinquedos e eletronicos foram os que mais geraram maior lucro, a menor categoria vendida foi produtos de beleza

