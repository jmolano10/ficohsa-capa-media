xquery version "2004-draft";
(:: pragma  parameter="$parametersOut" type="anyType" ::)
(:: pragma  parameter="$paramEntradaRemesa" type="anyType" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:evaluaListasClienteRequest" location="../xsd/evaluaListasClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/evaluaListasClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaListasCliente/xq/evaluaListasClienteConsultaRemesaIn/";

declare function xf:evaluaListasClienteConsultaRemesaIn($parametersOut as element(*),
    $paramEntradaRemesa as element(*),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns1:evaluaListasClienteRequest) {
    
    let $codigoContrato := $paramEntradaRemesa/CODIGOCONTRATO
    let $remitente := $paramEntradaRemesa/REMITENTE
	let $paisOrigen := $paramEntradaRemesa/PAISORIGEN
    return       
    
        <ns1:evaluaListasClienteRequest>
            <TRANSACTION_ID>{ data($parametersOut/primaryKey/text()) }</TRANSACTION_ID>
            <NAME_TO_EVALUATE>{ data($parametersOut/moreParameters/data[@fieldName=$remitente]/text()) }</NAME_TO_EVALUATE>
            <CONTRACT_ID>{ data($parametersOut/moreParameters/data[@fieldName=$codigoContrato ]/text()) }</CONTRACT_ID>
            <TYPE_OF_TRANSACTION>{ "Pago de Remesa" }</TYPE_OF_TRANSACTION>
            <AMOUNT>{ data($parametersOut/totalAmount/text()) }</AMOUNT>
            <TRANSACTION_DATE>{ fn:concat(fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()))}</TRANSACTION_DATE>     
            <COUNTRY>{ data($parametersOut/moreParameters/data[@fieldName=$paisOrigen]/text()) }</COUNTRY>
            <CANAL>{ upper-case($requestHeader/Authentication/UserName/text()) }</CANAL>
        </ns1:evaluaListasClienteRequest>
};

declare variable $parametersOut as element(*) external;
declare variable $paramEntradaRemesa as element(*) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:evaluaListasClienteConsultaRemesaIn($parametersOut,
    $paramEntradaRemesa,
    $requestHeader)