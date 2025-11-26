(:: pragma bea:local-element-parameter parameter="$dEBTOR1" type="ns0:consultaRecaudoMultiple/AGREEMENTS/AGREEMENT/DEBTORS/DEBTOR" location="../xsd/sjConsultaRecaudoMultipleTypesPA.xsd" ::)
(:: pragma bea:schema-type-return type="ns0:debtorsResponseType" location="../xsd/sjConsultaRecaudoMultipleTypesPA.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaRecaudoMultipleTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRecaudoMultiplePA/xq/sjConsRecaudoErrPAOut/";

declare function xf:sjConsRecaudoErrPAOut($dEBTOR1 as element(),
    $errorMessage as xs:string)
    as element() {
        <ns0:debtorsResponseType>
            <DEBTOR>
                <SUCCESS_INDICATOR>ERROR</SUCCESS_INDICATOR>
                <ERROR_MESSAGE>{ $errorMessage }</ERROR_MESSAGE>
                {
                    for $TRACE in $dEBTOR1/TRACE
                    return
                        <TRACE>{ data($TRACE) }</TRACE>
                }
                <CODE>{ data($dEBTOR1/CODE) }</CODE>
            </DEBTOR>
        </ns0:debtorsResponseType>
};

declare variable $dEBTOR1 as element() external;
declare variable $errorMessage as xs:string external;

xf:sjConsRecaudoErrPAOut($dEBTOR1,
    $errorMessage)