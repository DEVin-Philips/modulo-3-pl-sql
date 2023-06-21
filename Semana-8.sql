-- AULA 1
-- Criar uma soma entre dois números e devoler o resultado

CREATE OR REPLACE FUNCTION SomaNumerosSemParametros RETURN NUMBER IS 
BEGIN
    return 1 + 1;
END;

SELECT SomaNumerosSemParametros AS Soma FROM DUAL;

--
-- Passando parametros para soma dos números 

CREATE OR REPLACE FUNCTION SomaNumerosComParametros(num1 NUMBER, num2 NUMBER) RETURN NUMBER IS 
BEGIN
    return num1 + num2;
END;

SELECT SomaNumerosComParametros(1, 5) AS Soma FROM DUAL;
SELECT SomaNumerosSemParametros AS Soma, SomaNumerosComParametros(1, 5) AS Soma2  FROM DUAL;

-- Exemplo com retorno em VARCHAR
CREATE OR REPLACE FUNCTION RertonaNome(nome VARCHAR2) RETURN VARCHAR IS 
BEGIN
    return 'Olá, meu nome e ' || nome;
END;

DECLARE 
    retorno_nome VARCHAR2(100) := 'MENSAGEM NÃO RECEBIDA';
BEGIN
    retorno_nome := RertonaNome('Jamil');
    DBMS_OUTPUT.PUT_LINE(retorno_nome);    
END;

-- Retorna uma data

CREATE OR REPLACE FUNCTION ProximoAno(dataInput IN DATE) RETURN DATE IS 
BEGIN
    RETURN ADD_MONTHS(dataInput, 12);
END;

SELECT SYSDATE AS DataAtual, ProximoAno(SYSDATE) AS ProximoAno FROM DUAL;

-- Exmplo com cursor 

CREATE OR REPLACE FUNCTION ExemploCursor RETURN SYS_REFCURSOR IS 
    resultado SYS_REFCURSOR;
BEGIN
    OPEN resultado FOR SELECT Id, Descricao FROM Produto;
    RETURN resultado;
END;

DECLARE 
    funcao_ExemploCursor SYS_REFCURSOR;
    produto_Id NUMBER;
    produto_Descricao VARCHAR(200);
BEGIN
    
    funcao_exemplocursor := ExemploCursor();
    
    LOOP 
        FETCH funcao_exemplocursor INTO produto_Id, produto_Descricao;
        EXIT WHEN funcao_exemplocursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Produto ID ' || produto_Id || ' - Descricao ' || produto_Descricao);    
        
    END LOOP;
    
    CLOSE funcao_exemplocursor;
    
    DBMS_OUTPUT.PUT_LINE('FIM CURSOR');
    
END;

-- Exemplo complexo

-- Passo 1 Criar uma tabela com Data, Descricao
CREATE TABLE Feriados(Data VARCHAR(5), Descricao VARCHAR(100));

INSERT INTO Feriados (Data, Descricao) VALUES ('01/01', 'Ano Novo');
INSERT INTO Feriados (Data, Descricao) VALUES ('21/04', 'Tiradentes');
INSERT INTO Feriados (Data, Descricao) VALUES ('01/05', 'Dia do Trabalho');
INSERT INTO Feriados (Data, Descricao) VALUES ('07/09', 'Independência do Brasil');
INSERT INTO Feriados (Data, Descricao) VALUES ('12/10', 'Dia de Nossa Senhora Aparecida');
INSERT INTO Feriados (Data, Descricao) VALUES ('02/11', 'Finados');
INSERT INTO Feriados (Data, Descricao) VALUES ('15/11', 'Proclamação da República');
INSERT INTO Feriados (Data, Descricao) VALUES ('25/12', 'Natal');


-- Passo 2 criar a função

CREATE OR REPLACE FUNCTION RecarcularPrecoProduto(idProduto NUMBER, aplicarReajuste NUMBER, dataExemplo DATE) RETURN NUMBER 
IS
    ExisteFeriado NUMBER;
BEGIN
    
    SELECT COUNT(*) INTO ExisteFeriado FROM Feriados WHERE Data = TO_CHAR(dataExemplo, 'dd/MM');
    
    FOR produto IN (SELECT Valor FROM Produto WHERE ID = idProduto) LOOP
        IF ExisteFeriado > 0 THEN
            DBMS_OUTPUT.PUT_LINE('TEM QUE CALCULAR 15%');
            RETURN produto.Valor + (produto.Valor * 0.15);
        ELSE 
            DBMS_OUTPUT.PUT_LINE('REAJUSTE NORMAL');
            RETURN produto.Valor + (produto.Valor * aplicarReajuste);
        END IF;
    END LOOP; 
