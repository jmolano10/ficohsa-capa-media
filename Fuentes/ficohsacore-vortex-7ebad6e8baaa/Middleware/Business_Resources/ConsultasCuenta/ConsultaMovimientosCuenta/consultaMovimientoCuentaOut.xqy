xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultademovimientosdectaResponse1" element="ns0:ConsultademovimientosdectaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMovimientosCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaMovimientosCuenta/consultaMovimientoCuentaOutt/";

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

declare function xf:consultaMovimientoCuentaOutt($consultademovimientosdectaResponse1 as element(ns0:ConsultademovimientosdectaResponse),
    $fecha1 as xs:string,
    $fecha2 as xs:string,
    $fechaSalidaT24 as xs:string)
    as element(ns1:consultaMovimientosCuentaResponse) {
        <ns1:consultaMovimientosCuentaResponse>
            {
                for $ACCOUNTNUMBER in $consultademovimientosdectaResponse1/WSFICOESTMTGIVENDATESType[1]/ACCOUNTNUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNTNUMBER) }</ACCOUNT_NUMBER>
            }
            {
                for $ACCOUNTNAME in $consultademovimientosdectaResponse1/WSFICOESTMTGIVENDATESType[1]/ACCOUNTNAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNTNAME) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $consultademovimientosdectaResponse1/WSFICOESTMTGIVENDATESType[1]/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $STARTINGBALANCE in $consultademovimientosdectaResponse1/WSFICOESTMTGIVENDATESType[1]/STARTINGBALANCE
                return
                    <STARTING_BALANCE>{ data($STARTINGBALANCE) }</STARTING_BALANCE>
            }
            {
                for $ENDINGBALANCE in $consultademovimientosdectaResponse1/WSFICOESTMTGIVENDATESType[1]/ENDINGBALANCE
                return
                    <ENDING_BALANCE>{ data($ENDINGBALANCE) }</ENDING_BALANCE>
            }
            <START_DATE>{ $fecha1 }</START_DATE>
            <END_DATE>{ $fecha2 }</END_DATE>
            <ns1:consultaMovimientosCuentaResponseType>
            {
            	let $valueDates := $consultademovimientosdectaResponse1/WSFICOESTMTGIVENDATESType[1]/gWSFICOESTMTGIVENDATESDetailType/mWSFICOESTMTGIVENDATESDetailType/BOOKINGDATE
            	let $descriptions := $consultademovimientosdectaResponse1/WSFICOESTMTGIVENDATESType[1]/gWSFICOESTMTGIVENDATESDetailType/mWSFICOESTMTGIVENDATESDetailType/TXNDESCRIPTION
            	let $refNos := $consultademovimientosdectaResponse1/WSFICOESTMTGIVENDATESType[1]/gWSFICOESTMTGIVENDATESDetailType/mWSFICOESTMTGIVENDATESDetailType/TXNREFERENCE
            	let $chqNumbers := $consultademovimientosdectaResponse1/WSFICOESTMTGIVENDATESType[1]/gWSFICOESTMTGIVENDATESDetailType/mWSFICOESTMTGIVENDATESDetailType/CHEQUENUMBER
            	let $amounts := $consultademovimientosdectaResponse1/WSFICOESTMTGIVENDATESType[1]/gWSFICOESTMTGIVENDATESDetailType/mWSFICOESTMTGIVENDATESDetailType/TXNAMOUNT
            	let $transactionCode := $consultademovimientosdectaResponse1/WSFICOESTMTGIVENDATESType[1]/gWSFICOESTMTGIVENDATESDetailType/mWSFICOESTMTGIVENDATESDetailType/TXNCODE
                return
    				for $i in (1 to count($refNos))
        			return
        				if ((data($transactionCode[$i]) != "" or
        					data($valueDates[$i]) != "" or
        					data($refNos[$i]) != "" or
        					data($amounts[$i]) != "") 
        					and data($valueDates[$i]) >= $fechaSalidaT24
        					and not(data($valueDates[$i]) = $fechaSalidaT24 and fn:substring(data($refNos[$i]), 1, 2) = "DC")) then (
		                    <ns1:consultaMovimientosCuentaResponseRecordType>
		                        <VALUE_DATE>{ data($valueDates[$i]) }</VALUE_DATE>
		                        <DESCRIPTION>{ data($descriptions[$i]) }</DESCRIPTION>
		                        <REF_NO>{ data($refNos[$i]) }</REF_NO>
		                        <DOCUMENT_NUMBER>{ data($chqNumbers[$i]) }</DOCUMENT_NUMBER>
		                        <AMOUNT>{ data($amounts[$i]) }</AMOUNT>
		                        <EFFECT_ON_BALANCE>1</EFFECT_ON_BALANCE>
		                    </ns1:consultaMovimientosCuentaResponseRecordType>
						) else ()
            }
            </ns1:consultaMovimientosCuentaResponseType>
        </ns1:consultaMovimientosCuentaResponse>
};

declare variable $consultademovimientosdectaResponse1 as element(ns0:ConsultademovimientosdectaResponse) external;
declare variable $fecha1 as xs:string external;
declare variable $fecha2 as xs:string external;
declare variable $fechaSalidaT24 as xs:string external;

xf:consultaMovimientoCuentaOutt($consultademovimientosdectaResponse1,
    $fecha1,
    $fecha2,
    $fechaSalidaT24)