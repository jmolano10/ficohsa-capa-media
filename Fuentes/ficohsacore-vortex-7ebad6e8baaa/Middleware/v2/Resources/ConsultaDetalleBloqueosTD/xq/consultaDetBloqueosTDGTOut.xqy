xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/consultaDetalleBloqueosTD/xsd/consultaDetalleBloqueosTD_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleBloqueosTDResponse" location="../../../../Business_Resources/tarjetasDebito/ConsultaDetalleBloqueosTD/consultaDetalleBloqueosTDTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleBloqueosTD";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleBloqueosTDTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaDetalleBloqueosTD/xq/consultaDetalleBloqueosTDOut/";

declare function xf:consultaDetalleBloqueosTDOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaDetalleBloqueosTDResponse) {
        <ns1:consultaDetalleBloqueosTDResponse>
            {
                for $ACCOUNT_NUMBER_OUT in $outputParameters1/ns0:ACCOUNT_NUMBER_OUT
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER_OUT) }</ACCOUNT_NUMBER>
            }
            {
                for $ACCOUNT_NAME in $outputParameters1/ns0:ACCOUNT_NAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNT_NAME) }</ACCOUNT_NAME>
            }
            {
                for $TOTAL_VISA_LOCKED_AMOUNT in $outputParameters1/ns0:TOTAL_VISA_LOCKED_AMOUNT
                return
                    <TOTAL_VISA_LOCKED_AMOUNT>{ data($TOTAL_VISA_LOCKED_AMOUNT) }</TOTAL_VISA_LOCKED_AMOUNT>
            }
            <ns1:consultaDetalleBloqueosTDResponseType>
                {
                	let $valueDate := $outputParameters1/ns0:VALUE_DATE/ns0:VALUE_DATE_ITEM
                	let $terminalDescriptionItem := $outputParameters1/ns0:TERMINAL_DESCRIPTION/ns0:TERMINAL_DESCRIPTION_ITEM
                	let $releaseDate := $outputParameters1/ns0:RELEASE_DATE/ns0:VALUE_DATE_ITEM
                	let $currency := $outputParameters1/ns0:CURRENCY/ns0:VALUE_DATE_ITEM
                	let $originalAmount := $outputParameters1/ns0:ORIGINAL_AMOUNT/ns0:VALUE_DATE_ITEM
                	let $blockStatus := $outputParameters1/ns0:BLOCK_STATUS/ns0:BLOCK_STATUS_ITEM
                	let $confirmedAmount := $outputParameters1/ns0:CONFIRMED_AMOUNT/ns0:VALUE_DATE_ITEM
                	
                    for $i in (1 to count($valueDate))
                    return
                        <ns1:consultaDetalleBloqueosTDResponseRecordType>
                            <VALUE_DATE>{ data($valueDate[$i]) }</VALUE_DATE>
                            <TERMINAL_DESCRIPTION>{ data($terminalDescriptionItem[$i]) }</TERMINAL_DESCRIPTION>
                            <RELEASE_DATE>{ data($releaseDate[$i]) }</RELEASE_DATE>
                            <CURRENCY>{ data($currency) }</CURRENCY>
                            <ORIGINAL_AMOUNT>{ data($originalAmount[$i]) }</ORIGINAL_AMOUNT>
                            <BLOCK_STATUS>{ data($blockStatus[$i]) }</BLOCK_STATUS>
                            <CONFIRMED_AMOUNT>{ data($confirmedAmount[$i]) }</CONFIRMED_AMOUNT>
                        </ns1:consultaDetalleBloqueosTDResponseRecordType>
                }
            </ns1:consultaDetalleBloqueosTDResponseType>
        </ns1:consultaDetalleBloqueosTDResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaDetalleBloqueosTDOut($outputParameters1)