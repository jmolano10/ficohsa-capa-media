xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRemesas" element="ns0:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/obtenerRemesadora/xsd/ObtenerRemesadora_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerRemesadora";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/consultaInfoRemesadoraIn/";

declare function xf:consultaInfoRemesadoraIn($pagoRemesas as element(ns0:pagoRemesas),
    $userName as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_ID_CONVENIO_T24>{ data($pagoRemesas/REMITTER_ID) }</ns1:PV_ID_CONVENIO_T24>
            <ns1:PV_USUARIO_SERVICIO>{ $userName }</ns1:PV_USUARIO_SERVICIO>
        </ns1:InputParameters>
};

declare variable $pagoRemesas as element(ns0:pagoRemesas) external;
declare variable $userName as xs:string external;

xf:consultaInfoRemesadoraIn($pagoRemesas,
    $userName)