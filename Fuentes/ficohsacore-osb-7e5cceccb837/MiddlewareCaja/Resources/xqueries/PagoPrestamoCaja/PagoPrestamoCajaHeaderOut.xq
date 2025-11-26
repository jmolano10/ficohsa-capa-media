(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/PagoPrestamoCajaHeaderOut/";

declare function xf:PagoPrestamoCajaHeaderOut($message as xs:string,
    $transactionId as xs:string,
    $valueDate as xs:string)
    as element(ns0:ResponseHeader) {
    	if ( $message = "" ) then (
	        <ns0:ResponseHeader>
	            <transactionId>{ $transactionId }</transactionId>
	            <successIndicator>Success</successIndicator>
	            <valueDate>{ $valueDate }</valueDate>
	        </ns0:ResponseHeader>
		) else (
	        <ns0:ResponseHeader>
	            <successIndicator>ERROR</successIndicator>
	            <messages>{ $message }</messages>
	        </ns0:ResponseHeader>
		)
};

declare variable $message as xs:string external;
declare variable $transactionId as xs:string external;
declare variable $valueDate as xs:string external;

xf:PagoPrestamoCajaHeaderOut($message,
    $transactionId,
    $valueDate)