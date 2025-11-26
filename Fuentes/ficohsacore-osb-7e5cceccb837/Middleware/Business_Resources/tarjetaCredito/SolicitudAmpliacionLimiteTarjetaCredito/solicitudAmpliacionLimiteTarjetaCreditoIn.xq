(:: pragma bea:global-element-parameter parameter="$solicitudAmpliacionLimiteTarjetaCredito" element="ns1:solicitudAmpliacionLimiteTarjetaCredito" location="solicitudAmpliacionLimiteTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/SolicitudAmpliacionLimiteTarjetaCreditoT24/xsd/ORA_BANK_OSB_SOL_AMP_LIMIT_TC_T24.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudAmpliacionLimiteTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_SOL_AMP_LIMIT_TC_T24/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudAmpliacionLimiteTarjetaCredito/solicitudAmpliacionLimiteTarjetaCreditoIn/";

declare function xf:solicitudAmpliacionLimiteTarjetaCreditoIn($solicitudAmpliacionLimiteTarjetaCredito as element(ns1:solicitudAmpliacionLimiteTarjetaCredito),
    $name as xs:string,
    $date as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:USER_ID>{ data($solicitudAmpliacionLimiteTarjetaCredito/USER_ID) }</ns0:USER_ID>
            <ns0:EMAIL_ADDRESS>{ data($solicitudAmpliacionLimiteTarjetaCredito/EMAIL_ADDRESS) }</ns0:EMAIL_ADDRESS>
            <ns0:CUSTOMER_ID>{ data($solicitudAmpliacionLimiteTarjetaCredito/CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            <ns0:CUSTOMER_NAME>{ $name }</ns0:CUSTOMER_NAME>
            <ns0:INTERFACE_REFERENCE_NO>{ data($solicitudAmpliacionLimiteTarjetaCredito/INTERFACE_REFERENCE_NO) }</ns0:INTERFACE_REFERENCE_NO>
            <ns0:CARD_NUMBER>{ data($solicitudAmpliacionLimiteTarjetaCredito/CARD_NUMBER) }</ns0:CARD_NUMBER>
            <ns0:HOME_ADDRESS>{ data($solicitudAmpliacionLimiteTarjetaCredito/HOME_ADDRESS) }</ns0:HOME_ADDRESS>
            <ns0:REGION>{ data($solicitudAmpliacionLimiteTarjetaCredito/REGION) }</ns0:REGION>
            <ns0:WORK_COMPANY>{ data($solicitudAmpliacionLimiteTarjetaCredito/WORK_COMPANY) }</ns0:WORK_COMPANY>
            <ns0:CURRENT_WORK_POSITION>{ data($solicitudAmpliacionLimiteTarjetaCredito/CURRENT_WORK_POSITION) }</ns0:CURRENT_WORK_POSITION>
            <ns0:LCY_MONTHLY_SALARY>{ data($solicitudAmpliacionLimiteTarjetaCredito/LCY_MONTHLY_SALARY) }</ns0:LCY_MONTHLY_SALARY>
            <ns0:WORK_ADDRESS>{ data($solicitudAmpliacionLimiteTarjetaCredito/WORK_ADDRESS) }</ns0:WORK_ADDRESS>
            <ns0:WORK_PHONE>{ data($solicitudAmpliacionLimiteTarjetaCredito/WORK_PHONE) }</ns0:WORK_PHONE>
            <ns0:LCY_CURRENT_LIMIT>{ data($solicitudAmpliacionLimiteTarjetaCredito/LCY_CURRENT_LIMIT) }</ns0:LCY_CURRENT_LIMIT>
            <ns0:FCY_CURRENT_LIMIT>{ data($solicitudAmpliacionLimiteTarjetaCredito/FCY_CURRENT_LIMIT) }</ns0:FCY_CURRENT_LIMIT>
            <ns0:LCY_REQUESTED_LIMIT>{ data($solicitudAmpliacionLimiteTarjetaCredito/LCY_REQUESTED_LIMIT) }</ns0:LCY_REQUESTED_LIMIT>
            <ns0:FCY_REQUESTED_LIMIT>{ data($solicitudAmpliacionLimiteTarjetaCredito/FCY_REQUESTED_LIMIT) }</ns0:FCY_REQUESTED_LIMIT>
            <ns0:BMC_DATE>{ $date }</ns0:BMC_DATE>
        </ns0:InputParameters>
};

declare variable $solicitudAmpliacionLimiteTarjetaCredito as element(ns1:solicitudAmpliacionLimiteTarjetaCredito) external;
declare variable $name as xs:string external;
declare variable $date as xs:string external;

xf:solicitudAmpliacionLimiteTarjetaCreditoIn($solicitudAmpliacionLimiteTarjetaCredito,
    $name,
    $date)