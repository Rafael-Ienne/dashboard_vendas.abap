*&---------------------------------------------------------------------*
*& Include          ZDASHBOARDVENDAS85_F
*&---------------------------------------------------------------------*

FORM f_selecionar_dados.

  "Selecionando dados da VBAK com base na entrada de s_ordem
  SELECT vbak~vbeln,
         vbak~erdat,
         vbak~ernam,
         vbak~netwr,
         vbak~waerk,
         vbak~vkorg,
         vbak~vtweg,
         vbak~spart,
         vbak~gbstk,
         vbak~kunnr
    FROM vbak
    WHERE vbeln IN @s_ordem
    INTO CORRESPONDING FIELDS OF TABLE @gt_vbak.

  SORT gt_vbak BY vbeln ASCENDING.

  "Preenchendo a tabela de clientes, com base nas entradas da tabela gt_vbak
  SELECT name1,
    kunnr
    FROM kna1
    FOR ALL ENTRIES IN @gt_vbak
    WHERE kunnr = @gt_vbak-kunnr
    INTO CORRESPONDING FIELDS OF TABLE @gt_kna1.

  SORT gt_kna1 BY kunnr ASCENDING.

  "Preenchendo tabela chave-valor gt_remessa_ordem, com base na entrada em s_remes
  SELECT vbeln,
    vbelv
   FROM vbfa
   WHERE vbeln IN @s_remes
   AND vbtyp_n = 'J'
   AND vbtyp_v = 'C'
   INTO TABLE @gt_remessa_ordem.

  SORT gt_remessa_ordem BY vbelv ASCENDING.

  "Selecionando os registros de remessa, com base no número de remessa da tabela gt_remessa_ordem
  SELECT vbeln,
    erdat,
    vstel,
    btgew,
    gewei
   FROM likp
    FOR ALL ENTRIES IN @gt_remessa_ordem
   WHERE vbeln = @gt_remessa_ordem-vbeln
   INTO CORRESPONDING FIELDS OF TABLE @gt_likp.

  SORT gt_likp BY vbeln ASCENDING.

  "Preenchendo tabela chave-valor gt_fatura_remessa, com base na entrada em s_fat
  SELECT vbeln,
    vbelv
  FROM vbfa
  WHERE vbeln IN @s_fat
  AND vbtyp_n = 'M'
  AND vbtyp_v = 'J'
  INTO TABLE @gt_fatura_remessa.

  SORT gt_fatura_remessa BY vbelv ASCENDING.

  "Selecionando registros de faturas, com base nas entradas da tabela gt_fatura_remessa
  SELECT vbeln,
   fkdat,
   mwsbk,
   fksto
  FROM vbrk
  FOR ALL ENTRIES IN @gt_fatura_remessa
  WHERE vbeln = @gt_fatura_remessa-vbeln
  INTO CORRESPONDING FIELDS OF TABLE @gt_vbrk.

  SORT gt_vbrk BY vbeln ASCENDING.

ENDFORM.

