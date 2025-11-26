(:: pragma bea:global-element-parameter parameter="$transferenciasACHRecibidas1" element="ns0:transferenciasACHRecibidas" location="../xsd/transferenciasACHRecibidasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:transferenciasACHRecibidasResponse" location="../xsd/transferenciasACHRecibidasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHRecibidasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/transfACHRecibidaErrorOut/";

declare function xf:transfACHRecibidaErrorOut($transferenciasACHRecibidas1 as element(ns0:transferenciasACHRecibidas),
    $errorMessage as xs:string,
    $errorCode as xs:string)
    as element(ns0:transferenciasACHRecibidasResponse) {
        <ns0:transferenciasACHRecibidasResponse>
            <TRANSACTION_DETAILS>
                <TRANSACTION_DETAIL>
                    <TRANSACTION_TYPE>{ data($transferenciasACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_TYPE) }</TRANSACTION_TYPE>
                    <DESTINATION>{ data($transferenciasACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/DESTINATION) }</DESTINATION>
                    <CURRENCY>{ data($transferenciasACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/CURRENCY) }</CURRENCY>
                    <AMOUNT>{ data($transferenciasACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/AMOUNT) }</AMOUNT>
                    <BENEFICIARY_NAME>{ data($transferenciasACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                    <ORIGINATOR_INFO>{ $transferenciasACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/@* , $transferenciasACHRecibidas1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/node() }</ORIGINATOR_INFO>
                    <TRANSACTION_RESULT>
                        <ERROR_CODE>{ $errorCode }</ERROR_CODE>
                        <ERROR_MESSAGE>{ $errorMessage }</ERROR_MESSAGE>
                    </TRANSACTION_RESULT>
                </TRANSACTION_DETAIL>
            </TRANSACTION_DETAILS>
        </ns0:transferenciasACHRecibidasResponse>
};

declare variable $transferenciasACHRecibidas1 as element(ns0:transferenciasACHRecibidas) external;
declare variable $errorMessage as xs:string external;
declare variable $errorCode as xs:string external;

xf:transfACHRecibidaErrorOut($transferenciasACHRecibidas1,
    $errorMessage,
    $errorCode)