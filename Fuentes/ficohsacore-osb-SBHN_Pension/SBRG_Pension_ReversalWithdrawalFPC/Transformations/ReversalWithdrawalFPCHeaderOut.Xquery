<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/autType";
(:: import schema at "../../SBRG_Pension_Commons/Schemas/HeaderElements.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/ReversalWithdrawalFPCTypes.xsd" ::)

declare variable $ReversalWithdrawalFPCResponse as element() (:: schema-element(ns1:ReversalWithdrawalFPCResponse) ::) external;

declare function local:funcReversalWithdrawalFPCHeaderOut($ReversalWithdrawalFPCResponse as element() (:: schema-element(ns1:ReversalWithdrawalFPCResponse) ::)) as element() (:: schema-element(ns2:ResponseHeader) ::) {
    <ns2:ResponseHeader>
        {
            if ($ReversalWithdrawalFPCResponse/ErrorInfo/Error)
            then <MessageId>{fn:data($ReversalWithdrawalFPCResponse/ErrorInfo/Error)}</MessageId>
            else ()
        }
        {
            if ($ReversalWithdrawalFPCResponse/StatusInfo/Status)
            then <SuccessIndicator>{fn:data($ReversalWithdrawalFPCResponse/StatusInfo/Status)}</SuccessIndicator>
            else ()
        }
        <Messages>{fn:data($ReversalWithdrawalFPCResponse/ErrorInfo/Details/Messages)}</Messages>
    </ns2:ResponseHeader>
};

local:funcReversalWithdrawalFPCHeaderOut($ReversalWithdrawalFPCResponse)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBRG_Pension_Commons/Schemas/HeaderElements.xsd">
            <con:schema ref="SBRG_Pension_Commons/Schemas/HeaderElements"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/ReversalWithdrawalFPCTypes.xsd">
            <con:schema ref="SBRG_Pension_ReversalWithdrawalFPC/Schemas/ReversalWithdrawalFPCTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>