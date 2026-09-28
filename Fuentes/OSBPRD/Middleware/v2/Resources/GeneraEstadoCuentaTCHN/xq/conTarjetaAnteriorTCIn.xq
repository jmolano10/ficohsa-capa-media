(:: pragma bea:global-element-parameter parameter="$generaEstadoCuentaTC" element="ns1:generaEstadoCuentaTC" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ProcesosHN/conTarjetaAnteriorTC/xsd/conTarjetaAnteriorTC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTarjetaAnteriorTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEstadoCuentaTCHN/xq/conTarjetaAnteriorTCIn/";

declare function xf:conTarjetaAnteriorTCIn($generaEstadoCuentaTC as element(ns1:generaEstadoCuentaTC),
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $codigoPais }</ns0:Pais>
            <ns0:NumCard>{ data($generaEstadoCuentaTC/PRODUCT_VALUE) }</ns0:NumCard>
            <ns0:Mes>{ data($generaEstadoCuentaTC/MONTH) }</ns0:Mes>
            <ns0:Anio>{ data($generaEstadoCuentaTC/YEAR) }</ns0:Anio>
        </ns0:InputParameters>
};

declare variable $generaEstadoCuentaTC as element(ns1:generaEstadoCuentaTC) external;
declare variable $codigoPais as xs:string external;

xf:conTarjetaAnteriorTCIn($generaEstadoCuentaTC,
    $codigoPais)