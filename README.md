# Dashboard de vendas
Projeto desenvolvido em ABAP, voltado para o módulo SD e construído com base em uma especificação funcional.

## Objetivo
Atualmente não existe um relatório standard para mostrar todo o fluxo dos documentos de vendas.
Deve ser criado um relatório que mostre na mesma linha o número da ordem de venda, da remessa (fornecimento) e da fatura.

## Especificação funcional
Criar um programa que selecione o fluxo dos documentos de vendas e mostre o resultado em forma de relatório.
Este programa deve ter uma tela inicial contendo parâmetros de seleção para usar como filtros. Os filtros são:
Cliente:  kna1-kunnr;
Ordem de venda: vbak-vbeln;
Remessa: likp-vbeln;
Fatura: vbrk-vbeln.

O relatório deve conter os seguintes campos:
Tabela VBAK:
VBELN ERDAT ERNAM NETWR WAERK VKORG VTWEG SPART GBSTK KUNNR

Tabela KNA1:
NAME1
Encontrar NAME1 onde KUNNR = vbak-kunnr

Tabela LIKP:
VBELN ERDAT VSTEL BTGEW GEWEI

Tabela VBRK:
VBELN FKDAT MWSBK FKSTO

Condições de ligação para encontrar o fluxo de documentos na tabela vbfa
- de ordem para remessa
Selecionar VBELN onde VBELV = vbak-vbeln, VBTYP_N = J, VBTYP_V = C.

- de remessa para fatura
Selecionar vbeln onde vbelv = vbeln da seleção anterior, VBTYP_N = M, VBTYP_V = J.

## Skills empregadas
- tabelas internas;
- operações de leitura (select);
- loop, read table, select for all entries;
- append;
- funções ou classes;
- ALV OO.

## Tela de seleção
![Tela de seleção](https://raw.githubusercontent.com/Rafael-Ienne/dashboard_vendas.abap/refs/heads/main/img/tela_selecao_com_parametros.png)

## Resultado da busca sem parâmetros
![Resultado da busca sem parâmetros](https://raw.githubusercontent.com/Rafael-Ienne/dashboard_vendas.abap/refs/heads/main/img/dashboard_sem_parametros_entrada.png)

## Resultado da busca com parâmetros
![Resultado da busca com parâmetros](https://raw.githubusercontent.com/Rafael-Ienne/dashboard_vendas.abap/refs/heads/main/img/resultado_com_parametros.png)


