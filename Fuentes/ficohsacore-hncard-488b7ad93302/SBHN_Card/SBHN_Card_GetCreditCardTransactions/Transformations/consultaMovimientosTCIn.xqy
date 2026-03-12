xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMovimientosRecientesTC";
(:: import schema at "../Schemas/consultaMovimientosRecientesTC_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBHN_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare variable $requestHeader as element() (:: schema-element(ns1:getCreditCardTransactions) ::) external;

declare function local:consultaMovimientosTCIn($requestHeader as element() (:: schema-element(ns1:getCreditCardTransactions) ::)) as element() (:: schema-element(ns0:InputParameters) ::) {
    <ns0:InputParameters>
        <ns0:PV_CARD_NUMBER>{fn:data($requestHeader//CardNumber)}</ns0:PV_CARD_NUMBER>
        {
            if ($requestHeader//GeneralInfo/SourceBank)
            then <ns0:PV_COUNTRY_CODE>{fn:data($requestHeader//GeneralInfo/SourceBank)}</ns0:PV_COUNTRY_CODE>
            else ()
        }
      
    </ns0:InputParameters>
};

local:consultaMovimientosTCIn($requestHeader)