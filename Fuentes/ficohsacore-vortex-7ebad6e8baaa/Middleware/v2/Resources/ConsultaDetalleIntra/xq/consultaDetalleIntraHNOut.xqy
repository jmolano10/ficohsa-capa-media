xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataHN/conDetalleComprasCuotas/xsd/conDetalleComprasCuotas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleIntraResponse" location="../xsd/consultaDetalleIntraTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleIntra/xq/consultaDetalleIntraHNOut/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDetalleComprasCuotas";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleIntraTypes";

declare function xf:consultaDetalleIntraHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaDetalleIntraResponse) {
        <ns0:consultaDetalleIntraResponse>
            {
                for $item in $outputParameters/ns1:RowSet/ns1:Row
                return
                	(
            		 <PRODUCT_INFORMATION>
	            		 {
	            		 	for $currentDate in string($item/ns1:Column[@name = 'instmts_nbr']/text())
                    		return
	                    		if( $currentDate != '' )then(
	                    			<CURRENT_FEE>{ $currentDate }</CURRENT_FEE>
	                    		)else()
	            		 }
	            		 {
	            		 	for $feeDate in string($item/ns1:Column[@name = 'fee_date']/text())
	            		 	return
	            		 		if( $feeDate != '' )then(
	            		 			<FEE_DATE>
	            		 				{ 
            		 					fn-bea:dateTime-to-string-with-format('yyyy-MM-dd',$item/ns1:Column[@name = 'fee_date']) 
            		 					}
        		 					</FEE_DATE>
	            		 		)else()
	            		 }
	            		 {
	            		 	for $paymentAmount in string($item/ns1:Column[@name = 'tot_fee']/text())
	            		 	return
	            		 		if( $paymentAmount != '' )then(
	            		 			<PAYMENT_AMOUNT>{ $paymentAmount }</PAYMENT_AMOUNT>
	            		 		)else()
	            		 }                    	                                               
                         {
                         	for $currentAmount in string($item/ns1:Column[@name = 'tot_prin']/text())
                         	return
                         		if( $currentAmount != '' )then(
                         			<CURRENT_AMOUNT>{ $currentAmount }</CURRENT_AMOUNT>
                         		)else()
                         }
                         {
                         	for $rateAmount in string($item/ns1:Column[@name = 'tot_int']/text())
                         	return 
                         		if( $rateAmount != '' )then(
                         			<RATE_AMOUNT>{ $rateAmount }</RATE_AMOUNT>
                         		)else()
                         }
                         {
                         	for $currentCharges in string($item/ns1:Column[@name = 'MontoTotalCargo']/text())
                         	return
                         		if( $currentCharges != '' )then(
                         			<CURRENT_CHARGES>{ $currentCharges }</CURRENT_CHARGES>
                         		)else()
                         }
                         {
                         	for $currency in string($item/ns1:Column[@name = 'codMoneda']/text())
                         	return
                         		if( $currency != '' )then(
                         			<CURRENCY>{ $currency }</CURRENCY>
                         		)else()
                         }                        
                    </PRODUCT_INFORMATION>
                	)
                   
            }
        </ns0:consultaDetalleIntraResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaDetalleIntraHNOut($outputParameters)