xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosHistEstadoCuenta" element="ns2:consultaSaldosHistEstadoCuenta" location="../xsd/consultaSaldosHistEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ObtenerEncabezados" location="../../../BusinessServices/ObtenerEncabezados/xsd/XMLSchema_-1464971485.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosHistEstadoCuenta/xq/obtenerEncabezadosHNIn/";
declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosHistEstadoCuentaTypes";
declare namespace ns1 = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";

declare function xf:obtenerEncabezadosHNIn($consultaSaldosHistEstadoCuenta as element(ns2:consultaSaldosHistEstadoCuenta),$codigoPais as xs:string)
    as element(ns0:ObtenerEncabezados) {
        <ns0:ObtenerEncabezados>
            <ns0:data>
                <ns1:NumCuenta>{ data($consultaSaldosHistEstadoCuenta/CARD_NUMBER) }</ns1:NumCuenta>
                <ns1:Org>{ data($consultaSaldosHistEstadoCuenta/ORG) }</ns1:Org>
                <ns1:Pais>{ data($codigoPais) }</ns1:Pais>
                <ns1:PeriodoFinal>{ data($consultaSaldosHistEstadoCuenta/FINAL_PERIOD) }</ns1:PeriodoFinal>
                <ns1:PeriodoInicial>{ data($consultaSaldosHistEstadoCuenta/INITIAL_PERIOD) }</ns1:PeriodoInicial>
            </ns0:data>
        </ns0:ObtenerEncabezados>
};

declare variable $consultaSaldosHistEstadoCuenta as element(ns2:consultaSaldosHistEstadoCuenta) external;
declare variable $codigoPais as xs:string external;

xf:obtenerEncabezadosHNIn($consultaSaldosHistEstadoCuenta,$codigoPais)