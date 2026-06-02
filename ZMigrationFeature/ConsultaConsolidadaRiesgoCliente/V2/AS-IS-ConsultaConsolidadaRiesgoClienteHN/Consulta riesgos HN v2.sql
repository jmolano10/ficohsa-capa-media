
--EXEC [dbo].[p_consulta_ONBASE_V2] '0801199516979'

CREATE PROCEDURE [dbo].[p_consulta_ONBASE_V2]
@IDENTIDAD NVARCHAR(20)

AS

/**************************************************************************************************
 DESCRIPCION: Procedimiento de Consulta Consolidada OnBase

 REVISIONES:
 Ver	Fecha		Autor			Descripcion
 ====	==========	============	===============================================================
 1.0	21/Abr/2020	WAHE		    Creacion del procedimiento
 2.0    17/abr/2021 WAHE			Se realiza cambio en la estructura para objeto fuente de Vision+
 3.0	19/Ago/2022 FGarcia			Se agrega unificación de tablas para Ma_Solicitante y Ma_Pasivos
 4.0	23/Jul/2025 HN30491			Se agrega captura de errores de la tabla EQ_CONTROL 
***************************************************************************************************/
	DECLARE 
	@XML_CLIENTE			XML, 
	@XML_PASIVOS			XML, 
	@XML_TRXPASIVOS			XML, 
	@XML_TARJETAS			XML, 
	@XML_TRXTARJETAS		XML,
	@XML_PRESTAMOS			XML, 
	@XML_TRXPRESTAMOS		XML, 
	@XML_OFERTA				XML, 
	@XML_EXTRAFIN			XML, 
	@XML_RECORDT			XML, 
	@XML_RECORDB			XML, 
	@XML_RECORDD			XML, 
	@XML_RECORDC			XML, 
	@XML_RECORDPRB			XML,
	@XML_RECORDPRD			XML,
	@XML_RECORDPRT			XML,
	@XML_RecordHB			XML,
	@XML_RecordHD			XML,
	@XML_RecordHT			XML,
	---------------------------
	@XML_RecordA			XML,
	@XML_RecordTel			XML,
	@XML_RecordH			XML,
	@XML_RecordS			XML,
	@XML_RECORDEVALUACION	XML,
	@XML_EQX_CONTROL		XML,	
	@XML_BLAZE_DATA_PTMO	XML,
	---------------------------
	@id_estudio		   int, 
	@msjError          varchar(2000),  
	@reg			   int,
	@ERROR_Equifax     int,
	@li_existe_data_bl int,
	----------------------------------------------
	@F_Ini_proc         datetime, 
	@F_fin_proc         datetime,
	@F_Ini_equi         datetime,
	@F_fin_equi         datetime,
    @ErrorXML           XML,
	@ResultadoError    NVARCHAR(MAX),
    @observacion_error NVARCHAR(MAX),
	@ErrorBuro         int;
