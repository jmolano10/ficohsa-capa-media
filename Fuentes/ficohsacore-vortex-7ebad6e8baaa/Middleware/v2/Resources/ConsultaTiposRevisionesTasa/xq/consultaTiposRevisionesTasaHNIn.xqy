xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTiposRevisionesTasa" element="ns0:consultaTiposRevisionesTasa" location="../../CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CatalogosInfoPrestamo/consultaTiposRevisionesTasa/xsd/consultaTiposRevisionesTasa_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTiposRevisionesTasa";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposRevisionesTasa/xq/consultaTiposRevisionesTasaHNIn/";

declare function xf:consultaTiposRevisionesTasaHNIn($consultaTiposRevisionesTasa as element(ns0:consultaTiposRevisionesTasa))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_TYPE>{ data($consultaTiposRevisionesTasa/QUERY_TYPE/TYPE) }</ns1:P_TYPE>
        </ns1:InputParameters>
};

declare variable $consultaTiposRevisionesTasa as element(ns0:consultaTiposRevisionesTasa) external;

xf:consultaTiposRevisionesTasaHNIn($consultaTiposRevisionesTasa)