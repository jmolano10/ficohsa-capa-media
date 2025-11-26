(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/ObtenerNombreSucursal/ObtenerNombreSucursal_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerNombreSucursal";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ObtenerNombreSucursal/ObtenerNombreSucursalIn/";

declare function xf:ObtenerNombreSucursalIn($BranchID as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_BRANCHID>{ $BranchID }</ns0:PV_BRANCHID>
        </ns0:InputParameters>
};

declare variable $BranchID as xs:string external;

xf:ObtenerNombreSucursalIn($BranchID)
