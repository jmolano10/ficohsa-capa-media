xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaActivosClienteRequest" element="ns1:consultaActivosClienteRequest" location="../xsd/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaActivosClienteSolicitud" location="../../../BusinessServices/CTS/activos/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobisactivos.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosNIIn/";

declare function xf:consultaActivosNIIn($consultaActivosClienteRequest as element(ns1:consultaActivosClienteRequest),
    $USER_ID as xs:string)
    as element(ns2:opConsultaActivosClienteSolicitud) {
        <ns2:opConsultaActivosClienteSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:cliente>
                <ns0:codCliente>{ data($consultaActivosClienteRequest/CUSTOMER_ID) }</ns0:codCliente>
                <ns0:valIdCliente>{ $USER_ID }</ns0:valIdCliente>
            </ns0:cliente>
            <ns0:producto>
                <ns0:codTipoProducto>{ data($consultaActivosClienteRequest/ASSET_TYPE) }</ns0:codTipoProducto>
            </ns0:producto>
        </ns2:opConsultaActivosClienteSolicitud>
};

declare variable $consultaActivosClienteRequest as element(ns1:consultaActivosClienteRequest) external;
declare variable $USER_ID as xs:string external;

xf:consultaActivosNIIn($consultaActivosClienteRequest,
    $USER_ID)