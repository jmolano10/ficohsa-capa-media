xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMultiplesProductosResponse" element="ns0:cuentasRelacionesPeriodosResponse" location="../../../FPC/CloudCode/Schemas/CloudCodeTypes.xsd" ::)
(:: pragma bea:local-element-return type="ns1:sjConsultaMultipleProductosHNResponse/ns1:ASSETS/ns1:ASSET" location="../xsd/sjConsultaMultipleProductosHN.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";
declare namespace ns0 = "https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaMultiplesProductosOut/";

declare function xf:consultaMultiplesProductosOut($productId as xs:string,
    $productType as xs:string,
    $region as xs:string,
    $statusService as xs:string,
    $consultaMultiplesProductosResponse as element(ns0:cuentasRelacionesPeriodosResponse))
    as element() {
    <ns1:ASSET>
    {
    	if(fn:upper-case($statusService) != "SUCCESS") then (
    		<ns1:ID>{ $productId }</ns1:ID>,
    		<ns1:TYPE>{ $productType }</ns1:TYPE>,
    		<ns1:SOURCE_BANK>{ $region }</ns1:SOURCE_BANK>,
    		<ns1:SUCCESS_INDICATOR>{ upper-case($statusService) }</ns1:SUCCESS_INDICATOR>,
    		<ns1:ERROR_MESSAGE>{ data($consultaMultiplesProductosResponse/ns0:mensaje) }</ns1:ERROR_MESSAGE>
    	) else (
                <ns1:ID>{ data($consultaMultiplesProductosResponse/ns0:datos/ns0:cuenta/ns0:codigoCuenta) }</ns1:ID>,
                <ns1:PRODUCT_NAME>{ data($consultaMultiplesProductosResponse/ns0:datos/ns0:cuenta/ns0:nombreCliente) }</ns1:PRODUCT_NAME>,
                <ns1:CURRENCY>{ data($consultaMultiplesProductosResponse/ns0:datos/ns0:cuenta/ns0:codigoMoneda) }</ns1:CURRENCY>,
                <ns1:RESERVE_BALANCE>0.0</ns1:RESERVE_BALANCE>,
                <ns1:LOCKED_BALANCE>0.0</ns1:LOCKED_BALANCE>,
                <ns1:VISA_FLOATING_BALANCE>0.0</ns1:VISA_FLOATING_BALANCE>,
                <ns1:INTEREST_BALANCE>0.0</ns1:INTEREST_BALANCE>,
                <ns1:TOTAL_BALANCE>{ data($consultaMultiplesProductosResponse/ns0:datos/ns0:cuenta/ns0:saldoTotalActual) }</ns1:TOTAL_BALANCE>,
                <ns1:AVAILABLE_BALANCE>{ data($consultaMultiplesProductosResponse/ns0:datos/ns0:cuenta/ns0:saldoTotalActual) }</ns1:AVAILABLE_BALANCE>,
                 if(fn:string($consultaMultiplesProductosResponse/ns0:datos/ns0:cuenta/ns0:fechaAperturaCuenta/text()) != '') then(
                <ns1:OPENING_DATE>{ fn-bea:date-from-string-with-format("yyyyMMdd",data($consultaMultiplesProductosResponse/ns0:datos/ns0:cuenta/ns0:fechaAperturaCuenta/text())) }</ns1:OPENING_DATE>
                ) else (
                <ns1:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns1:OPENING_DATE>
                ),            
                <ns1:TYPE>FPC</ns1:TYPE>,
                <ns1:SOURCE_BANK>HN01</ns1:SOURCE_BANK>,
                <ns1:SUCCESS_INDICATOR>SUCCESS</ns1:SUCCESS_INDICATOR>
    		
    	)
    }
    </ns1:ASSET>
};

declare variable $productId as xs:string external;
declare variable $productType as xs:string external;
declare variable $region as xs:string external;
declare variable $statusService as xs:string external;
declare variable $consultaMultiplesProductosResponse as element(ns0:cuentasRelacionesPeriodosResponse) external;

xf:consultaMultiplesProductosOut($productId,
    $productType,
    $region,
    $statusService,
    $consultaMultiplesProductosResponse)