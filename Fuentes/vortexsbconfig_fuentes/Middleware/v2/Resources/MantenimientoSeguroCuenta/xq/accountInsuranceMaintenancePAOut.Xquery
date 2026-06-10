<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$accountInsuranceMaintenanceResponse1" element="ns1:AccountInsuranceMaintenanceResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns0:cancelacionSeguroResponse" location="../xsd/mantenimientoSeguroCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/mantenimientoSeguroCuentaTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MantenimientoSeguroCuenta/xq/accountInsuranceMaintenancePAOut/";

declare function xf:accountInsuranceMaintenancePAOut($accountInsuranceMaintenanceResponse1 as element(ns1:AccountInsuranceMaintenanceResponse))
    as element(ns0:cancelacionSeguroResponse) {
        <ns0:cancelacionSeguroResponse>
            <SERVICE_RESPONSE>{ data($accountInsuranceMaintenanceResponse1/SVC-RETURN) }</SERVICE_RESPONSE>
            <NUMBER_ERRORS>{ data($accountInsuranceMaintenanceResponse1/RC-NBR-OCCUR) }</NUMBER_ERRORS>
            <CODE_ERROR>{ data($accountInsuranceMaintenanceResponse1/ns1:ReturnCodes/RC[1]/Code) }</CODE_ERROR>
            <DESCRIPTION_ERROR>{ data($accountInsuranceMaintenanceResponse1/ns1:ReturnCodes/RC[1]/Desc) }</DESCRIPTION_ERROR>
        </ns0:cancelacionSeguroResponse>
};

declare variable $accountInsuranceMaintenanceResponse1 as element(ns1:AccountInsuranceMaintenanceResponse) external;

xf:accountInsuranceMaintenancePAOut($accountInsuranceMaintenanceResponse1)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616"/>
    </con:dependency>
    <con:dependency location="../xsd/mantenimientoSeguroCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/MantenimientoSeguroCuenta/xsd/mantenimientoSeguroCuentaTypes"/>
    </con:dependency>
</con:xqueryEntry>