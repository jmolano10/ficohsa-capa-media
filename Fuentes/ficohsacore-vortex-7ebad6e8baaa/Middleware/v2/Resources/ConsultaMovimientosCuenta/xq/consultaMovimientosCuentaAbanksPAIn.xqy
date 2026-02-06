xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuenta" element="ns0:consultaMovimientosCuenta" location="../xsd/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/consultaDetalladaMovimientosCuenta/xsd/consultaDetalladaMovimientosCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalladaMovimientosCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/consultaMovimientosCuentaAbanksPAIn/";

declare function xf:consultaMovimientosCuentaAbanksPAIn($consultaMovimientosCuenta as element(ns0:consultaMovimientosCuenta),
    $endDate as xs:string,
    $beginDate as xs:string,
    $ticket as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
          	<ns1:PV_ACCOUNTNUMBER>{ data($consultaMovimientosCuenta/ACCOUNT_NUMBER) }</ns1:PV_ACCOUNTNUMBER>
            <ns1:PV_BEGINDATE>{ $beginDate }</ns1:PV_BEGINDATE>
            <ns1:PV_ENDDATE>{ $endDate }</ns1:PV_ENDDATE>
            <ns1:PN_INITIALRECORD>{ data($consultaMovimientosCuenta/PAGING_INFO/INITIAL_RECORD) }</ns1:PN_INITIALRECORD>
            <ns1:PN_RECORDCOUNT>{ data($consultaMovimientosCuenta/PAGING_INFO/RECORD_COUNT) }</ns1:PN_RECORDCOUNT>
            <ns1:PV_TICKETOSB>{ $ticket }</ns1:PV_TICKETOSB>
        </ns1:InputParameters>
};

declare variable $consultaMovimientosCuenta as element(ns0:consultaMovimientosCuenta) external;
declare variable $endDate as xs:string external;
declare variable $beginDate as xs:string external;
declare variable $ticket as xs:string external;

xf:consultaMovimientosCuentaAbanksPAIn($consultaMovimientosCuenta,
    $endDate,
    $beginDate,
    $ticket)