(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataHN/conResumenFinanciamientos/xsd/conResumenFinanciamientos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaIntraExtraCuotaResponse" location="../xsd/consultaIntraExtraCuotaTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conResumenFinanciamientos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaIntraExtraCuotaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaIntraExtraCuota/xq/consultaIntraExtraCuotaHNOut/";

declare function xf:consultaIntraExtraCuotaHNOut($outputParameters as element(ns0:OutputParameters),
	$searchValue as xs:string)
    as element(ns1:consultaIntraExtraCuotaResponse) {
        <ns1:consultaIntraExtraCuotaResponse>
            {
             <PRODUCTS>
                {
                    for $row in $outputParameters/ns0:RowSet/ns0:Row
                    return
                    (
                    	<PRODUCT>
                        	{
                        		for $IndicadorFinanciamiento  in $row/ns0:Column[@name='IndicadorFinanciamiento']
	   							return
		         	 				<PRODUCT_TYPE>{ data($IndicadorFinanciamiento ) }</PRODUCT_TYPE>,
		         	 			
		         	 			for $org  in $row/ns0:Column[@name='org']
	   							return
		         	 				<ORG>{ data($org ) }</ORG>,
		         	 				
		         	 			for $codMoneda  in $row/ns0:Column[@name='codMoneda']
	   							return
		         	 				<CURRENCY>{ data($codMoneda ) }</CURRENCY>,
		         	 				
		         	 			for $original_install  in $row/ns0:Column[@name='original_install']
	   							return
		         	 				<FINANCING_ID>{ data($original_install ) }</FINANCING_ID>,
		         	 				 
		         	 			<PRODUCT_NUMBER>{ $searchValue }</PRODUCT_NUMBER>,
		         	 			
		         	 			for $FechaTransaccion  in $row/ns0:Column[@name='FechaTransaccion']
	   							return
		         	 				<TRANSACTION_DATE>{ data($FechaTransaccion ) }</TRANSACTION_DATE>,
		         	 				
		         	 			for $MontoInicial  in $row/ns0:Column[@name='MontoInicial']
	   							return
		         	 				<INICIAL_AMOUNT>{ data($MontoInicial ) }</INICIAL_AMOUNT>,
		         	 			
		         	 			for $Tasa  in $row/ns0:Column[@name='Tasa']
	   							return
		         	 				<RATE>{ data($Tasa ) }</RATE>,
		         	 				
		         	 			for $TotalCuota  in $row/ns0:Column[@name='TotalCuota']
	   							return
		         	 				<TOTAL_PAYMENT>{ data($TotalCuota ) }</TOTAL_PAYMENT>,
		         	 				
		         	 			for $Plazo  in $row/ns0:Column[@name='Plazo']
	   							return
		         	 				<TERM>{ data($Plazo ) }</TERM>,
		         	 				
		         	 			for $Cuota  in $row/ns0:Column[@name='Cuota']
	   							return
		         	 				<PAYMENT_NUMBER>{ data($Cuota ) }</PAYMENT_NUMBER>,	
		         	 				
		         	 			for $Cuota  in $row/ns0:Column[@name='SaldoActual']
	   							return
		         	 				<CURRENT_BALANCE>{ data($Cuota ) }</CURRENT_BALANCE>,				
		         	 		
		         	 			for $IndicadorFinanciamiento  in $row/ns0:Column[@name='IndicadorFinanciamiento']
	   							return
		         	 				<FINANCING_INDICATOR>{ data($IndicadorFinanciamiento ) }</FINANCING_INDICATOR>,	
		         	 				
		         	 			for $NombreComercio  in $row/ns0:Column[@name='NombreComercio']
	   							return
		         	 				<COMMERCE_NAME>{ data($NombreComercio ) }</COMMERCE_NAME>
                        	}
                        </PRODUCT>
                     )
                }
            	</PRODUCTS>
            }
        </ns1:consultaIntraExtraCuotaResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $searchValue as xs:string external;


xf:consultaIntraExtraCuotaHNOut($outputParameters,$searchValue)