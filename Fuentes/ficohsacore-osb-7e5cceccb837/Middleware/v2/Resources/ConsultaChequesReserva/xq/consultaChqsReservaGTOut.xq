(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaChequesReserva/xsd/consultaChequesReserva_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaChequesReservaResponse" location="../../../../Business_Resources/consultaCheque/consultaChequesReserva/consultaChequesReservaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesReservaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaChequesReserva";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaChequesReserva/xq/consultaChequesReservaOut/";

declare function xf:consultaChequesReservaOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaChequesReservaResponse) {
        <ns0:consultaChequesReservaResponse>
            {
                for $ACCOUNT_NAME in $outputParameters1/ns1:ACCOUNT_NAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNT_NAME) }</ACCOUNT_NAME>
            }
            {
                for $TOTAL_CLEARING_AMOUNT in $outputParameters1/ns1:TOTAL_CLEARING_AMOUNT
                return
                    <TOTAL_CLEARING_AMOUNT>{ data($TOTAL_CLEARING_AMOUNT) }</TOTAL_CLEARING_AMOUNT>
            }
            <consultaChequesReservaResponseType>
                {
                	let $bankName := $outputParameters1/ns1:BANK_NAME/ns1:BANK_NAME_ITEM
                	let $chequeNumber := $outputParameters1/ns1:CHEQUE_NUMBER/ns1:BANK_NAME_ITEM
                	let $amount := $outputParameters1/ns1:AMOUNT/ns1:BANK_NAME_ITEM
                	let $chequeStatus := $outputParameters1/ns1:CHEQUE_STATUS/ns1:BANK_NAME_ITEM
                	let $releaseDate := $outputParameters1/ns1:RELEASE_DATE/ns1:BANK_NAME_ITEM
                	let $clearingDate := $outputParameters1/ns1:CLEARING_DATE/ns1:BANK_NAME_ITEM
                	let $clearingDays := $outputParameters1/ns1:CLEARING_DAYS/ns1:BANK_NAME_ITEM
                	let $clearingRemainingDays := $outputParameters1/ns1:CLEARING_REMAINING_DAYS/ns1:BANK_NAME_ITEM
                	
                    for $i in (1 to count($bankName))
                    return
                        <consultaChequesReservaResponseRecordType>
                            <BANK_NAME>{ data($bankName[$i]) }</BANK_NAME>
                            <CHEQUE_NUMBER>{ data($chequeNumber[$i]) }</CHEQUE_NUMBER>
                            <AMOUNT>{ data($amount[$i]) }</AMOUNT>
                            <CHEQUE_STATUS>{ data($chequeStatus[$i]) }</CHEQUE_STATUS>
                            <RELEASE_DATE>{ data($releaseDate[$i]) }</RELEASE_DATE>
                            <CLEARING_DATE>{ data($clearingDate[$i]) }</CLEARING_DATE>
                            <CLEARING_DAYS>{ data($clearingDays[$i]) }</CLEARING_DAYS>
                            <CLEARING_REMAINING_DAYS>{ data($clearingRemainingDays[$i]) }</CLEARING_REMAINING_DAYS>
                        </consultaChequesReservaResponseRecordType>
                }
            </consultaChequesReservaResponseType>
        </ns0:consultaChequesReservaResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaChequesReservaOut($outputParameters1)