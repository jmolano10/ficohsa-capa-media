(:: pragma bea:global-element-parameter parameter="$cancelacionSeguro1" element="ns0:cancelacionSeguro" location="../xsd/mantenimientoSeguroCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:AccountInsuranceMaintenanceRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/mantenimientoSeguroCuentaTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MantenimientoSeguroCuenta/xq/accountInsuranceMaintenanceNIIn/";

declare function xf:accountInsuranceMaintenanceNIIn($cancelacionSeguro1 as element(ns0:cancelacionSeguro),
    $Filler as xs:string,
    $UserFiller as xs:string)
    as element(ns1:AccountInsuranceMaintenanceRequest) {
        <ns1:AccountInsuranceMaintenanceRequest>
            <ARXIUI-ORG>{ data($cancelacionSeguro1/ORG) }</ARXIUI-ORG>
            <ARXIUI-CARD-ACCT>{ data($cancelacionSeguro1/CARD_NUMBER) }</ARXIUI-CARD-ACCT>
            <ARXIUI-DUAL-IND>{ data($cancelacionSeguro1/DUAL_INDICATOR) }</ARXIUI-DUAL-IND>
            <ARXIUI-INS-PROD-CODE>{ data($cancelacionSeguro1/PRODUCT_CODE) }</ARXIUI-INS-PROD-CODE>
            <ARXIUI-INS-STATUS-CODE>{ data($cancelacionSeguro1/STATE_CODE) }</ARXIUI-INS-STATUS-CODE>
            <ARXIUI-CAN-REASON-CODE>{ data($cancelacionSeguro1/REASON_CANCELLATION) }</ARXIUI-CAN-REASON-CODE>
            <ARXIUI-FILLER>{ data($Filler) }</ARXIUI-FILLER>
            <ARXIUI-USER-FILLER>{ data($UserFiller) }</ARXIUI-USER-FILLER>
        </ns1:AccountInsuranceMaintenanceRequest>
};

declare variable $cancelacionSeguro1 as element(ns0:cancelacionSeguro) external;
declare variable $Filler as xs:string external;
declare variable $UserFiller as xs:string external;

xf:accountInsuranceMaintenanceNIIn($cancelacionSeguro1,
    $Filler,
    $UserFiller)