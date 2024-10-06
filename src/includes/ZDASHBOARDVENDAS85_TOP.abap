*&---------------------------------------------------------------------*
*& Include          ZDASHBOARDVENDAS85_TOP
*&---------------------------------------------------------------------*
TABLES: vbak, kna1, likp, vbrk.

"Types do tipo da tabela interna do relatório
TYPES: BEGIN OF ty_relatorio,
         vbeln_vbak TYPE vbak-vbeln,
         erdat_vbak TYPE vbak-erdat,
         ernam_vbak TYPE vbak-ernam,
         netwr_vbak TYPE vbak-netwr,
         waerk_vbak TYPE vbak-waerk,
         vkorg_vbak TYPE vbak-vkorg,
         vtweg_vbak TYPE vbak-vtweg,
         spart_vbak TYPE vbak-spart,
         gbstk_vbak TYPE vbak-gbstk,
         kunnr_vbak TYPE vbak-kunnr,
         name1_kna1 TYPE kna1-name1,
         vbeln_likp TYPE likp-vbeln,
         erdat_likp TYPE likp-erdat,
         vstel_likp TYPE likp-vstel,
         btgew_likp TYPE likp-btgew,
         gewei_likp TYPE likp-gewei,
         vbeln_vbrk TYPE vbrk-vbeln,
         fkdat_vbrk TYPE vbrk-fkdat,
         mwsbk_vbrk TYPE vbrk-mwsbk,
         fksto_vbrk TYPE vbrk-fksto.
TYPES: END OF ty_relatorio.

"Types de chave-valor entre remessa-ordem e fatura-remessa
TYPES: BEGIN OF ty_vbfa,
         vbeln TYPE vbfa-vbeln,
         vbelv TYPE vbfa-vbelv.
TYPES: END OF ty_vbfa.

"Tabelas de manipulação de dados
DATA: gt_kna1           TYPE STANDARD TABLE OF kna1,
      gt_vbrk           TYPE STANDARD TABLE OF vbrk,
      gt_likp           TYPE STANDARD TABLE OF likp,
      gt_vbak           TYPE STANDARD TABLE OF vbak,
      gt_remessa_ordem  TYPE STANDARD TABLE OF ty_vbfa,
      gt_fatura_remessa TYPE STANDARD TABLE OF ty_vbfa.

DATA: gt_relatorio TYPE STANDARD TABLE OF ty_relatorio, "Tabela interna com os dados a serem eibidos no ALV
      gs_relatorio LIKE LINE OF gt_relatorio.

DATA: go_alv TYPE REF TO cl_salv_table. "Objeto ALV

DATA: functions TYPE REF TO cl_salv_functions_list. "Objeto para adicionar a barra de funcionalidades do ALV

SELECTION-SCREEN: BEGIN OF BLOCK b1.
  SELECT-OPTIONS: s_client FOR kna1-kunnr, "número do cliente
                  s_ordem  FOR vbak-vbeln, "número da ordem de venda
                  s_remes  FOR likp-vbeln, "número de remessa
                  s_fat    FOR vbrk-vbeln. "número da fatura
SELECTION-SCREEN: END OF BLOCK b1.