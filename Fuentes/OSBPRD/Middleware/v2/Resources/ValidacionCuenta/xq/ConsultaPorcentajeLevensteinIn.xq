(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns1:AutenticacionRequestHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaPorcentajeLevenstein/xsd/CONS_PORC_LEVENSTEIN_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CONS_PORC_LEVENSTEIN";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/ConsultaPorcentajeLevensteinIn/";

declare function xf:ConsultaPorcentajeLevensteinIn($autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:VA_USUARIO>{ data($autenticacionRequestHeader1/UserName) }</ns0:VA_USUARIO>
        </ns0:InputParameters>
};

declare variable $autenticacionRequestHeader1 as element(ns1:AutenticacionRequestHeader) external;

xf:ConsultaPorcentajeLevensteinIn($autenticacionRequestHeader1)