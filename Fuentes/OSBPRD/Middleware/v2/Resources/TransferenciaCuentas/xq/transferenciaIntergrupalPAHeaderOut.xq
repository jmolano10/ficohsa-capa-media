(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/transferenciaIntergrupal/xsd/transferenciaIntergrupal_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciaIntergrupal";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/transferenciaIntergrupalPAHeaderOut/";

declare function xf:transferenciaIntergrupalPAHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
       <ns1:ResponseHeader>
            {
                for $TRANSACTION_ID in $outputParameters/ns0:TRANSACTION_ID
                return
                    <transactionId>{ data($TRANSACTION_ID) }</transactionId>
            }
            {
                let $PV_ERRORCODE := fn:string($outputParameters/ns0:PV_ERRORCODE/text())
                let $PV_ERRORMESSAGE := fn:string($outputParameters/ns0:PV_ERRORMESSAGE/text())
                return
                	if(upper-case($PV_ERRORCODE) = "SUCCESS")then(
                		<successIndicator>Success</successIndicator>
                	)else(
                		<successIndicator>{ $PV_ERRORCODE}</successIndicator>,
	            		<messages>{ $PV_ERRORMESSAGE }</messages>
                	)                    
            }            
            {
                for $PV_VALUEDATE in $outputParameters/ns0:PV_VALUEDATE
                return
                    <valueDate>{ data(fn:substring($PV_VALUEDATE, 1, 8)) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:transferenciaIntergrupalPAHeaderOut($outputParameters)