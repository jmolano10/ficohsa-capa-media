<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cancelacionSeguro" element="ns0:cancelacionSeguro" location="../xsd/mantenimientoSeguroCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:AccountInsuranceMaintenanceRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/mantenimientoSeguroCuentaTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MantenimientoSeguroCuenta/xq/accountInsuranceMaintenanceHNIn/";

declare function xf:accountInsuranceMaintenanceHNIn($cancelacionSeguro as element(ns0:cancelacionSeguro),
    $Filler as xs:string,
    $UserFiller as xs:string)
    as element(ns1:AccountInsuranceMaintenanceRequest) {
        <ns1:AccountInsuranceMaintenanceRequest>
            <ARXIUI-ORG>{ data($cancelacionSeguro/ORG) }</ARXIUI-ORG>
            <ARXIUI-CARD-ACCT>{ data($cancelacionSeguro/CARD_NUMBER) }</ARXIUI-CARD-ACCT>
            <ARXIUI-DUAL-IND>{ data($cancelacionSeguro/DUAL_INDICATOR) }</ARXIUI-DUAL-IND>
            <ARXIUI-INS-PROD-CODE>{ data($cancelacionSeguro/PRODUCT_CODE) }</ARXIUI-INS-PROD-CODE>
            <ARXIUI-INS-STATUS-CODE>{ data($cancelacionSeguro/STATE_CODE) }</ARXIUI-INS-STATUS-CODE>
            <ARXIUI-CAN-REASON-CODE>{ data($cancelacionSeguro/REASON_CANCELLATION) }</ARXIUI-CAN-REASON-CODE>
            <ARXIUI-FILLER>{ $Filler }</ARXIUI-FILLER>
            <ARXIUI-USER-FILLER>{ $UserFiller }</ARXIUI-USER-FILLER>
        </ns1:AccountInsuranceMaintenanceRequest>
};

declare variable $cancelacionSeguro as element(ns0:cancelacionSeguro) external;
declare variable $Filler as xs:string external;
declare variable $UserFiller as xs:string external;

xf:accountInsuranceMaintenanceHNIn($cancelacionSeguro,
    $Filler,
    $UserFiller)]]></con:xquery>
    <con:dependency location="../xsd/mantenimientoSeguroCuentaTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/MantenimientoSeguroCuenta/xsd/mantenimientoSeguroCuentaTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616"/>
    </con:dependency>
</con:xqueryEntry>