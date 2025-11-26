(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns2:ResponseHeader" location="../../../FPC/getMultipleProduct12c/xsd/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMultiplesProductosResponse" element="ns0:consultaMultiplesProductosResponse" location="../../../FPC/getMultipleProduct12c/xsd/GetMultipleProductTypes.xsd" ::)
(:: pragma bea:local-element-return type="ns1:sjConsultaMultipleProductosHNResponse/ns1:ASSETS/ns1:ASSET" location="../xsd/sjConsultaMultipleProductosHN.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMultiplesProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaMultiplesProductosOut/";

declare function xf:consultaMultiplesProductosOut($productId as xs:string,
    $productType as xs:string,
    $region as xs:string,
    $responseHeader as element(ns2:ResponseHeader),
    $consultaMultiplesProductosResponse as element(ns0:consultaMultiplesProductosResponse))
    as element() {
    <ns1:ASSET>
    {
    	if(fn:upper-case($responseHeader/successIndicator/text()) != "SUCCESS") then (
    		<ns1:ID>{ $productId }</ns1:ID>,
    		<ns1:TYPE>{ $productType }</ns1:TYPE>,
    		<ns1:SOURCE_BANK>{ $region }</ns1:SOURCE_BANK>,
    		<ns1:SUCCESS_INDICATOR>{ upper-case($responseHeader/successIndicator/text()) }</ns1:SUCCESS_INDICATOR>,
    		<ns1:ERROR_MESSAGE>{ string-join($responseHeader/messages/text()," ") }</ns1:ERROR_MESSAGE>
    	) else (
    		for $asset in $consultaMultiplesProductosResponse/ASSETS/ASSET[1]
    		return(
    			for $ID in $asset/ID
    			return
    			<ns1:ID>{ data($ID) }</ns1:ID>,
    			for $PRODUCT_NAME in $asset/PRODUCT_NAME
                return
                <ns1:PRODUCT_NAME>{ data($PRODUCT_NAME) }</ns1:PRODUCT_NAME>,
                for $CURRENCY in $asset/CURRENCY
                return
                <ns1:CURRENCY>{ data($CURRENCY) }</ns1:CURRENCY>,
                <ns1:RESERVE_BALANCE>0.0</ns1:RESERVE_BALANCE>,
                <ns1:LOCKED_BALANCE>0.0</ns1:LOCKED_BALANCE>,
                <ns1:VISA_FLOATING_BALANCE>0.0</ns1:VISA_FLOATING_BALANCE>,
                <ns1:INTEREST_BALANCE>0.0</ns1:INTEREST_BALANCE>,
                for $TOTAL_BALANCE in $asset/TOTAL_BALANCE
                return
                <ns1:TOTAL_BALANCE>{ data($TOTAL_BALANCE) }</ns1:TOTAL_BALANCE>,
                for $AVAILABLE_BALANCE in $asset/AVAILABLE_BALANCE
                return
                <ns1:AVAILABLE_BALANCE>{ data($AVAILABLE_BALANCE) }</ns1:AVAILABLE_BALANCE>,
                
                 if(fn:string($asset/OPENING_DATE/text()) != '') then(
                <ns1:OPENING_DATE>{ fn-bea:date-from-string-with-format("yyyyMMdd",data($asset/OPENING_DATE/text())) }</ns1:OPENING_DATE>
                ) else (
                <ns1:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns1:OPENING_DATE>
                ),                
                for $TYPE in $asset/TYPE
                return
                <ns1:TYPE>{ data($TYPE) }</ns1:TYPE>,
                <ns1:SOURCE_BANK>HN01</ns1:SOURCE_BANK>,
                <ns1:SUCCESS_INDICATOR>SUCCESS</ns1:SUCCESS_INDICATOR>
    		)
    	)
    }
    </ns1:ASSET>
};

declare variable $productId as xs:string external;
declare variable $productType as xs:string external;
declare variable $region as xs:string external;
declare variable $responseHeader as element(ns2:ResponseHeader) external;
declare variable $consultaMultiplesProductosResponse as element(ns0:consultaMultiplesProductosResponse) external;

xf:consultaMultiplesProductosOut($productId,
    $productType,
    $region,
    $responseHeader,
    $consultaMultiplesProductosResponse)
