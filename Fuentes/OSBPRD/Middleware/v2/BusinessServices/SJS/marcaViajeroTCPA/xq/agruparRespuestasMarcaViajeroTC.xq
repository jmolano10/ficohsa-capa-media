(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCreditoResponse" element="ns1:consultaDatosTarjetaCreditoResponse" location="../../../../../Business_Resources/tarjetaCredito/ConsultaDatosTarjetaCredito/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$salesforceMarcaViajeroTCResponse" element="ns0:salesforceMarcaViajeroTCResponse" location="../../../../Resources/SalesforceMarcaViajeroTC/xsd/salesforceMarcaViajeroTCTypes.xsd" ::)
(:: pragma  type="anyType" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/salesforceMarcaViajeroTCTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/marcaViajeroTCPA/xq/agruparRespuestasMarcaViajeroTC/";

declare function xf:agruparRespuestasMarcaViajeroTC($errorCode as xs:string,
    $index as xs:int,
    $validationMessage as xs:string,
    $consultaDatosTarjetaCreditoResponse as element(ns1:consultaDatosTarjetaCreditoResponse),
    $salesforceMarcaViajeroTCResponse as element(ns0:salesforceMarcaViajeroTCResponse))
    as element(*) {
    <CREDIT_CARD_INFORMATION>
    	<INDEX>{ $index }</INDEX>
        {
             for $CARD_NUMBER in $consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType[1]/CARD_NUMBER
             return
             	<CREDIT_CARD_NUMBER>{ data($CARD_NUMBER) }</CREDIT_CARD_NUMBER>
        }
        {
             for $ACCOUNT_HOLDER_NAME in $consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType[1]/ACCOUNT_HOLDER_NAME
             return
             	<ACCOUNT_HOLDER_NAME>{ data($ACCOUNT_HOLDER_NAME) }</ACCOUNT_HOLDER_NAME>
        }
        {
             for $CARD_HOLDER_NAME in $consultaDatosTarjetaCreditoResponse/ns1:consultaDatosTarjetaCreditoResponseType/ns1:consultaDatosTarjetaCreditoResponseRecordType[1]/CARD_HOLDER_NAME
             return
             	<CARD_HOLDER_NAME>{ data($CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
        }
        <CASE_NUMBER>{ data($salesforceMarcaViajeroTCResponse/CASE_NUMBER) }</CASE_NUMBER>
        <SUCCESS_INDICATOR>{ $errorCode }</SUCCESS_INDICATOR>
        <MESSAGES>{ $validationMessage }</MESSAGES>
    </CREDIT_CARD_INFORMATION>
};
declare variable $errorCode as xs:string external;
declare variable $index as xs:int external;
declare variable $validationMessage as xs:string external;
declare variable $consultaDatosTarjetaCreditoResponse as element(ns1:consultaDatosTarjetaCreditoResponse) external;
declare variable $salesforceMarcaViajeroTCResponse as element(ns0:salesforceMarcaViajeroTCResponse) external;

xf:agruparRespuestasMarcaViajeroTC($errorCode,
    $index,
    $validationMessage,
    $consultaDatosTarjetaCreditoResponse,
    $salesforceMarcaViajeroTCResponse)