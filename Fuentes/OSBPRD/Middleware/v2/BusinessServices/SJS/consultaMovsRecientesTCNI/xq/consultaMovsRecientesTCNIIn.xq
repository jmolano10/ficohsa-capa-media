(:: pragma bea:global-element-parameter parameter="$sjConsultaMovsRecientesTCNIRequest" element="ns2:sjConsultaMovsRecientesTCNIRequest" location="../xsd/sjConsultaMovsRecientesTCNI.xsd" ::)
(:: pragma bea:global-element-return element="ns1:opConsultaMovimientosTarjetaCreditoSolicitud" location="../../../CTS/tarjetaCredito/xsd/services.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMovsRecientesTCNI";
declare namespace ns1 = "http://service.srvaplcobistarjetacredito.ecobis.cobiscorp";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMovsRecientesTC/xq/consultaMovsRecientesNIIn/";

declare function xf:consultaMovsRecientesNIIn($sjConsultaMovsRecientesTCNIRequest as element(ns2:sjConsultaMovsRecientesTCNIRequest),
    $int1 as xs:int,
    $int2 as xs:int)
    as element(ns1:opConsultaMovimientosTarjetaCreditoSolicitud) {
        <ns1:opConsultaMovimientosTarjetaCreditoSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:valTarjetaCredito>
                <ns0:valNumeroTC>
                    <ns0:codTipoProducto>{ data($sjConsultaMovsRecientesTCNIRequest/ns2:CARD_NUMBER) }</ns0:codTipoProducto>
                </ns0:valNumeroTC>
            </ns0:valTarjetaCredito>
            <ns0:valSecuencial>
                <ns0:valUltimoRegistroEntero>{ fn:string($int1) }</ns0:valUltimoRegistroEntero>
            </ns0:valSecuencial>
            <ns0:valSecuencial2>
                <ns0:valUltimoRegistroEntero>{ fn:string($int2) }</ns0:valUltimoRegistroEntero>
            </ns0:valSecuencial2>
        </ns1:opConsultaMovimientosTarjetaCreditoSolicitud>
};

declare variable $sjConsultaMovsRecientesTCNIRequest as element(ns2:sjConsultaMovsRecientesTCNIRequest) external;
declare variable $int1 as xs:int external;
declare variable $int2 as xs:int external;

xf:consultaMovsRecientesNIIn($sjConsultaMovsRecientesTCNIRequest,
    $int1,
    $int2)