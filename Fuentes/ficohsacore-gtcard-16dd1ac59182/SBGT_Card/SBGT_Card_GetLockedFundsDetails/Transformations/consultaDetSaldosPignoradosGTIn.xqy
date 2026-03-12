xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleSaldosPignorados";
(:: import schema at "../Schemas/consultaDetalleSaldosPignorados_sp.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBGT_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare variable $consultaDetalleSaldosPignorados as element() (:: schema-element(ns1:getLockedFundsDetails) ::) external;

declare function local:func($consultaDetalleSaldosPignorados as element() (:: schema-element(ns1:getLockedFundsDetails) ::)) as element() (:: schema-element(ns0:InputParameters) ::) {
    <ns0:InputParameters>
        <ns0:ACCOUNT_NUMBER>{fn:data($consultaDetalleSaldosPignorados/AccountNumber)}</ns0:ACCOUNT_NUMBER>
    </ns0:InputParameters>
};

local:func($consultaDetalleSaldosPignorados)