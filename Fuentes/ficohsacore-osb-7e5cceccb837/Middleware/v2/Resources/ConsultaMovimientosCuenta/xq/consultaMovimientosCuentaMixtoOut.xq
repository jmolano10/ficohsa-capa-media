(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/INTFC/consultaDetalladaMovimientosCuenta/xsd/consultaDetalladaMovimientosCuenta_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuenta1" element="ns2:consultaMovimientosCuenta" location="../xsd/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaMovimientosCuentaResponse" location="../xsd/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalladaMovimientosCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/consultaMovimientosCuentaMixtoOut/";

declare function xf:consultaMovimientosCuentaMixtoOut($outputParameters1 as element(ns0:OutputParameters),
    $consultaMovimientosCuenta1 as element(ns2:consultaMovimientosCuenta),
    $fechaSalidaT24 as xs:string,
    $beginDate as xs:string,
    $ticket as xs:string,
    $nombreCuenta as xs:string,
    $monedaCuenta as xs:string)
    as element(ns2:consultaMovimientosCuentaResponse) {
        <ns2:consultaMovimientosCuentaResponse>
            <ACCOUNT_NUMBER>{ data($consultaMovimientosCuenta1/ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            <ACCOUNT_NAME>{ $nombreCuenta }</ACCOUNT_NAME>
            <CURRENCY>{ $monedaCuenta }</CURRENCY>
            {
                for $PV_STARTINGBALANCE in $outputParameters1/ns0:PV_STARTINGBALANCE
                return
                    <STARTING_BALANCE>{ data($PV_STARTINGBALANCE) }</STARTING_BALANCE>
            }
            {
                for $PV_ENDINGBALANCE in $outputParameters1/ns0:PV_ENDINGBALANCE
                return
                    <ENDING_BALANCE>{ data($PV_ENDINGBALANCE) }</ENDING_BALANCE>
            }
            <START_DATE>{ data($consultaMovimientosCuenta1/BEGIN_DATE) }</START_DATE>
            <END_DATE>{ data($consultaMovimientosCuenta1/END_DATE) }</END_DATE>
            <DEBIT_COUNT>{ xs:string($outputParameters1/ns0:PN_DEBITTOTAL) }</DEBIT_COUNT>
            <CREDIT_COUNT>{ xs:string($outputParameters1/ns0:PN_CREDITTOTAL) }</CREDIT_COUNT>
            <DEBIT_TOTAL_AMOUNT>{ xs:string($outputParameters1/ns0:PN_DEBITTOTALAMOUNT) }</DEBIT_TOTAL_AMOUNT>
            <CREDIT_TOTAL_AMOUNT>{ xs:string($outputParameters1/ns0:PN_CREDITTOTALAMOUNT) }</CREDIT_TOTAL_AMOUNT>
            <RECORDS_INFO>
                {
                    for $INITIAL_RECORD in $consultaMovimientosCuenta1/PAGING_INFO/INITIAL_RECORD
                    return
                        <INITIAL_RECORD>{ data($INITIAL_RECORD) }</INITIAL_RECORD>
                }
                <RECORDS_RETURNED>{ xs:string($outputParameters1/ns0:PN_TOTALRECORDSRETURNED) }</RECORDS_RETURNED>
                <RECORDS_TOTAL>{ xs:string($outputParameters1/ns0:PN_TOTALRECORD) }</RECORDS_TOTAL>
                <TICKET>{ $ticket }</TICKET>
            </RECORDS_INFO>
            <ns2:consultaMovimientosCuentaResponseType>
                {
                    let $vDates  := ($outputParameters1/ns0:PT_BOOKINGDATE/ns0:ITEM)  
                    let $descrs  := ($outputParameters1/ns0:PT_TRANSACTIONDESCRIPTION/ns0:ITEM)  
                    let $refs  := ($outputParameters1/ns0:PT_REFNO/ns0:ITEM)  
                    let $docNros  := ($outputParameters1/ns0:PT_CHEQUENUMBER/ns0:ITEM)  
                    let $txnReference  := ($outputParameters1/ns0:PT_DEUDOR/ns0:ITEM)  
                    let $amounts  := ($outputParameters1/ns0:PT_AMOUNT/ns0:ITEM)  
                    let $effectBal  := ($outputParameters1/ns0:PT_EFFECTONBALANCE/ns0:ITEM)  
                    let $inputter  := ($outputParameters1/ns0:PT_INPUTTER/ns0:ITEM)  
                    let $txnCode  := ($outputParameters1/ns0:PT_TRANSACTIONCODE/ns0:ITEM)  
                    let $txnagnCode  := ($outputParameters1/ns0:PT_AGENCYCODE/ns0:ITEM)  
                    let $txnagnName  := ($outputParameters1/ns0:PT_AGENCYNAME/ns0:ITEM)  
                    let $txnDescriptionAll  := ($outputParameters1/ns0:PT_CUSTOMERDESCRIPTION/ns0:ITEM)  
                    let $authorizer  := ($outputParameters1/ns0:PT_AUTHORIZER/ns0:ITEM)  
                    let $txnDateTime  := ($outputParameters1/ns0:PT_VALUEDATE/ns0:ITEM)  
                    let $balance  := ($outputParameters1/ns0:PT_RUNNINGBALANCE/ns0:ITEM)  
                    let $inicio  := (data($consultaMovimientosCuenta1/PAGING_INFO/INITIAL_RECORD))  
                    let $contador  := ($outputParameters1/ns0:PN_TOTALRECORDSRETURNED)  
                    let $BalanceInicial  := (xs:float(data($outputParameters1/ns0:PV_STARTINGBALANCE)))  
                    return
                        for $i  in (1 to $contador)  
                        return
                            (<ns2:consultaMovimientosCuentaResponseRecordType>
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
                            <RUNNING_BALANCE>{data($balance[$i])}</RUNNING_BALANCE>
                            </ns2:consultaMovimientosCuentaResponseRecordType>)
                }
</ns2:consultaMovimientosCuentaResponseType>
        </ns2:consultaMovimientosCuentaResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $consultaMovimientosCuenta1 as element(ns2:consultaMovimientosCuenta) external;
declare variable $fechaSalidaT24 as xs:string external;
declare variable $beginDate as xs:string external;
declare variable $ticket as xs:string external;
declare variable $nombreCuenta as xs:string external;
declare variable $monedaCuenta as xs:string external;

xf:consultaMovimientosCuentaMixtoOut($outputParameters1,
    $consultaMovimientosCuenta1,
    $fechaSalidaT24,
    $beginDate,
    $ticket,
    $nombreCuenta,
    $monedaCuenta)