END;


-- Exemplo execução um
 SELECT ID, Valor, Descricao, RECARCULARPRECOPRODUTO(ID, '0,02', TO_Date('01/01/2020', 'dd/MM/YYYY')) AS NovoCalculo FROM Produto;

-- Exemplo execução dois

DECLARE
    dataExemplo DATE;
    percentualReajuste VARCHAR2(10);
BEGIN
    dataExemplo  := TO_Date('02/01/2020', 'dd/MM/YYYY');
    percentualReajuste := '0,02';
    
    FOR produto IN (SELECT Id FROM Produto) LOOP
       DBMS_OUTPUT.PUT_LINE('ID Tabela' ||  produto.Id || ' REAJUSTE ' ||  RECARCULARPRECOPRODUTO(produto.Id, percentualReajuste, dataExemplo));
    END LOOP;
END;


--

-- Aula 2 View

-- Criação de View Simples por linha de comando

-- BLOCO 1
CREATE OR REPLACE VIEW BuscarDadosProdutosSimples
AS
    SELECT ID, Descricao, Valor, Cadastro FROM PRODUTO


-- BLOCO 2
SELECT * FROM BuscarDadosProdutosSimples;
SELECT * FROM BuscarDadosProdutosSimples WHERE ID = 5;
INSERT INTO BuscarDadosProdutosSimples(ID, DESCRICAO, VALOR, CADASTRO) VALUES (11, 'TESTE', 10, SYSDATE)
SELECT * FROM PRODUTO WHERE ID = 11
DELETE FROM BuscarDadosProdutosSimples WHERE ID = 11

-- Criação de View Simples por linha de comando devolvendo o ALIAS alteradado para cada coluna

--BLOCO 1

CREATE OR REPLACE VIEW BuscarDadosProdutosAllias(CAMPO_ID, CAMPO_TEXTO, CAMPO_PRECO, CAMPO_INCLUSAO)
AS
    SELECT ID, Descricao, Valor, Cadastro FROM PRODUTO;

-- BLOCO 2

SELECT * FROM BuscarDadosProdutosAllias WHERE CAMPO_ID = 5;

-- BLOCO 3 VIEW e FUNCTION

DECLARE
    dataExemplo DATE;
    percentualReajuste VARCHAR2(10);
BEGIN
    dataExemplo  := TO_Date('02/01/2020', 'dd/MM/YYYY');
    percentualReajuste := '0,02';
    
    FOR produto IN (SELECT CAMPO_ID FROM BuscarDadosProdutosAllias) LOOP
       DBMS_OUTPUT.PUT_LINE('ID Tabela' ||  produto.CAMPO_ID || ' REAJUSTE ' ||  RECARCULARPRECOPRODUTO(produto.CAMPO_ID, percentualReajuste, dataExemplo));
    END LOOP;
END;

--

-- Exemplo WITH READ ONLY

CREATE OR REPLACE VIEW BuscarProdutoLeitura
AS
    SELECT ID, Descricao, Valor, Cadastro FROM PRODUTO WITH READ ONLY;

SELECT * FROM BuscarProdutoLeitura WHERE ID = 5

/* QUando exeuctado o INSERT, UPDATE, DELETE o  ORACLE não permiti efetuar tais comandos */
INSERT INTO BuscarProdutoLeitura(ID, DESCRICAO, VALOR, CADASTRO) VALUES (11, 'TESTE', 10, SYSDATE)
DELETE FROM BuscarProdutoLeitura WHERE ID = 11

-- 

-- Exemplo 

CREATE OR REPLACE VIEW BuscarProdutoComMenorValor
AS
    SELECT ID, Descricao, Valor, Cadastro 
    FROM PRODUTO 
    WHERE Valor < 100 
    WITH CHECK OPTION;


SELECT * FROM BUSCARPRODUTOCOMMENORVALOR;
-- 5, 8, 9 -- valores 1500,00  

INSERT INTO BUSCARPRODUTOCOMMENORVALOR(ID, DESCRICAO, VALOR, CADASTRO) VALUES (11, 'TESTE', 2000, SYSDATE);

DELETE FROM BUSCARPRODUTOCOMMENORVALOR WHERE ID = 11

SELECT * FROM PRODUTO WHERE ID = 11

UPDATE BUSCARPRODUTOCOMMENORVALOR SET Valor = 10 WHERE ID = 11