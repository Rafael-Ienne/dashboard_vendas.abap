*&---------------------------------------------------------------------*
*& Include          ZDASHBOARDVENDAS85_P
*&---------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM f_selecionar_dados.

  PERFORM f_processar_dados.

  IF gt_relatorio IS NOT INITIAL.
    PERFORM f_exibir_alv.
  ELSE.
    MESSAGE TEXT-001 TYPE 'I' DISPLAY LIKE 'E'.
  ENDIF.