xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/OriginacionesGT/xsd/BLAZE_BOM_SALIDA_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/BLAZE_BOM_SALIDA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaCreditoCliente/xq/registraSalidaBlazeIn/";

declare function xf:registraSalidaBlazeIn($resultadoBlaze as xs:string, $numEval as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:pv_NumeroEvaluacion>{ $numEval }</ns0:pv_NumeroEvaluacion>
        	{
        	   let $temp := fn:replace(data($resultadoBlaze), "\|", ",.,")	
	           let $cadena := fn:replace(data($temp), "&amp;", "@")
	           let $cadenaNombres := substring-before($cadena, '@')
	           let $cadenaValores := substring-after($cadena, '@')
	           let $listValores := fn:tokenize($cadenaValores,",.,")
	           let $listNombres := fn:tokenize($cadenaNombres,",.,")
	          
	           for $i in 0 to count($listNombres)
	           return 
	           	(
					if ($listNombres[$i] = "CUSTOMER_ID") then (
		            	<ns0:pv_identidad>{ $listValores[$i] }</ns0:pv_identidad>
		            ) else if ($listNombres[$i] = "VAR1") then (
		            	<ns0:pv_var1>{ data($listValores[$i]) }</ns0:pv_var1>
		            ) else if ($listNombres[$i] = "VAR2") then (
		            	<ns0:pv_var2>{ data($listValores[$i]) }</ns0:pv_var2>
		            ) else if ($listNombres[$i] = "VAR3") then (
		            	<ns0:pv_var3>{ data($listValores[$i]) }</ns0:pv_var3>
		            ) else if ($listNombres[$i] = "VAR4") then (
		            	<ns0:pv_var4>{ data($listValores[$i]) }</ns0:pv_var4>
		            ) else if ($listNombres[$i] = "VAR5") then (
		            	<ns0:pv_var5>{ data($listValores[$i]) }</ns0:pv_var5>
		            ) else if ($listNombres[$i] = "VAR6") then (
		            	<ns0:pv_var6>{ data($listValores[$i]) }</ns0:pv_var6>
		            ) else if ($listNombres[$i] = "VAR7") then (
		            	<ns0:pv_var7>{ data($listValores[$i]) }</ns0:pv_var7>
		            ) else if ($listNombres[$i] = "VAR8") then (
		            	<ns0:pv_var8>{ data($listValores[$i]) }</ns0:pv_var8>
		            ) else if ($listNombres[$i] = "VAR9") then (
		            	<ns0:pv_var9>{ data($listValores[$i]) }</ns0:pv_var9>
		            ) else if ($listNombres[$i] = "VAR10") then (
		            	<ns0:pv_var10>{ data($listValores[$i]) }</ns0:pv_var10>
		            ) else if ($listNombres[$i] = "VAR11") then (
		            	<ns0:pv_var11>{ data($listValores[$i]) }</ns0:pv_var11>
		            ) else if ($listNombres[$i] = "VAR12") then (
		            	<ns0:pv_var12>{ data($listValores[$i]) }</ns0:pv_var12>
		            ) else if ($listNombres[$i] = "VAR13") then (
		            	<ns0:pv_var13>{ data($listValores[$i]) }</ns0:pv_var13>
		            ) else if ($listNombres[$i] = "VAR14") then (
		            	<ns0:pv_var14>{ data($listValores[$i]) }</ns0:pv_var14>
		            ) else if ($listNombres[$i] = "VAR15") then (
		            	<ns0:pv_var15>{ data($listValores[$i]) }</ns0:pv_var15>
		            ) else if ($listNombres[$i] = "REPORTED") then (
		            	<ns0:pv_flagSirc>{ data($listValores[$i]) }</ns0:pv_flagSirc>
		            ) else if ($listNombres[$i] = "HIT") then (
		            	<ns0:pv_flagNoHit>{ data($listValores[$i]) }</ns0:pv_flagNoHit>
		            ) else if ($listNombres[$i] = "HIT_SINREF") then (
		            	<ns0:pv_flagHitSinRefs>{ data($listValores[$i]) }</ns0:pv_flagHitSinRefs>
		            ) else if ($listNombres[$i] = "HIT_SCORE") then (
		            	<ns0:pv_ScoreHit>{ data($listValores[$i]) }</ns0:pv_ScoreHit>
		            ) else if ($listNombres[$i] = "NO_HIT_SCORE") then (
		            	<ns0:pv_ScoreNoHit>{ data($listValores[$i]) }</ns0:pv_ScoreNoHit>
		            ) else if ($listNombres[$i] = "VALID_REFERENCE_TYPE") then (
		            	<ns0:pv_tipoReferenciaValida>{ data($listValores[$i]) }</ns0:pv_tipoReferenciaValida>
		            ) else if ($listNombres[$i] = "ENTITY_REFERENCE") then (
		            	<ns0:pv_EntidadReferenciaValida>{ data($listValores[$i]) }</ns0:pv_EntidadReferenciaValida>
		            ) else if ($listNombres[$i] = "RISK_LEVEL") then (
		            	<ns0:pv_calificacion_riesgo>{ data($listValores[$i]) }</ns0:pv_calificacion_riesgo>
		            ) else if ($listNombres[$i] = "REFERENCE_VALID_TIME") then (
		            	<ns0:pv_antiguedadReferenciaValida>{ data($listValores[$i]) }</ns0:pv_antiguedadReferenciaValida>
		            ) else if ($listNombres[$i] = "MAX_AMOUNT_BANK") then (
		            	<ns0:pv_montoMaximaBanca>{ data($listValores[$i]) }</ns0:pv_montoMaximaBanca>
		            ) else if ($listNombres[$i] = "MAX_AMOUNT_COMMERCE") then (
		            	<ns0:pv_montoMaximoComercio>{ data($listValores[$i]) }</ns0:pv_montoMaximoComercio>
		            ) else if ($listNombres[$i] = "LIMIT_MAX_CARDS") then (
		            	<ns0:pv_LimiteMaxTarjeta>{ data($listValores[$i]) }</ns0:pv_LimiteMaxTarjeta>
		            ) else if ($listNombres[$i] = "ASSIGNED_LIMIT") then (
		            	<ns0:pv_limiteAsignado>{ data($listValores[$i]) }</ns0:pv_limiteAsignado>
		            ) else if ($listNombres[$i] = "SUGGESTED_PRODUCT") then (
		            	<ns0:pv_productoSugerido>{ data($listValores[$i]) }</ns0:pv_productoSugerido>
		            ) else if ($listNombres[$i] = "RESULT") then (
		            	<ns0:pv_CodigoResultado>{ data($listValores[$i]) }</ns0:pv_CodigoResultado>
		            ) else if ($listNombres[$i] = "RATE_LOAN") then (
		            	<ns0:pv_tasaPtmoFidu>{ data($listValores[$i]) }</ns0:pv_tasaPtmoFidu>
		            ) else if ($listNombres[$i] = "AMOUNT_LOAN") then (
		            	<ns0:pv_montoPtmoFidu>{ data($listValores[$i]) }</ns0:pv_montoPtmoFidu>
		            ) else ()
		         )
            }
        </ns0:InputParameters>
};

declare variable $resultadoBlaze as xs:string external;
declare variable $numEval as xs:string external;

xf:registraSalidaBlazeIn($resultadoBlaze, $numEval)