-- Criar tabela de clientes
CREATE TABLE clientes (
    id_cliente NVARCHAR(20) PRIMARY KEY,
    nome NVARCHAR(150),
    uf NVARCHAR(2),
    regiao NVARCHAR(20)
);

-- Criar tabela de produtos
CREATE TABLE produtos (
    referencia NVARCHAR(50) PRIMARY KEY,
    descricao NVARCHAR(150),
    marca NVARCHAR(50),
    familia NVARCHAR(50)
);

-- Criar tabela de vendas
CREATE TABLE vendas (
    id INT IDENTITY(1,1) PRIMARY KEY,
    data_emissao DATE,
    nf NVARCHAR(50),
    id_cliente NVARCHAR(20),
    referencia_produto NVARCHAR(50),
    quantidade INT,
    valor_total DECIMAL(10,2),
    desconto DECIMAL(5,2),
    vendedor NVARCHAR(100),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (referencia_produto) REFERENCES produtos(referencia)
);

-- Inserir dados em clientes
INSERT INTO clientes VALUES
('_08940134', 'NOVA TECH COMERCIO DIGITAL LTDA', 'SP', 'SUDESTE'),
('_05664312', 'ALEXSIS INFORMATICA - ME', 'RR', 'NORTE'),
('_04602789', 'DATAPLUS TECNOLOGIA S/A', 'BA', 'NORDESTE'),
('_07993973', 'TERADIGITAL COMERCIO ELETRONICO', 'ES', 'SUDESTE'),
('_22261093', 'EMC SOLUCOES EM TECNOLOGIA LTDA', 'MG', 'SUDESTE');

-- Inserir dados em produtos
INSERT INTO produtos VALUES
('503010070202', 'TECLADO USB MODELO K125 PRETO', 'MEGATECH', 'TECLADO'),
('410060270400', 'FONE BT TWS BRANCO MODELO W300', 'AURISOUND', 'FONE'),
('302020680103', 'MOUSE SEM FIO MODELO M200', 'PIXTECH', 'MOUSE'),
('401030590100', 'GABINETE MID TOWER G900 SEM FONTE', 'PIXTECH GAMING', 'GABINETE'),
('503040090101', 'KIT TECLADO+MOUSE SEM FIO MODELO KM700', 'MEGATECH', 'KIT');

-- Inserir dados em vendas
INSERT INTO vendas (data_emissao, nf, id_cliente, referencia_produto, quantidade, valor_total, desconto, vendedor) VALUES
('2024-01-09', '3 -104553', '_08940134', '503010070202', 20, 1079.96, 29, 'RAFAEL NUNES'),
('2024-01-09', '3 -104551', '_05664312', '410060270400', 30, 1570.96, 20, 'ELISA TORRES'),
('2024-01-09', '3 -104633', '_04602789', '302020680103', 105, 1868.98, 27, 'ALBERTO COSTA'),
('2024-01-09', '3 -104569', '_07993973', '401030590100', 30, 7934.93, 20, 'MARIO EMILIANO'),
('2024-01-09', '3 -104519', '_22261093', '503040090101', 50, 7661.60, 15, 'ALBERTO COSTA'),
('2024-01-10', '3 -104610', '_08940134', '410060270400', 15, 800.50, 10, 'RAFAEL NUNES'),
('2024-01-10', '3 -104611', '_05664312', '503010070202', 10, 520.00, 5, 'ELISA TORRES'),
('2024-01-11', '3 -104612', '_04602789', '401030590100', 20, 4920.00, 18, 'ALBERTO COSTA'),
('2024-01-11', '3 -104613', '_22261093', '302020680103', 40, 780.00, 12, 'MARIO EMILIANO'),
('2024-01-12', '3 -104614', '_07993973', '503040090101', 25, 3820.50, 20, 'RAFAEL NUNES');

-- Consultas de prática (adaptadas)
-- 1. Vendas com cliente e referência
/*
SELECT vendas.data_emissao, vendas.nf, clientes.nome, vendas.referencia_produto AS REF, vendas.quantidade, vendas.valor_total
FROM vendas
INNER JOIN clientes ON vendas.id_cliente = clientes.id_cliente;
*/

-- 2. Total de vendas por cliente
/*
SELECT clientes.nome AS Cliente, SUM(vendas.valor_total) AS Total
FROM clientes
INNER JOIN vendas ON clientes.id_cliente = vendas.id_cliente
GROUP BY clientes.nome
ORDER BY Total;
*/

-- 3. Total de vendas por marca
/*
SELECT produtos.marca, SUM(vendas.valor_total) AS Total
FROM produtos
INNER JOIN vendas ON produtos.referencia = vendas.referencia_produto
GROUP BY produtos.marca
ORDER BY Total DESC;
*/

-- 4. Clientes que compraram mais de 1000
/*
SELECT clientes.nome, SUM(vendas.valor_total) AS TotalVendido
FROM clientes
INNER JOIN vendas ON clientes.id_cliente = vendas.id_cliente
GROUP BY clientes.nome
HAVING SUM(vendas.valor_total) > 1000
ORDER BY TotalVendido ASC;
*/

-- 5. Top 3 produtos mais vendidos
/*
SELECT TOP 3 produtos.descricao AS Mercadoria, SUM(vendas.quantidade) AS Quantidade
FROM produtos
INNER JOIN vendas ON produtos.referencia = vendas.referencia_produto
GROUP BY produtos.descricao
ORDER BY Quantidade DESC;
*/

-- 6. Desconto médio por vendedor
/*
SELECT vendas.vendedor, AVG(vendas.desconto) AS DescontoMedio
FROM vendas
GROUP BY vendas.vendedor
ORDER BY DescontoMedio ASC;
*/

-- 7. Vendas de janeiro de 2024
/*
SELECT * 
FROM vendas
WHERE YEAR(vendas.data_emissao) = 2024 AND MONTH(vendas.data_emissao) = 1;
*/

-- 8. Faturamento por região
/*
SELECT clientes.regiao, SUM(vendas.valor_total) AS Total
FROM clientes
INNER JOIN vendas ON clientes.id_cliente = vendas.id_cliente
GROUP BY clientes.regiao
ORDER BY Total;
*/

-- 9. Produtos vendidos mais de uma vez
/*
SELECT produtos.descricao AS produto, COUNT(*) AS Contagem
FROM produtos
INNER JOIN vendas ON produtos.referencia = vendas.referencia_produto
GROUP BY produtos.descricao
HAVING COUNT(*) > 1;
*/

-- 10. Detalhe de uma nota fiscal
SELECT
   v.*,
   c.nome AS NomeCliente,
   p.descricao AS DescricaoProduto
FROM vendas AS v
INNER JOIN clientes AS c ON v.id_cliente = c.id_cliente
INNER JOIN produtos AS p ON v.referencia_produto = p.referencia
WHERE v.nf = '3 -104553';


