xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$generaEstadoCuentaTC" element="ns1:generaEstadoCuentaTC" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ObtenerSerializado" location="../../../BusinessServices/VisionPlusREG/obtenerSerializado/xsd/bfemEECCHistorico.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEstadoCuentaTC/xq/obtenerSerializadoHNIn/";

declare function xf:obtenerSerializadoHNIn($generaEstadoCuentaTC as element(ns1:generaEstadoCuentaTC),
    $codigoPais as xs:string)
    as element(ns0:ObtenerSerializado) {
        <ns0:ObtenerSerializado>
            <ns0:data>
                <ns2:Extension>{ data($generaEstadoCuentaTC/FILE_EXTENSION) }</ns2:Extension>
                <ns2:Pais>{ $codigoPais }</ns2:Pais>
                <ns2:Periodo>{ fn:concat(data($generaEstadoCuentaTC/YEAR),data($generaEstadoCuentaTC/MONTH)) }</ns2:Periodo>
                <ns2:ProductoNumero>{ data($generaEstadoCuentaTC/PRODUCT_VALUE) }</ns2:ProductoNumero>
                <ns2:ProductoTipo>{ data($generaEstadoCuentaTC/PRODUCT_TYPE) }</ns2:ProductoTipo>
            </ns0:data>
        </ns0:ObtenerSerializado>
};

declare variable $generaEstadoCuentaTC as element(ns1:generaEstadoCuentaTC) external;
declare variable $codigoPais as xs:string external;

xf:obtenerSerializadoHNIn($generaEstadoCuentaTC,
    $codigoPais)