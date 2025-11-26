xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaTargetTipoPrestamo" element="ns0:consultaTargetTipoPrestamo" location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ServiciosEmpresariales/consultaTargetTipoPrestamo/xsd/consultaTargetTipoPrestamo_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTargetTipoPrestamo/xq/consultaTargetTipoPrestamoHNIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/serviciosEmpresarialesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTargetTipoPrestamo";

declare function xf:consultaTargetTipoPrestamoHNIn($consultaTargetTipoPrestamo as element(ns0:consultaTargetTipoPrestamo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
		        <P_TARGET>{ data($consultaTargetTipoPrestamo/TARGET_ID) }</P_TARGET>
        </ns1:InputParameters>
};

declare variable $consultaTargetTipoPrestamo as element(ns0:consultaTargetTipoPrestamo) external;

xf:consultaTargetTipoPrestamoHNIn($consultaTargetTipoPrestamo)