BEGIN TRY
 
  set @ErrorBuro     =0
  set @F_Ini_proc = getdate(); 
  set @F_Ini_equi = getdate();
  EXEC  [172.23.177.67].[CREDITOS_RIESGOS].[dbo].[sp_exec_cliet_Equifax] @Identidad = @IDENTIDAD, @id_estudio = @id_estudio output , @msjError   = @msjError   output
   set @F_fin_equi = getdate();

  select @ERROR_Equifax = ERROR ,@observacion_error = observaciones
   --from  CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL
   FROM [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL
   where idestudio  = @id_estudio
   and   identidad  = @IDENTIDAD 

 if isnull(@ERROR_Equifax,1) = 1
 begin 
   set @ErrorBuro =1
   Select @id_estudio = isnull(MAX(idestudio),0) 
      --from CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL
   FROM [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL
   where identidad = @IDENTIDAD
   and   ERROR     = 0;
 end
 
 if @observacion_error is null and @id_estudio=0
 begin
 set @observacion_error = @msjError
 set @ErrorBuro =1
 end

if @ErrorBuro=1 and  @id_estudio=0
begin
	 SET @observacion_error= 'Error al obtener datos en Buro Externo: '+ @observacion_error
     set @F_fin_proc = getdate();
     
	--insert into creditos_riesgos.hn_onbase.log_errores_consulta(IdEstudio,Hora,Desc_error)
    --values (@id_estudio,@F_fin_proc, @observacion_error);

     SET @XML_CLIENTE =( 
     SELECT  @IDENTIDAD IDENTIDAD,
     @observacion_error AS ERROR
     FOR XML PATH ('CLIENTE')
     );

	 
    SELECT @XML_CLIENTE AS CLIENTE;

	return;
	 
end

 select @li_existe_data_bl = COUNT(0) 
 from CREDITOS_RIESGOS.HN_ONBASE.Ma_Solicitante
 where Identidad = @IDENTIDAD;

if @li_existe_data_bl = 0 
  
	 
	
     SET @XML_CLIENTE =( 
     SELECT  @IDENTIDAD IDENTIDAD
     FOR XML PATH ('CLIENTE')
     )


else 
  begin 									
	SET @XML_CLIENTE = (
	 SELECT * FROM (
	 SELECT  
	   sol.IDENTIDAD											AS  IDENTIDAD                                  --HN_ONBASE.BLAZE_DATA_PTMO
	 , sol.SEGMENTOCLIENTE										AS  SEGMENTOCLIENTE                            --HN_ONBASE.BLAZE_DATA_PTMO
	 , cast(Sol.FECHANACIMIENTO	as date)         				AS  FECHANACIMIENTO                            --HN_ONBASE.BLAZE_DATA_PTMO
	 , Sol.EDAD													AS  EDAD                                       --HN_ONBASE.BLAZE_DATA_PTMO
	 , Sol.TIPOCLIENTE											AS  TIPOCLIENTE                                --HN_ONBASE.BLAZE_DATA_PTMO
	 , Sol.SALARIOCLIENTE										AS  SALARIOCLIENTE                             --HN_ONBASE.BLAZE_DATA_PTMO
	 , Sol.FLAGBLAZE											AS  FLAGBLAZE                                  --HN_ONBASE.BLAZE_DATA_PTMO
	 , Sol.MES_PLANILLA										    AS  MESPLANILLA
	 , Sol.MONTO_LPS_PLANILLA									AS  MONTOLPSPLANILLA
	 FROM			   CREDITOS_RIESGOS.HN_ONBASE.Ma_Solicitante            Sol 
	 WHERE sol.IDENTIDAD = @IDENTIDAD
	 UNION
	 SELECT		T1.Identidad		AS IDENTIDAD,
				NULL				AS SEGMENTOCLIENTE, 
				NULL				AS FECHANACIMIENTO, 
				NULL				AS EDAD,            
				NULL				AS TIPOCLIENTE,   
				NULL				AS SALARIOCLIENTE,  
				NULL				AS FLAGBLAZE,       
				NULL				AS MESPLANILLA,
				NULL				AS MONTOLPSPLANILLA

	 FROM CREDITOS_RIESGOS.HN_ONBASE.Ma_Solicitante_XML AS T1
	 WHERE T1.Identidad = @IDENTIDAD) AS A
	 FOR XML PATH ('CLIENTE'))
end; 

 -------------------------------------BLAZE_DATA_PTMO---------------------------------	  
SET @XML_BLAZE_DATA_PTMO = (
SELECT 
     a.flagHit					as 	flagHit
	,a.score					as 	scoreMC
	,a.calificacionScore		as 	calificacionScoreMC
	,a.nivelRiesgo				as 	nivelRiesgoMC
	,a.ofertaRetanqueo			as 	montoRetanqueoMC
	,a.tasaRetanqueo			as 	cuotaRetanqueoMC
	,a.cuotaRetanqueo			as 	tasaRetanqueoMC
	,a.ofertaRetanqueo12		as 	monto12RetanqueoMC
	,a.ofertaRetanqueo18		as 	monto18RetanqueoMC
	,a.ofertaRetanqueo24		as 	monto24RetanqueoMC
	,a.ofertaRetanqueo36		as 	monto36RetanqueoMC
	,a.ofertaRetanqueo48		as 	monto48RetanqueoMC
	,a.ofertaRetanqueo60		as 	monto60RetanqueoMC
	,a.timesIncomeRetanqueo		as 	timesIncomeRetanqueoMC
	,a.resolucionRetanqueo		as 	codResolucionRetanqueoMC
  FROM CREDITOS_RIESGOS.HN_ONBASE.BLAZE_DATA_PTMO A --CAMBIO REALIZADO 20210210
  --from [BLAZEUP_PRESTAMOS].[dbo].[BLAZE_DATA_PTMO] a
  where Identidad = @IDENTIDAD
 FOR XML RAW('CUENTA'),ROOT('BLAZE_DATA_PTMO')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_BLAZE_DATA_PTMO") into (/CLIENTE)[1]'); 


 ----------------------------PASIVOS--------------------------------------------------
 SET @XML_PASIVOS =
 (SELECT * FROM (
 SELECT 
	   D.NUMERO_CUENTA											AS  NUMEROCUENTA                               --HN_ONBASE.MA_PASIVOS
	 , D.CATEGORIA												AS  CATEGORIA                                  --HN_ONBASE.MA_PASIVOS
	 , D.MONEDA													AS  MONEDA                                     --HN_ONBASE.MA_PASIVOS
	 , D.FECHA_APERTURA											AS  FECHAAPERTURA                              --HN_ONBASE.MA_PASIVOS
	 , D.FECHA_CANCELACION										AS  FECHACANCELACION                           --HN_ONBASE.MA_PASIVOS
	 , D.SALDO_ACTUAL											AS  SALDOACTUAL                                --HN_ONBASE.MA_PASIVOS
	 , D.SALDO_FIN_MES											AS  SALDOFINMES                                --HN_ONBASE.MA_PASIVOS
	 , D.SALDO_PROMEDIO											AS  SALDOPROMEDIO                              --HN_ONBASE.MA_PASIVOS
	 , D.TIPO_OPERACION											AS  TIPOOPERACION                              --HN_ONBASE.MA_PASIVOS
	 --, D.FECHA														AS  FECHAFINDEPERIODO                          --HN_ONBASE.MA_PASIVOS
    FROM  CREDITOS_RIESGOS.HN_ONBASE.MA_PASIVOS   D  
WHERE D.NUMERO_IDENTIDAD = @IDENTIDAD
UNION 
SELECT	
		T1.[Numero_Cuenta]				AS  NUMEROCUENTA,
		T1.[Categoria]					AS  CATEGORIA,
		T1.[Moneda]						AS  MONEDA,
		T1.[Fecha_Apertura]				AS  FECHAAPERTURA,
		T1.[Fecha_Cancelacion]			AS  FECHACANCELACION,
		T1.[Saldo_Actual]				AS  SALDOACTUAL,
		T1.[Saldo_Fin_Mes]				AS  SALDOFINMES,
		T1.[Saldo_Promedio]				AS  SALDOPROMEDIO,	
		T1.[Tipo_Operacion]				AS  TIPOOPERACION   
	
FROM CREDITOS_RIESGOS.HN_ONBASE.Ma_Pasivos_XML AS T1 
WHERE T1.Numero_Identidad = @IDENTIDAD) AS B
FOR XML RAW('CUENTA'),ROOT('PASIVOS'));
SET @XML_CLIENTE.modify('insert sql:variable("@XML_PASIVOS") into (/CLIENTE)[1] ')

 ----------------------------TRANSACCIONES PASIVO-------------------------------------
 SET @XML_TRXPASIVOS=
 (SELECT 
   E.Cuenta
 , E.SALDO_FIN												AS  SALDOFIN                                   --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.SALDO_MAX												AS  SALDOMAX                                   --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.SALDO_MIN												AS  SALDOMIN                                   --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.SALDO_PROMEDIO											AS  SALDOPROMEDIO                              --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.FECHA_ULTIMO_CREDITO									AS  FECHAULTIMOCREDITO                         --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.NUMERO_CREDITOS										AS  NUMEROCREDITOS                             --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.MONTO_CREDITOS											AS  MONTOCREDITOS                              --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.FECHA_ULTIMO_DEBITO									AS  FECHAULTIMODEBITO                          --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.NUMERO_DEBITOS											AS  NUMERODEBITOS                              --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.MONTO_DEBITOS											AS  MONTODEBITOS                               --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.NUMERO_INTERESES_DEBITOS								AS  NUMEROINTERESESDEBITOS                     --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.MONTO_INTERESES_DEBITOS								AS  MONTOINTERESESDEBITOS                      --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.NUMERO_INTERESES_CREDITOS								AS  NUMEROINTERESESCREDITOS                    --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.MONTO_INTERESES_CREDITOS								AS  MONTOINTERESESCREDITOS                     --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.FLAG_FACILIDADES_CUENTA								AS  FLAGFACILIDADESCUENTA                      --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.FLAG_REPRESENTANTE_LEGAL								AS  FLAGREPRESENTANTELEGAL                     --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.FLAG_CUENTA_PLANILLA									AS  FLAGCUENTAPLANILLA                         --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.MONTO_ACREDITADO_PLANILLA								AS  MONTOACREDITADOPLANILLA                    --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.FLAG_CUENTA_MANCOMUNADA								AS  FLAGCUENTAMANCOMUNADA                      --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.FLAG_BLOQUEO_CUENTA									AS  FLAGBLOQUEOCUENTA                          --HN_ONBASE.MA_TRANSACCIONESPASIVOS
 , E.Fecha_Finde_Periodo							        AS  FECHAFINDEPERIODO						   --HN_ONBASE.MA_TRANSACCIONESPASIVOS
  FROM              CREDITOS_RIESGOS.HN_ONBASE.MA_TRANSACCIONESPASIVOS   E
         INNER JOIN CREDITOS_RIESGOS.HN_ONBASE.MA_PASIVOS                D ON E.Cuenta = D.Numero_Cuenta
		WHERE D.Numero_Identidad = @IDENTIDAD  
   FOR XML RAW('CUENTA'),ROOT('TRANSACCIONESPASIVOS')); 
   SET @XML_CLIENTE.modify('insert sql:variable("@XML_TRXPASIVOS") into (/CLIENTE)[1] ');

  
-----------------------------------TARJETAS-------------------------------------------
SET @XML_TARJETAS = 
(SELECT 
   F.NUMERO_CUENTA              							AS  NUMEROCUENTA                               --HN_ONBASE.MA_TARJETAS en revision
 , F.BEHAVIORSCORE											AS  BEHAVIORSCORE                              --HN_ONBASE.MA_TARJETAS
 , F.CALIFICACION_SCORE										AS  CALIFICACIONSCORE                          --HN_ONBASE.MA_TARJETAS
 , F.CALIFICACION_SCORE_CLIENTE								AS  CALIFICACIONSCORECLIENTE                   --HN_ONBASE.MA_TARJETAS
 , F.ESTADO													AS  ESTADO                                     --HN_ONBASE.MA_TARJETAS en revision
 , F.GRUPO_AFINIDAD											AS  GRUPOAFINIDAD                              --HN_ONBASE.MA_TARJETAS
 , F.PRODUCTO												AS  PRODUCTO                                   --HN_ONBASE.MA_TARJETAS
   /*, F.MODELO_LIQUIDACION										AS  MODELOLIQUIDACION                          --HN_ONBASE.MA_TARJETAS  queda fuera por proyecto migracion rmt151 wahe 20220203*/ 
 , F.FECHA_APERTURA											AS  FECHAAPERTURA                              --HN_ONBASE.MA_TARJETAS
 , F.FECHA_CANCELACION										AS  FECHACANCELACION                           --HN_ONBASE.MA_TARJETAS
 , F.FECHA_ULTIMO_EXTRA										AS  FECHAULTIMOEXTRA                           --HN_ONBASE.MA_TARJETAS
 , F.MORA_ACTUAL											AS  MORAACTUAL                                 --HN_ONBASE.MA_TARJETAS
 , F.LIMITE_ACTUAL											AS  LIMITEACTUAL                               --HN_ONBASE.MA_TARJETAS
 , F.SALDO_ACTUAL											AS  SALDOACTUAL                                --HN_ONBASE.MA_TARJETAS
 , F.SALDO_CORTE											AS  SALDOCORTE                                 --HN_ONBASE.MA_TARJETAS
 , F.SALDO_EXTRA											AS  SALDOEXTRA                                 --HN_ONBASE.MA_TARJETAS
 , F.SALDO_INTRA											AS  SALDOINTRA                                 --HN_ONBASE.MA_TARJETAS
 , F.CUOTASEXTRAVIGENTES									AS  CUOTASEXTRAVIGENTES                        --HN_ONBASE.MA_TARJETAS
 , F.FechaDescuentoContado									AS  FECHADESCUENTOCONTADO                      --HN_ONBASE.MA_TARJETAS
 
 ----------------------------v2 rmt151 WAHE 20210717----------------------
 ,MOROSIDADHISTORICA_LOC									AS  MOROSIDADHISTORICA_LOC
 ,MOROSIDADHISTORICA_USD									AS  MOROSIDADHISTORICA_USD						
 ,FLAG_CASTIGO												AS  FLAG_CASTIGO
 ,FECBLOQUE1												AS  FECBLOQUE1
 ,FECBLOQUE2												AS  FECBLOQUE2
 ,CODBLOQUE1												AS  CODBLOQUE1
 ,CODBLOQUE2												AS  CODBLOQUE2
 ,FECHA_APROBACION_EXTRA									AS  FECHA_APROBACION_EXTRA
 ,FECHA_APROBACION_INTRA									AS  FECHA_APROBACION_INTRA
 ,FECHA_APROBACION_PIL										AS  FECHA_APROBACION_PIL
 ,LIMITE_PREVIO												AS  LIMITE_PREVIO
 ,SALDO_AUTORIZACION 										AS  SALDO_AUTORIZACION 
 
 -------------------------------------------------------------------------
  FROM  CREDITOS_RIESGOS.HN_ONBASE.MA_TARJETAS  F
  WHERE ltrim(rtrim(Identidad)) = @IDENTIDAD       ----Ajuste para pruebas por problemas de calidad de datos Wahe 21/01/2022
  FOR XML RAW('CUENTA'),ROOT('TARJETAS')
); 
SET @XML_CLIENTE.modify('insert sql:variable("@XML_TARJETAS") into (/CLIENTE)[1]')

 
-------------------------TRANSACCIONES TARJETAS------------------------------------
SET @XML_TRXTARJETAS = (
SELECT 
   G.CODIGO_CUENTA											AS  NUMEROCUENTA                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.FECHA_CORTE_HACE_1										AS  FECHACORTE_1                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.FECHA_CORTE_HACE_2										AS  FECHACORTE_2                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.FECHA_CORTE_HACE_3										AS  FECHACORTE_3                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.FECHA_CORTE_HACE_4										AS  FECHACORTE_4                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.FECHA_CORTE_HACE_5										AS  FECHACORTE_5                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.FECHA_CORTE_HACE_6										AS  FECHACORTE_6                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.FECHA_CORTE_HACE_7										AS  FECHACORTE_7                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.FECHA_CORTE_HACE_8										AS  FECHACORTE_8                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.FECHA_CORTE_HACE_9										AS  FECHACORTE_9                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.FECHA_CORTE_HACE_10									AS  FECHACORTE_10                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.FECHA_CORTE_HACE_11									AS  FECHACORTE_11                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.FECHA_CORTE_HACE_12									AS  FECHACORTE_12                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_CORTE_HACE_1										AS  SALDOCORTE_1                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_CORTE_HACE_2										AS  SALDOCORTE_2                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_CORTE_HACE_3										AS  SALDOCORTE_3                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_CORTE_HACE_4										AS  SALDOCORTE_4                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_CORTE_HACE_5										AS  SALDOCORTE_5                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_CORTE_HACE_6										AS  SALDOCORTE_6                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_CORTE_HACE_7										AS  SALDOCORTE_7                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_CORTE_HACE_8										AS  SALDOCORTE_8                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_CORTE_HACE_9										AS  SALDOCORTE_9                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_CORTE_HACE_10									AS  SALDOCORTE_10                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_CORTE_HACE_11									AS  SALDOCORTE_11                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_CORTE_HACE_12									AS  SALDOCORTE_12                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGO_MINIMO_HACE_1										AS  PAGOMINIMO_1                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGO_MINIMO_HACE_2										AS  PAGOMINIMO_2                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGO_MINIMO_HACE_3										AS  PAGOMINIMO_3                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGO_MINIMO_HACE_4										AS  PAGOMINIMO_4                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGO_MINIMO_HACE_5										AS  PAGOMINIMO_5                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGO_MINIMO_HACE_6										AS  PAGOMINIMO_6                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGO_MINIMO_HACE_7										AS  PAGOMINIMO_7                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGO_MINIMO_HACE_8										AS  PAGOMINIMO_8                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGO_MINIMO_HACE_9										AS  PAGOMINIMO_9                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGO_MINIMO_HACE_10									AS  PAGOMINIMO_10                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGO_MINIMO_HACE_11									AS  PAGOMINIMO_11                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGO_MINIMO_HACE_12									AS  PAGOMINIMO_12                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGOS_HACE_1											AS  PAGOS_1									   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGOS_HACE_2											AS  PAGOS_2									   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGOS_HACE_3											AS  PAGOS_3									   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGOS_HACE_4											AS  PAGOS_4                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGOS_HACE_5											AS  PAGOS_5                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGOS_HACE_6											AS  PAGOS_6                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGOS_HACE_7											AS  PAGOS_7                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGOS_HACE_8											AS  PAGOS_8                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGOS_HACE_9											AS  PAGOS_9                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGOS_HACE_10											AS  PAGOS_10                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGOS_HACE_11											AS  PAGOS_11                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.PAGOS_HACE_12											AS  PAGOS_12                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CONSUMOS_HACE_1										AS  CONSUMOS_1                                 --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CONSUMOS_HACE_2										AS  CONSUMOS_2                                 --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CONSUMOS_HACE_3										AS CONSUMOS_3                                  --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CONSUMOS_HACE_4										AS CONSUMOS_4                                  --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CONSUMOS_HACE_5										AS CONSUMOS_5                                  --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CONSUMOS_HACE_6										AS CONSUMOS_6                                  --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CONSUMOS_HACE_7										AS CONSUMOS_7                                  --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CONSUMOS_HACE_8										AS CONSUMOS_8                                  --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CONSUMOS_HACE_9										AS CONSUMOS_9                                  --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CONSUMOS_HACE_10										AS CONSUMOS_10                                 --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CONSUMOS_HACE_11										AS CONSUMOS_11                                 --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CONSUMOS_HACE_12										AS CONSUMOS_12                                 --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.RETIROS_HACE_1											AS RETIROS_1                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.RETIROS_HACE_2											AS RETIROS_2                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.RETIROS_HACE_3											AS RETIROS_3                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.RETIROS_HACE_41										AS RETIROS_4                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.RETIROS_HACE_5											AS RETIROS_5                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.RETIROS_HACE_6											AS RETIROS_6                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.RETIROS_HACE_7											AS RETIROS_7                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.RETIROS_HACE_8											AS RETIROS_8                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.RETIROS_HACE_9											AS RETIROS_9                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.RETIROS_HACE_10										AS RETIROS_10                                  --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.RETIROS_HACE_11										AS RETIROS_11                                  --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.RETIROS_HACE_12										AS RETIROS_12                                  --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.LIMITE_HACE_1											AS LIMITE_1                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.LIMITE_HACE_2											AS LIMITE_2                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.LIMITE_HACE_3											AS LIMITE_3                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.LIMITE_HACE_4											AS LIMITE_4                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.LIMITE_HACE_5											AS LIMITE_5                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.LIMITE_HACE_6											AS LIMITE_6                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.LIMITE_HACE_7											AS LIMITE_7                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.LIMITE_HACE_8											AS LIMITE_8                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.LIMITE_HACE_9											AS LIMITE_9                                    --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.LIMITE_HACE_10											AS LIMITE_10                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.LIMITE_HACE_11											AS LIMITE_11                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.LIMITE_HACE_12											AS LIMITE_12                                   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTRAS_TRANSACCIONES_HACE_1								AS  OTRASTRANSACCIONES_1                       --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTRAS_TRANSACCIONES_HACE_2								AS  OTRASTRANSACCIONES_2                       --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTRAS_TRANSACCIONES_HACE_3								AS  OTRASTRANSACCIONES_3                       --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTRAS_TRANSACCIONES_HACE_4								AS  OTRASTRANSACCIONES_4                       --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTRAS_TRANSACCIONES_HACE_5								AS  OTRASTRANSACCIONES_5                       --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTRAS_TRANSACCIONES_HACE_6								AS  OTRASTRANSACCIONES_6                       --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTRAS_TRANSACCIONES_HACE_7								AS  OTRASTRANSACCIONES_7                       --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTRAS_TRANSACCIONES_HACE_8								AS  OTRASTRANSACCIONES_8                       --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTRAS_TRANSACCIONES_HACE_9								AS  OTRASTRANSACCIONES_9                       --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTRAS_TRANSACCIONES_HACE_10							AS  OTRASTRANSACCIONES_10                      --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTRAS_TRANSACCIONES_HACE_11							AS  OTRASTRANSACCIONES_11                      --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTRAS_TRANSACCIONES_HACE_12							AS  OTRASTRANSACCIONES_12                      --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_HACE_1										AS  INTERESES_1                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_HACE_2										AS  INTERESES_2                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_HACE_3										AS  INTERESES_3                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_HACE_4										AS  INTERESES_4                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_HACE_5                  						AS INTERESES_5                                 --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_HACE_6                  						AS INTERESES_6                                 --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_HACE_7                  						AS INTERESES_7                                 --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_HACE_8                  						AS INTERESES_8                                 --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_HACE_9                  						AS INTERESES_9                                 --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_HACE_10                 						AS INTERESES_10                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_HACE_11                 						AS INTERESES_11                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_HACE_12                 						AS INTERESES_12                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.TOTAL_CARGOS_HACE_1               						AS TOTALCARGOS_1                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.TOTAL_CARGOS_HACE_2               						AS TOTALCARGOS_2                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.TOTAL_CARGOS_HACE_3               						AS TOTALCARGOS_3                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.TOTAL_CARGOS_HACE_4               						AS TOTALCARGOS_4                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.TOTAL_CARGOS_HACE_5               						AS TOTALCARGOS_5                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.TOTAL_CARGOS_HACE_6               						AS TOTALCARGOS_6                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.TOTAL_CARGOS_HACE_7               						AS TOTALCARGOS_7                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.TOTAL_CARGOS_HACE_8               						AS TOTALCARGOS_8                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.TOTAL_CARGOS_HACE_9               						AS TOTALCARGOS_9                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.TOTAL_CARGOS_HACE_10              						AS TOTALCARGOS_10                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.TOTAL_CARGOS_HACE_11              						AS TOTALCARGOS_11                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.TOTAL_CARGOS_HACE_12              						AS TOTALCARGOS_12                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTROS_DEBITOS_HACE_1              						AS OTROSDEBITOS_1                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTROS_DEBITOS_HACE_2              						AS OTROSDEBITOS_2                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTROS_DEBITOS_HACE_3              						AS OTROSDEBITOS_3                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTROS_DEBITOS_HACE_4              						AS OTROSDEBITOS_4                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTROS_DEBITOS_HACE_5              						AS OTROSDEBITOS_5                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTROS_DEBITOS_HACE_6              						AS OTROSDEBITOS_6                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTROS_DEBITOS_HACE_7              						AS OTROSDEBITOS_7                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTROS_DEBITOS_HACE_8              						AS OTROSDEBITOS_8                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTROS_DEBITOS_HACE_9              						AS OTROSDEBITOS_9                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTROS_DEBITOS_HACE_10             						AS OTROSDEBITOS_10                             --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTROS_DEBITOS_HACE_11             						AS OTROSDEBITOS_11                             --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.OTROS_DEBITOS_HACE_12             						AS OTROSDEBITOS_12                             --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.MORA_HACE_1											AS MORA_1									   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.MORA_HACE_2											AS MORA_2                                      --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.MORA_HACE_3											AS MORA_3                                      --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.MORA_HACE_4											AS MORA_4                                      --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.MORA_HACE_5											AS MORA_5                                      --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.MORA_HACE_6											AS MORA_6                                      --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.MORA_HACE_7											AS MORA_7                                      --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.MORA_HACE_8											AS MORA_8                                      --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.MORA_HACE_9											AS MORA_9                                      --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.MORA_HACE_10											AS MORA_10                                     --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.MORA_HACE_11											AS MORA_11                                     --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.MORA_HACE_12											AS MORA_12                                     --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_TOTAL_HACE_1                						AS SALDOTOTAL_1                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_TOTAL_HACE_2                						AS SALDOTOTAL_2                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_TOTAL_HACE_3                						AS SALDOTOTAL_3                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_TOTAL_HACE_4                						AS SALDOTOTAL_4                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_TOTAL_HACE_5                						AS SALDOTOTAL_5                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_TOTAL_HACE_6                						AS SALDOTOTAL_6                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_TOTAL_HACE_7                						AS SALDOTOTAL_7                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_TOTAL_HACE_8                						AS SALDOTOTAL_8                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_TOTAL_HACE_9                						AS SALDOTOTAL_9                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_TOTAL_HACE_10               						AS SALDOTOTAL_10                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_TOTAL_HACE_11               						AS SALDOTOTAL_11                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_TOTAL_HACE_12               						AS SALDOTOTAL_12                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_EXTRA_HACE_1                						AS SALDOEXTRA_1                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_EXTRA_HACE_2                						AS SALDOEXTRA_2                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_EXTRA_HACE_3                						AS SALDOEXTRA_3                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_EXTRA_HACE_4                						AS SALDOEXTRA_4                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_EXTRA_HACE_5                						AS SALDOEXTRA_5                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_EXTRA_HACE_6                						AS SALDOEXTRA_6                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_EXTRA_HACE_7                						AS SALDOEXTRA_7                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_EXTRA_HACE_8                						AS SALDOEXTRA_8                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_EXTRA_HACE_9                						AS SALDOEXTRA_9                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_EXTRA_HACE_10               						AS SALDOEXTRA_10                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_EXTRA_HACE_11               						AS SALDOEXTRA_11                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_EXTRA_HACE_12               						AS SALDOEXTRA_12                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_EXTRA_HACE_1                						AS CUOTAEXTRA_1                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_EXTRA_HACE_2                						AS CUOTAEXTRA_2                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_EXTRA_HACE_3                						AS CUOTAEXTRA_3                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_EXTRA_HACE_4                						AS CUOTAEXTRA_4                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_EXTRA_HACE_5                						AS CUOTAEXTRA_5                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_EXTRA_HACE_6                						AS CUOTAEXTRA_6                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_EXTRA_HACE_7                						AS CUOTAEXTRA_7                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_EXTRA_HACE_8                						AS CUOTAEXTRA_8                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_EXTRA_HACE_9                						AS CUOTAEXTRA_9                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_EXTRA_HACE_10               						AS CUOTAEXTRA_10                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_EXTRA_HACE_11               						AS CUOTAEXTRA_11                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_EXTRA_HACE_12               						AS CUOTAEXTRA_12                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_EXTRA_HACE_1            						AS INTERESESEXTRA_1                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_EXTRA_HACE_2            						AS INTERESESEXTRA_2                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_EXTRA_HACE_3            						AS INTERESESEXTRA_3                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_EXTRA_HACE_4            						AS INTERESESEXTRA_4                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_EXTRA_HACE_5            						AS INTERESESEXTRA_5                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_EXTRA_HACE_6            						AS INTERESESEXTRA_6                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_EXTRA_HACE_7            						AS INTERESESEXTRA_7                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_EXTRA_HACE_8            						AS INTERESESEXTRA_8                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_EXTRA_HACE_9            						AS INTERESESEXTRA_9                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_EXTRA_HACE_10           						AS INTERESESEXTRA_10                           --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_EXTRA_HACE_11           						AS INTERESESEXTRA_11                           --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERESES_EXTRA_HACE_12           						AS INTERESESEXTRA_12                           --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_EXTRA_HACE_1               						AS CARGOSEXTRA_1                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_EXTRA_HACE_2               						AS CARGOSEXTRA_2                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_EXTRA_HACE_3               						AS CARGOSEXTRA_3                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_EXTRA_HACE_4               						AS CARGOSEXTRA_4                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_EXTRA_HACE_5               						AS CARGOSEXTRA_5                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_EXTRA_HACE_6               						AS CARGOSEXTRA_6                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_EXTRA_HACE_7               						AS CARGOSEXTRA_7                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_EXTRA_HACE_8               						AS CARGOSEXTRA_8                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_EXTRA_HACE_9               						AS CARGOSEXTRA_9                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_EXTRA_HACE_10              						AS CARGOSEXTRA_10                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_EXTRA_HACE_11              						AS CARGOSEXTRA_11                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_EXTRA_HACE_12              						AS CARGOSEXTRA_12                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_INTRA_HACE_1                						AS SALDOINTRA_1                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_INTRA_HACE_2                						AS SALDOINTRA_2                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_INTRA_HACE_3                						AS SALDOINTRA_3                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_INTRA_HACE_4                						AS SALDOINTRA_4								   --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_INTRA_HACE_5                						AS SALDOINTRA_5                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_INTRA_HACE_6                						AS SALDOINTRA_6                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_INTRA_HACE_7                						AS SALDOINTRA_7                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_INTRA_HACE_8                						AS SALDOINTRA_8                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_INTRA_HACE_9                						AS SALDOINTRA_9                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_INTRA_HACE_10               						AS SALDOINTRA_10                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_INTRA_HACE_11               						AS SALDOINTRA_11                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.SALDO_INTRA_HACE_12               						AS SALDOINTRA_12                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_INTRA_HACE_1                						AS CUOTAINTRA_1                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_INTRA_HACE_2                						AS CUOTAINTRA_2                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_INTRA_HACE_3                						AS CUOTAINTRA_3                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_INTRA_HACE_4                						AS CUOTAINTRA_4                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_INTRA_HACE_5                						AS CUOTAINTRA_5                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_INTRA_HACE_6                						AS CUOTAINTRA_6                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_INTRA_HACE_7                						AS CUOTAINTRA_7                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_INTRA_HACE_8                						AS CUOTAINTRA_8                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_INTRA_HACE_9                						AS CUOTAINTRA_9                                --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_INTRA_HACE_10               						AS CUOTAINTRA_10                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_INTRA_HACE_11               						AS CUOTAINTRA_11                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CUOTA_INTRA_HACE_12               						AS CUOTAINTRA_12                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERES_INTRA_HACE_1              						AS INTERESESINTRA_1                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERES_INTRA_HACE_2              						AS INTERESESINTRA_2                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERES_INTRA_HACE_3              						AS INTERESESINTRA_3                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERES_INTRA_HACE_4              						AS INTERESESINTRA_4                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERES_INTRA_HACE_5              						AS INTERESESINTRA_5                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERES_INTRA_HACE_6              						AS INTERESESINTRA_6                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERES_INTRA_HACE_7              						AS INTERESESINTRA_7                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERES_INTRA_HACE_8              						AS INTERESESINTRA_8                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERES_INTRA_HACE_9              						AS INTERESESINTRA_9                            --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERES_INTRA_HACE_10             						AS INTERESESINTRA_10                           --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERES_INTRA_HACE_11             						AS INTERESESINTRA_11                           --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.INTERES_INTRA_HACE_12             						AS INTERESESINTRA_12                           --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_INTRA_HACE_1               						AS CARGOSINTRA_1                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_INTRA_HACE_2               						AS CARGOSINTRA_2                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_INTRA_HACE_3               						AS CARGOSINTRA_3                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_INTRA_HACE_4               						AS CARGOSINTRA_4                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_INTRA_HACE_5               						AS CARGOSINTRA_5                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_INTRA_HACE_6               						AS CARGOSINTRA_6                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_INTRA_HACE_7               						AS CARGOSINTRA_7                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_INTRA_HACE_8               						AS CARGOSINTRA_8                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_INTRA_HACE_9               						AS CARGOSINTRA_9                               --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_INTRA_HACE_10              						AS CARGOSINTRA_10                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_INTRA_HACE_11              						AS CARGOSINTRA_11                              --HN_ONBASE.MA_TRANSACCIONESTARJETA
 , G.CARGOS_INTRA_HACE_12              						AS CARGOSINTRA_12                              --HN_ONBASE.MA_TRANSACCIONESTARJETA 
 ----------------------------v2 rmt151 WAHE 20210717----------------------
  ,[Total_Compras_Hace_1]									AS Total_Compras_1
  ,[Total_Compras_Hace_2]									AS Total_Compras_2
  ,[Total_Compras_Hace_3]									AS Total_Compras_3
  ,[Total_Compras_Hace_4]									AS Total_Compras_4
  ,[Total_Compras_Hace_5]									AS Total_Compras_5
  ,[Total_Compras_Hace_6]									AS Total_Compras_6
  ,[Total_Compras_Hace_7]									AS Total_Compras_7
  ,[Total_Compras_Hace_8]									AS Total_Compras_8
  ,[Total_Compras_Hace_9]									AS Total_Compras_9
  ,[Total_Compras_Hace_10]									AS Total_Compras_10
  ,[Total_Compras_Hace_11]									AS Total_Compras_11
  ,[Total_Compras_Hace_12]									AS Total_Compras_12
  ,[Disponible_hace_1]										AS Disponible_1
  ,[Disponible_hace_2]										AS Disponible_2
  ,[Disponible_hace_3]										AS Disponible_3
  ,[Disponible_hace_4]										AS Disponible_4
  ,[Disponible_hace_5]										AS Disponible_5
  ,[Disponible_hace_6]										AS Disponible_6
  ,[Disponible_hace_7]										AS Disponible_7
  ,[Disponible_hace_8]										AS Disponible_8
  ,[Disponible_hace_9]										AS Disponible_9
  ,[Disponible_hace_10]										AS Disponible_10
  ,[Disponible_hace_11]										AS Disponible_11
  ,[Disponible_hace_12]										AS Disponible_12
  -------------------------------------------------------------------------
   FROM  CREDITOS_RIESGOS.HN_ONBASE.MA_TRANSACCIONESTARJETA G
  WHERE G.IDENTIDAD     = @IDENTIDAD
  FOR XML RAW('CUENTA'),ROOT('TRANSACCIONESTARJETA')); 
  SET @XML_CLIENTE.modify('insert sql:variable("@XML_TRXTARJETAS") into (/CLIENTE)[1]')
  ------------------------------------------EXTRAFIN-----------------------------------------
  SET @XML_EXTRAFIN = (
  SELECT  
	  L.NUMUSU												    AS NUMEROCUENTA								   --YSERA.DWHOUSE.EXTRAFIN
	 , CONVERT(VARCHAR(10),L.FECHA_ORIGINAL_CUPON,120)			AS FECHAEXTRA								   --YSERA.DWHOUSE.EXTRAFIN
	 , L.TASA_COSTO_FINANCIERO									AS TASAEXTRA								   --YSERA.DWHOUSE.EXTRAFIN
	 --, L.IMPORTE_TOTAL_PLAN 									AS MONTOTOMADO								   --YSERA.DWHOUSE.EXTRAFIN
	 , L.CAPITAL_PENDIENTE_LIQUIDAR       						AS MONTOTOMADO								   --agregado el 20201221 segun correo recibido Allan Argueta el 20201211 Wahe
	 , L.MONTO_CUOTA											AS CUOTAEXTRA								   --YSERA.DWHOUSE.EXTRAFIN								
	 , L.CUOTA_NRO												AS CUOTANUMERO								   --YSERA.DWHOUSE.EXTRAFIN
	 , L.CUOTAS_PLAN											AS TOTALCUOTAS								   --YSERA.DWHOUSE.EXTRAFIN
	  FROM CREDITOS_RIESGOS.HN_ONBASE.EXTRAFIN    L, 
	       CREDITOS_RIESGOS.HN_ONBASE.Ma_Tarjetas B
	  WHERE  /*CONVERT (VARCHAR(10),L.FECHA_CARGA,120) = CONVERT(VARCHAR(10),GETDATE(),120)
	  AND*/ L.NUMUSU = B.Numero_Cuenta
	  AND B.Identidad = @IDENTIDAD	 
	  FOR XML RAW('CUENTA'),ROOT('EXTRAFIN')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_EXTRAFIN") into (/CLIENTE)[1]')
	  
  ------------------------------PRESTAMOS--------------------------------------------
 SET @XML_PRESTAMOS =(
    SELECT 
       H.NUMERO_CONTRATO										AS NUMEROCONTRATO                              --HN_ONBASE.OR_PRESTAMOS
     , H.Numero_Prestamo										AS NUMEROPRESTAMO                              --HN_ONBASE.OR_PRESTAMOS
     , H.CODIGO_AGENCIA											AS CODIGOAGENCIA                               --HN_ONBASE.OR_PRESTAMOS
     , H.CODIGO_SUB_APLICACION               					AS CODIGOSUBAPLICACION                         --HN_ONBASE.OR_PRESTAMOS
     , H.FECHA_APERTURA											AS FECHAAPERTURA                               --HN_ONBASE.OR_PRESTAMOS
     , H.FECHA_CANCELACION                  					AS FECHACANCELACION                            --HN_ONBASE.OR_PRESTAMOS
     , H.MONTO_INICIAL											AS MONTOINICIAL                                --HN_ONBASE.OR_PRESTAMOS
     , H.SALDO_ACTUAL											AS SALDOACTUAL                                 --HN_ONBASE.OR_PRESTAMOS
     , H.VALOR_CUOTA											AS VALORCUOTA                                  --HN_ONBASE.OR_PRESTAMOS
     , H.TASA													AS TASA                                        --HN_ONBASE.OR_PRESTAMOS
     , H.PLAZO													AS PLAZO                                       --HN_ONBASE.OR_PRESTAMOS
     , H.NUMERO_CUOTAS											AS NUMEROCUOTAS                                --HN_ONBASE.OR_PRESTAMOS
     , H.FECHA_PRIMER_PAGO_CAPITAL         						AS FECHAPRIMERPAGOCAPITAL                      --HN_ONBASE.MA_PRESTAMOS
     , H.FECHA_ULTIMO_PAGO                 						AS FECHAULTIMOPAGO                             --HN_ONBASE.MA_PRESTAMOS
     , H.CANTIDAD_CUOTAS_PAGADAS           						AS CANTIDADCUOTASPAGADAS                       --HN_ONBASE.MA_PRESTAMOS
     , H.FRECUENCIA_CAPITAL                						AS FRECUENCIACAPITAL                           --HN_ONBASE.MA_PRESTAMOS
     , H.CODIGO_DESTINO											AS CODIGODESTINO                               --HN_ONBASE.MA_PRESTAMOS
     , H.PRIMA_MENSUAL											AS PRIMAMENSUAL                                --HN_ONBASE.MA_PRESTAMOS
	 , H.Cargos													AS CARGOS
	 , H.codigo_tipo_garantia									AS CODIGOTIPOGARANTIA
	 , H.codigo_tipo_prestamo									AS CODIGOTIPOPRESTAMO
	 , H.interes												AS INTERES
	 , H.Mora_Actual											AS MORAACTUAL
	 , H.Otros_Cargos											AS OTROSCARGOS
	 , H.Seguros												AS SEGUROS
	 , H.Tipo_Deudor											AS TIPODEUDOR
    FROM CREDITOS_RIESGOS.HN_ONBASE.Ma_Prestamos  H
   WHERE H.Numero_Identidad = @IDENTIDAD
   FOR XML RAW('CUENTA'),ROOT('PRESTAMOS')); 
  SET @XML_CLIENTE.modify('insert sql:variable("@XML_PRESTAMOS") into (/CLIENTE)[1]')

------------------------TRANSACCIONES PRESTAMOS-----------------------------------------
SET @XML_TRXPRESTAMOS =(
 SELECT 
      J.NUMERO_PRESTAMO										AS NUMEROPRESTAMO                              --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
	, J.CODIGO_AGENCIA										AS CODIGOAGENCIA                               --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
	, J.CODIGO_SUB_APLICACION             					AS CODIGOSUBAPLICACION                         --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
	, J.FECHA_CIERRE										AS FECHACIERRE                                 --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
	, J.SALDO_TOTAL											AS ALDOTOTAL                                   --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
	, J.SALDO_CAPITAL										AS SALDOCAPITAL                                --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
	, J.SALDO_VENCIDO										AS SALDOVENCIDO                                --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
	, J.CARGOS												AS CARGOS                                      --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
	, J.INTERESES											AS INTERESES                                   --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
	, J.PAGOS												AS PAGOS									   --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
	, J.SEGUROS												AS SEGUROS									   --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
	, J.OTROS_CARGOS										AS OTROSCARGOS								   --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
	, J.MORA_CIERRE											AS MORACIERRE								   --HN_ONBASE.MA_TRANSACCIONESPRESTAMO
    FROM   CREDITOS_RIESGOS.HN_ONBASE.Ma_Prestamos               A,
	       CREDITOS_RIESGOS.HN_ONBASE.MA_TRANSACCIONESPRESTAMO   J
	WHERE A.Codigo_Agencia = J.Codigo_Agencia
	AND   A.Codigo_Sub_Aplicacion = J.Codigo_Sub_APlicacion
	AND   A.Numero_Prestamo = J.Numero_Prestamo
	AND   A.Numero_Identidad = @IDENTIDAD
	FOR XML RAW('CUENTA'),ROOT('TRANSACCIONESPRESTAMO')); 
  SET @XML_CLIENTE.modify('insert sql:variable("@XML_TRXPRESTAMOS") into (/CLIENTE)[1]')

  -------------------------------MA_OFERTA_PREAPROBADA------------------------------------
  SET @XML_OFERTA = (
  SELECT   
   K.FechaInformacion										AS FECHAINFORMACION                            --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAFICOCREDITO12           							AS OFERTAFICOCREDITO12                         --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAFICOCREDITO24           							AS OFERTAFICOCREDITO24                         --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAFICOCREDITO36           							AS OFERTAFICOCREDITO36                         --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAFICOCREDITO48           							AS OFERTAFICOCREDITO48                         --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAFICOCREDITO60           							AS OFERTAFICOCREDITO60                         --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.CUOTAFICOCREDITO										AS CUOTAFICOCREDITO                            --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.TASAFICOCREDITO               							AS TASAFICOCREDITO                             --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.TIMESINCOMEFICOCREDITO           						AS TIMESINCOMEFICOCREDITO                      --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAFICOYA12											AS OFERTAFICOYA12                              --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAFICOYA24											AS OFERTAFICOYA24                              --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAFICOYA36											AS OFERTAFICOYA36                              --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAFICOYA48											AS OFERTAFICOYA48                              --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAFICOYA60											AS OFERTAFICOYA60                              --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.CUOTAFICOYA											AS CUOTAFICOYA                                 --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.TASAFICOYA												AS TASAFICOYA                                  --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.TIMESINCOMEFICOYA               						AS TIMESINCOMEFICOYA                           --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAOPI12											AS OFERTAOPI12                                 --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAOPI24											AS OFERTAOPI24                                 --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAOPI36											AS OFERTAOPI36                                 --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAOPI48											AS OFERTAOPI48                                 --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTAOPI60											AS OFERTAOPI60                                 --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.CUOTAOPI												AS CUOTAOPI                                    --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.TASAOPI												AS TASAOPI                                     --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.TIMESINCOMEOPI											AS TIMESINCOMEOPI                              --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTARETANQUEO12               						AS OFERTARETANQUEO12                           --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTARETANQUEO24               						AS OFERTARETANQUEO24                           --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTARETANQUEO36               						AS OFERTARETANQUEO36                           --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTARETANQUEO48               						AS OFERTARETANQUEO48                           --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.OFERTARETANQUEO60               						AS OFERTARETANQUEO60                           --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.CUOTARETANQUEO											AS CUOTARETANQUEO                              --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.TASARETANQUEO											AS TASARETANQUEO                               --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , K.TIMESINCOMERETANQUEO           						AS TIMESINCOMERETANQUEO                        --HN_ONBASE.MA_OFERTA_PREAPROBADA
 , CONVERT(VARCHAR(10),GETDATE(),120)						AS FECHACARGA
 , SYSTEM_USER												AS USUARIO
	   FROM CREDITOS_RIESGOS.HN_ONBASE.MA_OFERTA_PREAPROBADA K
	WHERE K.IDENTIDAD = @IDENTIDAD 
   FOR XML RAW('OFERTA'),ROOT('OFERTAPREAPROBADA')); 
  SET @XML_CLIENTE.modify('insert sql:variable("@XML_OFERTA") into (/CLIENTE)[1]')
  
-------------------------------------EQX_CONTROL-----------------------------------------
SET @XML_EQX_CONTROL = (
  SELECT 
     b.IdEstudio,
	 b.ValorScore,
	 a.Fecha_Consulta
   --FROM  CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL			 A,
   --      CREDITOS_RIESGOS.HN_ONBASE.[RecordScore]          B
      FROM  [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL			A,
            [svrpruebas].BURO_EXTERNO.DBO.[RecordScore]        B
  where a.IdEstudio    = b.IdEstudio
  and   a.identidad    =  @IDENTIDAD
  and   A.IdEstudio    = @id_estudio
  FOR XML RAW('CUENTA'),ROOT('EQX_CONTROL')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_EQX_CONTROL") into (/CLIENTE)[1]'); 

	  
-------------------------------------RECORDB-----------------------------------------
SET @XML_RECORDB = ( 
SELECT 
	 --o.idEstudio												as idEstudio              
	 'BancaVigente'												as TipoReferencia  --- revisar 'BancaVigente'
	,o.operationNumber											as noReferencia
	,o.infoPeriod												as periodoInfo
	,o.creditorName												as Acreedor
	,o.category        											as Estado
	,o.obligationtype											as tipoObligacion
	,o.typeOrDestiny											as TipoPrestamo
	,o.warrantyType												as TipoGarantia
	,o.gaveDate													as FechaApertura
	,o.expdate													as FechaCancelacion
	,o.expDate													as FechaVencimiento
	,o.currency													as Moneda
	,o.category													as nivelMora
	,o.originalAmount											as LimiteMonto
	,o.actualDebt												as SaldoActual
	,o.punishedDebt												as SaldoCastigado
	,o.dwellingDebt												as SaldoMora
	,o.expiredDebt												as SaldoVencido
	,o.inExecutionDebt											as SaldoCobroJudicial
	,o.cuota													as Cuota
	,o.PAYWAY													as FormaPago
	,o.warrantyValue											as ValorGarantia
	--,c.valorScore												as Score
--FROM CREDITOS_RIESGOS.HN_ONBASE.RecordB             O,
--     CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL         B
FROM [svrpruebas].BURO_EXTERNO.DBO.RecordB             O,
     [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL         B
WHERE O.IdEstudio = B.IdEstudio
and   B.IDENTIDAD = @IDENTIDAD
and   O.IdEstudio = @id_estudio
	 FOR XML RAW('CUENTA'),ROOT('RECORDB')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RECORDB") into (/CLIENTE)[1]'); 

-------------------------------------RECORDd-----------------------------------------
SET @XML_RECORDD = ( 
SELECT 
	 --p.idEstudio				as idEstudio
	 'ComercioVigente' 			as TipoReferencia
	,p.referencia				as noReferencia
	,p.infoPeriod				as periodoInfo
	,p.infoSource				as Acreedor
	,p.accountStatus			as Estado
	,p.infoType					as TipoPrestamo
	,p.creditType				as TipoGarantia
	,p.openningDate				as FechaApertura
	,p.cancelationDate			as FechaCancelacion
	,p.lastDate					as FechaVencimiento
	,p.amountCurrencyType		as Moneda
	,p.dwellLevel				as nivelMora
	,p.changeFactor				as FactorCambio
	,p.givedAmount				as LimiteMonto
	,p.debt						as SaldoActual
	,p.dwellingDebt				as SaldoMora
	,p.paymentValue				as Cuota
	,p.numberOfPayments			as Plazo
	--,c.valorScore				as Score
--FROM CREDITOS_RIESGOS.HN_ONBASE.RecordD				P ,
--     CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL			B
FROM [svrpruebas].BURO_EXTERNO.DBO.RecordD				P ,
     [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL			B
WHERE P.IdEstudio = B.IdEstudio
and   B.IDENTIDAD = @IDENTIDAD
and   p.IdEstudio = @id_estudio
 FOR XML RAW('CUENTA'),ROOT('RECORDD')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RECORDD") into (/CLIENTE)[1]'); 
	  
-------------------------------------RECORDT-----------------------------------------
SET @XML_RECORDT = ( 	
	SELECT 
	 --n.idEstudio							as idEstudio
	'TarjetaVigente'					    as TipoReferencia
	,n.referencia							as noReferencia
	,n.infoPeriod							as periodoInfo
	,n.infoSource							as Acreedor
	,n.accountStatus						as Estado
	,n.coverage								as TipoPrestamo
	,n.openningDate							as FechaApertura
	,n.cancelationDate						as FechaCancelacion
	,null									as FechaVencimiento   --revisar este campo
	,n.currencyTypeGivedLimit				as Moneda
	,n.dwellLevel							as nivelMora
	,n.changeFactor							as FactorCambio
	,n.givedLimit							as LimiteMonto
	,n.debt									as SaldoActual
	,n.dwellingDebt							as SaldoMora
	,n.paymentValue							as Cuota
	--,c.valorScore							as Score
	--FROM CREDITOS_RIESGOS.HN_ONBASE.RecordT				N,
	--	 CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL			B
	FROM [svrpruebas].BURO_EXTERNO.DBO.RecordT				N,
		 [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL			B
	WHERE N.IdEstudio  = B.IdEstudio
	and   B.IDENTIDAD  = @IDENTIDAD
	and   N.IdEstudio = @id_estudio
	 FOR XML RAW('CUENTA'),ROOT('RECORDT')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RECORDT") into (/CLIENTE)[1]')
	  
-------------------------------------RECORDPRB-----------------------------------------
SET @XML_RECORDPRB = ( 
  SELECT 
	 --pr.idEstudio						as idEstudio
	'BancaHistorico'					as TipoReferencia
	,pr.operationNumber					as noReferencia
	,pr.infoPeriod						as periodoInfo
	,pr.creditorName					as Acreedor
	,pr.category						as Estado
	,pr.obligationtype					as tipoObligacion
	,pr.typeOrDestiny					as TipoPrestamo
	,pr.warrantyType					as TipoGarantia
	,pr.gaveDate						as FechaApertura
	,'19000101'							as FechaCancelacion
	,pr.expDate							as FechaVencimiento
	,pr.currency						as Moneda
	,pr.category						as nivelMora
	,pr.originalAmount					as LimiteMonto
	,pr.actualDebt						as SaldoActual
	,pr.punishedDebt					as SaldoCastigado
	,pr.dwellingDebt					as SaldoMora
	,pr.expiredDebt					    as SaldoVencido
	,pr.inExecutionDebt				    as SaldoCobroJudicial
	,null							    as Cuota  --No se encontro este campo
    ,pr.PAYWAY							as FormaPago
	,pr.warrantyValue					as ValorGarantia
			,c.conteoHistorico						as conteoHistoricoLoc
			,'000000000000'							as conteoHistoricoDol
			,C.categoriaHistorica					as MoraHistorica
  --    from      CREDITOS_RIESGOS.HN_ONBASE.RECORDPRB	pr
  --   inner join CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL	B on  pr.IdEstudio = B.IdEstudio
	 --left join  CREDITOS_RIESGOS.HN_ONBASE.RECORDhB		C on pr.idEstudio = c.idEstudio and pr.creditorName = c.acreedor and pr.operationNumber	= c.numeroReferencia
	  from      [svrpruebas].BURO_EXTERNO.DBO.RECORDPRB	pr
     inner join [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL	B on  pr.IdEstudio = B.IdEstudio
	 left join  [svrpruebas].BURO_EXTERNO.DBO.RECORDhB		C on pr.idEstudio = c.idEstudio and pr.creditorName = c.acreedor and pr.operationNumber	= c.numeroReferencia
	 WHERE B.IDENTIDAD  = @IDENTIDAD
	 and   PR.IdEstudio = @id_estudio
 FOR XML RAW('CUENTA'),ROOT('RECORDPRB')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RECORDPRB") into (/CLIENTE)[1]'); 
	  
-------------------------------------RECORDPRD-----------------------------------------
SET @XML_RECORDPRD = ( 
  SELECT 
	 --prd.idEstudio								as idEstudio
	 'ComercioHistorico'						as TipoReferencia
	,prd.referencia								as noReferencia
	,prd.infoPeriod								as periodoInfo
	,prd.infoSource								as Acreedor
	,prd.accountStatus							as Estado
	,prd.infoType								as TipoPrestamo
	,prd.creditType								as TipoGarantia
	,prd.openningDate							as FechaApertura
	,prd.cancelationDate						as FechaCancelacion
	,prd.lastDate								as FechaVencimiento
	,prd.amountCurrencyType						as Moneda
	,prd.dwellLevel								as nivelMora
	,prd.changeFactor							as FactorCambio
	,prd.givedAmount							as LimiteMonto
	,prd.debt									as SaldoActual
	,prd.dwellingDebt							as SaldoMora
	,prd.paymentValue							as Cuota
	,prd.numberOfPayments						as Plazo
	,c.ConteoHistorico								as conteoHistoricoLoc	
	,'000000000000'									as conteoHistoricoDol
	,c.CategoriaHistorica							as MoraHistorica
--FROM            CREDITOS_RIESGOS.HN_ONBASE.RECORDPRD    prd
--     inner join CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL  B  on prd.IdEstudio = B.IdEstudio
--	 left join  CREDITOS_RIESGOS.HN_ONBASE.RECORDHD		C  on prd.idEstudio = c.idEstudio and  prd.infoSource = c.acreedor and  prd.referencia = c.numeroreferencia 
FROM            [svrpruebas].BURO_EXTERNO.DBO.RECORDPRD    prd
     inner join [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL  B  on prd.IdEstudio = B.IdEstudio
	 left join  [svrpruebas].BURO_EXTERNO.DBO.RECORDHD		C  on prd.idEstudio = c.idEstudio and  prd.infoSource = c.acreedor and  prd.referencia = c.numeroreferencia 
where B.IDENTIDAD   = @IDENTIDAD
and   PRD.IdEstudio = @id_estudio
 FOR XML RAW('CUENTA'),ROOT('RECORDPRD')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RECORDPRD") into (/CLIENTE)[1]'); 
	  
-------------------------------------RECORDPRT-----------------------------------------
SET @XML_RECORDPRT = ( 
  SELECT 
	 --prt.idEstudio							as idEstudio
	 'TarjetaHistorico'						as TipoReferencia
	,prt.referencia							as noReferencia
	,prt.infoPeriod							as periodoInfo
	,prt.infoSource							as Acreedor
	,prt.accountStatus						as Estado
	,prt.coverage							as TipoPrestamo
	,prt.openningDate						as FechaApertura
	,prt.cancelationDate					as FechaCancelacion
	,'19000101'								as FechaVencimiento
	,prt.currencyTypeGivedLimit				as Moneda
	,prt.dwellLevel							as nivelMora
	,prt.changeFactor						as FactorCambio
	,prt.givedLimit							as LimiteMonto
	,prt.debt								as SaldoActual
	,prt.dwellingDebt						as SaldoMora
	,prt.paymentValue						as Cuota
	,C.ConteoHistoricoLoc					as conteoHistoricoLoc
	,c.ConteoHistoricoDol					as conteoHistoricoDol
	,c.vectorCategoriasTar					as MoraHistorica
--FROM            CREDITOS_RIESGOS.HN_ONBASE.RECORDPRT   prt
--     inner join CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL B on  prt.IdEstudio = B.IdEstudio
--	 left join  CREDITOS_RIESGOS.HN_ONBASE.RECORDHT	   C on prT.idEstudio	= c.IdEstudio and prT.infoSource = c.acreedor AND prT.referencia  = c.NumeroReferencia
FROM             [svrpruebas].BURO_EXTERNO.DBO.RECORDPRT   prt
     inner join  [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL B on  prt.IdEstudio = B.IdEstudio
	 left join   [svrpruebas].BURO_EXTERNO.DBO.RECORDHT	   C on prT.idEstudio	= c.IdEstudio and prT.infoSource = c.acreedor AND prT.referencia  = c.NumeroReferencia
WHERE prt.IdEstudio   = B.IdEstudio
and   B.IDENTIDAD     = @IDENTIDAD
and   PRT.IdEstudio   = @id_estudio
 FOR XML RAW('CUENTA'),ROOT('RECORDPRT')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RECORDPRT") into (/CLIENTE)[1]'); 
	 
-------------------------------------RecordHB-----------------------------------------
SET @XML_RecordHB = ( 
		select 
		 --a.idEstudio					as idEstudio
		'BancaVigente'					as TipoReferencia
		,a.operationNumber				as noReferencia
		,a.infoPeriod					as periodoInfo
		,a.creditorName					as Acreedor
		,a.category						as Estado
		,a.obligationtype				as tipoObligacion
		,a.typeOrDestiny				as TipoPrestamo
		,a.warrantyType					as TipoGarantia
		,b.categoriaHistorica			as MoraHistorica
		,b.conteoHistorico				as conteoHistoricoLoc
		,'000000000000'					as conteoHistoricoDol
		,a.gaveDate						as FechaApertura
		,'19000101'						as FechaCancelacion
		,a.expDate						as FechaVencimiento
		,a.currency						as Moneda
		,a.category						as nivelMora
		,a.originalAmount				as LimiteMonto
		,a.actualDebt					as SaldoActual
		,a.punishedDebt					as SaldoCastigado
		,a.dwellingDebt					as SaldoMora
		,a.expiredDebt					as SaldoVencido
		,a.inExecutionDebt				as SaldoCobroJudicial
		,a.cuota						as Cuota
		--,c.valorScore					as Score
	--from CREDITOS_RIESGOS.HN_ONBASE.[recordb]		a,
	--     CREDITOS_RIESGOS.HN_ONBASE.[recordhB]		b,
	--	 CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL     d
	from [svrpruebas].BURO_EXTERNO.DBO.[recordb]		a,
	     [svrpruebas].BURO_EXTERNO.DBO.[recordhB]		b,
		 [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL     d
   where a.idEstudio		= b.idEstudio
   and   a.creditorName		= b.acreedor 
   and   a.operationNumber	= b.numeroReferencia
   and   a.idEstudio		= d.idEstudio
   and   d.IDENTIDAD		= @IDENTIDAD
   and   A.IdEstudio        = @id_estudio
 FOR XML RAW('CUENTA'),ROOT('RECORDHB')); 
 SET @XML_CLIENTE.modify('insert sql:variable("@XML_RecordHB") into (/CLIENTE)[1]'); 
 
 -------------------------------------RecordHD-----------------------------------------
SET @XML_RecordHD = ( 
SELECT 
	-- a.idEstudio								as idEstudio
	'ComercioVigente' 							as TipoReferencia
	,a.referencia								as noReferencia
	,a.infoPeriod								as periodoInfo
	,a.infoSource								as Acreedor
	,a.accountStatus							as Estado
	,a.infoType									as TipoPrestamo
	,a.creditType								as TipoGarantia
	    ,c.categoriaHistorica					as MoraHistorica
		,c.conteoHistorico						as conteoHistoricoLoc
		,'000000000000'							as conteoHistoricoDol
	,a.openningDate								as FechaApertura
	,a.cancelationDate							as FechaCancelacion
	,a.lastDate									as FechaVencimiento
	,a.amountCurrencyType						as Moneda
	,a.dwellLevel								as nivelMora
	,a.changeFactor								as FactorCambio
	,a.givedAmount								as LimiteMonto
	,a.debt										as SaldoActual
	,a.dwellingDebt								as SaldoMora
	,a.paymentValue								as Cuota
	,a.numberOfPayments							as Plazo
	--,d.valorScore								as Score
--FROM CREDITOS_RIESGOS.HN_ONBASE.RecordD           A,
--     CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL       B,
--	 CREDITOS_RIESGOS.HN_ONBASE.[recordhD]        C
FROM [svrpruebas].BURO_EXTERNO.DBO.RecordD           A,
     [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL       B,
	 [svrpruebas].BURO_EXTERNO.DBO.[recordhD]        C
WHERE    a.IdEstudio        = B.IdEstudio
   and   a.idEstudio		= c.idEstudio
   and   a.referencia    	= c.numeroReferencia
and      B.IDENTIDAD        = @IDENTIDAD
and      A.IdEstudio        = @id_estudio
 FOR XML RAW('CUENTA'),ROOT('RECORDHD')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RecordHD") into (/CLIENTE)[1]'); 
	
-------------------------------------RecordHT-----------------------------------------
SET @XML_RECORDHT = ( 	
	SELECT 
	 --a.idEstudio							as idEstudio
	  'TarjetaVigente'				    	as TipoReferencia
	,a.referencia							as noReferencia
	,a.infoPeriod							as periodoInfo
	,a.infoSource							as Acreedor
	,a.accountStatus						as Estado
	,a.coverage								as TipoPrestamo
	,c.vectorCategoriasTar					as MoraHistorica
    ,c.conteoHistoricoLoc					as conteoHistoricoLoc
    ,c.conteoHistoricoDol					as conteoHistoricoDol
	,a.openningDate							as FechaApertura
	,a.cancelationDate						as FechaCancelacion
	,null									as FechaVencimiento   --revisar este campo
	,a.currencyTypeGivedLimit				as Moneda
	,a.dwellLevel							as nivelMora
	,a.changeFactor							as FactorCambio
	,a.givedLimit							as LimiteMonto
	,a.debt									as SaldoActual
	,a.dwellingDebt							as SaldoMora
	,a.paymentValue							as Cuota
	--,d.valorScore							as Score
   -- FROM CREDITOS_RIESGOS.HN_ONBASE.RecordT				A,
		 --CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL			B,
		 --CREDITOS_RIESGOS.HN_ONBASE.[recordhT]		    C
    FROM [svrpruebas].BURO_EXTERNO.DBO.RecordT				A,
		 [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL			B,
		 [svrpruebas].BURO_EXTERNO.DBO.[recordhT]		    C
	WHERE A.IdEstudio	= B.IdEstudio
	AND   A.IdEstudio	= C.IdEstudio
	AND   a.referencia  = c.NumeroReferencia
	and   B.IDENTIDAD   = @IDENTIDAD
	and   A.IdEstudio   = @id_estudio
	 FOR XML RAW('CUENTA'),ROOT('RECORDHT')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RECORDHT") into (/CLIENTE)[1]')
	    
-----------------------------------@XML_RecordA--------------------
SET @XML_RecordA = ( 
SELECT 
     a.[viewLength]
	,a.[viewReturnCode]
	,a.[viewId]
	,a.[creditor]
	,a.[debtorAddress]
	,a.[informationPeriod]
	,a.[candidateCorrelative]
	,a.[addresses_Id]
--FROM CREDITOS_RIESGOS.HN_ONBASE.RECORDA			    A,
--     CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL			B
FROM [svrpruebas].BURO_EXTERNO.DBO.RECORDA			    A,
     [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL			B
WHERE A.IdEstudio     = B.IdEstudio
and   B.IDENTIDAD     = @IDENTIDAD
and   A.IdEstudio   = @id_estudio
 FOR XML RAW('CUENTA'),ROOT('RECORDA')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RecordA") into (/CLIENTE)[1]'); 
	  
-----------------------------------@XML_RecordTel--------------------
SET @XML_RecordTel = ( 
SELECT 
     a.[numeroTelefono]
	,a.[periodoInformacion]
	,a.[telefonos_Id]
--FROM CREDITOS_RIESGOS.HN_ONBASE.RECORDTEL			A,
--     CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL		B
	 FROM [svrpruebas].BURO_EXTERNO.DBO.RECORDTEL		A,
          [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL	B
WHERE A.IdEstudio     = B.IdEstudio
and   B.IDENTIDAD     = @IDENTIDAD
and   A.IdEstudio   = @id_estudio
 FOR XML RAW('CUENTA'),ROOT('RECORDTEL')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RecordTel") into (/CLIENTE)[1]'); 

-----------------------------------@XML_RecordH--------------------
SET @XML_RecordH = ( 
SELECT 
      a.[inDate]
	 ,a.[inMotivation]
	 ,a.[currency]
	 ,a.[totalDebtAmount]
	 ,a.[changeFactor]
	 ,a.[infoDate]
	 ,a.[viewLength]
	 ,a.[viewReturnCode]
	 ,a.[viewId]
	 ,a.[creditor]
	 ,a.[debtorAddress]
	 ,a.[informationPeriod]
	 ,a.[candidateCorrelative]
	 ,a.[highRisk_Id]
--FROM CREDITOS_RIESGOS.HN_ONBASE.RECORDH			    A,
--     CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL			B
FROM [svrpruebas].BURO_EXTERNO.DBO.RECORDH			    A,
     [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL			B
WHERE A.IdEstudio     = B.IdEstudio
and   B.IDENTIDAD     = @IDENTIDAD
and   A.IdEstudio   = @id_estudio
 FOR XML RAW('CUENTA'),ROOT('RECORDH')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RecordH") into (/CLIENTE)[1]'); 
	  
-----------------------------------@XML_RecordS--------------------
SET @XML_RecordS = ( 
SELECT 
     a.[viewId]
	,a.[viewReturnCode]
	,a.[dwellDate]
	,a.[accountNumber]
	,a.[accountType]
	,a.[currency]
	,a.[dwellDays]
	,a.[debtorAddress]
	,a.[asocDebtorType]
	,a.[asocDebtor]
	,a.[infoDate]
	,a.[infoType]
	,a.[creditor]
	,a.[viewLength]
	,a.[candidateCorrelative]
	,a.[dwellAmount]
	,a.[changeFactor]
	,a.[moraMasReciente]
	,a.[sicom_Id]
--FROM CREDITOS_RIESGOS.HN_ONBASE.RECORDS			    A,
--     CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL			B
FROM [svrpruebas].BURO_EXTERNO.DBO.RECORDS			    A,
     [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL			B
WHERE A.IdEstudio     = B.IdEstudio
and   B.IDENTIDAD     = @IDENTIDAD
and   A.IdEstudio     = @id_estudio
 FOR XML RAW('CUENTA'),ROOT('RECORDS')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RecordS") into (/CLIENTE)[1]'); 
	  
-----------------------------------@XML_RecordC--------------------
SET @XML_RECORDC = ( 
SELECT 
       a.[viewId]
      ,a.[candidateCorrelative]
      ,a.[viewLength]
      ,a.[viewReturnCode]
      ,a.[infoPeriod]
      ,a.[actualPeriod]
      ,a.[whoMadeQuery]
      ,a.[queryDate]
      ,a.[infoConsultas_Id]
--FROM CREDITOS_RIESGOS.HN_ONBASE.RECORDC			    A,
--     CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL			B
FROM [svrpruebas].BURO_EXTERNO.DBO.RECORDC			    A,
     [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL			B
WHERE A.IdEstudio     = B.IdEstudio
and   B.IDENTIDAD     = @IDENTIDAD
and   A.IdEstudio   = @id_estudio
 FOR XML RAW('CUENTA'),ROOT('RECORDC')); 
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RecordC") into (/CLIENTE)[1]'); 

-----------------------------------@RECORDEVALUACION--------------------
SET @XML_RECORDEVALUACION = ( 
SELECT 
       a.[estadoIncobrableComercioUltimos12Meses]
      ,a.[numeroReferenciasBancaMoraVigente]
      ,a.[resultadoEvaluacion]
      ,a.[moraAntiguedadBancaEntre60y90]
      ,a.[moraAntiguedadBancaMayorIgual90]
      ,a.[saldoCastigadoUltimos12Meses]
      ,a.[numeroreRerenciasCateroriaV12Meses]
      ,a.[numeroReferenciasBancaPositivas]
      ,a.[numeroReferenciasTarjetasMoraVigente]
      ,a.[moraAntiguedadTarjetasEntre60y90]
      ,a.[moraAntiguedadTarjetasMayorIgual90]
      ,a.[numeroEstadoJuridicoUltimos12Meses]
      ,a.[estadoIncobrableTarjetasUltimos12Meses]
      ,a.[numeroReferenciasTarjetasPositivas]
      ,a.[numeroReferenciasComercioMoraVigente]
      ,a.[moraAntiguedadComercioEntre60y90]
      ,a.[moraAntiguedadComercioMayorIgual90]
      ,a.[numeroReferenciasComercioPositivas]
      ,a.[indicadorReferenciaPositiva]
      ,a.[indicadorReferenciaNegativa]
      ,a.[evaluacion_id]
--FROM CREDITOS_RIESGOS.HN_ONBASE.RECORDEVALUACION A,
--     CREDITOS_RIESGOS.HN_ONBASE.EQX_CONTROL		 B
FROM [svrpruebas].BURO_EXTERNO.DBO.RECORDEVALUACION A,
     [svrpruebas].BURO_EXTERNO.DBO.EQX_CONTROL		 B
	WHERE A.IdEstudio     = B.IdEstudio
	and   B.IDENTIDAD     = @IDENTIDAD
	and   A.IdEstudio     = @id_estudio
 FOR XML RAW('CUENTA'),ROOT('RECORDEVALUACION'));
      SET @XML_CLIENTE.modify('insert sql:variable("@XML_RECORDEVALUACION") into (/CLIENTE)[1]'); 

SELECT @XML_CLIENTE CLIENTE; 
 --set @F_fin_proc = getdate();
 --insert into  creditos_riesgos.hn_onbase.Log_Consulta_Cliente values (@IDENTIDAD,@id_estudio,@F_Ini_proc,@F_fin_proc,@F_Ini_Equi, @F_fin_equi);
END TRY

BEGIN CATCH

 declare @desc_error nvarchar(max) = concat(ERROR_MESSAGE(),'| EQX_ERROR: ', @msjError); 
 set @F_fin_proc = getdate();
-- insert into  creditos_riesgos.hn_onbase.Log_Consulta_Cliente values (@IDENTIDAD,@id_estudio,@F_Ini_proc,@F_fin_proc,@F_Ini_Equi, @F_fin_equi);
--insert into creditos_riesgos.hn_onbase.log_errores_consulta  values (@id_estudio,@F_fin_proc,@desc_error);

   SET @ErrorXML = (
        SELECT 
            @IDENTIDAD AS IDENTIDAD,
            ERROR_MESSAGE() AS ERROR
        FOR XML PATH('CLIENTE'), TYPE
    );
    SELECT @ErrorXML AS CLIENTE;

END CATCH;

