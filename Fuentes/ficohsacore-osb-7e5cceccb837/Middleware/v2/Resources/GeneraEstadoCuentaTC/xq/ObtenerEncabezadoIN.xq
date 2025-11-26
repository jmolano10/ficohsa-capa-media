(:: pragma bea:global-element-parameter parameter="$generaEstadoCuentaTC" element="ns1:generaEstadoCuentaTC" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ObtenerEncabezadosV2" location="../../../BusinessServices/VisionPlusREG/obtenerSerializado/xsd/bfemEECCHistorico.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEstadoCuentaTC/xq/ObtenerEncabezadoNIIN/";

declare function xf:ObtenerEncabezadoNIIN($generaEstadoCuentaTC as element(ns1:generaEstadoCuentaTC),
    $codigoPais as xs:string,
    $producttypevalue as xs:string)
    as element(ns0:ObtenerEncabezadosV2) {
        <ns0:ObtenerEncabezadosV2>
            <ns0:data>
                <ns2:Pais>{ $codigoPais }</ns2:Pais>
                <ns2:PeriodoFinal>{ fn:concat(data($generaEstadoCuentaTC/YEAR),data($generaEstadoCuentaTC/MONTH)) }</ns2:PeriodoFinal>
                <ns2:PeriodoInicial>{ fn:concat(data($generaEstadoCuentaTC/YEAR),data($generaEstadoCuentaTC/MONTH)) }</ns2:PeriodoInicial>
                <ns2:ProductoNumero>{ data($generaEstadoCuentaTC/PRODUCT_VALUE) }</ns2:ProductoNumero>
                <ns2:ProductoTipo>{ $producttypevalue }</ns2:ProductoTipo>
            </ns0:data>
        </ns0:ObtenerEncabezadosV2>
};

declare variable $generaEstadoCuentaTC as element(ns1:generaEstadoCuentaTC) external;
declare variable $codigoPais as xs:string external;
declare variable $producttypevalue as xs:string external;

xf:ObtenerEncabezadoNIIN($generaEstadoCuentaTC,
    $codigoPais,
    $producttypevalue)