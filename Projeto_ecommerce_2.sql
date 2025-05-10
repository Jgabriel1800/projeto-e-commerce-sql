USE projeto;

SELECT * FROM avaliacoes;

-- Criando a coluna de classificação avaliação
ALTER TABLE avaliacoes 
ADD COLUMN  avaliacao_descritiva VARCHAR(20)
;

UPDATE avaliacoes
SET avaliacao_descritiva =
	CASE
		WHEN nota =1  THEN 'Pessimo'
		WHEN  nota=2 THEN 'Ruim'
		WHEN   nota=3 THEN 'Normal'
		WHEN  nota=4 THEN 'Bom'
		WHEN   nota=5 THEN 'Otimo'
	ELSE 'nota invalida'
	END ;
    
SELECT avaliacao_descritiva,COUNT(avaliacao_descritiva) AS contagem_categoria_avaliacao FROM avaliacoes
GROUP BY avaliacao_descritiva;
-- notamos que temos mais avaliações pessimas e logo após vem as avaliações ótimas, as menores notas são 'bom'e 'Ruim'

SELECT * FROM clientes;

SELECT sexo,COUNT(sexo) AS genero from clientes 
GROUP BY sexo;
-- TEMOS UM NÚMERO MAIOR DE HOMENS DO QUE DE MULHERES, PORÉM É UMA DIFERENÇA DE UMA PESSOA

-- VAMOS CRIAR UMA COLUNA DE FAIXA ETARIA 
 ALTER TABLE clientes
 ADD COLUMN faixa_etaria VARCHAR (10);
 
 UPDATE clientes 
 SET faixa_etaria=
	CASE 
    WHEN idade>18 AND idade<=25 THEN '18-25'
    WHEN idade>25 AND idade<=35 THEN '26-35'
    WHEN idade>35 AND idade<=45 THEN '36-45'
    WHEN idade>45 AND idade<=60 THEN '46-60'
    WHEN idade>60 THEN '60+'
    END ;
    
    SELECT faixa_etaria,COUNT(faixa_etaria) idade_faixa FROM clientes
    GROUP BY faixa_etaria;
    -- Notamos que a maioria dos nossos clientes tem entre 26 a 6o anos, não tendo nenhum cliente com 60+ e ainda temos um número muito pequeno entre os jovens de 18-25
    
SELECT estado, COUNT(estado) AS pedido_estado FROM clientes
GROUP BY estado
ORDER BY pedido_estado DESC;

-- ESTADOS COM MAIS PEDIDOS SÃO PE,RJ E RS. JÁ OS COM MENOS PEDIDOS TEMOS ESTADOS COM NENHUM PEDIDO COMO AL,AP,MG E RN
ALTER TABLE clientes
ADD column regioes VARCHAR(20);
UPDATE clientes
SET regioes = 
CASE
    WHEN estado IN ('AC', 'AP', 'AM', 'PA', 'RO', 'RR', 'TO') THEN 'Norte'
    WHEN estado IN ('AL', 'BA', 'CE', 'MA', 'PB', 'PE', 'PI', 'RN', 'SE') THEN 'Nordeste'
    WHEN estado IN ('DF', 'GO', 'MT', 'MS') THEN 'Centro-Oeste'
    WHEN estado IN ('ES', 'MG', 'RJ', 'SP') THEN 'Sudeste'
    WHEN estado IN ('PR', 'RS', 'SC') THEN 'Sul'
    ELSE 'Desconhecida'
END;

SELECT regioes,COUNT(*) AS qtd_regioes FROM clientes 
GROUP BY regioes
ORDER BY qtd_regioes DESC;
-- REGIÕES COM MAIS COMPRAS SÃO: NORDESTE, NORTE E SUL, JÁ A MENOR É A DO CENTRO-OESTE

SELECT * FROM entregas;

SELECT AVG(tempo_entrega_dias) AS tempo_medio_dias FROM entregas;
-- tempo medio entrega é de 6 dias 

-- PROCEDURE DE MEDIA DE AVALIAÇÃO POR ESTADO
DELIMITER //
CREATE PROCEDURE MediaAvaliacoesPorEstado()
BEGIN
    SELECT 
        c.estado,
        ROUND(AVG(a.nota), 2) AS media_nota
    FROM avaliacoes a
    JOIN pedidos p ON a.id_pedido = p.id_pedido
    JOIN clientes c ON p.id_cliente = c.id_cliente
    GROUP BY c.estado
    ORDER BY media_nota DESC;
END //
DELIMITER ;

CALL  MediaAvaliacoesPorEstado(); -- ESTADOS COM A MAIOR MEDIA DE AVALIAÇÃO SÃO PIAUÍ, RIO DE JANEIRO E DISTRITO FEDERAL. JÁ OS 3 PIORES SÃO ESPIRITO SANTO,PARÁ E RORAIMA


DELIMITER //

CREATE PROCEDURE media_entrega_estado()
BEGIN
    SELECT
        c.estado,
        ROUND(AVG(e.tempo_entrega_dias), 2) AS media_entrega
    FROM entregas e
    JOIN pedidos p ON e.id_pedido = p.id_pedido
    JOIN clientes c ON p.id_cliente = c.id_cliente
    GROUP BY c.estado
    ORDER BY media_entrega DESC;
END //

DELIMITER ;

CALL media_entrega_estado() -- Os 3 estados com maiores médias de entrega são Tocantins, Pará e Mato grosso. Já com menor media temos Paraná,Espirito Santo e Goiás

	


				









