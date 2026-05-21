<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/PaymentWithdrawalFPCTypes.xsd" ::)

declare variable $request as element() (:: schema-element(ns1:paymentWithdrawalFPC) ::) external;

declare function local:func($request as element() (:: schema-element(ns1:paymentWithdrawalFPC) ::)) as element() (:: schema-element(ns2:retirosPost) ::) {
    <ns2:retirosPost>
        <ns2:numeroTransaccion>{fn:data($request/ApplicationNumber)}</ns2:numeroTransaccion>
        <ns2:moneda>{fn:data($request/Currency)}</ns2:moneda>
        <ns2:monto>{fn:data($request/Amount)}</ns2:monto>
        <ns2:usuarioPago>{fn:data($request/PaidUse)}</ns2:usuarioPago>
        <ns2:fechaPago>{fn:data($request/PaymentDate)}</ns2:fechaPago>
        <ns2:numeroReferencia>{fn:data($request/Transaction)}</ns2:numeroReferencia>
        <ns2:codigoAgencia>{fn:data($request/AgencyCode)}</ns2:codigoAgencia>
        <ns2:nombreAgencia>{fn:data($request/AgencyName)}</ns2:nombreAgencia>
    </ns2:retirosPost>
};

local:func($request)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/PaymentWithdrawalFPCTypes.xsd">
            <con:schema ref="SBHN_Pension_PaymentWithdrawalFPC/Schemas/PaymentWithdrawalFPCTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>