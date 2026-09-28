(:: pragma bea:global-element-parameter parameter="$colocacionPrestamoATMRequest" element="ns1:colocacionPrestamoATMRequest" location="../xsd/colocacionPrestamoATMTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ATM/RegistrarColocacion/Prestamo/xsd/registrarColocacionPrestamo_db_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarColocacionPrestamo_db";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/colocacionPrestamoATMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ColocacionPrestamoATM/xq/registrarColocacionPrestamo_dbIn/";

declare function xf:registrarColocacionPrestamo_dbIn($colocacionPrestamoATMRequest as element(ns1:colocacionPrestamoATMRequest),
    $legalId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_DNI>{ fn-bea:trim($legalId) }</ns0:PV_DNI>
            <ns0:PV_ID_ATM>{ fn:data($colocacionPrestamoATMRequest/ATM_ID) }</ns0:PV_ID_ATM>
            <ns0:PV_ID_TRACE>{ fn:data($colocacionPrestamoATMRequest/TRACE_ID) }</ns0:PV_ID_TRACE>
            <ns0:PV_NOMBRE_ATM>{ fn:data($colocacionPrestamoATMRequest/ATM_NAME) }</ns0:PV_NOMBRE_ATM>
        </ns0:InputParameters>
};

declare variable $colocacionPrestamoATMRequest as element(ns1:colocacionPrestamoATMRequest) external;
declare variable $legalId as xs:string external;

xf:registrarColocacionPrestamo_dbIn($colocacionPrestamoATMRequest,
    $legalId)