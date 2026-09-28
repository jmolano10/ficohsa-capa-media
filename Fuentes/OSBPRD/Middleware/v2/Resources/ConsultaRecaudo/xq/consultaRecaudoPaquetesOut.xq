(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns1:consultaRecaudo" location="../xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaPaquetesMovilesResponse" element="ns0:ConsultaPaquetesMovilesResponse" location="../../../BusinessServices/T24/PaquetesMoviles/xsd/XMLSchema_-578407725.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeparametroscoreResponse" element="ns0:ConsultadeparametroscoreResponse" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoResponse" location="../xsd/consultaRecaudoTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PaquetesMoviles/xq/consultaRecaudoPaquetesOut/";

declare function xf:consultaRecaudoPaquetesOut($consultaRecaudo as element(ns1:consultaRecaudo),
    $consultaPaquetesMovilesResponse as element(ns0:ConsultaPaquetesMovilesResponse),
    $consultadeparametroscoreResponse as element(ns0:ConsultadeparametroscoreResponse), $contractName as xs:string)
    as element(ns1:consultaRecaudoResponse) {
        <ns1:consultaRecaudoResponse>
            <CONTRACT_ID>{ data($consultaRecaudo/CONTRACT_ID) }</CONTRACT_ID>
            <CONTRACT_NAME>{ data($contractName) }</CONTRACT_NAME>
            <DEBTOR_CODE>{ data($consultaRecaudo/DEBTOR_CODE) }</DEBTOR_CODE>
            <BILLS>
                {
                    for $mWSFICOPARAMPACKAGEDetailType in $consultaPaquetesMovilesResponse/WSFICOPARAMPACKAGEType[1]/gWSFICOPARAMPACKAGEDetailType/mWSFICOPARAMPACKAGEDetailType
                    where $mWSFICOPARAMPACKAGEDetailType/PACKOPERCODE = data($consultaRecaudo/ADDITIONAL_INFO/DATA[1])
                    return
                        <BILL_RECORD>
                            {
                                for $PACKOPERCODE in $mWSFICOPARAMPACKAGEDetailType/PACKOPERCODE
                                return
                                    <BILL_NUMBER>{ data($PACKOPERCODE) }</BILL_NUMBER>
                            }
                            <BILL_CURRENCY>HNL</BILL_CURRENCY>
                            <BILL_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</BILL_DATE>
                            <DUE_DATE>{ fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()) }</DUE_DATE>
                            {
                                for $PACKPRICE in $mWSFICOPARAMPACKAGEDetailType/PACKPRICE
                                return
                                    <BILL_AMOUNT>{ data($PACKPRICE) }</BILL_AMOUNT>
                            }
                            {
                                for $PACKPRICE in $mWSFICOPARAMPACKAGEDetailType/PACKPRICE
                                return
                                    <TOTAL_AMOUNT_LOC>{ data($PACKPRICE) }</TOTAL_AMOUNT_LOC>
                            }
                            {
                                for $PACKNAME in $mWSFICOPARAMPACKAGEDetailType/PACKNAME
                                return
                                    <BILL_DESCRIPTION>{ data($PACKNAME) }</BILL_DESCRIPTION>
                            }
                        </BILL_RECORD>
                }
            </BILLS>
        </ns1:consultaRecaudoResponse>
};

declare variable $consultaRecaudo as element(ns1:consultaRecaudo) external;
declare variable $consultaPaquetesMovilesResponse as element(ns0:ConsultaPaquetesMovilesResponse) external;
declare variable $consultadeparametroscoreResponse as element(ns0:ConsultadeparametroscoreResponse) external;
declare variable $contractName as xs:string external;

xf:consultaRecaudoPaquetesOut($consultaRecaudo,
    $consultaPaquetesMovilesResponse,
    $consultadeparametroscoreResponse,
    $contractName)