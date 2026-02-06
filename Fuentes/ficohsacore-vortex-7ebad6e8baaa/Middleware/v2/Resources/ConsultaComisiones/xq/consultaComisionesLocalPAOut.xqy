xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaComisiones/xsd/consultaComisiones_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaComisiones" element="ns0:consultaComisiones" location="../xsd/consultaComisionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaComisionesResponse" location="../xsd/consultaComisionesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisiones";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesLocalPAOut/";

declare function xf:consultaComisionesLocalPAOut($outputParameters as element(ns1:OutputParameters),
    $consultaComisiones as element(ns0:consultaComisiones))
    as element(ns0:consultaComisionesResponse) {
        <ns0:consultaComisionesResponse>
            <CURRENCY>{ data($consultaComisiones/SOURCE_CURRENCY) }</CURRENCY>
            <AMOUNT>{ data($outputParameters/ns1:COMISION) }</AMOUNT>
        </ns0:consultaComisionesResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $consultaComisiones as element(ns0:consultaComisiones) external;

xf:consultaComisionesLocalPAOut($outputParameters,
    $consultaComisiones)