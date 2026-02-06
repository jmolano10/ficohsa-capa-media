xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns1:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaComisionesResponse" element="ns0:consultaComisionesResponse" location="../../ConsultaComisiones/xsd/consultaComisionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:retiroTarjetaCreditoResponse" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/retiroTarjetaCreditoGTOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";

declare function xf:retiroTarjetaCreditoGTOut($retiroTarjetaCredito as element(ns1:retiroTarjetaCredito),
    $consultaComisionesResponse as element(ns0:consultaComisionesResponse))
    as element(ns1:retiroTarjetaCreditoResponse) {
       <ns1:retiroTarjetaCreditoResponse>
        {
        	for $withdrawalAmount in $retiroTarjetaCredito/AMOUNT
        	for $commission in $consultaComisionesResponse/AMOUNT
        	return
        		(
        			<CURRENCY>{ data($consultaComisionesResponse/CURRENCY) }</CURRENCY>,
        			<WITHDRAWAL_AMOUNT>{ xs:decimal(data($withdrawalAmount)) }</WITHDRAWAL_AMOUNT>,
        			<CHARGES>{ xs:decimal(data($commission)) }</CHARGES>,           			
            		<TOTAL_CHARGED_AMOUNT>{ fn:sum((xs:decimal(data($withdrawalAmount)), xs:decimal(data($commission))))}</TOTAL_CHARGED_AMOUNT>
        		)        	
        }
        </ns1:retiroTarjetaCreditoResponse>
};

declare variable $retiroTarjetaCredito as element(ns1:retiroTarjetaCredito) external;
declare variable $consultaComisionesResponse as element(ns0:consultaComisionesResponse) external;

xf:retiroTarjetaCreditoGTOut($retiroTarjetaCredito,
    $consultaComisionesResponse)