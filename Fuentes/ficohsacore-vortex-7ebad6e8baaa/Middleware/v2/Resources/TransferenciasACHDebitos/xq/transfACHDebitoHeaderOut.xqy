xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHDebitos/xq/transfACHDebitoHeaderOut/";

declare function xf:transfACHDebitoHeaderOut($responseHeader as element(ns0:ResponseHeader))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $responseHeader/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            <successIndicator>
	            {
	            	let $successIndicator := fn:upper-case(fn:string($responseHeader/successIndicator/text()))
	            	return
		                if ($successIndicator = "SUCCESS") then(
		                "Success") 
		                else if ($successIndicator =  "PENDING") then (
		               		$successIndicator
		                ) else ( 
							"ERROR"
						)
	            }
            </successIndicator>
            <messages>{ fn:string-join($responseHeader/messages, ". ") }</messages>
            {
                for $valueDate in $responseHeader/valueDate
                return
                    <valueDate>{ data($valueDate) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $responseHeader as element(ns0:ResponseHeader) external;

xf:transfACHDebitoHeaderOut($responseHeader)