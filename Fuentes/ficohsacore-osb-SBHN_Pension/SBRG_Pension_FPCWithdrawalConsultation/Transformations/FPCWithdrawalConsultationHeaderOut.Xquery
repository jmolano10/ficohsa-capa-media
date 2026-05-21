<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/autType";
(:: import schema at "../../SBRG_Pension_Commons/Schemas/HeaderElements.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/FPCWithdrawalConsultationTypes.xsd" ::)

declare variable $FPCWithdrawalConsultationResponse as element() (:: schema-element(ns1:FPCWithdrawalConsultationResponse) ::) external;

declare function local:funcFPCWithdrawalConsultationHeaderOut($FPCWithdrawalConsultationResponse as element() (:: schema-element(ns1:FPCWithdrawalConsultationResponse) ::)) as element() (:: schema-element(ns2:ResponseHeader) ::) {
    <ns2:ResponseHeader>
        {
            if ($FPCWithdrawalConsultationResponse/ErrorInfo/Error)
            then <MessageId>{fn:data($FPCWithdrawalConsultationResponse/ErrorInfo/Error)}</MessageId>
            else ()
        }
        {
            if ($FPCWithdrawalConsultationResponse/StatusInfo/Status)
            then <SuccessIndicator>{fn:data($FPCWithdrawalConsultationResponse/StatusInfo/Status)}</SuccessIndicator>
            else ()
        }
        <Messages>{fn:data($FPCWithdrawalConsultationResponse/ErrorInfo/Details/Messages)}</Messages>
    </ns2:ResponseHeader>
};

local:funcFPCWithdrawalConsultationHeaderOut($FPCWithdrawalConsultationResponse)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBRG_Pension_Commons/Schemas/HeaderElements.xsd">
            <con:schema ref="SBRG_Pension_Commons/Schemas/HeaderElements"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/FPCWithdrawalConsultationTypes.xsd">
            <con:schema ref="SBRG_Pension_FPCWithdrawalConsultation/Schemas/FPCWithdrawalConsultationTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>