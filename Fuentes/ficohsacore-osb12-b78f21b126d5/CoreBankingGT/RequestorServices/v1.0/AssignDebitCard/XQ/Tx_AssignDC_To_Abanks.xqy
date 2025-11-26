xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/debitCardsTypes";
(:: import schema at "../../../../../MWBanking/DebitCards/RequestorServices/XSD/debitCardsTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/AssignDebitCardGT_BS";
(:: import schema at "../../../../ProviderServices/XSD/AssignDebitCard/AssignDebitCardGT_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $input as element() (:: schema-element(ns1:assignDebitCardRequest) ::) external;

declare function xq:Tx_AssignDC_To_Abanks($input as element() (:: schema-element(ns1:assignDebitCardRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:PV_NUMERO_IDENTIDAD>{fn:data($input/ns1:CustomerLegalId)}</ns2:PV_NUMERO_IDENTIDAD>
        <ns2:PV_NUMERO_CUENTA_A_ASIGNAR>{fn:data($input/ns1:PrimaryAccount)}</ns2:PV_NUMERO_CUENTA_A_ASIGNAR>
        <ns2:PV_CODIGO_CLIENTE>{fn:data($input/ns1:CustomerCode)}</ns2:PV_CODIGO_CLIENTE>
        <ns2:PV_CODIGO_USUARIO>{fn:data($input/ns1:InterfaceUser)}</ns2:PV_CODIGO_USUARIO>
        {
            if ($input/ns1:CardNumber)
            then <ns2:PV_NO_TARJETA>{fn:data($input/ns1:CardNumber)}</ns2:PV_NO_TARJETA>
            else ()
        }
    </ns2:InputParameters>
};

xq:Tx_AssignDC_To_Abanks($input)