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

-- FULL JOIN  de Exemplo
SELECT * FROM Produto FULL JOIN Orcamento ON Produto.Id = Orcamento.IdProduto;

-- Aula 2

-- Declaração de variavies no PL/SQL

DECLARE 
        numero NUMBER := 10;
        pi CONSTANT NUMBER := 3.14;
        raio NUMBER := 10;
        area NUMBER;
        texto VARCHAR2(50) := 'VALOR DA ÁREA É ';

BEGIN
    /* Bloco de Código para criar o que precisa ser feito */
    DBMS_OUTPUT.PUT_LINE('Valor ' || numero);
    area := pi * raio * raio;
    DBMS_OUTPUT.PUT_LINE(texto || area);
END;

-- IF ELSIF ELSE

DECLARE 
    numero NUMBER := 0;

BEGIN
    IF numero > 0 THEN
        DBMS_OUTPUT.PUT_LINE('O nr é maior que zero : ' || numero);
    ELSIF numero < 0 THEN
        DBMS_OUTPUT.PUT_LINE('O nr é menor que zero : ' || numero);
    ELSE
        DBMS_OUTPUT.PUT_LINE('O nr é igual a zero : ' || numero);
    END IF;
END;

-- CASE WHEN

DECLARE 
    nDiaSemana NUMBER := 6;
BEGIN
    CASE diaSemana
        WHEN 1 THEN
            DBMS_OUTPUT.PUT_LINE('DOMINGO');    
        WHEN 2 THEN
            DBMS_OUTPUT.PUT_LINE('SEGUNDA');    
        WHEN 3 THEN
            DBMS_OUTPUT.PUT_LINE('TERCA');    
        WHEN 4 THEN
            DBMS_OUTPUT.PUT_LINE('QUARTA');    
        WHEN 5 THEN
            DBMS_OUTPUT.PUT_LINE('QUINTA');    
        WHEN 6 THEN
            DBMS_OUTPUT.PUT_LINE('SEXTA');    
        WHEN 7 THEN
            DBMS_OUTPUT.PUT_LINE('SABADO');    
        ELSE
            DBMS_OUTPUT.PUT_LINE('DIA DA SEMANA INVÁLIDO');
    END CASE;
END;

-- FROM Simples

BEGIN
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE('Nr Impresso : ' || i);
    END LOOP;    
END;


-- FOR Complexo

BEGIN
    FOR i IN (SELECT Numero FROM Exemplo) LOOP
        DBMS_OUTPUT.PUT_LINE('Nr Impresso : ' || i.Numero);
    
        IF i.Numero = 2 THEN
            INSERT INTO Exemplo(Numero) VALUES(i.Numero + 1);
        END IF;
        
    END LOOP;
END;

--SELECT Numero FROM Exemplo;
--CREATE TABLE Exemplo(Numero NUMBER(1));
--SELECT Numero FROM Exemplo;
--INSERT INTO Exemplo(Numero) VALUES(9);

-- Aula 3

-- Aula 4