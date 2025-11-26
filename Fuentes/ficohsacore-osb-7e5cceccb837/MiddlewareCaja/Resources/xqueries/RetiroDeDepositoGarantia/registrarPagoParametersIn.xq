xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$Header" element="ns0:RequestHeader" location="../../xsds/General/Autenticacion_v2.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$Body" element="ns2:retiroDeDepositoGarantia" location="../../xsds/RetiroDeDepositoGarantia/retiroDeDepositoGarantiaTypes.xsd" ::)
(:: pragma bea:schema-type-return type="ns1:serviceRequest" location="../../xsds/EnrutadorConvenios/XMLSchema_-1423180259.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeDepositoGarantia/registrarPagoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/retiroDeDepositoGarantiaTypes";
declare namespace ns1 = "http://service.webserviceprovider.transporters.service.frametexx.com/";

declare function xf:registrarPagoIn($Header as element(ns0:RequestHeader),
    $Body as element(ns2:retiroDeDepositoGarantia),
    $TransactionID as xs:string,
    $BranchCode as xs:string)
    as element(*) {
        <parametersIn>
			<channelCode>{data($Header/Authentication/UserName)}</channelCode>
			<subChannelCode/>
			<agreementContractID>{ data($Body/CONTRACT_ID) }</agreementContractID>
			<userCode>{data($Header/Authentication/UserName)}</userCode>
			<bankCode>HN0010001</bankCode>
			<primaryKey>{ data($Body/PRIMARY_KEY) }</primaryKey>
			<operationCode>2</operationCode>
			<totalAmount>{ data($Body/AMOUNT) }</totalAmount>
			<coreRunningDate>{ data(fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss", fn:adjust-dateTime-to-timezone(fn:current-dateTime(), ()))) }</coreRunningDate>
			<transactionID>{ $TransactionID }</transactionID>
			<moreParameters>
				<data id="1" fieldName="branchCode">{$BranchCode}</data>
				<data id="2" fieldName="rucImpoExpo"/>
				<data id="3" fieldName="paymentMethod">CASH</data>
				<data id="4" fieldName="useAgrNonStandard">S</data>
				<data id="5" fieldName="returnDealslip">S</data>
				<data id="6" fieldName="fechaEnvioATercero">{ data(fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss", fn:adjust-dateTime-to-timezone(fn:current-dateTime(), ()))) }</data>
				</moreParameters>
			</parametersIn> 
};

declare variable $Header as element(ns0:RequestHeader) external;
declare variable $Body as element(ns2:retiroDeDepositoGarantia) external;
declare variable $TransactionID as xs:string external;
declare variable $BranchCode as xs:string external;

xf:registrarPagoIn($Header,
    $Body, $TransactionID, $BranchCode)
