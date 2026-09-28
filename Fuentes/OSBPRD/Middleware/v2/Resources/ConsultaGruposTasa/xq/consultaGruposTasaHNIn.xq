(:: pragma bea:global-element-parameter parameter="$consultaGruposTasa" element="ns0:consultaGruposTasa" location="../../CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CatalogosInfoPrestamo/ConsultaGruposTasa/xsd/ConsultaGruposTasa_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaGruposTasa";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGruposTasa/xq/consultaGruposTasaIn/";

declare function xf:consultaGruposTasaIn($consultaGruposTasa as element(ns0:consultaGruposTasa))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_COD_TASA>{ data($consultaGruposTasa/RATE_CODE) }</ns1:P_COD_TASA>
        </ns1:InputParameters>
};

declare variable $consultaGruposTasa as element(ns0:consultaGruposTasa) external;

xf:consultaGruposTasaIn($consultaGruposTasa)