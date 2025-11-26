xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/TransferenciaCuentas";
(:: import schema at "../../../../ProviderServices/XSD/TransfersLocalAccount/TransfersLocalAccount_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/transfersLocalAccountGTIn";

declare variable $transfersLocalAccountRequest as element() (:: schema-element(ns2:transfersLocalAccountRequest) ::) external;
declare variable $usuarioCanalRequest1 as xs:string external;

declare function ns1:transfersLocalAccountGTIn($transfersLocalAccountRequest as element() (:: schema-element(ns2:transfersLocalAccountRequest) ::), $usuarioCanalRequest1 as xs:string) as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
        <ns3:DEBIT_ACCOUNT>{fn:data($transfersLocalAccountRequest/ns2:DebitAccount)}</ns3:DEBIT_ACCOUNT>
        <ns3:CREDIT_ACCOUNT>{fn:data($transfersLocalAccountRequest/ns2:CreditAccount)}</ns3:CREDIT_ACCOUNT>
        {
            if ($transfersLocalAccountRequest/ns2:Currency)
            then <ns3:CURRENCY>{fn:data($transfersLocalAccountRequest/ns2:Currency)}</ns3:CURRENCY>
            else ()
        }
        <ns3:TRANSFER_AMOUNT>{fn:data($transfersLocalAccountRequest/ns2:TransferAmmount)}</ns3:TRANSFER_AMOUNT>
        {
            if ($transfersLocalAccountRequest/ns2:DebitCredit)
            then <ns3:DEBIT_CREDIT>{fn:data($transfersLocalAccountRequest/ns2:DebitCredit)}</ns3:DEBIT_CREDIT>
            else ()
        }
        {
            if ($transfersLocalAccountRequest/ns2:Description)
            then <ns3:DESCRIPTION>{fn:data($transfersLocalAccountRequest/ns2:Description)}</ns3:DESCRIPTION>
            else ()
        }
        {
            if ($transfersLocalAccountRequest/ns2:TransferDetails)
            then <ns3:TRANSFER_DETAILS>{fn:data($transfersLocalAccountRequest/ns2:TransferDetails)}</ns3:TRANSFER_DETAILS>
            else ()
        }
        {
            if ($transfersLocalAccountRequest/ns2:InterfaceReferenceNo)
            then <ns3:INTERFACE_REFERENCE_NO>{fn:data($transfersLocalAccountRequest/ns2:InterfaceReferenceNo)}</ns3:INTERFACE_REFERENCE_NO>
            else ()
        }
        {
            if ($transfersLocalAccountRequest/ns2:ItemLevel1)
            then <ns3:FINANCIAL_SECTOR_CATEGORY>{fn:data($transfersLocalAccountRequest/ns2:ItemLevel1)}</ns3:FINANCIAL_SECTOR_CATEGORY>
            else ()
        }
        {
            if ($transfersLocalAccountRequest/ns2:ItemLevel2)
            then <ns3:FINANCIAL_SECTOR_SUBCATEGORY>{fn:data($transfersLocalAccountRequest/ns2:ItemLevel2)}</ns3:FINANCIAL_SECTOR_SUBCATEGORY>
            else ()
        }
        <ns3:USERNAME>{fn:data($usuarioCanalRequest1)}</ns3:USERNAME>
        {
            if ($transfersLocalAccountRequest/ns2:AuthorizationTicket)
            then <ns3:AUTHORIZATION_TICKET>{fn:data($transfersLocalAccountRequest/ns2:AuthorizationTicket)}</ns3:AUTHORIZATION_TICKET>
            else ()
        }
    </ns3:InputParameters>
};

ns1:transfersLocalAccountGTIn($transfersLocalAccountRequest, $usuarioCanalRequest1)