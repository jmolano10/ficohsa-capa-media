(:: pragma bea:global-element-parameter parameter="$consultaSaldosHistEstadoCuenta" element="ns0:consultaSaldosHistEstadoCuenta" location="../../ConsultaSaldosHistEstadoCuenta/xsd/consultaSaldosHistEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataGT/conHeaderEncabezadoEstadoCuenta/xsd/conHeaderEncabezadoEstadoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosHistEstadoCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conHeaderEncabezadoEstadoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosHistEstadoCuentaGT/xq/conHeaderEncabezadoEstadoCuentaPAIn/";

declare function xf:conHeaderEncabezadoEstadoCuentaPAIn($consultaSaldosHistEstadoCuenta as element(ns0:consultaSaldosHistEstadoCuenta),
    $codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $codigoPais }</ns1:Pais>
            <ns1:Org>{ data($consultaSaldosHistEstadoCuenta/ORG) }</ns1:Org>
            <ns1:NumCuenta>{ data($consultaSaldosHistEstadoCuenta/CARD_NUMBER) }</ns1:NumCuenta>
            <ns1:PeriodoInicial>{ data($consultaSaldosHistEstadoCuenta/INITIAL_PERIOD) }</ns1:PeriodoInicial>
            <ns1:PeriodoFinal>{ data($consultaSaldosHistEstadoCuenta/FINAL_PERIOD) }</ns1:PeriodoFinal>
        </ns1:InputParameters>
};

declare variable $consultaSaldosHistEstadoCuenta as element(ns0:consultaSaldosHistEstadoCuenta) external;
declare variable $codigoPais as xs:string external;

xf:conHeaderEncabezadoEstadoCuentaPAIn($consultaSaldosHistEstadoCuenta,
    $codigoPais)