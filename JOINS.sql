USE PETSHOP

SELECT * FROM CLIENTE
SELECT * FROM PET
SELECT * FROM PRODUTOS
SELECT * FROM VENDAS
SELECT * FROM CONTRATO








--JOINS



--CLIENTES DO SEXO M QUE POSSUEM CONTRATOS

SELECT IDCONTRATO ,C.NOME, C.CPF, C.EMAIL, C.SEXO FROM CLIENTE C
INNER JOIN CONTRATO ON C.IDCLIENTE = ID_CLIENTE
WHERE C.SEXO = 'M'


--CLIENTE QUE POSSUEM PETS NO SISTEMAS

SELECT P.IDPET, P.ESPECIE , P.GENERO, P.RACA, P.IDADE,  P.PESO_KG, C.NOME AS 'CLIENTE' 
FROM PET P
INNER JOIN CLIENTE C ON C.IDCLIENTE = P.ID_DONO



-- A VENDA MAIS CARA DO SISTEMA

SELECT V.IDVENDA, C.NOME, P.NOME, V.TOTAL 
FROM CLIENTE C
INNER JOIN VENDAS V ON C.IDCLIENTE = V.ID_CLIENTE 
INNER JOIN PRODUTOS P ON P.IDPRODUTO = V.ID_PRODUTO
GROUP BY V.IDVENDA, C.NOME, P.NOME, V.TOTAL
HAVING V.TOTAL >= (SELECT MAX(TOTAL) FROM VENDAS)




--PRODUTOS COM O ESTOQUE MAIOR QUE 50 UNIDADES 


SELECT * FROM PRODUTOS 
WHERE ESTOQUE > 50



--CONTRATO QUE POSSUE MAIOR TAXA DE CANCELAMENTO


SELECT CC.IDCONTRATO, C.NOME AS 'CLIENTE', P.ESPECIE AS 'PET', CC.DATAA_EMISSAO,
		C.EMAIL, CC.DATAA_VALIDADE, CC.TAXA, CC.DATA_CANCELAMENTO FROM CLIENTE C
INNER JOIN CONTRATO CC ON C.IDCLIENTE = CC.ID_CLIENTE
INNER JOIN PET P ON P.IDPET = CC.ID_PET
GROUP BY CC.IDCONTRATO, C.NOME , P.ESPECIE, CC.DATAA_EMISSAO,
		C.EMAIL, CC.DATAA_VALIDADE, CC.TAXA, CC.DATA_CANCELAMENTO

HAVING TAXA >= (SELECT MAX(TAXA) FROM CONTRATO)


-- PESSOAS QUE POSSUEM + 40 ANOS E TEM VENDAS EM SEU NOME


SELECT V.IDVENDA, P.NOME as 'PRODUTO',  C.NOME AS 'CLIENTE', C.CPF, C.EMAIL, C.NASCIMENTO, V.DATAA_VENDA, V.TOTAL, 
V.QUANTIDADE FROM CLIENTE C
INNER JOIN VENDAS V ON C.IDCLIENTE  = V.ID_CLIENTE
INNER JOIN PRODUTOS P ON P.IDPRODUTO = V.ID_PRODUTO
WHERE YEAR(C.NASCIMENTO) <= YEAR(GETDATE()) - 40



-- PESSOAS QUE POSSUEM A DATA DE CANCELAMENTO MENOR QUE A DATA DE VALIDADE



SELECT CC.IDCONTRATO, C.NOME, P.ESPECIE, CC.DATAA_EMISSAO, C.EMAIL, CC.DATAA_VALIDADE,
	   CC.TAXA, CC.DATA_CANCELAMENTO FROM CLIENTE C

	  INNER JOIN CONTRATO CC ON C.IDCLIENTE = CC.ID_CLIENTE
	  INNER JOIN PET P ON P.IDPET = CC.ID_PET
	  WHERE CC.DATAA_VALIDADE > CC.DATA_CANCELAMENTO



-- CLIENTE MAIS VELHO DO SISTEMA


SELECT * FROM CLIENTE
WHERE YEAR(nascimento) = (SELECT MIN(YEAR(nascimento)) FROM CLIENTE




--PETS QUE POSSUEM DONO E EST�O EM CONTRATO


SELECT DISTINCT P.IDPET, P.ESPECIE, P.GENERO, P.RACA, P.IDADE, P.PESO_KG, C.NOME AS 'DONO', CC.IDCONTRATO
FROM PET P 
INNER JOIN
CLIENTE C
ON C.IDCLIENTE = P.ID_DONO 
INNER JOIN 
CONTRATO CC
ON
P.IDPET = CC.ID_PET



--PETS QUE POSSUEM DONO E N�O POSSUEM CONTRATO


SELECT DISTINCT P.IDPET, P.ESPECIE, P.GENERO, P.RACA, P.IDADE, P.PESO_KG, C.NOME AS 'DONO', CC.IDCONTRATO
FROM PET P 
INNER JOIN
CLIENTE C
ON C.IDCLIENTE = P.ID_DONO 
LEFT JOIN 
CONTRATO CC
ON
P.IDPET = CC.ID_PET
WHERE IDCONTRATO IS NULL
