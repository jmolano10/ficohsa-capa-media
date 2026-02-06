xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$obtenerEncabezadosResponse1" element="ns0:ObtenerEncabezadosResponse" location="../../../BusinessServices/ObtenerEncabezados/xsd/XMLSchema_-1464971485.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaSaldosHistEstadoCuentaResponse" location="../xsd/consultaSaldosHistEstadoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosHistEstadoCuentaTypes";
declare namespace ns1 = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosHistEstadoCuenta/xq/consultaSaldosHistEstadoCuentaPAOut/";

declare function xf:consultaSaldosHistEstadoCuentaPAOut($obtenerEncabezadosResponse1 as element(ns0:ObtenerEncabezadosResponse))
    as element(ns2:consultaSaldosHistEstadoCuentaResponse) {
        <ns2:consultaSaldosHistEstadoCuentaResponse>
         {  
             for $rowEncabezados in $obtenerEncabezadosResponse1/ns0:ObtenerEncabezadosResult/ns1:Encabezados/ns1:DatoObtenerEncabezados
             return(
            <BALANCE_INFORMATION>
               {
  					for $period in string($rowEncabezados/ns1:Periodo/text())
               		return
                    	<PERIOD>{$period }</PERIOD>
               }
               {
  					for $currency in string($rowEncabezados/ns1:CodMoneda/text())
               		return
                    	<CURRENCY>{$currency }</CURRENCY>
               }
               {
  					for $org in string($rowEncabezados/ns1:Org/text())
               		return
                    	<ORG>{$org }</ORG>
               }
               {
            	  	for $cutoff_Date in fn-bea:date-from-dateTime(adjust-dateTime-to-timezone($rowEncabezados/ns1:FechaCorte/text(),()))
                	return
                		   if(string($cutoff_Date)!='')then( 
                    			<CUTOFF_DATE>{ $cutoff_Date }</CUTOFF_DATE>
                    	   )else()
               }
               {
                     for $miles_Earned in string($rowEncabezados/ns1:MilesEarned/text())
                	 return
                			if(string($miles_Earned)!='')then( 
                    			 <MILES_EARNED>{ $miles_Earned }</MILES_EARNED>
                    		)else()
               }
               {
                	 for $point_Earned in string($rowEncabezados/ns1:PointEarned/text())
                	 return
                		    if(string($point_Earned)!='')then( 
                    			 <POINTS_EARNED>{ $point_Earned }</POINTS_EARNED>
                    		)else()
               }
               {
                 	 for $min_Payment in string($rowEncabezados/ns1:PagoMinimo/text())
                	 return
                			if(string($min_Payment)!='')then( 
                    			 <MIN_PAYMENT>{ $min_Payment }</MIN_PAYMENT>
                    		)else()
               }
               {
                	  for $total_Payment in string($rowEncabezados/ns1:PagoTotal/text())
                	  return
                			 if(string($total_Payment)!='')then( 
                    				<TOTAL_PAYMENT>{ $total_Payment }</TOTAL_PAYMENT>
                    		 )else()
               }
               {
                	   for $late_Fee in string($rowEncabezados/ns1:SaldoMora/text())
                	   return
                			  if(string($late_Fee)!='')then( 
                    				<LATE_FEE>{ $late_Fee }</LATE_FEE>
                    		  )else()
               }
               {
                	   for $balance in string($rowEncabezados/ns1:Balance/text())
              		   return
              				  if(string($balance)!='')then( 
                    				<BALANCE>{ $balance }</BALANCE>
                    		  )else()
               }
               {
                	   for $account_cicle in string($rowEncabezados/ns1:Ciclo/text())
                	   return
                			  if(string($account_cicle)!='')then( 
                    				<ACCOUNT_CICLE>{ $account_cicle }</ACCOUNT_CICLE>
                    		  )else()
               }
               {
                	   for $statement_Url in string($rowEncabezados/ns1:FileLink/text())
                	   return
                				<STATEMENT_URL>{ $statement_Url }</STATEMENT_URL>
               }
               {
                	   for $statement in string($rowEncabezados/ns1:PdfFile/text())
                	   return
                				<STATEMENT>{ $statement }</STATEMENT>
               }
               {
                	   for $cycleDue in string($rowEncabezados/ns1:CycleDue/text())
                	   return
                			   if($cycleDue != '')then(
                					<CYCLE_DUE>{ $cycleDue }</CYCLE_DUE>
                			   )else()
               }
            </BALANCE_INFORMATION>)
          }
            
        </ns2:consultaSaldosHistEstadoCuentaResponse>
};

declare variable $obtenerEncabezadosResponse1 as element(ns0:ObtenerEncabezadosResponse) external;

xf:consultaSaldosHistEstadoCuentaPAOut($obtenerEncabezadosResponse1)