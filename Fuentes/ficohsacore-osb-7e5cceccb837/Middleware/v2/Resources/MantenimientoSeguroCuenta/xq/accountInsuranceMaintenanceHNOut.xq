(:: pragma bea:global-element-parameter parameter="$accountInsuranceMaintenanceResponse" element="ns1:AccountInsuranceMaintenanceResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns0:cancelacionSeguroResponse" location="../xsd/mantenimientoSeguroCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/mantenimientoSeguroCuentaTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MantenimientoSeguroCuenta/xq/accountInsuranceMaintenanceHNOut/";

declare function xf:accountInsuranceMaintenanceHNOut($accountInsuranceMaintenanceResponse as element(ns1:AccountInsuranceMaintenanceResponse))
    as element(ns0:cancelacionSeguroResponse) {
        <ns0:cancelacionSeguroResponse>
            <SERVICE_RESPONSE>{ data($accountInsuranceMaintenanceResponse/SVC-RETURN) }</SERVICE_RESPONSE>
            <NUMBER_ERRORS>{ data($accountInsuranceMaintenanceResponse/RC-NBR-OCCUR) }</NUMBER_ERRORS>
            <CODE_ERROR>{ data($accountInsuranceMaintenanceResponse/ns1:ReturnCodes/RC[1]/Code) }</CODE_ERROR>
            <DESCRIPTION_ERROR>{ data($accountInsuranceMaintenanceResponse/ns1:ReturnCodes/RC[1]/Desc) }</DESCRIPTION_ERROR>
        </ns0:cancelacionSeguroResponse>
};

declare variable $accountInsuranceMaintenanceResponse as element(ns1:AccountInsuranceMaintenanceResponse) external;

xf:accountInsuranceMaintenanceHNOut($accountInsuranceMaintenanceResponse)