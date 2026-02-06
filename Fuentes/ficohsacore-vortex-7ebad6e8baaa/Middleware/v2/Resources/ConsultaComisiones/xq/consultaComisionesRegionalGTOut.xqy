xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaComisionRegional/xsd/consultaComisionRegional_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaComisiones" element="ns0:consultaComisiones" location="../xsd/consultaComisionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaComisionesResponse" location="../xsd/consultaComisionesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisionRegional";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesRegionalGTOut/";

declare function xf:consultaComisionesRegionalGTOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaComisionesResponse) {
        <ns0:consultaComisionesResponse>
            <CURRENCY>USD</CURRENCY>
            <AMOUNT>{ data($outputParameters/ns1:PN_COMISION) }</AMOUNT>
        </ns0:consultaComisionesResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $consultaComisiones as element(ns0:consultaComisiones) external;

xf:consultaComisionesRegionalGTOut($outputParameters)