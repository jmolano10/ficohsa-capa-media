(:: pragma bea:global-element-parameter parameter="$registrarPago1" element="ns0:registrarPago" location="../../wsdls/Alcance.wsdl" ::)
(:: pragma  type="anyType" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/TarjetaCreditoT24/RegistrarPagoParametersIn/";

declare function xf:RegistrarPagoParametersIn($registrarPago1 as element(ns0:registrarPago),
    $contractId as xs:string)
    as element(*) {		        					
    						<parametersIn>
							<channelCode>HN.ITUT24</channelCode>
							<subChannelCode></subChannelCode>
							<agreementContractID>{ data($contractId) }</agreementContractID>
							<userCode>HN.ITUT24</userCode>
							<bankCode>HN0010001</bankCode>
							<primaryKey>{ data($registrarPago1/ns0:noTarjetaCredito) }</primaryKey>
							<operationCode>2</operationCode>
							<totalAmount>{ data($registrarPago1/ns0:montoPago) }</totalAmount>
							<coreRunningDate>{ fn:concat(data($registrarPago1/ns0:fechaPago),data(fn-bea:dateTime-to-string-with-format("HHmmss", fn:adjust-dateTime-to-timezone(fn:current-dateTime(), ())))) }</coreRunningDate>
							<transactionID>{ data($registrarPago1/ns0:idRefPago) }</transactionID>
							<moreParameters>
							<data id="1" fieldName="branchCode">110200000000</data>
							{
								if (fn:string(data($registrarPago1/ns0:monedaPago)) = "HNL") then (	
									<data id="2" fieldName="Currency">HNL</data>
								)
								else(
									<data id="2" fieldName="Currency">USD</data>
								)
							}
							<data id="3" fieldName="paymentType">{ data($registrarPago1/ns0:formaPago) }</data>
							<data id="4" fieldName="exchangeRate">1</data>
							<data id="5" fieldName="returnDealslip">S</data>
							<data id="6" fieldName="fechaEnvioATercero">{ data(fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss", fn:adjust-dateTime-to-timezone(fn:current-dateTime(), ()))) }</data>
							</moreParameters>
							</parametersIn>    					    					    					        			
};

declare variable $registrarPago1 as element(ns0:registrarPago) external;
declare variable $contractId as xs:string external;

xf:RegistrarPagoParametersIn($registrarPago1,
    $contractId)