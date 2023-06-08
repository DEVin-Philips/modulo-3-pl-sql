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

--FORALL Example

--Bloco 1 para criar a tabela

CREATE TABLE Exemplo2 (Nome VARCHAR2(100));

--Bloco 2 para executar

DECLARE 
    TYPE string_array IS TABLE OF VARCHAR2(100);
    nomes string_array := string_array('NOME UM', 'NOME DOIS', 'NOME TRES');
BEGIN
    FORALL contador IN 1..nomes.COUNT
        INSERT INTO Exemplo2(Nome) VALUES(nomes(contador));
    DBMS_OUTPUT.put_line('Registro(s) Inserido(s) ' || nomes.COUNT);
    COMMIT;
END;

-- EXIT

BEGIN
    FOR contador IN 1..100 LOOP
        DBMS_OUTPUT.put_line('Imprimir o conador ' || contador);
        
        IF contador = 50 THEN
            DBMS_OUTPUT.put_line('Sair ao chegar ao numero ' || contador);
            EXIT;
        END IF;
    END LOOP;
END;

-- Aula 3

-- GOTO 

BEGIN
    FOR contador IN 1..100 LOOP
        DBMS_OUTPUT.put_line('Imprimir o contador ' || contador);
        
        IF contador = 3 THEN
            DBMS_OUTPUT.put_line('Sair ao chegar ao numero ' || contador);
            GOTO mensagem_teste_sem_if;
            
            DBMS_OUTPUT.put_line('Pulou essa linha');
            
            <<mensagem_teste_sem_if>>
            DBMS_OUTPUT.put_line('Contador nao passou pelo IF ' || contador);
            
            GOTO mensagem_teste;
        END IF;
    END LOOP;
    
    <<mensagem_teste>>
    DBMS_OUTPUT.put_line('For chegou no número 3 e chamou o GOTO mensagem_teste');
    
END;

-- WHILE

DECLARE 
    contador NUMBER := 0;
BEGIN
    WHILE contador = 0 LOOP
        DBMS_OUTPUT.put_line('Imprimir o contador ' || contador);
        contador := contador + 2;
    END LOOP;    
END;

-- Emulando o REPEAT LOOP

-- Utilizando IF com EXIT

DECLARE 
    contador NUMBER := 1;
BEGIN
    LOOP 
        DBMS_OUTPUT.put_line('Imprimir o contador ' || contador);
        contador := contador + 1;
        IF contador > 10 THEN
            EXIT;
        END IF;
    END LOOP;
END;


-- Utilizando EXIT WHEN 
DECLARE 
    contador NUMBER := 1;
BEGIN
    LOOP 
        DBMS_OUTPUT.put_line('Imprimir o contador ' || contador);
        contador := contador + 1;
        EXIT WHEN contador > 10;
    END LOOP;
END;

-- Exemplo mais complexo

Bloco 1

CREATE TABLE DM_ValorProdutoVendidos(IdProduto NUMBER NOT NULL, SomaValorVenda NUMBER(10, 2) NOT NULL);

Bloco 2

DECLARE 
    valorVendaSomada NUMBER(10, 2);
BEGIN
    
    DELETE FROM DM_ValorProdutoVendidos;
    
    FOR produto IN (SELECT Id FROM Produto) LOOP
        valorVendaSomada := 0;
        
        FOR produtoVendido IN (SELECT * FROM Orcamento WHERE IdProduto = produto.Id) LOOP
            valorVendaSomada := produtoVendido.ValorVenda + valorVendaSomada;
        END LOOP;
        
        IF valorVendaSomada > 0 THEN 
            INSERT INTO DM_ValorProdutoVendidos(IdProduto, SomaValorVenda) VALUES (produto.Id, valorVendaSomada);
        END IF;
    END LOOP;    
END;

-- Aula 4