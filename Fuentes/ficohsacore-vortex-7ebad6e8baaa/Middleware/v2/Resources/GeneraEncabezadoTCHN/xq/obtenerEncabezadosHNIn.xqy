xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$generaEncabezadoTC" element="ns1:generaEncabezadoTC" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ObtenerEncabezadosV2" location="../../../BusinessServices/VisionPlusHN/obtenerSerializado/xsd/bfemEECCHistorico.xsd" ::)

declare namespace ns2 = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEncabezadoTCHN/xq/obtenerEncabezadosHNIn/";

declare function xf:obtenerEncabezadosHNIn($pais as xs:string,
    $generaEncabezadoTC as element(ns1:generaEncabezadoTC))
    as element(ns0:ObtenerEncabezadosV2) {
        <ns0:ObtenerEncabezadosV2>
            <ns0:data>
                <ns2:Pais>{ $pais }</ns2:Pais>
                <ns2:PeriodoFinal>{ data($generaEncabezadoTC/FINAL_DATE) }</ns2:PeriodoFinal>
                <ns2:PeriodoInicial>{ data($generaEncabezadoTC/INITIAL_DATE) }</ns2:PeriodoInicial>
                <ns2:ProductoNumero>{ data($generaEncabezadoTC/PRODUCT_VALUE) }</ns2:ProductoNumero>
                <ns2:ProductoTipo>{ data($generaEncabezadoTC/PRODUCT_TYPE) }</ns2:ProductoTipo>
            </ns0:data>
        </ns0:ObtenerEncabezadosV2>
};

declare variable $pais as xs:string external;
declare variable $generaEncabezadoTC as element(ns1:generaEncabezadoTC) external;

xf:obtenerEncabezadosHNIn($pais,
    $generaEncabezadoTC)