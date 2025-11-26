xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultarSaldos1" element="ns0:consultarSaldos" location="../../wsdls/Alcance.wsdl" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/ConsultarSaldosParametersIn/";
declare namespace ns0 = "http://tempuri.org/";

declare function xf:ConsultarSaldosParametersIn($consultarSaldos1 as element(ns0:consultarSaldos),
    $contractId as xs:string)
    as element(*) {
        <parametersIn>
						<channelCode>HN.ITUT24</channelCode>
						<subChannelCode></subChannelCode>
						<agreementContractID>{ data($contractId) }</agreementContractID>
						<userCode>HN.ITUT24</userCode>
						<bankCode>HN0010001</bankCode>
						<primaryKey>{ data($consultarSaldos1/ns0:noTarjetaCredito) }</primaryKey>
						<operationCode>1</operationCode>
						<totalAmount>1</totalAmount>
						<coreRunningDate>{ data(fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss", fn:adjust-dateTime-to-timezone(fn:current-dateTime(), ()))) }</coreRunningDate>
						<transactionID>1</transactionID>
						<moreParameters>
						<data id="1" fieldName="branchCode">110200000000</data>						
						<data id="2" fieldName="Currency">HNL</data>							
						<data id="3" fieldName="paymentType">1</data>
						<data id="4" fieldName="exchangeRate">1</data>
						<data id="5" fieldName="returnDealslip">S</data>
						<data id="6" fieldName="fechaEnvioATercero">{ data(fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss", fn:adjust-dateTime-to-timezone(fn:current-dateTime(), ()))) }</data>
						</moreParameters>
						</parametersIn>
};

declare variable $consultarSaldos1 as element(ns0:consultarSaldos) external;
declare variable $contractId as xs:string external;

xf:ConsultarSaldosParametersIn($consultarSaldos1,
    $contractId)