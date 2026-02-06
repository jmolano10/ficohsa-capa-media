xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validacionCuentaExterna" element="ns1:validacionCuentaExterna" location="../xsd/validacionCuentaExternaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaProductoSolicitud" location="../../../BusinessServices/CTS/ValidacionCuentaExterna/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisachsaliente.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobisachsaliente.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaExternaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionCuentaExterna/xq/consultaProductoExternoNIIn/";

declare function xf:consultaProductoExternoNIIn($validacionCuentaExterna as element(ns1:validacionCuentaExterna),
    $canalOriginador as xs:string,
    $valor as xs:string,
    $referencia as xs:string,
    $concepto as xs:string,
    $cuentaOrigen as xs:string,
    $productoDestino as xs:string,
    $productoOriginador as xs:string,
    $purpuseId as xs:string)
    as element(ns2:opConsultaProductoSolicitud) {
        <ns2:opConsultaProductoSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>{ data($canalOriginador) }</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:requestACHSaliente>
                <ns0:moneda>{ data($validacionCuentaExterna/ACCOUNT_CURRENCY) }</ns0:moneda>
                <ns0:productoOriginador>{ $productoOriginador }</ns0:productoOriginador>
                <ns0:valor>{data($valor)}</ns0:valor>
                <ns0:cuentaDestino>{ data($validacionCuentaExterna/ACCOUNT_NUMBER) }</ns0:cuentaDestino>
                <ns0:referencia>{ $referencia }</ns0:referencia>
                <ns0:cuentaOrigen>{ $cuentaOrigen }</ns0:cuentaOrigen>
                <ns0:concepto>{ $concepto }</ns0:concepto>
                <ns0:bancoDestino>{ data($validacionCuentaExterna/BANK_DETAILS/BANK[1]/BANK_CODE) }</ns0:bancoDestino>
                <ns0:productoDestino>{ $productoDestino }</ns0:productoDestino>
                <ns0:purpuseId>{ $purpuseId }</ns0:purpuseId>
            </ns0:requestACHSaliente>
        </ns2:opConsultaProductoSolicitud>
};

declare variable $validacionCuentaExterna as element(ns1:validacionCuentaExterna) external;
declare variable $canalOriginador as xs:string external;
declare variable $valor as xs:string external;
declare variable $referencia as xs:string external;
declare variable $concepto as xs:string external;
declare variable $cuentaOrigen as xs:string external;
declare variable $productoDestino as xs:string external;
declare variable $productoOriginador as xs:string external;
declare variable $purpuseId as xs:string external;

xf:consultaProductoExternoNIIn($validacionCuentaExterna,
    $canalOriginador,
    $valor,
    $referencia,
    $concepto,
    $cuentaOrigen,
    $productoDestino,
    $productoOriginador,
    $purpuseId)