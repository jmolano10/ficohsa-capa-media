<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosHistEstadoCuenta1" element="ns0:consultaSaldosHistEstadoCuenta" location="../../ConsultaSaldosHistEstadoCuenta/xsd/consultaSaldosHistEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ProcesosPA/conHeaderEncabezadoEstadoCuenta/xsd/conHeaderEncabezadoEstadoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosHistEstadoCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conHeaderEncabezadoEstadoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosHistEstadoCuentaPA/xq/conHeaderEncabezadoEstadoCuentaPAIn/";

declare function xf:conHeaderEncabezadoEstadoCuentaPAIn($consultaSaldosHistEstadoCuenta1 as element(ns0:consultaSaldosHistEstadoCuenta),
    $codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $codigoPais }</ns1:Pais>
            <ns1:Org>{ data($consultaSaldosHistEstadoCuenta1/ORG) }</ns1:Org>
            <ns1:NumCuenta>{ data($consultaSaldosHistEstadoCuenta1/CARD_NUMBER) }</ns1:NumCuenta>
            <ns1:PeriodoInicial>{ data($consultaSaldosHistEstadoCuenta1/INITIAL_PERIOD) }</ns1:PeriodoInicial>
            <ns1:PeriodoFinal>{ data($consultaSaldosHistEstadoCuenta1/FINAL_PERIOD) }</ns1:PeriodoFinal>
        </ns1:InputParameters>
};

declare variable $consultaSaldosHistEstadoCuenta1 as element(ns0:consultaSaldosHistEstadoCuenta) external;
declare variable $codigoPais as xs:string external;

xf:conHeaderEncabezadoEstadoCuentaPAIn($consultaSaldosHistEstadoCuenta1,
    $codigoPais)]]></con:xquery>
    <con:dependency location="../../ConsultaSaldosHistEstadoCuenta/xsd/consultaSaldosHistEstadoCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaSaldosHistEstadoCuenta/xsd/consultaSaldosHistEstadoCuentaTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ProcesosPA/conHeaderEncabezadoEstadoCuenta/xsd/conHeaderEncabezadoEstadoCuenta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ProcesosPA/conHeaderEncabezadoEstadoCuenta/xsd/conHeaderEncabezadoEstadoCuenta_sp"/>
    </con:dependency>
</con:xqueryEntry>