xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaDetalladaMovimientosCuenta/xsd/consultaDetalladaMovimientosCuenta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuenta" element="ns0:consultaMovimientosCuenta" location="../xsd/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMovimientosCuentaResponse" location="../xsd/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/consultaMovimientosCuentaAbanksPAOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalladaMovimientosCuenta";

declare function xf:consultaMovimientosCuentaAbanksGTOut($outputParameters as element(ns1:OutputParameters),
    $consultaMovimientosCuenta as element(ns0:consultaMovimientosCuenta),
    $Ticket as xs:string,
    $beginDate as xs:string,
    $endDate as xs:string)
    as element(ns0:consultaMovimientosCuentaResponse) {
        <ns0:consultaMovimientosCuentaResponse>
      	<ACCOUNT_NUMBER>{ data($consultaMovimientosCuenta/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            {
                for $PV_ACCOUNTNAME in $outputParameters/ns1:PV_ACCOUNTNAME
                return
                    <ACCOUNT_NAME>{ data($PV_ACCOUNTNAME) }</ACCOUNT_NAME>
            }
            {
                for $PV_CURRENCY in $outputParameters/ns1:PV_CURRENCY
                return
                    <CURRENCY>{ data($PV_CURRENCY) }</CURRENCY>
            }
            {
                for $PV_STARTINGBALANCE in $outputParameters/ns1:PV_STARTINGBALANCE
                return
                    <STARTING_BALANCE>{ data($PV_STARTINGBALANCE) }</STARTING_BALANCE>
            }
            {
                for $PV_ENDINGBALANCE in $outputParameters/ns1:PV_ENDINGBALANCE
                return
                    <ENDING_BALANCE>{ data($PV_ENDINGBALANCE) }</ENDING_BALANCE>
            }
            <START_DATE>{ $beginDate }</START_DATE>
            <END_DATE>{ $endDate }</END_DATE>
            {
                for $PN_DEBITTOTAL in $outputParameters/ns1:PN_DEBITTOTAL
                return
                    <DEBIT_COUNT>{ fn:string(data($PN_DEBITTOTAL)) }</DEBIT_COUNT>
            }
            {
                for $PN_CREDITTOTAL in $outputParameters/ns1:PN_CREDITTOTAL
                return
                    <CREDIT_COUNT>{ fn:string(data($PN_CREDITTOTAL)) }</CREDIT_COUNT>
            }
            {
                for $PN_DEBITTOTALAMOUNT in $outputParameters/ns1:PN_DEBITTOTALAMOUNT
                return
                    <DEBIT_TOTAL_AMOUNT>{ fn:string(data($PN_DEBITTOTALAMOUNT)) }</DEBIT_TOTAL_AMOUNT>
            }
            {
                for $PN_CREDITTOTALAMOUNT in $outputParameters/ns1:PN_CREDITTOTALAMOUNT
                return
                    <CREDIT_TOTAL_AMOUNT>{ fn:string(data($PN_CREDITTOTALAMOUNT)) }</CREDIT_TOTAL_AMOUNT>
            }
            <RECORDS_INFO>
                {
                    for $INICIAL_RECORD in $consultaMovimientosCuenta/PAGING_INFO/INITIAL_RECORD
                    return
                        <INITIAL_RECORD>
                            {
                                if (fn:string($consultaMovimientosCuenta/PAGING_INFO/PAGING/text()) = "YES") then
                                    (data($INICIAL_RECORD))
                                else 
                                    1
                            }
						</INITIAL_RECORD>
                }
                {
                    for $PN_TOTALRECORDSRETURNED in $outputParameters/ns1:PN_TOTALRECORDSRETURNED
                    return
                        <RECORDS_RETURNED>{ fn:string(data($PN_TOTALRECORDSRETURNED)) }</RECORDS_RETURNED>
                }
                {
                	for $PN_TOTALRECORD in $outputParameters/ns1:PN_TOTALRECORD
                	return
                    	<RECORDS_TOTAL>{ fn:string(data($PN_TOTALRECORD)) }</RECORDS_TOTAL>
            	}
                <TICKET>{ $Ticket }</TICKET>
            </RECORDS_INFO>
            <ns0:consultaMovimientosCuentaResponseType>
                {
                    let $vDates  := ($outputParameters/ns1:PT_VALUEDATE/ns1:PT_AMOUNT_ITEM)  
                    let $descrs  := ($outputParameters/ns1:PT_TRANSACTIONDESCRIPTION/ns1:PT_TRANSACTIONDESCRIPTION_ITEM)  
                    let $refs  := ($outputParameters/ns1:PT_REFNO/ns1:PT_REFNO_ITEM)  
                    let $docNros  := ($outputParameters/ns1:PT_CHEQUENUMBER/ns1:PT_REFNO_ITEM)
                    let $txnReference := ($outputParameters/ns1:PT_DEUDOR/ns1:PT_DEUDOR_ITEM)
                    let $amounts  := ($outputParameters/ns1:PT_AMOUNT/ns1:PT_AMOUNT_ITEM)  
                    let $effectBal  := ($outputParameters/ns1:PT_EFFECTONBALANCE/ns1:PT_TRANSACTIONCODE_ITEM)  
                    let $inputter  := ($outputParameters/ns1:PT_INPUTTER/ns1:PT_AMOUNT_ITEM)  
                    let $txnCode  := ($outputParameters/ns1:PT_TRANSACTIONCODE/ns1:PT_TRANSACTIONCODE_ITEM)  
                    let $txnagnCode  := ($outputParameters/ns1:PT_AGENCYCODE/ns1:PT_AMOUNT_ITEM)  
                    let $txnagnName  := ($outputParameters/ns1:PT_AGENCYNAME/ns1:PT_DEUDOR_ITEM)  
                    let $txnDescriptionAll  := ($outputParameters/ns1:PT_CUSTOMERDESCRIPTION/ns1:PT_CUSTOMERDESCRIPTION_ITEM)  
                    let $authorizer  := ($outputParameters/ns1:PT_AUTHORIZER/ns1:PT_AMOUNT_ITEM)  
                    let $txnDateTime  := ($outputParameters/ns1:PT_BOOKINGDATE/ns1:PT_AMOUNT_ITEM)
                    let $runningBalance := ($outputParameters/ns1:PT_RUNNINGBALANCE/ns1:PT_AMOUNT_ITEM)               
                    return
                        for $i in (1 to fn:count($refs))  
                        return
                            (<ns0:consultaMovimientosCuentaResponseRecordType>
                            <VALUE_DATE>{ data($vDates[$i]) }</VALUE_DATE>
                            <DESCRIPTION>{ data($descrs[$i]) }</DESCRIPTION>
                            <REF_NO>{ data($refs[$i]) }</REF_NO>
                            <DOCUMENT_NUMBER>{ data($docNros[$i]) }</DOCUMENT_NUMBER>
                            <TXN_REFERENCE>{ data($txnReference[$i]) }</TXN_REFERENCE>
                            <AMOUNT>{ data($amounts[$i]) }</AMOUNT>
                            <EFFECT_ON_BALANCE>{ data($effectBal[$i]) }</EFFECT_ON_BALANCE>
                            <INPUTTER>{ data($inputter[$i]) }</INPUTTER>
                            <TXNCODE>{ data($txnCode[$i]) }</TXNCODE>
                            <TXNAGNCODE>{ data($txnagnCode[$i]) }</TXNAGNCODE>
                            <TXNAGNNAME>{ data($txnagnName[$i]) }</TXNAGNNAME>
                            <TXNDESCRIPTIONALL>{ data($txnDescriptionAll[$i]) }</TXNDESCRIPTIONALL>
                            <AUTHORISER>{ data($authorizer[$i]) }</AUTHORISER>
                            <TXNDATETIME>{ data($txnDateTime[$i]) }</TXNDATETIME>
                            <RUNNING_BALANCE>{ data($runningBalance[$i]) }</RUNNING_BALANCE>
                            </ns0:consultaMovimientosCuentaResponseRecordType>)
                }
</ns0:consultaMovimientosCuentaResponseType>
        </ns0:consultaMovimientosCuentaResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $consultaMovimientosCuenta as element(ns0:consultaMovimientosCuenta) external;
declare variable $Ticket as xs:string external;
declare variable $beginDate as xs:string external;
declare variable $endDate as xs:string external;

xf:consultaMovimientosCuentaAbanksGTOut($outputParameters,
    $consultaMovimientosCuenta,
    $Ticket,
    $beginDate,
    $endDate)