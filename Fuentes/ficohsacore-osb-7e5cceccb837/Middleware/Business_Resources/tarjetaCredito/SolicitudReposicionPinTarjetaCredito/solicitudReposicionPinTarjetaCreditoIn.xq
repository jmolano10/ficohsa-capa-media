(:: pragma bea:global-element-parameter parameter="$solicitudReposicionPinTarjetaCredito" element="ns1:solicitudReposicionPinTarjetaCredito" location="solicitudReposicionPinTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/SolicitudReposicionPinTarjetaCreditoT24/xsd/ORA_BANK_OSB_SOL_REPOSICION_PIN_TC_T24.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudReposicionPinTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_SOL_REPOSICION_PIN_TC_T24/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudReposicionPinTarjetaCredito/solicitudReposicionPinTarjetaCreditoIn/";

declare function xf:solicitudReposicionPinTarjetaCreditoIn($solicitudReposicionPinTarjetaCredito as element(ns1:solicitudReposicionPinTarjetaCredito),
    $date as xs:string,
    $name as xs:string,
    $agency as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:USER_ID>{ data($solicitudReposicionPinTarjetaCredito/USER_ID) }</ns0:USER_ID>
            <ns0:EMAIL_ADDRESS>{ data($solicitudReposicionPinTarjetaCredito/EMAIL_ADDRESS) }</ns0:EMAIL_ADDRESS>
            <ns0:CUSTOMER_ID>{ data($solicitudReposicionPinTarjetaCredito/CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            <ns0:INTERFACE_REFERENCE_NO>{ data($solicitudReposicionPinTarjetaCredito/INTERFACE_REFERENCE_NO) }</ns0:INTERFACE_REFERENCE_NO>
            <ns0:CARD_NUMBER>{ data($solicitudReposicionPinTarjetaCredito/CARD_NUMBER) }</ns0:CARD_NUMBER>
            <ns0:CUSTOMER_LEGAL_ID>{ data($solicitudReposicionPinTarjetaCredito/CUSTOMER_LEGAL_ID) }</ns0:CUSTOMER_LEGAL_ID>
            <ns0:WITHDRAWAL_BRANCH_CODE>{ data($solicitudReposicionPinTarjetaCredito/WITHDRAWAL_BRANCH_CODE) }</ns0:WITHDRAWAL_BRANCH_CODE>
            <ns0:BMC_DATE>{ $date }</ns0:BMC_DATE>
            <ns0:AGENCY_NAME>{ $agency }</ns0:AGENCY_NAME>
            <ns0:CUSTOMER_NAME>{ $name }</ns0:CUSTOMER_NAME>
        </ns0:InputParameters>
};

declare variable $solicitudReposicionPinTarjetaCredito as element(ns1:solicitudReposicionPinTarjetaCredito) external;
declare variable $date as xs:string external;
declare variable $name as xs:string external;
declare variable $agency as xs:string external;

xf:solicitudReposicionPinTarjetaCreditoIn($solicitudReposicionPinTarjetaCredito,
    $date,
    $name,
    $agency)