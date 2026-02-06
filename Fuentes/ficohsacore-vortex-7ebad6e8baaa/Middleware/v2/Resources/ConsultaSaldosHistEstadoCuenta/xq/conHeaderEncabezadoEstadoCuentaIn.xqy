xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosHistEstadoCuenta" element="ns1:consultaSaldosHistEstadoCuenta" location="../xsd/consultaSaldosHistEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conHeaderEncabezadoEstadoCuenta/xsd/conHeaderEncabezadoEstadoCuenta_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosHistEstadoCuentaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conHeaderEncabezadoEstadoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosHistEstadoCuenta/xq/conHeaderEncabezadoEstadoCuentaIn/";

declare function xf:conHeaderEncabezadoEstadoCuentaIn($consultaSaldosHistEstadoCuenta as element(ns1:consultaSaldosHistEstadoCuenta),
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $codigoPais }</ns0:Pais>
            <ns0:Org>{ data($consultaSaldosHistEstadoCuenta/ORG) }</ns0:Org>
            <ns0:NumCuenta>{ data($consultaSaldosHistEstadoCuenta/CARD_NUMBER) }</ns0:NumCuenta>
            <ns0:PeriodoInicial>{ data($consultaSaldosHistEstadoCuenta/INITIAL_PERIOD) }</ns0:PeriodoInicial>
            <ns0:PeriodoFinal>{ data($consultaSaldosHistEstadoCuenta/FINAL_PERIOD) }</ns0:PeriodoFinal>
        </ns0:InputParameters>
};

declare variable $consultaSaldosHistEstadoCuenta as element(ns1:consultaSaldosHistEstadoCuenta) external;
declare variable $codigoPais as xs:string external;

xf:conHeaderEncabezadoEstadoCuentaIn($consultaSaldosHistEstadoCuenta,
    $codigoPais)