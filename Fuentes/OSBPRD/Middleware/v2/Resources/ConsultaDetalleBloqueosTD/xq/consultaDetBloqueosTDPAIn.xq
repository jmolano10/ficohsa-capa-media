(:: pragma bea:global-element-parameter parameter="$consultaDetalleBloqueosTD1" element="ns1:consultaDetalleBloqueosTD" location="../../../../Business_Resources/tarjetasDebito/ConsultaDetalleBloqueosTD/consultaDetalleBloqueosTDTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaDetalleBloqueosTD/xsd/consultaDetalleBloqueosTD_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleBloqueosTD";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleBloqueosTDTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaDetalleBloqueosTD/xq/consultaDetalleBloqueosIn/";

declare function xf:consultaDetalleBloqueosIn($consultaDetalleBloqueosTD1 as element(ns1:consultaDetalleBloqueosTD))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:ACCOUNT_NUMBER>{ data($consultaDetalleBloqueosTD1/ACCOUNT_NUMBER) }</ns0:ACCOUNT_NUMBER>
        </ns0:InputParameters>
};

declare variable $consultaDetalleBloqueosTD1 as element(ns1:consultaDetalleBloqueosTD) external;

xf:consultaDetalleBloqueosIn($consultaDetalleBloqueosTD1)