xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$reversarPago1" element="ns0:reversarPago" location="../../wsdls/Alcance.wsdl" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/ReversarPagoParametersIn/";
declare namespace ns0 = "http://tempuri.org/";

declare function xf:ReversarPagoParametersIn($reversarPago1 as element(ns0:reversarPago),
    $contractId as xs:string)
    as element(*) {
        <parametersIn>
						<channelCode>HN.ITUT24</channelCode>
						<subChannelCode></subChannelCode>
						<agreementContractID>{ data($contractId) }</agreementContractID>
						<userCode>HN.ITUT24</userCode>
						<bankCode>HN0010001</bankCode>
						<primaryKey>{ data($reversarPago1/ns0:noTarjetaCredito) }</primaryKey>
						<operationCode>3</operationCode>
						<totalAmount>{ data($reversarPago1/ns0:montoPago) }</totalAmount>
						<coreRunningDate>{ fn:concat(data($reversarPago1/ns0:fechaPago),data(fn-bea:dateTime-to-string-with-format("HHmmss", fn:adjust-dateTime-to-timezone(fn:current-dateTime(), ())))) }</coreRunningDate>
						<transactionID>{ data($reversarPago1/ns0:idRefPago) }</transactionID>						
						</parametersIn>
};

declare variable $reversarPago1 as element(ns0:reversarPago) external;
declare variable $contractId as xs:string external;

xf:ReversarPagoParametersIn($reversarPago1,
    $contractId)