(:: pragma bea:global-element-parameter parameter="$solicitudTarjetaCreditoAdicional" element="ns0:solicitudTarjetaCreditoAdicional" location="solicitudTarjetaCreditoAdicionalTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resources/SolicitudTarjetaCreditoAdicionalT24/xsd/ORA_BANK_OSB_SOL_ADICIONAL_TC_T24.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_SOL_ADICIONAL_TC_T24/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudTarjetaCreditoAdicionalTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/SolicitudTarjetaCreditoAdicional/solicitudTarjetaCreditoAdicionalIn/";

declare function xf:solicitudTarjetaCreditoAdicionalIn($solicitudTarjetaCreditoAdicional as element(ns0:solicitudTarjetaCreditoAdicional),
    $date as xs:string,
    $name as xs:string,
    $agency as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:USER_ID>{ data($solicitudTarjetaCreditoAdicional/USER_ID) }</ns1:USER_ID>
            <ns1:EMAIL_ADDRESS>{ data($solicitudTarjetaCreditoAdicional/EMAIL_ADDRESS) }</ns1:EMAIL_ADDRESS>
            <ns1:CUSTOMER_ID>{ data($solicitudTarjetaCreditoAdicional/CUSTOMER_ID) }</ns1:CUSTOMER_ID>
            <ns1:INTERFACE_REFERENCE_NO>{ data($solicitudTarjetaCreditoAdicional/INTERFACE_REFERENCE_NO) }</ns1:INTERFACE_REFERENCE_NO>
            <ns1:CARD_NUMBER>{ data($solicitudTarjetaCreditoAdicional/CARD_NUMBER) }</ns1:CARD_NUMBER>
            <ns1:CUSTOMER_LEGAL_ID>{ data($solicitudTarjetaCreditoAdicional/CUSTOMER_LEGAL_ID) }</ns1:CUSTOMER_LEGAL_ID>
            <ns1:FIRST_GIVEN_NAME>{ data($solicitudTarjetaCreditoAdicional/FIRST_GIVEN_NAME) }</ns1:FIRST_GIVEN_NAME>
            <ns1:SECOND_GIVEN_NAME>{ data($solicitudTarjetaCreditoAdicional/SECOND_GIVEN_NAME) }</ns1:SECOND_GIVEN_NAME>
            <ns1:FIRST_FAMILY_NAME>{ data($solicitudTarjetaCreditoAdicional/FIRST_FAMILY_NAME) }</ns1:FIRST_FAMILY_NAME>
            <ns1:SECOND_FAMILY_NAME>{ data($solicitudTarjetaCreditoAdicional/SECOND_FAMILY_NAME) }</ns1:SECOND_FAMILY_NAME>
            <ns1:NAME_ON_CARD>{ data($solicitudTarjetaCreditoAdicional/NAME_ON_CARD) }</ns1:NAME_ON_CARD>
            <ns1:SECONDARY_CARD_HOLDER_ID>{ data($solicitudTarjetaCreditoAdicional/SECONDARY_CARD_HOLDER_ID) }</ns1:SECONDARY_CARD_HOLDER_ID>
            <ns1:WITHDRAWAL_BRANCH_CODE>{ data($solicitudTarjetaCreditoAdicional/WITHDRAWAL_BRANCH_CODE) }</ns1:WITHDRAWAL_BRANCH_CODE>
            <ns1:BMC_DATE>{ $date }</ns1:BMC_DATE>
            <ns1:CUSTOMER_NAME>{ $name }</ns1:CUSTOMER_NAME>
            <ns1:AGENCY_NAME>{ $agency }</ns1:AGENCY_NAME>
        </ns1:InputParameters>
};

declare variable $solicitudTarjetaCreditoAdicional as element(ns0:solicitudTarjetaCreditoAdicional) external;
declare variable $date as xs:string external;
declare variable $name as xs:string external;
declare variable $agency as xs:string external;

xf:solicitudTarjetaCreditoAdicionalIn($solicitudTarjetaCreditoAdicional,
    $date,
    $name,
    $agency)