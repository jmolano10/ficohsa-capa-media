xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/consultaComisionSwift/xsd/consultaComisionSwift_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaComisionSwiftResponse" location="../xsd/consultaComisionSwiftTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisionSwift";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionSwiftTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisionSwift/xq/consultaComisionSwiftGTOut/";

declare function xf:consultaComisionSwiftGTOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaComisionSwiftResponse) {
        <ns1:consultaComisionSwiftResponse>
            <CHARGE_CURRENCY>{ data($outputParameters/ns0:CHARGE_CURRENCY) }</CHARGE_CURRENCY>
            <CHARGE_AMOUNT>{ data($outputParameters/ns0:CHARGE_AMOUNT) }</CHARGE_AMOUNT>
        </ns1:consultaComisionSwiftResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaComisionSwiftGTOut($outputParameters)