FORM f_exibir_alv.

  cl_salv_table=>factory(
    IMPORTING
      r_salv_table   = go_alv
    CHANGING
      t_table        = gt_relatorio
  ).

  functions = go_alv->get_functions( ).
  functions->set_all( abap_true ).

  DATA: lo_columns TYPE REF TO cl_salv_columns_table.
  DATA: lr_column TYPE REF TO cl_salv_column.

  lo_columns = go_alv->get_columns( ).

  lr_column = lo_columns->get_column( columnname = 'VBELN_VBAK' ).
  lr_column->set_long_text( value = 'Ordem venda' ).
  lr_column->set_medium_text( value = 'Ordem venda' ).
  lr_column->set_short_text( value = 'Ordem' ).

  lr_column = lo_columns->get_column( columnname = 'ERDAT_VBAK' ).
  lr_column->set_long_text( value = 'Data criação ordem' ).
  lr_column->set_medium_text( value = 'Data cri.' ).
  lr_column->set_short_text( value = 'Data' ).

  lr_column = lo_columns->get_column( columnname = 'ERNAM_VBAK' ).
  lr_column->set_long_text( value = 'Responsável da ordem' ).
  lr_column->set_medium_text( value = 'Responsável' ).
  lr_column->set_short_text( value = 'Resp' ).

  lr_column = lo_columns->get_column( columnname = 'NETWR_VBAK' ).
  lr_column->set_long_text( value = 'Valor líquido ordem' ).
  lr_column->set_medium_text( value = 'Val. liq.' ).
  lr_column->set_short_text( value = 'V. liq.' ).

  lr_column = lo_columns->get_column( columnname = 'WAERK_VBAK' ).
  lr_column->set_long_text( value = 'Moeda documento' ).
  lr_column->set_medium_text( value = 'Moeda doc.' ).
  lr_column->set_short_text( value = 'Moeda' ).

  lr_column = lo_columns->get_column( columnname = 'VKORG_VBAK' ).
  lr_column->set_long_text( value = 'Organização de vendas' ).
  lr_column->set_medium_text( value = 'Org. vendas' ).
  lr_column->set_short_text( value = 'Org. vend.' ).

  lr_column = lo_columns->get_column( columnname = 'VTWEG_VBAK' ).
  lr_column->set_long_text( value = 'Canal de distribuição' ).
  lr_column->set_medium_text( value = 'Canal dist.' ).
  lr_column->set_short_text( value = 'C. dist.' ).

  lr_column = lo_columns->get_column( columnname = 'SPART_VBAK' ).
  lr_column->set_long_text( value = 'Setor de atividade' ).
  lr_column->set_medium_text( value = 'Set. ativ.' ).
  lr_column->set_short_text( value = 'Setor' ).

  lr_column = lo_columns->get_column( columnname = 'GBSTK_VBAK' ).
  lr_column->set_long_text( value = 'Status global de processamento' ).
  lr_column->set_medium_text( value = 'Status proces.' ).
  lr_column->set_short_text( value = 'Status' ).

  lr_column = lo_columns->get_column( columnname = 'KUNNR_VBAK' ).
  lr_column->set_long_text( value = 'Emissor da ordem' ).
  lr_column->set_medium_text( value = 'Emissor. ord.' ).
  lr_column->set_short_text( value = 'Emissor' ).

  lr_column = lo_columns->get_column( columnname = 'NAME1_KNA1' ).
  lr_column->set_long_text( value = 'Nome cliente' ).
  lr_column->set_medium_text( value = 'Cliente' ).
  lr_column->set_short_text( value = 'Cliente' ).

  lr_column = lo_columns->get_column( columnname = 'VBELN_LIKP' ).
  lr_column->set_long_text( value = 'Remessa' ).
  lr_column->set_medium_text( value = 'Remessa' ).
  lr_column->set_short_text( value = 'Remessa' ).

  lr_column = lo_columns->get_column( columnname = 'ERDAT_LIKP' ).
  lr_column->set_long_text( value = 'Data criação remessa' ).
  lr_column->set_medium_text( value = 'D. criação rem.' ).
  lr_column->set_short_text( value = 'Data rem.' ).

  lr_column = lo_columns->get_column( columnname = 'VSTEL_LIKP' ).
  lr_column->set_long_text( value = 'Local de expedição' ).
  lr_column->set_medium_text( value = 'Local exped.' ).
  lr_column->set_short_text( value = 'Expedição' ).

  lr_column = lo_columns->get_column( columnname = 'BTGEW_LIKP' ).
  lr_column->set_long_text( value = 'Peso total' ).
  lr_column->set_medium_text( value = 'P. total' ).
  lr_column->set_short_text( value = 'P. total' ).

  lr_column = lo_columns->get_column( columnname = 'GEWEI_LIKP' ).
  lr_column->set_long_text( value = 'Unidade de peso' ).
  lr_column->set_medium_text( value = 'U. peso' ).
  lr_column->set_short_text( value = 'U. peso' ).

  lr_column = lo_columns->get_column( columnname = 'VBELN_VBRK' ).
  lr_column->set_long_text( value = 'Documento de faturamento' ).
  lr_column->set_medium_text( value = 'Fatura' ).
  lr_column->set_short_text( value = 'Fatura' ).

  lr_column = lo_columns->get_column( columnname = 'FKDAT_VBRK' ).
  lr_column->set_long_text( value = 'Data do faturamento' ).
  lr_column->set_medium_text( value = 'Data fat.' ).
  lr_column->set_short_text( value = 'Data fat.' ).

  lr_column = lo_columns->get_column( columnname = 'MWSBK_VBRK' ).
  lr_column->set_long_text( value = 'Montante imposto na moeda' ).
  lr_column->set_medium_text( value = 'Imposto na moeda' ).
  lr_column->set_short_text( value = 'Imp. moeda' ).

  lr_column = lo_columns->get_column( columnname = 'FKSTO_VBRK' ).
  lr_column->set_long_text( value = 'Documento de faturamento estornado' ).
  lr_column->set_medium_text( value = 'Doc. fat. est.' ).
  lr_column->set_short_text( value = 'Fat. est.' ).

  go_alv->display( ).

