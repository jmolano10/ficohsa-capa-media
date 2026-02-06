xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$generaEstadoCuentaTC1" element="ns0:generaEstadoCuentaTC" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ObtenerSerializadoResquest" location="../../../BusinessServices/VisionPlusHN/obtenerSerializado/xsd/bfemEECCHistorico_1.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace ns1 = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEstadoCuentaTCHN/xq/obtenerSerializadoHNIn/";

declare function xf:obtenerSerializadoHNIn($generaEstadoCuentaTC1 as element(ns0:generaEstadoCuentaTC),
    $pais as xs:string)
    as element(ns1:ObtenerSerializadoResquest) {
        <ns1:ObtenerSerializadoResquest>
            <ns1:Extension>{ data($generaEstadoCuentaTC1/FILE_EXTENSION) }</ns1:Extension>
            <ns1:Pais>{ $pais }</ns1:Pais>
            <ns1:Periodo>{fn:concat(data($generaEstadoCuentaTC1/MONTH),data($generaEstadoCuentaTC1/YEAR))}</ns1:Periodo>
            <ns1:ProductoNumero>{ data($generaEstadoCuentaTC1/PRODUCT_VALUE) }</ns1:ProductoNumero>
            <ns1:ProductoTipo>{ data($generaEstadoCuentaTC1/PRODUCT_TYPE) }</ns1:ProductoTipo>
       </ns1:ObtenerSerializadoResquest>
};

declare variable $generaEstadoCuentaTC1 as element(ns0:generaEstadoCuentaTC) external;
declare variable $pais as xs:string external;

xf:obtenerSerializadoHNIn($generaEstadoCuentaTC1,
    $pais)