xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataHN/conListadoPrestamos/xsd/conListadoPrestamos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFinanciamientosClienteResponse" location="../xsd/consultaFinanciamientosClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinanciamientosCliente/xq/consultaFinanciamientosClienteHNOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFinanciamientosClienteTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conListadoPrestamos";

declare function xf:consultaFinanciamientosClienteHNOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaFinanciamientosClienteResponse) {
        <ns1:consultaFinanciamientosClienteResponse>
        {
        	for $rows in $outputParameters/ns0:RowSet/ns0:Row
        	let $column := $rows/ns0:Column
       			 return(
       					 <consultaFinanciamientosClienteResponseRecordType>
       						 {
       							 let $productoFinanciamiento := string($column[@name = "ProductoFinanciamiento"]/text())
       							 return
       								 if($productoFinanciamiento != "")then(
										<PRODUCT_TYPE>{ $productoFinanciamiento }</PRODUCT_TYPE>  
									 )else()              
      						  }
      						  {
      							  let $org := string($column[@name = "org"]/text())
  							      return
     								 if($org != "")then(
									   	 <ORG>{ $org }</ORG>
									 )else()        
       						  }
 					          {
       							  let $moneda := string($column[@name = "moneda"]/text())
       							  return        
									<CURRENCY>{ $moneda }</CURRENCY>    
   						     }
   						     {
   							     let $numplan := string($column[@name = "numplan"]/text())
   							     return        
									<PLAN_CODE>{ $numplan }</PLAN_CODE>        
   						     }
  						     {
  							      let $planRecord := string($column[@name = "PlanRecord"]/text())
      							  return        
									<PLAN_SEQUENCE>{ $planRecord }</PLAN_SEQUENCE>      
       						 }
      						 {
        						  let $numReferencia := string($column[@name = "NumReferencia"]/text())
       							  return        
									<FINANCING_REFERENCE>{ $numReferencia }</FINANCING_REFERENCE>      
     						 }
					         {
						          let $cuenta := string($column[@name = "cuenta"]/text())
							      return        
									<PRODUCT_NUMBER>{ $cuenta }</PRODUCT_NUMBER>    
					         }
					         {
						          let $fecDesembolso := $column[@name = "FecDesembolso"]
							      return
							        if(string($fecDesembolso/text()) != "")then(
							                let $fechaString := fn-bea:dateTime-to-string-with-format('yyyy-MM-dd',data($fecDesembolso))
							                let $fecha := fn-bea:date-from-string-with-format('yyyy-MM-dd',$fechaString)
							                return
								                <DISBURSEMENT_DATE>{ $fecha }</DISBURSEMENT_DATE>                
					                )else()
					        }
					        {
					    		  let $fechaPago := $column[@name = "FechaPago"]
					        	  return
					        		if(string($fechaPago/text()) != "")then(
							                let $fechaString := fn-bea:dateTime-to-string-with-format('yyyy-MM-dd',data($fechaPago))
							                let $fecha := fn-bea:date-from-string-with-format('yyyy-MM-dd',$fechaString)                
							                return
							              	  <MATURITY_DATE>{ $fecha }</MATURITY_DATE>                
							        )else()
					        }
					        {
							      let $montoInicial := string($column[@name = "MontoInicial"]/text())
					  	          return
							        if($montoInicial != "" )then(
							                <PRINCIPAL_INICIAL_AMOUNT>{ $montoInicial }</PRINCIPAL_INICIAL_AMOUNT>
					                )else()
					        }
     					    {
   							      let $balanceActual := string($column[@name = "BalanceActual"]/text())
      							  return
       								if($balanceActual != "" )then(
           								    <PRINCIPAL_DUE_AMOUNT>{ $balanceActual }</PRINCIPAL_DUE_AMOUNT>
        					        )else()
     					    }
     					    {
     							  let $tasa := string($column[@name = "Tasa"]/text())
     							  return
  								    if($tasa != "" )then(
       								         <INTEREST_RATE>{ $tasa }</INTEREST_RATE>
        					        )else()        
					        }
					        {
							      let $interesTotal := string($column[@name = "InteresTotal"]/text())
							      return
					        		if($interesTotal != "" )then(
					                 		 <INTEREST_AMOUNT>{ $interesTotal }</INTEREST_AMOUNT>
					                )else()          
					        }
					        {
					       		  let $seguroTotal := string($column[@name = "SeguroTotal"]/text())
					       		  return
					        		if($seguroTotal != "" )then(
					               			 <INSURANCE_AMOUNT>{ $seguroTotal }</INSURANCE_AMOUNT>
					                )else()          
					        }
					        {
							      let $seguros := string($column[@name = "Seguros"]/text())
							      return
					       			if($seguros != "" )then(
					                		<PENDING_INSURANCE_AMOUNT>{ $seguros }</PENDING_INSURANCE_AMOUNT>
					                )else()          
					        }
					        {
					        	  let $comisionTotal := string($column[@name = "ComisionTotal"]/text())
					       		  return
					       			if($comisionTotal != "" )then(
					          		        <COMMISION_AMOUNT>{ $comisionTotal }</COMMISION_AMOUNT>
					                )else()          
					        }
					        {
					        	  let $comision := string($column[@name = "Comision"]/text())
					       		  return
					        		if($comision != "" )then(
					               			<PENDING_COMMISION_AMOUNT>{ $comision }</PENDING_COMMISION_AMOUNT>
					                )else()          
					        }
					        {
					        	  let $interesMoratorio := string($column[@name = "InteresMoratorio"]/text())
					        	  return
					        		if($interesMoratorio != "" )then(
					        		        <PENALTY_AMOUNT>{ $interesMoratorio }</PENALTY_AMOUNT>
					                )else()          
					        }
					        {
					        	  let $montoAjustado := string($column[@name = "MontoAjustado"]/text())
					        	  return
					        		if($montoAjustado != "" )then(
					          		        <MONTHLY_PAYMENT>{ $montoAjustado }</MONTHLY_PAYMENT>
					                )else()          
					        }        
					        {
					        	  let $plazoInicial := string($column[@name = "PlazoInicial"]/text())
					        	  return
					        		if($plazoInicial != "" )then(
					                		<INITIAL_LOAN_TERM>{ $plazoInicial }</INITIAL_LOAN_TERM>
					                )else()          
					        }
					        {
					        	  let $plazoPendiente := string($column[@name = "PlazoPendiente"]/text())
					        	  return
					       			if($plazoPendiente != "" )then(
					                		<REMAINING_LOAN_TERM>{ $plazoPendiente }</REMAINING_LOAN_TERM>
					                )else()          
					        }
					        {
					        	  let $plazoActual := string($column[@name = "PlazoActual"]/text())
					          	  return
					        		if($plazoActual != "" )then(
					                		<CURRENT_LOAN_TERM>{ $plazoActual }</CURRENT_LOAN_TERM>
					                )else()          
					        }
					        {
					        	  let $totalaPagar := string($column[@name = "TotalaPagar"]/text())
					        	  return
					        		if($totalaPagar != "" )then(
					              			<TOTAL_DEBT>{ $totalaPagar }</TOTAL_DEBT>
					                )else()          
					        }
					        {
					        	  let $pagoMinimo := string($column[@name = "PagoMinimo"]/text())
					        	  return
					        		if($pagoMinimo != "" )then(
					             		   <MIN_PAYMENT_AMOUNT>{ $pagoMinimo }</MIN_PAYMENT_AMOUNT>
					                )else()          
					        }
					        {
					        	  let $ciclo := string($column[@name = "Ciclo"]/text())
					        	  return
					        		if($ciclo != "" )then(
					             		  <CHARGE_CYCLE_DAY>{ $ciclo }</CHARGE_CYCLE_DAY>
					                )else()          
					        }
					        {
					       		 let $saldoActual := string($column[@name = "SaldoActual"]/text())
					       		 return
					        		if($saldoActual != "" )then(
					         		      <PENDING_PRINCIPAL_AMOUNT>{ $saldoActual }</PENDING_PRINCIPAL_AMOUNT>
					                )else()          
					        }
					        {
					       		 let $numeroTarjeta := string($column[@name = "NumeroTarjeta"]/text())
					        	 return
					        		if($numeroTarjeta != "" )then(
					                	  <CARD_NUMBER>{ $numeroTarjeta }</CARD_NUMBER>
					                )else()          
					        }
					        {
					        	 let $indicadorFinanciamiento := string($column[@name = "IndicadorFinanciamiento"]/text())
					       		 return
					     		   if($indicadorFinanciamiento != "" )then(
					       		         <LOAN_INDICATOR>{ $indicadorFinanciamiento }</LOAN_INDICATOR>
					               )else()          
					        }
					        {
					  		     let $descripcionPlan := string($column[@name = "DescripcionPlan"]/text())
					       		 return
					     		   if($descripcionPlan != "" )then(
					    	             <PLAN_DESCRIPTION>{ $descripcionPlan }</PLAN_DESCRIPTION>
					               )else()          
					        }
					</consultaFinanciamientosClienteResponseRecordType>        
					        )
					        }            
        </ns1:consultaFinanciamientosClienteResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaFinanciamientosClienteHNOut($outputParameters)