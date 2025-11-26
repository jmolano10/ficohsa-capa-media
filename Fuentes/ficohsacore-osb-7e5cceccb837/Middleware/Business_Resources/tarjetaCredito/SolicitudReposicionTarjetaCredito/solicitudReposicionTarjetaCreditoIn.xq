(:: pragma bea:global-element-parameter parameter="$solicitudReposicionTarjetaCredito" element="ns0:solicitudReposicionTarjetaCredito" location="solicitudReposicionTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resources/SolicitudReposicionTarjetaCreditoT24/xsd/ORA_BANK_OSB_SOL_REPOSICION_TC_T24.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_SOL_REPOSICION_TC_T24/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudReposicionTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudReposicionTarjetaCredito/solicitudReposicionTarjetaCreditoIn/";

declare function xf:solicitudReposicionTarjetaCreditoIn($solicitudReposicionTarjetaCredito as element(ns0:solicitudReposicionTarjetaCredito),
    $date as xs:string,
    $name as xs:string,
    $agency as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:USER_ID>{ data($solicitudReposicionTarjetaCredito/USER_ID) }</ns1:USER_ID>
            <ns1:EMAIL_ADDRESS>{ data($solicitudReposicionTarjetaCredito/EMAIL_ADDRESS) }</ns1:EMAIL_ADDRESS>
            <ns1:CUSTOMER_ID>{ data($solicitudReposicionTarjetaCredito/CUSTOMER_ID) }</ns1:CUSTOMER_ID>
            <ns1:INTERFACE_REFERENCE_NO>{ data($solicitudReposicionTarjetaCredito/INTERFACE_REFERENCE_NO) }</ns1:INTERFACE_REFERENCE_NO>
            <ns1:CARD_NUMBER>{ data($solicitudReposicionTarjetaCredito/CARD_NUMBER) }</ns1:CARD_NUMBER>
            <ns1:CARD_TO_REPLACE>{ data($solicitudReposicionTarjetaCredito/CARD_TO_REPLACE) }</ns1:CARD_TO_REPLACE>
            <ns1:REPLACEMENT_REASON>{ data($solicitudReposicionTarjetaCredito/REPLACEMENT_REASON) }</ns1:REPLACEMENT_REASON>
            <ns1:WITHDRAWAL_BRANCH_CODE>{ data($solicitudReposicionTarjetaCredito/WITHDRAWAL_BRANCH_CODE) }</ns1:WITHDRAWAL_BRANCH_CODE>
            <ns1:BMC_DATE>{ $date }</ns1:BMC_DATE>
            <ns1:AGENCY_NAME>{ $agency }</ns1:AGENCY_NAME>
            <ns1:CUSTOMER_NAME>{ $name }</ns1:CUSTOMER_NAME>
        </ns1:InputParameters>
};

declare variable $solicitudReposicionTarjetaCredito as element(ns0:solicitudReposicionTarjetaCredito) external;
declare variable $date as xs:string external;
declare variable $name as xs:string external;
declare variable $agency as xs:string external;

xf:solicitudReposicionTarjetaCreditoIn($solicitudReposicionTarjetaCredito,
    $date,
    $name,
    $agency)