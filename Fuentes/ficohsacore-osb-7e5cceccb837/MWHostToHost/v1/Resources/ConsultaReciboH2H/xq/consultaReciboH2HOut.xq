(:: pragma bea:global-element-parameter parameter="$consultaRecibo" element="ns0:consultaRecibo" location="../../CobranzasH2H/xsd/cobranzasH2HTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaReciboResponse" location="../../CobranzasH2H/xsd/cobranzasH2HTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasH2HTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaReciboH2H/xq/consultaReciboH2HOut/";

declare function xf:transformarReciboHTML($serviceId as xs:string, $dealSlip as xs:string, $customerName as xs:string) as xs:string{
	if($serviceId = "9") then (
		replace( replace( replace( replace($dealSlip,'\[','<'), '\]','>'), '@','"'), '<-nombreCliente->',$customerName)
	) else (
		$dealSlip
	)
};

declare function xf:consultaReciboH2HOut($consultaRecibo as element(ns0:consultaRecibo),
    $serviceName as xs:string,
    $dealSlip as xs:string,
    $debtorCode as xs:string,
    $customerName as xs:string)
    as element(ns0:consultaReciboResponse) {
        <ns0:consultaReciboResponse>
            <CUSTOMER_ID>{ data($consultaRecibo/CUSTOMER_ID) }</CUSTOMER_ID>
            <TRANSACTION_ID>{ data($consultaRecibo/TRANSACTION_ID) }</TRANSACTION_ID>
            <SERVICE_ID>{ data($consultaRecibo/SERVICE_ID) }</SERVICE_ID>
            <SERVICE_NAME>{ $serviceName }</SERVICE_NAME>
            <DEBTOR_CODE>{ $debtorCode }</DEBTOR_CODE>
            <DEALSLIP>{ xf:transformarReciboHTML(fn:string($consultaRecibo/SERVICE_ID/text()), $dealSlip, $customerName) }</DEALSLIP>
        </ns0:consultaReciboResponse>
};

declare variable $consultaRecibo as element(ns0:consultaRecibo) external;
declare variable $serviceName as xs:string external;
declare variable $dealSlip as xs:string external;
declare variable $debtorCode as xs:string external;
declare variable $customerName as xs:string external;

xf:consultaReciboH2HOut($consultaRecibo,
    $serviceName,
    $dealSlip,
    $debtorCode,
    $customerName)