(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuentaResponse1" element="ns0:ConsultaMovimientosCuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMovimientosCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaMovimientosCuenta/consultaMovimientoCuentaOutt/";

declare function getTxnReference($reference as xs:string) as xs:string {
	let $refList := fn:tokenize($reference,"-")
	return
	if ($refList[1] = "DRF") then (
		fn:replace($refList[2],"!!","-")
	) else (
		$reference
	)
	
};

declare function xf:consultaMovimientoCuentaOutt($consultaMovimientosCuentaResponse1 as element(ns0:ConsultaMovimientosCuentaResponse),
    $fecha1 as xs:string,
    $fecha2 as xs:string,
    $fechaSalidaT24 as xs:string)
    as element(ns1:consultaMovimientosCuentaResponse) {
        <ns1:consultaMovimientosCuentaResponse>
            {
                for $ACCOUNTNUMBER in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/ACCOUNTNUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNTNUMBER) }</ACCOUNT_NUMBER>
            }
            {
                for $ACCOUNTNAME in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/ACNAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNTNAME) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/ACCCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $STARTINGBALANCE in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/STARTINGBALANCE
                return
                    <STARTING_BALANCE>{ data($STARTINGBALANCE) }</STARTING_BALANCE>
            }
            {
                for $ENDINGBALANCE in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/ENDINGBALANCE
                return
                    <ENDING_BALANCE>{ data($ENDINGBALANCE) }</ENDING_BALANCE>
            }
            <START_DATE>{ $fecha1 }</START_DATE>
            <END_DATE>{ $fecha2 }</END_DATE>
            <ns1:consultaMovimientosCuentaResponseType>
            {
            	let $valueDates := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/BOOKINGDATE
            	let $descriptions := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNDESCRIPTION
            	let $refNos := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNREFERENCE
            	let $chqNumbers := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/CHEQUENUMBER
            	let $txnReference := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/DEPOSITREF
            	let $dAmount := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/DAMOUNT
            	let $cAmount := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/CAMOUNT
            	let $transactionCode := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNCODE
                return
    				for $i in (1 to count($refNos))
        			return
        				if ((data($transactionCode[$i]) != "" or
        					data($valueDates[$i]) != "" or
        					data($refNos[$i]) != "" or
        					data($dAmount[$i]) != "" or
        					data($cAmount[$i]) != "")  
        					and data($valueDates[$i]) >= $fechaSalidaT24
        					and not(data($valueDates[$i]) = $fechaSalidaT24 and fn:substring(data($refNos[$i]), 1, 2) = "DC")) then (
		                    <ns1:consultaMovimientosCuentaResponseRecordType>
		                        <VALUE_DATE>{ data($valueDates[$i]) }</VALUE_DATE>
		                        <DESCRIPTION>{ data($descriptions[$i]) }</DESCRIPTION>
		                        <REF_NO>{ data($refNos[$i]) }</REF_NO>
		                        <DOCUMENT_NUMBER>{ data($chqNumbers[$i]) }</DOCUMENT_NUMBER>
		                        <TXN_REFERENCE>{ getTxnReference(fn:string($txnReference[$i]/text())) }</TXN_REFERENCE>
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
};

declare variable $consultaMovimientosCuentaResponse1 as element(ns0:ConsultaMovimientosCuentaResponse) external;
declare variable $fecha1 as xs:string external;
declare variable $fecha2 as xs:string external;
declare variable $fechaSalidaT24 as xs:string external;

xf:consultaMovimientoCuentaOutt($consultaMovimientosCuentaResponse1,
    $fecha1,
    $fecha2,
    $fechaSalidaT24)