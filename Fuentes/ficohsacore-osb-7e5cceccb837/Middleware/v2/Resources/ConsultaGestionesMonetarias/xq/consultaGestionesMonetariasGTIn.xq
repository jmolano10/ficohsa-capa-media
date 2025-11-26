(:: pragma bea:global-element-parameter parameter="$consultaGestionesMonetarias" element="ns0:consultaGestionesMonetarias" location="../xsd/consultaGestionesMonetariasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/IntefazSalesforce/GestionesMonetarias/xsd/consultaGestionesMonetarias_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGestionesMonetariasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaGestionesMonetarias";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGestionesMonetarias/xq/consultaGestionesMonetariasGTIn/";

declare function xf:consultaGestionesMonetariasGTIn($consultaGestionesMonetarias as element(ns0:consultaGestionesMonetarias))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_NUMUSU>{ data($consultaGestionesMonetarias/NUMUSU) }</ns1:PN_NUMUSU>
            <ns1:PV_PAIS>{ data($consultaGestionesMonetarias/PAIS) }</ns1:PV_PAIS>
            <ns1:PV_DETALLE>{ data($consultaGestionesMonetarias/DETALLE_GESTION) }</ns1:PV_DETALLE>
        </ns1:InputParameters>
};

declare variable $consultaGestionesMonetarias as element(ns0:consultaGestionesMonetarias) external;

xf:consultaGestionesMonetariasGTIn($consultaGestionesMonetarias)
