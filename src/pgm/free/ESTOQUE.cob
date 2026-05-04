      *>>SOURCE FORMAT IS FREE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ESTOQUE-SISTEMA.
       AUTHOR. LPCOUTINHO.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-ESTOQUE ASSIGN TO 'data/ESTOQUE.dat'
           ORGANIZATION IS INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS PROD-ID
           FILE STATUS IS WS-FS-ESTOQUE.

       DATA DIVISION.
       FILE SECTION.
       FD  ARQ-ESTOQUE.
           COPY 'PRODUTO.cpy'.

       WORKING-STORAGE SECTION.
       01  WS-FS-ESTOQUE     PIC X(02).
       01  WS-OPCAO          PIC X(01).
       01  WS-CONFIRMA       PIC X(01).
       01  WS-FIM            PIC X(01) VALUE 'N'.
       01  WS-FIM-REL        PIC X(01) VALUE 'N'.
       01  WS-LINHA          PIC 9(02).
       
       01  WS-MASKS.
           05 WS-MASK-PRECO  PIC ZZZ.ZZ9,99.
           05 WS-MASK-QTD    PIC ZZZ9.

       SCREEN SECTION.
       01 TELA-LIMPA.
          05 BLANK SCREEN.

       01 TELA-MENU.
          05 LINE 02 COLUMN 20 VALUE "SISTEMA DE GESTAO DE ESTOQUE" HIGHLIGHT.
          05 LINE 03 COLUMN 20 VALUE "----------------------------".
          05 LINE 05 COLUMN 25 VALUE "1. CADASTRAR PRODUTO".
          05 LINE 06 COLUMN 25 VALUE "2. CONSULTAR PRODUTO".
          05 LINE 07 COLUMN 25 VALUE "3. ALTERAR ESTOQUE".
          05 LINE 08 COLUMN 25 VALUE "4. EXCLUIR PRODUTO".
          05 LINE 09 COLUMN 25 VALUE "5. RELATORIO GERAL".
          05 LINE 11 COLUMN 25 VALUE "0. SAIR".
          05 LINE 13 COLUMN 25 VALUE "OPCAO: ".
          05 COLUMN PLUS 1 PIC X(01) TO WS-OPCAO.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           OPEN I-O ARQ-ESTOQUE.
           IF WS-FS-ESTOQUE = '35'
               OPEN OUTPUT ARQ-ESTOQUE
               CLOSE ARQ-ESTOQUE
               OPEN I-O ARQ-ESTOQUE
           END-IF.

           PERFORM UNTIL WS-FIM = 'S'
               DISPLAY TELA-LIMPA
               DISPLAY TELA-MENU
               ACCEPT TELA-MENU
               
               EVALUATE WS-OPCAO
                   WHEN '1' PERFORM CADASTRAR-PRODUTO
                   WHEN '2' PERFORM CONSULTAR-PRODUTO
                   WHEN '3' PERFORM ALTERAR-PRODUTO
                   WHEN '4' PERFORM EXCLUIR-PRODUTO
                   WHEN '5' PERFORM RELATORIO-GERAL
                   WHEN '0' MOVE 'S' TO WS-FIM
               END-EVALUATE
           END-PERFORM.

           CLOSE ARQ-ESTOQUE.
           STOP RUN.

       CADASTRAR-PRODUTO.
           DISPLAY TELA-LIMPA.
           DISPLAY "CADASTRO DE PRODUTO" LINE 02 COLUMN 25.
           DISPLAY "ID    : " LINE 04 COLUMN 20.
           ACCEPT PROD-ID LINE 04 COLUMN 28.
           DISPLAY "NOME  : " LINE 05 COLUMN 20.
           ACCEPT PROD-NOME LINE 05 COLUMN 28.
           DISPLAY "QTD   : " LINE 06 COLUMN 20.
           ACCEPT PROD-QTD LINE 06 COLUMN 28.
           DISPLAY "PRECO : " LINE 07 COLUMN 20.
           ACCEPT PROD-PRECO LINE 07 COLUMN 28.

           WRITE REG-PRODUTO
               INVALID KEY 
                   DISPLAY "ERRO: ID JA CADASTRADO!" LINE 09 COLUMN 20
               NOT INVALID KEY
                   DISPLAY "SUCESSO: PRODUTO SALVO!" LINE 09 COLUMN 20
           END-WRITE.
           DISPLAY "PRESSIONE QUALQUER TECLA PARA VOLTAR..." LINE 11 COLUMN 20.
           ACCEPT WS-OPCAO.

       CONSULTAR-PRODUTO.
           DISPLAY TELA-LIMPA.
           DISPLAY "CONSULTA DE PRODUTO" LINE 02 COLUMN 25.
           DISPLAY "DIGITE O ID: " LINE 04 COLUMN 20.
           ACCEPT PROD-ID LINE 04 COLUMN 35.

           READ ARQ-ESTOQUE 
               INVALID KEY
                   DISPLAY "PRODUTO NAO ENCONTRADO!" LINE 06 COLUMN 20
               NOT INVALID KEY
                   DISPLAY TELA-LIMPA
                   DISPLAY "CONSULTA DE PRODUTO" LINE 02 COLUMN 25
                   DISPLAY "DADOS DO PRODUTO SELECIONADO" LINE 04 COLUMN 20 HIGHLIGHT
                   MOVE PROD-PRECO TO WS-MASK-PRECO
                   MOVE PROD-QTD   TO WS-MASK-QTD
                   DISPLAY "ID    : " LINE 06 COLUMN 20
                   DISPLAY PROD-ID       LINE 06 COLUMN 28
                   DISPLAY "NOME  : " LINE 07 COLUMN 20
                   DISPLAY PROD-NOME     LINE 07 COLUMN 28
                   DISPLAY "QTD   : " LINE 08 COLUMN 20
                   DISPLAY WS-MASK-QTD   LINE 08 COLUMN 28
                   DISPLAY "PRECO : R$ " LINE 09 COLUMN 20
                   DISPLAY WS-MASK-PRECO LINE 09 COLUMN 32
           END-READ.
           DISPLAY "PRESSIONE QUALQUER TECLA PARA VOLTAR..." LINE 11 COLUMN 20.
           ACCEPT WS-OPCAO.

       ALTERAR-PRODUTO.
           DISPLAY TELA-LIMPA.
           DISPLAY "ALTERACAO DE PRODUTO" LINE 02 COLUMN 25.
           DISPLAY "DIGITE O ID: " LINE 04 COLUMN 20.
           ACCEPT PROD-ID LINE 04 COLUMN 35.

           READ ARQ-ESTOQUE
               INVALID KEY
                   DISPLAY "PRODUTO NAO ENCONTRADO!" LINE 06 COLUMN 20
               NOT INVALID KEY
                   DISPLAY TELA-LIMPA
                   DISPLAY "ALTERACAO DE PRODUTO" LINE 02 COLUMN 25
                   MOVE PROD-PRECO TO WS-MASK-PRECO
                   MOVE PROD-QTD   TO WS-MASK-QTD
                   DISPLAY "ID SELECIONADO: " LINE 04 COLUMN 20 HIGHLIGHT
                   DISPLAY PROD-ID LINE 04 COLUMN 36 HIGHLIGHT
                   
                   DISPLAY "NOME ATUAL : " LINE 06 COLUMN 20
                   DISPLAY PROD-NOME     LINE 06 COLUMN 35
                   DISPLAY "PRECO ATUAL: R$ " LINE 07 COLUMN 20
                   DISPLAY WS-MASK-PRECO LINE 07 COLUMN 35
                   DISPLAY "QTD ATUAL  : " LINE 08 COLUMN 20
                   DISPLAY WS-MASK-QTD   LINE 08 COLUMN 35
                   
                   DISPLAY "NOVO NOME  : " LINE 10 COLUMN 20
                   ACCEPT PROD-NOME LINE 10 COLUMN 35
                   DISPLAY "NOVA QTD   : " LINE 11 COLUMN 20
                   ACCEPT PROD-QTD LINE 11 COLUMN 35
                   DISPLAY "NOVO PRECO : " LINE 12 COLUMN 20
                   ACCEPT PROD-PRECO LINE 12 COLUMN 35
                   
                   REWRITE REG-PRODUTO
                       INVALID KEY
                           DISPLAY "ERRO AO ATUALIZAR!" LINE 14 COLUMN 20
                       NOT INVALID KEY
                           DISPLAY "PRODUTO ATUALIZADO COM SUCESSO!" LINE 14 COLUMN 20
                   END-REWRITE
           END-READ.
           DISPLAY "PRESSIONE QUALQUER TECLA PARA VOLTAR..." LINE 16 COLUMN 20.
           ACCEPT WS-OPCAO.

       EXCLUIR-PRODUTO.
           DISPLAY TELA-LIMPA.
           DISPLAY "EXCLUSAO DE PRODUTO" LINE 02 COLUMN 25.
           DISPLAY "DIGITE O ID: " LINE 04 COLUMN 20.
           ACCEPT PROD-ID LINE 04 COLUMN 35.

           READ ARQ-ESTOQUE
               INVALID KEY
                   DISPLAY "PRODUTO NAO ENCONTRADO!" LINE 06 COLUMN 20
               NOT INVALID KEY
                   DISPLAY TELA-LIMPA
                   DISPLAY "EXCLUSAO DE PRODUTO" LINE 02 COLUMN 25
                   MOVE PROD-PRECO TO WS-MASK-PRECO
                   MOVE PROD-QTD   TO WS-MASK-QTD
                   DISPLAY "ID SELECIONADO: " LINE 04 COLUMN 20 HIGHLIGHT
                   DISPLAY PROD-ID LINE 04 COLUMN 36 HIGHLIGHT
                   
                   DISPLAY "PRODUTO: " LINE 06 COLUMN 20
                   DISPLAY PROD-NOME LINE 06 COLUMN 28
                   DISPLAY "ESTOQUE: " LINE 07 COLUMN 20
                   DISPLAY WS-MASK-QTD LINE 07 COLUMN 28
                   DISPLAY "VALOR  : R$ " LINE 08 COLUMN 20
                   DISPLAY WS-MASK-PRECO LINE 08 COLUMN 32
                   
                   DISPLAY "CONFIRMA EXCLUSAO? (S/N): " LINE 10 COLUMN 20
                   ACCEPT WS-CONFIRMA LINE 10 COLUMN 46
                   
                   IF WS-CONFIRMA = 'S' OR WS-CONFIRMA = 's'
                       DELETE ARQ-ESTOQUE RECORD
                           INVALID KEY
                               DISPLAY "ERRO AO EXCLUIR!" LINE 12 COLUMN 20
                           NOT INVALID KEY
                               DISPLAY "PRODUTO EXCLUIDO COM SUCESSO!" LINE 12 COLUMN 20
                       END-DELETE
                   ELSE
                       DISPLAY "EXCLUSAO CANCELADA." LINE 12 COLUMN 20
                   END-IF
           END-READ.
           DISPLAY "PRESSIONE QUALQUER TECLA PARA VOLTAR..." LINE 14 COLUMN 20.
           ACCEPT WS-OPCAO.

       RELATORIO-GERAL.
           DISPLAY TELA-LIMPA.
           DISPLAY "RELATORIO GERAL DE ESTOQUE" LINE 02 COLUMN 25 HIGHLIGHT.
           DISPLAY "ID    | NOME                           | QTD  | PRECO" LINE 04 COLUMN 10.
           DISPLAY "------------------------------------------------------" LINE 05 COLUMN 10.
           
           MOVE 0 TO PROD-ID.
           START ARQ-ESTOQUE KEY IS NOT LESS PROD-ID
               INVALID KEY
                   DISPLAY "ARQUIVO VAZIO!" LINE 07 COLUMN 10
                   MOVE 'S' TO WS-FIM-REL
               NOT INVALID KEY
                   MOVE 'N' TO WS-FIM-REL
                   MOVE 6 TO WS-LINHA
           END-START.

           PERFORM UNTIL WS-FIM-REL = 'S'
               READ ARQ-ESTOQUE NEXT
                   AT END
                       MOVE 'S' TO WS-FIM-REL
                   NOT AT END
                       MOVE PROD-PRECO TO WS-MASK-PRECO
                       MOVE PROD-QTD   TO WS-MASK-QTD
                       DISPLAY PROD-ID       LINE WS-LINHA COLUMN 10
                       DISPLAY "|"           LINE WS-LINHA COLUMN 16
                       DISPLAY PROD-NOME     LINE WS-LINHA COLUMN 18
                       DISPLAY "|"           LINE WS-LINHA COLUMN 49
                       DISPLAY WS-MASK-QTD   LINE WS-LINHA COLUMN 51
                       DISPLAY "|"           LINE WS-LINHA COLUMN 56
                       DISPLAY WS-MASK-PRECO LINE WS-LINHA COLUMN 58
                       
                       ADD 1 TO WS-LINHA
                       
                       IF WS-LINHA > 20
                           DISPLAY "PRESSIONE ENTER PARA PROXIMA PAGINA..." LINE 22 COLUMN 10
                           ACCEPT WS-OPCAO
                           DISPLAY TELA-LIMPA
                           DISPLAY "RELATORIO GERAL DE ESTOQUE (CONT.)" LINE 02 COLUMN 25 HIGHLIGHT
                           DISPLAY "ID    | NOME                           | QTD  | PRECO" LINE 04 COLUMN 10
                           DISPLAY "------------------------------------------------------" LINE 05 COLUMN 10
                           MOVE 6 TO WS-LINHA
                       END-IF
               END-READ
           END-PERFORM.

           DISPLAY "FIM DO RELATORIO. PRESSIONE QUALQUER TECLA..." LINE WS-LINHA COLUMN 10.
           ACCEPT WS-OPCAO.
