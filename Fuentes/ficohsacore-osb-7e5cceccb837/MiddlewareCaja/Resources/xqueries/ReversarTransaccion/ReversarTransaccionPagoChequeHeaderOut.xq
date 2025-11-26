xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$reversiondePagodeChequesResponse" element="ns0:ReversiondePagodeChequesResponse" location="../../xsds/ReversaTransaccion/XMLSchema_-193201527.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoChequeHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:ReversarTransaccionPagoChequeHeaderOut($reversiondePagodeChequesResponse as element(ns0:ReversiondePagodeChequesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $reversiondePagodeChequesResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                let $RECORDSTATUS := fn:string($reversiondePagodeChequesResponse/FICOHCHQTRANREVERSEType/TXNSTATUS/text())
                return
                	if($RECORDSTATUS = "Reversed") then (
                    	<successIndicator>Success</successIndicator>
                    ) else (
                    	<successIndicator>ERROR</successIndicator>
                    )
            }
            {
            	if (fn:string($reversiondePagodeChequesResponse/Status/successIndicator/text()) = "Success") then (
            		<messages>{ data($reversiondePagodeChequesResponse/FICOHCHQTRANREVERSEType/gDESCRIPTION/DESCRIPTION) }</messages>
            	) else (
            		<messages>{ data($reversiondePagodeChequesResponse/Status/messages) }</messages>
            	) 
            }
            {
                let $result :=
                    for $DATETIME in $reversiondePagodeChequesResponse/FICOHCHQTRANREVERSEType/gDATETIME/DATETIME
                    return
                        <valueDate>{ concat("20",$DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $reversiondePagodeChequesResponse as element(ns0:ReversiondePagodeChequesResponse) external;

xf:ReversarTransaccionPagoChequeHeaderOut($reversiondePagodeChequesResponse)