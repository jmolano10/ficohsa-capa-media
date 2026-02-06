xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoBancaSat/xq/pagoBancaSatISVTCHeaderOut/";

declare function xf:pagoBancaSatISVTCHeaderOut($CodigoError as xs:string,
    $MensajeError as xs:string,$transaction_reference as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
             
            <transactionId>{ data($transaction_reference) }</transactionId>
            {
        			if ($CodigoError = 'SUCCESS')then(
        				<successIndicator>{ "Success" }</successIndicator>
        			)else(
        				<successIndicator>{ "ICBBSAT-ERROR" }</successIndicator>
    				)
            }
            {
        			if ($CodigoError != 'SUCCESS')then(
                        <messages>{ $MensajeError }</messages>
                    )else()
            }
        </ns0:ResponseHeader>
};

declare variable $CodigoError as xs:string external;
declare variable $MensajeError as xs:string external;
declare variable $transaction_reference as xs:string external;

xf:pagoBancaSatISVTCHeaderOut($CodigoError,
    $MensajeError,$transaction_reference)