xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasResponse" element="ns2:transferenciaCuentasResponse" location="../../TransferenciaCuentas/xsd/transferenciaCuentasType.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaComisionesResponse" element="ns0:consultaComisionesResponse" location="../../ConsultaComisiones/xsd/consultaComisionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:retiroTarjetaCreditoResponse" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/retiroTarjetaCreditoHNOut/";

declare function xf:retiroTarjetaCreditoHNOut($transferenciaCuentasResponse as element(ns2:transferenciaCuentasResponse),
    $consultaComisionesResponse as element(ns0:consultaComisionesResponse),
    $successIndicatorComision as xs:string)
    as element(ns1:retiroTarjetaCreditoResponse) {
        <ns1:retiroTarjetaCreditoResponse>
        	{
        		for $withdrawalAmount in $transferenciaCuentasResponse/CREDIT_AMOUNT
        		return
        			(
        				<CURRENCY>{ data($transferenciaCuentasResponse/CREDIT_CURRENCY) }</CURRENCY>,
        				<WITHDRAWAL_AMOUNT>{ xs:decimal(data($withdrawalAmount)) }</WITHDRAWAL_AMOUNT>,
        				if ($successIndicatorComision = 'SUCCESS') then 
        				(
        					<CHARGES>{ xs:decimal(data($consultaComisionesResponse/AMOUNT)) }</CHARGES>,           			
            				<TOTAL_CHARGED_AMOUNT>{ fn:sum((xs:decimal(data($withdrawalAmount)), xs:decimal(data($consultaComisionesResponse/AMOUNT))))}</TOTAL_CHARGED_AMOUNT>
        				) else (
        					<CHARGES>ERROR</CHARGES>,           			
            				<TOTAL_CHARGED_AMOUNT>{ xs:decimal(data($withdrawalAmount))}</TOTAL_CHARGED_AMOUNT>
        				)
        				
        			)        	
        	}
        </ns1:retiroTarjetaCreditoResponse>
};

declare variable $transferenciaCuentasResponse as element(ns2:transferenciaCuentasResponse) external;
declare variable $consultaComisionesResponse as element(ns0:consultaComisionesResponse) external;
declare variable $successIndicatorComision as xs:string external;

xf:retiroTarjetaCreditoHNOut($transferenciaCuentasResponse,
    $consultaComisionesResponse,
    $successIndicatorComision)