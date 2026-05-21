<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/pagoRetiroFPCTypes";
(:: import schema at "../Schemas/PagoRetiroFPCTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/PaymentWithdrawalFPCTypes.xsd" ::)

declare variable $responseRegional as element() (:: schema-element(ns1:paymentWithdrawalFPCResponse) ::) external;

declare function local:funcRegionalToVirtualBody11gHN($responseRegional as element() (:: schema-element(ns1:paymentWithdrawalFPCResponse) ::)) as element() (:: schema-element(ns2:pagoRetiroFPCResponse) ::) {
    &lt;ns2:pagoRetiroFPCResponse/>
};

local:funcRegionalToVirtualBody11gHN($responseRegional)</con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/PagoRetiroFPCTypes.xsd">
            <con:schema ref="SBRG_Pension_PaymentWithdrawalFPC/Schemas/PagoRetiroFPCTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/PaymentWithdrawalFPCTypes.xsd">
            <con:schema ref="SBRG_Pension_PaymentWithdrawalFPC/Schemas/PaymentWithdrawalFPCTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>