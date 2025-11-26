(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/ObtenerUsuarioCaja/ObtenerUsuarioCaja_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerUsuarioCaja";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/General/obtenerUsuarioCaja/";

declare function xf:obtenerUsuarioCaja($tellerCode as xs:string,
    $branchCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDCAJERO>{ $tellerCode }</ns0:PV_IDCAJERO>
            <ns0:PV_IDAGENCIA>{ $branchCode }</ns0:PV_IDAGENCIA>
        </ns0:InputParameters>
};

declare variable $tellerCode as xs:string external;
declare variable $branchCode as xs:string external;

xf:obtenerUsuarioCaja($tellerCode,
    $branchCode)