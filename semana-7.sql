--AULA 1 CURSORES
DELETE FROM Produto;
DELETE FROM Orcamento;

INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES (1, 'PRODUTO A', 17.80, TO_DATE('2022-06-04', 'YYYY-MM-DD'));
INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES (2, 'PRODUTO B', 27.80, TO_DATE('2021-07-04', 'YYYY-MM-DD'));
INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES (3, 'PRODUTO C', 79.80, TO_DATE('2021-05-04', 'YYYY-MM-DD'));
INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES (4, 'PRODUTO D', 7.80, TO_DATE('2023-05-04', 'YYYY-MM-DD'));
INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES (5, 'PRODUTO E', 15.75, TO_DATE('2020-05-05', 'YYYY-MM-DD'));
INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES (6, 'PRODUTO F', 12.30, TO_DATE('2022-11-06', 'YYYY-MM-DD'));
INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES (7, 'PRODUTO G', 8.99, TO_DATE('2023-05-07', 'YYYY-MM-DD'));
INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES (8, 'PRODUTO H', 11.50, TO_DATE('2023-05-08', 'YYYY-MM-DD'));
INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES (9, 'PRODUTO I', 6.25, TO_DATE('2023-11-09', 'YYYY-MM-DD'));
INSERT INTO Produto(Id, Descricao, Valor, Cadastro) VALUES (10, 'PRODUTO J', 14.99, TO_DATE('2023-06-10', 'YYYY-MM-DD'));

--Inserir dinamicamente na tabela orcamento
BEGIN
  FOR i IN 1..50000 LOOP
    INSERT INTO Orcamento(Id, IdProduto, ValorVenda, Quantidade)
    VALUES(i, ROUND(DBMS_RANDOM.VALUE(1, 10)), ROUND(DBMS_RANDOM.VALUE(1000, 10000), 2), ROUND(DBMS_RANDOM.VALUE(1, 100)));
  END LOOP;
  
  COMMIT;
END;


-- Query entre Produto e Orcamento
SELECT * FROM Produto INNER JOIN Orcamento ON Produto.Id = Orcamento.IdProduto;


--Exemplo Um para Cursor

DECLARE 
    v_ano NUMBER := 2020;
    CURSOR cursor_quantidade_produto IS SELECT Cadastro, Valor FROM Produto WHERE EXTRACT(YEAR FROM Cadastro) = v_ano;
    v_soma_produtos NUMBER(12, 2) := 0.00;
    v_cadastro DATE;
    v_valor DECIMAL(12, 2) := 0.00;
BEGIN
    OPEN cursor_quantidade_produto;
        LOOP
            FETCH cursor_quantidade_produto INTO v_cadastro, v_valor;
                EXIT WHEN cursor_quantidade_produto%NOTFOUND;
                    v_soma_produtos := v_soma_produtos + v_valor;
        END LOOP;
    CLOSE cursor_quantidade_produto;
    
    DBMS_OUTPUT.PUT_LINE('Ano selecionado ' || v_ano);
    DBMS_OUTPUT.PUT_LINE('Soma Total Dos Produtos ' || v_soma_produtos);
END;

-- Examplo 2 Cursor
-- Bloco 1
DECLARE
    CURSOR cursor_produto  IS SELECT Id, Valor FROM Produto;
    v_id NUMBER;
    v_valor_produto NUMBER(10, 2);
    v_idprodutoOrcamento NUMBER;
    v_valor_orcamento NUMBER (12, 2);
BEGIN
    OPEN cursor_produto;
        LOOP
            FETCH cursor_produto INTO v_id, v_valor_produto;
                EXIT WHEN cursor_produto%NOTFOUND;
                
                SELECT SUM(ValorVenda) INTO v_valor_orcamento FROM Orcamento WHERE IdProduto = v_id;
                DBMS_OUTPUT.PUT_LINE('Id Produto : '  || v_id  || ' Soma do valor orcamento ' ||  v_valor_orcamento);
        END LOOP; 
    CLOSE cursor_produto;
END;


-- Bloco 2 Para validar
SELECT SUM(ValorVenda),  COUNT(*) FROM Orcamento WHERE IdProduto = 10;