ENDFORM.

FORM f_processar_dados.

  LOOP AT gt_vbak ASSIGNING FIELD-SYMBOL(<fs_vbak>).

    "Selecionando o nome do cliente
    READ TABLE gt_kna1 ASSIGNING FIELD-SYMBOL(<fs_kna1>) WITH KEY kunnr = <fs_vbak>-kunnr BINARY SEARCH.

    "Selecionando número de remessa com base na ordem de venda
    READ TABLE gt_remessa_ordem ASSIGNING FIELD-SYMBOL(<fs_remessa_ordem>) WITH KEY vbelv = <fs_vbak>-vbeln BINARY SEARCH.

    CHECK sy-subrc IS INITIAL.

    "Selecionando registro da tabela de remessas com base no número de remessa
    READ TABLE gt_likp ASSIGNING FIELD-SYMBOL(<fs_likp>) WITH KEY vbeln = <fs_remessa_ordem>-vbeln BINARY SEARCH.

    CHECK sy-subrc IS INITIAL.

    "Selecionando número da fatura com base no número de remessa
    READ TABLE gt_fatura_remessa ASSIGNING FIELD-SYMBOL(<fs_fatura_remessa>) WITH KEY vbelv = <fs_remessa_ordem>-vbeln BINARY SEARCH.

    CHECK sy-subrc IS INITIAL.

    "Selecionando registro da tabela de faturas com base no número de fatura
    READ TABLE gt_vbrk ASSIGNING FIELD-SYMBOL(<fs_vbrk>) WITH KEY vbeln = <fs_fatura_remessa>-vbeln BINARY SEARCH.

    CHECK sy-subrc IS INITIAL.

    gs_relatorio = VALUE #(
    vbeln_vbak = <fs_vbak>-vbeln
    erdat_vbak = <fs_vbak>-erdat
    ernam_vbak = <fs_vbak>-ernam
    netwr_vbak = <fs_vbak>-vbeln
    waerk_vbak = <fs_vbak>-waerk
    vkorg_vbak = <fs_vbak>-vkorg
    vtweg_vbak = <fs_vbak>-vtweg
    spart_vbak = <fs_vbak>-spart
    gbstk_vbak = <fs_vbak>-gbstk
    kunnr_vbak = <fs_vbak>-kunnr
    name1_kna1 = <fs_kna1>-name1
    vbeln_likp = <fs_likp>-vbeln
    erdat_likp = <fs_likp>-erdat
    vstel_likp = <fs_likp>-vstel
    btgew_likp = <fs_likp>-btgew
    gewei_likp = <fs_likp>-gewei
    vbeln_vbrk = <fs_vbrk>-vbeln
    fkdat_vbrk = <fs_vbrk>-fkdat
    mwsbk_vbrk = <fs_vbrk>-mwsbk
    fksto_vbrk = <fs_vbrk>-fksto ).

    APPEND gs_relatorio TO gt_relatorio.

  ENDLOOP.

ENDFORM.