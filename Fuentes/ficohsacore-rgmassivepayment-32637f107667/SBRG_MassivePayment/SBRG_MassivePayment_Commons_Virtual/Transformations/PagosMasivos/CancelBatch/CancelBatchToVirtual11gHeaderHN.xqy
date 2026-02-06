xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/autType";
(:: import schema at "../../../Schemas/HeaderElements.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_CancelBatch/Schemas/CancelBatchTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:cancelBatchResponse) ::) external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:cancelBatchResponse) ::)
    ) as element() (:: schema-element(ns2:ResponseHeader) ::) {
    <ns2:ResponseHeader>
        {
            if ($responseService/ErrorInfo/Error)
            then <messageId>{fn:data($responseService/ErrorInfo/Error)}</messageId>
            else ()
        }
        {
            if ($responseService/StatusInfo/Status) then
                if (fn:data($responseService/StatusInfo/Status) = 'Error') then 
                    <successIndicator>ERROR</successIndicator>
                else 
                    <successIndicator>{fn:data($responseService/StatusInfo/Status)}</successIndicator>
            else ()
        }
        {
            if ($responseService/ErrorInfo/Description)
            then  <messages>{fn:data($responseService/ErrorInfo/Description)}</messages>
            else ()
        }
    </ns2:ResponseHeader>
};

local:func($responseService)