xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaIntergrupalReverseResponse" element="ns0:TransferenciaIntergrupalReverseResponse" location="../../../BusinessServices/T24/TransferenciaIntergrupal/xsd/TransferenciaIntergrupalTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/transferenciaIntergrupalHNHeaderOut/";

declare function xf:transferenciaIntergrupalHNHeaderOut($transferenciaIntergrupalReverseResponse as element(ns0:TransferenciaIntergrupalReverseResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $transferenciaIntergrupalReverseResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
            	let $successIndicator :=  fn:string($transferenciaIntergrupalReverseResponse/Status/successIndicator/text())
                let $messages := fn:string($transferenciaIntergrupalReverseResponse/Status/messages[1]/text())
                return
                	if(upper-case($successIndicator) = "SUCCESS")then(
                		<successIndicator>Success</successIndicator>
                	)else(
                		<successIndicator>{$successIndicator}</successIndicator>,
                		 <messages>{ data($messages) }</messages>
                	)
                    
            }            
        </ns1:ResponseHeader>
};

declare variable $transferenciaIntergrupalReverseResponse as element(ns0:TransferenciaIntergrupalReverseResponse) external;

xf:transferenciaIntergrupalHNHeaderOut($transferenciaIntergrupalReverseResponse)