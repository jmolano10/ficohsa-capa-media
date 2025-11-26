(:: pragma bea:global-element-parameter parameter="$respuestaAbanks" element="ns2:OutputParameters" location="../Resources/ConsultaMovimientosCuenta/xsd/ORA_BANK_OSB_K_CONSULTAMOVSCUENTA_TOPLEVEL-24OSB_CON_MOVS_CTA.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$respuestaT24" element="ns0:ConsultaMovimientosCuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMovimientosCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTAMOVSCUENTA/TOPLEVEL-24OSB_CON_MOVS_CTA/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaMovimientosCuentaAbanks/consultaMovimientosCuentaMixtoOut/";

(: Retorna la fecha formateada a YYYYMMDD :)
declare function format-date 
  ( $date as xs:string )  as xs:string {
  if (fn:string($date) != "") then (
    if (fn:upper-case(substring($date, 4, 3)) = ("JAN", "ENE")) then (
    	concat("20", substring($date, 8, 2), "01", substring($date, 1, 2)) 
    ) else if (fn:upper-case(substring($date, 4, 3)) = "FEB") then (
    	concat("20", substring($date, 8, 2), "02", substring($date, 1, 2)) 
    ) else if (fn:upper-case(substring($date, 4, 3)) = "MAR") then (
    	concat("20", substring($date, 8, 2), "03", substring($date, 1, 2)) 
    ) else if (fn:upper-case(substring($date, 4, 3)) = ("APR", "ABR")) then (
    	concat("20", substring($date, 8, 2), "04", substring($date, 1, 2)) 
    ) else if (fn:upper-case(substring($date, 4, 3)) = "MAY") then (
    	concat("20", substring($date, 8, 2), "05", substring($date, 1, 2)) 
    ) else if (fn:upper-case(substring($date, 4, 3)) = "JUN") then (
    	concat("20", substring($date, 8, 2), "06", substring($date, 1, 2)) 
    ) else if (fn:upper-case(substring($date, 4, 3)) = "JUL") then (
    	concat("20", substring($date, 8, 2), "07", substring($date, 1, 2)) 
    ) else if (fn:upper-case(substring($date, 4, 3)) = ("AUG", "AGO")) then (
    	concat("20", substring($date, 8, 2), "08", substring($date, 1, 2)) 
    ) else if (fn:upper-case(substring($date, 4, 3)) = "SEP") then (
    	concat("20", substring($date, 8, 2), "09", substring($date, 1, 2)) 
    ) else if (fn:upper-case(substring($date, 4, 3)) = "OCT") then (
    	concat("20", substring($date, 8, 2), "10", substring($date, 1, 2)) 
    ) else if (fn:upper-case(substring($date, 4, 3)) = "NOV") then (
    	concat("20", substring($date, 8, 2), "11", substring($date, 1, 2)) 
    ) else (
    	concat("20", substring($date, 8, 2), "12", substring($date, 1, 2))
    )
   ) else (
   		""
   )
 } ;
 
declare function xf:consultaMovimientosCuentaMixtoOut($respuestaAbanks as element(ns2:OutputParameters),
    $respuestaT24 as element(ns0:ConsultaMovimientosCuentaResponse),
    $fechaSalidaT24 as xs:string,
    $beginDate  as xs:string)
    as element(ns1:consultaMovimientosCuentaResponse) {
	if ( fn:string($respuestaT24/Status/successIndicator) = "Success" and
		 fn:string($respuestaAbanks/ns2:ERROR_CODE) = "SUCCESS" and
		 ( count($respuestaAbanks/ns2:REF_NO/ns2:ITEM) > 0  or fn:empty($respuestaT24/WSFICOESTMTGIVENDATESType[1]/ZERORECORDS) )) then (
		 
	        <ns1:consultaMovimientosCuentaResponse>
	            {
	                for $ACCOUNTNUMBER in $respuestaT24/WSACCOUNTENTRIESType[1]/ACCOUNTNUMBER
	                return
	                    <ACCOUNT_NUMBER>{ data($ACCOUNTNUMBER) }</ACCOUNT_NUMBER>
	            }
	            {
	                for $ACCOUNTNAME in $respuestaT24/WSACCOUNTENTRIESType[1]/ACNAME
	                return
	                    <ACCOUNT_NAME>{ data($ACCOUNTNAME) }</ACCOUNT_NAME>
	            }
	            {
	                for $CURRENCY in $respuestaT24/WSACCOUNTENTRIESType[1]/ACCCY
	                return
	                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
	            }
	            {
	                let $STARTINGBALANCET24 := fn:string($respuestaT24/WSACCOUNTENTRIESType[1]/STARTINGBALANCE/text())
	                let $STARTINGBALANCETABANKS := fn:string($respuestaAbanks/ns2:STARTING_BALANCE/text())
	                return
	                if ($beginDate < $fechaSalidaT24) then (
	                	<STARTING_BALANCE>{ if (number($STARTINGBALANCETABANKS) < 0) then ( "0" ) else ( $STARTINGBALANCETABANKS ) }</STARTING_BALANCE>
	                ) else (
	                    <STARTING_BALANCE>{ data($STARTINGBALANCET24) }</STARTING_BALANCE>
	                )
	            }
	            {
	                for $ENDINGBALANCE in $respuestaT24/WSACCOUNTENTRIESType[1]/ENDINGBALANCE
	                return
	                    <ENDING_BALANCE>{ data($ENDINGBALANCE) }</ENDING_BALANCE>
	            }
	            {
	                for $START_DATE in $respuestaAbanks/ns2:START_DATE
	                return
	                    <START_DATE>{ data($START_DATE) }</START_DATE>
	            }
	            {
	                for $END_DATE_OUT in $respuestaAbanks/ns2:END_DATE_OUT
	                return
	                    <END_DATE>{ data($END_DATE_OUT) }</END_DATE>
	            }
	            <ns1:consultaMovimientosCuentaResponseType>
	            {
	            	let $vDates := $respuestaAbanks/ns2:VALUE_DATE/ns2:ITEM
	            	let $descrs := $respuestaAbanks/ns2:DESCRIPTION/ns2:ITEM
	            	let $refs := $respuestaAbanks/ns2:REF_NO/ns2:ITEM
	            	let $docNros := $respuestaAbanks/ns2:DOCUMENT_NUMBER/ns2:ITEM
	            	let $amounts := $respuestaAbanks/ns2:AMOUNT/ns2:ITEM
	            	let $effectBal := $respuestaAbanks/ns2:EFFECT_ON_BALANCE/ns2:ITEM
	            	return
		            	for $i in (1 to count($refs))
		                return
		                if (data($vDates) < $fechaSalidaT24)then (
	                	<ns1:consultaMovimientosCuentaResponseRecordType>
	                        <VALUE_DATE>{ data($vDates[$i]) }</VALUE_DATE>
	                        <DESCRIPTION>{ data($descrs[$i]) }</DESCRIPTION>
	                        <REF_NO>{ data($refs[$i]) }</REF_NO>
	                        <DOCUMENT_NUMBER>{ data($docNros[$i]) }</DOCUMENT_NUMBER>
	                        <AMOUNT>{ data($amounts[$i]) }</AMOUNT>
	                        <EFFECT_ON_BALANCE>{ data($effectBal[$i]) }</EFFECT_ON_BALANCE>
	                    </ns1:consultaMovimientosCuentaResponseRecordType>
	                    )else()
	            }
	            {
	            	let $valueDatesT24 := $respuestaT24/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/BOOKINGDATE
	            	let $descriptionsT24 := $respuestaT24/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNDESCRIPTION
	            	let $refNosT24 := $respuestaT24/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNREFERENCE
	            	let $chqNumbersT24 := $respuestaT24/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/CHEQUENUMBER
	            	let $dAmount := $respuestaT24/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/DAMOUNT
    	        	let $cAmount := $respuestaT24/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/CAMOUNT
	                return
	    				for $i in (1 to count($refNosT24))
	        			return
	        				if(data($valueDatesT24[$i]) >= $fechaSalidaT24
	        					and not(data($valueDatesT24[$i]) = $fechaSalidaT24 and fn:substring(data($refNosT24[$i]), 1, 2) = "DC")) then (
			                    <ns1:consultaMovimientosCuentaResponseRecordType>
			                        <VALUE_DATE>{ data($valueDatesT24[$i]) }</VALUE_DATE>
			                        <DESCRIPTION>{ data($descriptionsT24[$i]) }</DESCRIPTION>
			                        <REF_NO>{ data($refNosT24[$i]) }</REF_NO>
			                        <DOCUMENT_NUMBER>{ data($chqNumbersT24[$i]) }</DOCUMENT_NUMBER>
			                        <AMOUNT>
			                        { 
			                        	if ($cAmount[$i] = "0.00") then (
			                        		data($dAmount[$i])
			                        	) else (
			                        		data($cAmount[$i])
			                        	)
			                        }
			                        </AMOUNT>
			                        <EFFECT_ON_BALANCE>1</EFFECT_ON_BALANCE>
			                    </ns1:consultaMovimientosCuentaResponseRecordType>
			    			) else ()
	            }
	            </ns1:consultaMovimientosCuentaResponseType>
	        </ns1:consultaMovimientosCuentaResponse>
	 ) else (
	 	<ns1:consultaMovimientosCuentaResponse/>
	 ) 
};

declare variable $respuestaAbanks as element(ns2:OutputParameters) external;
declare variable $respuestaT24 as element(ns0:ConsultaMovimientosCuentaResponse) external;
declare variable $fechaSalidaT24 as xs:string external;
declare variable $beginDate as xs:string external;

xf:consultaMovimientosCuentaMixtoOut($respuestaAbanks,
    $respuestaT24,
    $fechaSalidaT24,
    $beginDate)