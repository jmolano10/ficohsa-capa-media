xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../Resources/ConsultaDetalladaMovimientosCuenta/xsd/ORA_BANK_OSB_K__CONSDETMOVSCTA_TOPLEVEL-24OSB_CON_DET_MOVS_CTA.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalladaMovimientosCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K__CONSDETMOVSCTA/TOPLEVEL-24OSB_CON_DET_MOVS_CTA/";
declare namespace xf = "http://tempuri.org/MiddlewareAbanks/Business_Resources/ConsultasCuenta/ConsultaDetalladaMovimientosCuenta/consultaDetalladaMovimientosCuentaOut/";

declare function xf:consultaDetalladaMovimientosCuentaOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaDetalladaMovimientosCuentaResponse) {
        <ns1:consultaDetalladaMovimientosCuentaResponse>
            {
                for $ACCOUNT_NAME in $outputParameters/ns0:ACCOUNT_NAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNT_NAME) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $outputParameters/ns0:CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $STARTING_BALANCE in $outputParameters/ns0:STARTING_BALANCE
                return
                    <STARTING_BALANCE>{ data($STARTING_BALANCE) }</STARTING_BALANCE>
            }
            {
                for $BEGIN_DATE in $outputParameters/ns0:BEGIN_DATE
                return
                    <START_DATE>{ data($BEGIN_DATE) }</START_DATE>
            }
            {
                for $END_DATE in $outputParameters/ns0:END_DATE
                return
                    <END_DATE>{ data($END_DATE) }</END_DATE>
            }
            <ns1:consultaDetalladaMovimientosCuentaResponseType>
                {
                    let $refs  := ($outputParameters/ns0:REF_NO/ns0:ITEM)  
                    let $amounts  := ($outputParameters/ns0:AMOUNT/ns0:ITEM)  
                    let $trxDescrs  := ($outputParameters/ns0:TRANSACTION_DESCRIPTION/ns0:ITEM)  
                    let $cusDescrs  := ($outputParameters/ns0:CUSTOMER_DESCRIPTION/ns0:ITEM)  
                    let $bDates  := ($outputParameters/ns0:BOOKING_DATE/ns0:ITEM)  
                    let $vDates  := ($outputParameters/ns0:VALUE_DATE/ns0:ITEM)  
                    let $chkNros  := ($outputParameters/ns0:CHEQUE_NUMBER/ns0:ITEM)  
                    let $inputters  := ($outputParameters/ns0:INPUTTER/ns0:ITEM)  
                    let $auths  := ($outputParameters/ns0:AUTHORIZER/ns0:ITEM)  
                    let $agencies_code  := ($outputParameters/ns0:AGENCY_CODE/ns0:ITEM)  
                    let $agencies_name  := ($outputParameters/ns0:AGENCY_NAME/ns0:ITEM)  
                    let $transactions_code  := ($outputParameters/ns0:TRANSACTION_CODE/ns0:ITEM)
                    let $effect_on_balance  := ($outputParameters/ns0:EFFECT_ON_BALANCE/ns0:ITEM)  
                    return
                        for $i  in (1 to count($refs))  
                        return
                            (<ns1:consultaDetalladaMovimientosCuentaResponseRecordType>
                            <REF_NO>{ data($refs[$i]) }</REF_NO>
                            <AMOUNT>{ data($amounts[$i]) }</AMOUNT>
                            <TRANSACTION_DESCRIPTION>{ data($trxDescrs[$i]) }</TRANSACTION_DESCRIPTION>
                            <CUSTOMER_DESCRIPTION>{ data($cusDescrs[$i]) }</CUSTOMER_DESCRIPTION>
                            <BOOKING_DATE>{ data($bDates[$i]) }</BOOKING_DATE>
                            <VALUE_DATE>{ data($vDates[$i]) }</VALUE_DATE>
                            <CHEQUE_NUMBER>{ data($chkNros[$i]) }</CHEQUE_NUMBER>
                            <INPUTTER>{ data($inputters[$i]) }</INPUTTER>
                            <AUTHORIZER>{ data($auths[$i]) }</AUTHORIZER>
                            <AGENCY_CODE>{ data($agencies_code[$i]) }</AGENCY_CODE>
                            <AGENCY_NAME>{ data($agencies_name[$i]) }</AGENCY_NAME>
                            <TRANSACTION_CODE>{ data($transactions_code[$i]) }</TRANSACTION_CODE>
                            <EFFECT_ON_BALANCE>{ data($effect_on_balance[$i]) }</EFFECT_ON_BALANCE>
                            </ns1:consultaDetalladaMovimientosCuentaResponseRecordType>)
                }
</ns1:consultaDetalladaMovimientosCuentaResponseType>
        </ns1:consultaDetalladaMovimientosCuentaResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaDetalladaMovimientosCuentaOut($outputParameters)