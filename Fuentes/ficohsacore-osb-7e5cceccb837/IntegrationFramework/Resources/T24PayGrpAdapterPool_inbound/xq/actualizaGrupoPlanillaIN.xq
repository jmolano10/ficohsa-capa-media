(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/actualizaGrupoPlanilla/xsd/actualizaGrupoPlanilla_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaGrupoPlanilla_db";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24PayGrpAdapterPool_inbound/xq/actualizaGrupoPlanillaIN/";

declare function xf:actualizaGrupoPlanillaIN($GrupoPlanilla as xs:string,
    $CuentaT24 as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID_CUENTA>{ $CuentaT24 }</ns0:PV_ID_CUENTA>
            <ns0:PV_ID_GRUPO_PLANILLA>{ $GrupoPlanilla }</ns0:PV_ID_GRUPO_PLANILLA>
        </ns0:InputParameters>
};

declare variable $GrupoPlanilla as xs:string external;
declare variable $CuentaT24 as xs:string external;

xf:actualizaGrupoPlanillaIN($GrupoPlanilla,
    $CuentaT24)
