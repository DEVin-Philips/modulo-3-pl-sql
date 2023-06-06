--Aula 1

CREATE TABLE Produto(
    Id NUMBER PRIMARY KEY, 
    Descricao VARCHAR2(100) NOT NULL, 
    Valor NUMBER(10, 2) NOT NULL,
    Cadastro DATE NOT NULL
);

CREATE TABLE Orcamento(
    Id NUMBER PRIMARY KEY,
    IdProduto NUMBER,  --- TER UM RELACIONAMENTO COM PRODUTO
    ValorVenda NUMBER(10, 2) NOT NULL,
    Quantidade NUMBER NOT NULL,
    CONSTRAINT fk_orcamento_pedido FOREIGN KEY(IdProduto) REFERENCES Produto(Id)
);

-- Inserção de Produso
INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES(1, 'PRODUTO A', 10.99, TO_DATE('2023-05-01', 'YYYY-MM-DD'));
INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES(2, 'PRODUTO B', 999.10, TO_DATE('2023-06-01', 'YYYY-MM-DD'));
INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES(3, 'PRODUTO C', 642.01, TO_DATE('2023-06-05', 'YYYY-MM-DD'));

-- Produto 1
INSERT INTO Orcamento(Id, IdProduto, ValorVenda, Quantidade) VALUES(10, 1,  21.98, 2);
INSERT INTO Orcamento(Id, IdProduto, ValorVenda, Quantidade) VALUES(11, 1,  10.99, 1);
INSERT INTO Orcamento(Id, IdProduto, ValorVenda, Quantidade) VALUES(12, 1,  109.90, 10);

-- Produto 2
INSERT INTO Orcamento(Id, IdProduto, ValorVenda, Quantidade) VALUES(14, 2,  4995.50, 5);
INSERT INTO Orcamento(Id, IdProduto, ValorVenda, Quantidade) VALUES(15, 2,  -999.1, 1);

-- Consultas
SELECT * FROM Produto;
SELECT * FROM Orcamento;

-- UPDATE Coluna Negativa
UPDATE Orcamento SET ValorVenda = 999.1 WHERE id = 15;

-- INNER JOIN Tabela Produto com Orcamento
SELECT * FROM Produto INNER JOIN Orcamento ON Produto.Id = Orcamento.IdProduto;

-- LEFT JOIN Tabela Produto com Orcamento (O resultado vai trazer todos os dados da tabela produto)
SELECT * FROM Produto LEFT JOIN Orcamento ON Produto.Id = Orcamento.IdProduto;


-- Aula 2

-- Aula 3

-- Aula 4