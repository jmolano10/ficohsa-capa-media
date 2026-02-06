xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterData/conDetalleComprasCuotas/xsd/conDetalleComprasCuotas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleIntraResponse" location="../xsd/consultaDetalleIntraTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleIntra/xq/consultaDetalleIntraOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDetalleComprasCuotas";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleIntraTypes";

declare function xf:consultaDetalleIntraOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaDetalleIntraResponse) {    
        <ns1:consultaDetalleIntraResponse>
        {
           	for $item in $outputParameters/ns0:RowSet/ns0:Row
        	return
        	(
        		<PRODUCT_INFORMATION>
        		{
        			for $currentFee in string($item/ns0:Column[@name='instmts_nbr']/text())
        			return
        				if($currentFee != '')then(
        					<CURRENT_FEE>
        						{$currentFee}
        					</CURRENT_FEE>
        				)else()
        		}
        		
        		{
        			for $feeDate in string($item/ns0:Column[@name='fee_date']/text())
        			return
        				if($feeDate != '')then(
        					<FEE_DATE>
        						{
        						fn-bea:dateTime-to-string-with-format('yyyy-MM-dd', $item/ns0:Column[@name = 'fee_date'])
        						}
        					</FEE_DATE>
        				)else()
        		}
        		
        		 {
        			for $paymentAmount in string($item/ns0:Column[@name='tot_fee']/text())
        			return
        				if($paymentAmount != '')then(
        					<PAYMENT_AMOUNT>
        						{$paymentAmount}
        					</PAYMENT_AMOUNT>
        				)else()
        		}
        		
        		{
        			for $currentAmount in string($item/ns0:Column[@name='tot_prin']/text())
        			return
        				if($currentAmount != '')then(
        					<CURRENT_AMOUNT>
        						{$currentAmount}
        					</CURRENT_AMOUNT>
        				)else()
        		}
        		
        		{
        			for $rateAmount in string($item/ns0:Column[@name='tot_int']/text())
        			return
        				if($rateAmount != '')then(
        					<RATE_AMOUNT>
        						{$rateAmount}
        					</RATE_AMOUNT>
        				)else()
        		}
        		
        		{
        			for $currentCharges in string($item/ns0:Column[@name='MontoTotalCargo']/text())
        			return
        				if($currentCharges != '')then(
        					<CURRENT_CHARGES>
        						{$currentCharges}
        					</CURRENT_CHARGES>
        				)else()
        		}
        		{
        			for $currency in string($item/ns0:Column[@name='codMoneda']/text())
        			return
        			if($currency != "") then (
        				<CURRENCY>{ $currency }</CURRENCY>
        			) else ()
        		}
        		</PRODUCT_INFORMATION>
        	)
        
        }
        </ns1:consultaDetalleIntraResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaDetalleIntraOut($outputParameters)