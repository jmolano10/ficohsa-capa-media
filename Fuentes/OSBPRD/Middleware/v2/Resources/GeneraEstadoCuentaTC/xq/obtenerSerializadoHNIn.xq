(:: pragma bea:global-element-parameter parameter="$generaEstadoCuentaTC" element="ns1:generaEstadoCuentaTC" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ObtenerSerializado" location="../../../BusinessServices/VASA/obtenerSerializado/wsdl/ConsultaReporte.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEstadoCuentaTC/xq/obtenerSerializadoHNIn/";

declare function xf:obtenerSerializadoHNIn($generaEstadoCuentaTC as element(ns1:generaEstadoCuentaTC),
    $codigoPais as xs:string)
    as element(ns0:ObtenerSerializado) {
        <ns0:ObtenerSerializado>
            <ns0:data>
                <ns0:Extension>{ data($generaEstadoCuentaTC/FILE_EXTENSION) }</ns0:Extension>
                <ns0:Pais>{ $codigoPais }</ns0:Pais>
                <ns0:Periodo>{ fn:concat(data($generaEstadoCuentaTC/YEAR),data($generaEstadoCuentaTC/MONTH)) }</ns0:Periodo>
                <ns0:ProductoNumero>{ data($generaEstadoCuentaTC/PRODUCT_VALUE) }</ns0:ProductoNumero>
                <ns0:ProductoTipo>{ data($generaEstadoCuentaTC/PRODUCT_TYPE) }</ns0:ProductoTipo>
            </ns0:data>
        </ns0:ObtenerSerializado>
};

declare variable $generaEstadoCuentaTC as element(ns1:generaEstadoCuentaTC) external;
declare variable $codigoPais as xs:string external;

xf:obtenerSerializadoHNIn($generaEstadoCuentaTC,
    $codigoPais)