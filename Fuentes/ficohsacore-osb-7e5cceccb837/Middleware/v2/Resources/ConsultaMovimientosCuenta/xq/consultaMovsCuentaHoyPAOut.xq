(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaMovimientosCuentaHoy/xsd/consultaMovimientosCuentaHoy_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMovimientosCuentaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMovimientosCuentaHoy";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaMovimientosCuentaHoy/xq/consultaMovimientosCuentaOut/";

declare function xf:consultaMovimientosCuentaOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaMovimientosCuentaResponse) {
        <ns0:consultaMovimientosCuentaResponse>
            {
                for $ACCOUNT_NUMBER_OUT in $outputParameters1/ns1:ACCOUNT_NUMBER_OUT
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER_OUT) }</ACCOUNT_NUMBER>
            }
            {
                for $ACCOUNT_NAME in $outputParameters1/ns1:ACCOUNT_NAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNT_NAME) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $outputParameters1/ns1:CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $STARTING_BALANCE in $outputParameters1/ns1:STARTING_BALANCE
                return
                    <STARTING_BALANCE>{ data($STARTING_BALANCE) }</STARTING_BALANCE>
            }
            {
                for $ENDING_BALANCE in $outputParameters1/ns1:ENDING_BALANCE
                return
                    <ENDING_BALANCE>{ data($ENDING_BALANCE) }</ENDING_BALANCE>
            }
            {
                for $START_DATE in $outputParameters1/ns1:START_DATE
                return
                    <START_DATE>{ data($START_DATE) }</START_DATE>
            }
            {
                for $END_DATE_OUT in $outputParameters1/ns1:END_DATE_OUT
                return
                    <END_DATE>{ data($END_DATE_OUT) }</END_DATE>
            }
            <ns0:consultaMovimientosCuentaResponseType>
                {
                    let $valueDate := $outputParameters1/ns1:VALUE_DATE/ns1:VALUE_DATE_ITEM
            	let $description :=  $outputParameters1/ns1:DESCRIPTION/ns1:DESCRIPTION_ITEM
            	let $refNo := $outputParameters1/ns1:REF_NO/ns1:REF_NO_ITEM
            	let $documentNumber := $outputParameters1/ns1:DOCUMENT_NUMBER/ns1:REF_NO_ITEM
            	let $amountItem := $outputParameters1/ns1:AMOUNT/ns1:AMOUNT_ITEM
            	let $efectOnBalance := $outputParameters1/ns1:EFFECT_ON_BALANCE/ns1:VALUE_DATE_ITEM
                
                for $i in (1 to count($valueDate))
                    return
                        <ns0:consultaMovimientosCuentaResponseRecordType>
                            <VALUE_DATE>{ data($valueDate[$i]) }</VALUE_DATE>
                            <DESCRIPTION>{ data($description[$i]) }</DESCRIPTION>
                            <REF_NO>{ data($refNo[$i]) }</REF_NO>
                            <DOCUMENT_NUMBER>{ data($documentNumber[$i]) }</DOCUMENT_NUMBER>
                            <AMOUNT>{ data($amountItem[$i]) }</AMOUNT>
                            <EFFECT_ON_BALANCE>{ data($efectOnBalance[$i]) }</EFFECT_ON_BALANCE>
                        </ns0:consultaMovimientosCuentaResponseRecordType>
                }
            </ns0:consultaMovimientosCuentaResponseType>
        </ns0:consultaMovimientosCuentaResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaMovimientosCuentaOut($outputParameters1)