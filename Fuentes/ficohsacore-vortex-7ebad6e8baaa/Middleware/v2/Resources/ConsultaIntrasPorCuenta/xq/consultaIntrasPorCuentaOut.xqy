xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/MasterData/conResumenComprasCuotas/xsd/conResumenComprasCuotas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaIntrasPorCuentaResponse" location="../xsd/consultaIntrasPorCuentaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaIntrasPorCuenta/xq/consultaIntrasPorCuentaOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conResumenComprasCuotas";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaIntrasPorCuentaTypes";

declare function xf:consultaIntrasPorCuentaOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaIntrasPorCuentaResponse) {
    	<ns1:consultaIntrasPorCuentaResponse>
    	{
    		for $item in $outputParameters1/ns0:RowSet/ns0:Row
    		return (
    			<PRODUCT_INFORMATION>
    			{
    				for $intrafinancingId in $item/ns0:Column[@name = 'original_install']
    				return
    				<INTRAFINANCING_ID>{ data($intrafinancingId) }</INTRAFINANCING_ID>
    			}
    			{
    				for $commerceName in $item/ns0:Column[@name = 'NombreComercio']
    				return
    				<COMMERCE_NAME>{ data($commerceName) }</COMMERCE_NAME>
    			}
    			{
    				for $transactionDate in string($item/ns0:Column[@name = 'FechaTransaccion']/text())
    				return
    				if($transactionDate != "") then (
    					<TRANSACTION_DATE>{ fn-bea:dateTime-to-string-with-format('yyyy-MM-dd', $item/ns0:Column[@name = 'FechaTransaccion'] ) }</TRANSACTION_DATE>
    				) else ()
    			}
    			{
    				for $amount in string($item/ns0:Column[@name = 'MontoInicial']/text())
    				return
    				if($amount != "") then (
    					<AMOUNT>{ $amount }</AMOUNT>
    				) else ()
    			}
    			{
    				for $currentBalance in string($item/ns0:Column[@name = 'SaldoActual']/text())
    				return
    				if($currentBalance != "") then (
    					<CURRENT_BALANCE>{ $currentBalance }</CURRENT_BALANCE>
    				) else ()
    			}
    			{
    				for $feeAmount in string($item/ns0:Column[@name = 'TotalCuota']/text())
    				return
    				if($feeAmount != "") then (
    					<FEE_AMOUNT>{ $feeAmount }</FEE_AMOUNT>
    				) else ()
    			}
    			{
    				for $interestRate in string($item/ns0:Column[@name = 'Tasa']/text())
    				return
    				if($interestRate != "") then (
    					<INTEREST_RATE>{ $interestRate }</INTEREST_RATE>
    				) else ()
    			}
    			{
    				for $term in string($item/ns0:Column[@name = 'Plazo']/text())
    				return
    				if($term != "") then (
    					<TERM>{ $term }</TERM>
    				) else ()
    			}
    			{
    				for $currentFee in string($item/ns0:Column[@name = 'Cuota']/text())
    				return
    				if($currentFee != "") then (
    					<CURRENT_FEE>{ $currentFee }</CURRENT_FEE>
    				) else ()
    			}
    			{
    				for $currency in string($item/ns0:Column[@name = 'codMoneda']/text())
    				return
    				if($currency != "") then (
    					<CURRENCY>{ $currency }</CURRENCY>
    				) else ()
    			}
    			</PRODUCT_INFORMATION>
    		)
    	}
        </ns1:consultaIntrasPorCuentaResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaIntrasPorCuentaOut($outputParameters1)