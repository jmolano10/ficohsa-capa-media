xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TransferenciaCuentas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/transferenciaCuentas/xq/transferencaCuentasHeaderOut/";

declare function xf:transferencaCuentasHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $TRANSACTION_ID in $outputParameters1/ns1:TRANSACTION_ID
                return
                    <transactionId>{ data($TRANSACTION_ID) }</transactionId>
            }
            {
            	let $successIndicator := fn:string($outputParameters1/ns1:ERROR_CODE/text())
            	let $message := fn:string($outputParameters1/ns1:ERROR_MESSAGE/text())
            	return 
	            	if ($successIndicator  = "SUCCESS") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	) 
            }
            {
                for $VALUE_DATE in $outputParameters1/ns1:VALUE_DATE
                return
                    <valueDate>{ data(fn:substring($VALUE_DATE, 1, 8)) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:transferencaCuentasHeaderOut($outputParameters1)