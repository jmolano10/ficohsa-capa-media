(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuentaResponse1" element="ns1:ConsultaMovimientosCuentaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMovimientosCuentaResponse" location="../xsd/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/ConsultaMovimientosCuentaOut/";

declare function getTxnReference($reference as xs:string) as xs:string {
	let $refList := fn:tokenize($reference,"-")
	return
	if ($refList[1] = "DRF") then (
		fn:replace($refList[2],"!!","-")
	) else (
		$reference
	)
	
};

declare function xf:ConsultaMovimientosCuentaOut($consultaMovimientosCuentaResponse1 as element(ns1:ConsultaMovimientosCuentaResponse),
    $StartDate as xs:string,
    $EndDate as xs:string,
    $FechaSalidaT24 as xs:string,
    $InicialRecord as xs:string,
    $ticket as xs:string)
    as element(ns0:consultaMovimientosCuentaResponse) {
        <ns0:consultaMovimientosCuentaResponse>
            {
                for $ACCOUNTNUMBER in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/ACCOUNTNUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNTNUMBER) }</ACCOUNT_NUMBER>
            }
            {
                for $ACNAME in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/ACNAME
                return
                    <ACCOUNT_NAME>{ data($ACNAME) }</ACCOUNT_NAME>
            }
            {
                for $ACCCY in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/ACCCY
                return
                    <CURRENCY>{ data($ACCCY) }</CURRENCY>
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
            <START_DATE>{ $StartDate }</START_DATE>
            <END_DATE>{ $EndDate }</END_DATE>
            <DEBIT_COUNT>{ data($consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/NOOFDEBITS) }</DEBIT_COUNT>
            <CREDIT_COUNT>{ data($consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/NOOFCREDITS) }</CREDIT_COUNT>
            <DEBIT_TOTAL_AMOUNT>{ data($consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/DTOTALDAMOUNT) }</DEBIT_TOTAL_AMOUNT>
            <CREDIT_TOTAL_AMOUNT>{ data($consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/DTOTALCAMOUNT) }</CREDIT_TOTAL_AMOUNT>

            <RECORDS_INFO>
            	<INITIAL_RECORD>{ $InicialRecord }</INITIAL_RECORD>
            	{
	                for $NUMMOSTRADO in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/NUMMOSTRADO
	                return
	                    <RECORDS_RETURNED>{ data($NUMMOSTRADO) }</RECORDS_RETURNED>
	            }
	            {
	                for $TOTALREGISTRO in $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/TOTALREGISTRO
	                return
	                    <RECORDS_TOTAL>{ data($TOTALREGISTRO) }</RECORDS_TOTAL>
	            }
	            <TICKET>{ $ticket }</TICKET>
            </RECORDS_INFO>
            
            
            <ns0:consultaMovimientosCuentaResponseType>
            {
            	let $valueDates := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/BOOKINGDATE
            	let $descriptions := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNDESCRIPTION
            	let $refNos := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNREFERENCE
            	let $chqNumbers := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/CHEQUENUMBER
            	let $txnReference := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/DEPOSITREF
            	let $txnCode := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNCODE
            	let $dAmount := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/DAMOUNT
            	let $cAmount := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/CAMOUNT
            	let $transactionCode := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNCODE
            	
            	let $inputter := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/INPUTTER
            	let $txnAgnCode := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNAGNCODE
            	let $txnAgnName := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNAGNNAME
            	let $txnDescriptionAll := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNDESCRIPTIONALL
            	let $authoriser := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/AUTHORISER
            	let $txnDatetime := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/TXNDATETIME
            	let $balance := $consultaMovimientosCuentaResponse1/WSACCOUNTENTRIESType[1]/gWSACCOUNTENTRIESDetailType/mWSACCOUNTENTRIESDetailType/RBALANCE
            	
                return
    				for $i in (1 to count($refNos))
        			return
        				if ((data($transactionCode[$i]) != "" or
        					data($valueDates[$i]) != "" or
        					data($refNos[$i]) != "" or
        					data($dAmount[$i]) != "" or
        					data($cAmount[$i]) != "")  
        					and data($valueDates[$i]) >= $FechaSalidaT24
        					and not(data($valueDates[$i]) = $FechaSalidaT24 and fn:substring(data($refNos[$i]), 1, 2) = "DC")) then (
		                    <ns0:consultaMovimientosCuentaResponseRecordType>
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
		                        <INPUTTER>{ data($inputter[$i]) }</INPUTTER>
		                        <TXNCODE>{ data($transactionCode[$i]) }</TXNCODE>
								<TXNAGNCODE>{ data($txnAgnCode[$i]) }</TXNAGNCODE>
								<TXNAGNNAME>{ data($txnAgnName[$i]) }</TXNAGNNAME>
								<TXNDESCRIPTIONALL>{ fn:concat(fn:replace(fn:string($txnReference[$i]/text()),"!!","-"),data($txnDescriptionAll[$i])) }</TXNDESCRIPTIONALL>
								<AUTHORISER>{ data($authoriser[$i]) }</AUTHORISER>
								<TXNDATETIME>{ data($txnDatetime[$i]) }</TXNDATETIME>
								<RUNNING_BALANCE>{ data($balance[$i]) }</RUNNING_BALANCE>
		                    </ns0:consultaMovimientosCuentaResponseRecordType>
		                    
						) else ()
            }
            </ns0:consultaMovimientosCuentaResponseType>
        </ns0:consultaMovimientosCuentaResponse>
};

declare variable $consultaMovimientosCuentaResponse1 as element(ns1:ConsultaMovimientosCuentaResponse) external;
declare variable $StartDate as xs:string external;
declare variable $EndDate as xs:string external;
declare variable $FechaSalidaT24 as xs:string external;
declare variable $InicialRecord as xs:string external;
declare variable $ticket as xs:string external;

xf:ConsultaMovimientosCuentaOut($consultaMovimientosCuentaResponse1,
    $StartDate,
    $EndDate,
    $FechaSalidaT24,
    $InicialRecord,
    $ticket)