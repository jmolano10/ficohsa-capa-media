xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterData/conHeaderEncabezadoEstadoCuenta/xsd/conHeaderEncabezadoEstadoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSaldosHistEstadoCuentaResponse" location="../xsd/consultaSaldosHistEstadoCuentaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosHistEstadoCuenta/xq/consultaSaldosHistEstadoCuentaOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosHistEstadoCuentaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conHeaderEncabezadoEstadoCuenta";

declare function xf:consultaSaldosHistEstadoCuentaOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaSaldosHistEstadoCuentaResponse) {
        <ns1:consultaSaldosHistEstadoCuentaResponse>
    		{
    			for $row in $outputParameters/ns0:RowSet/ns0:Row
    				return(
    					<BALANCE_INFORMATION>
  						{
  							for $period in string($row/ns0:Column[@name='Periodo']/text())
               				return
                    			<PERIOD>{$period }</PERIOD>
            			}
            	 		{
                			for $currency in string($row/ns0:Column[@name='CodMoneda']/text())
                			return
                    			<CURRENCY>{ $currency }</CURRENCY>
            			}
             			{
                			for $org in string($row/ns0:Column[@name='org']/text())
               				return
               					<ORG>{ $org }</ORG>
                    	}
            	  		{
            	  			for $cutoff_Date in fn-bea:date-from-dateTime(adjust-dateTime-to-timezone($row/ns0:Column[@name='FechaCorte']/text(),()))
                			return
                					if(string($cutoff_Date)!='')then( 
                    					<CUTOFF_DATE>{ $cutoff_Date }</CUTOFF_DATE>
                    				)else()
                    	}
            			{
                			for $miles_Earned in string($row/ns0:Column[@name='Miles_Earned']/text())
                			return
                					if(string($miles_Earned)!='')then( 
                    					<MILES_EARNED>{ $miles_Earned }</MILES_EARNED>
                    				)else()
                    	}
               			{
                			for $point_Earned in string($row/ns0:Column[@name='Point_Earned']/text())
                			return
                					if(string($point_Earned)!='')then( 
                    					<POINTS_EARNED>{ $point_Earned }</POINTS_EARNED>
                    				)else()
                    	}
             			{
                 			for $min_Payment in string($row/ns0:Column[@name='PagoMinimo']/text())
                			return
                					if(string($min_Payment)!='')then( 
                    					<MIN_PAYMENT>{ $min_Payment }</MIN_PAYMENT>
                    				)else()
                    	}
             			{
                			for $total_Payment in string($row/ns0:Column[@name='PagoTotal']/text())
                			return
                					if(string($total_Payment)!='')then( 
                    					<TOTAL_PAYMENT>{ $total_Payment }</TOTAL_PAYMENT>
                    				)else()
                    	}
             			{
                			for $late_Fee in string($row/ns0:Column[@name='SaldoMora']/text())
                			return
                					if(string($late_Fee)!='')then( 
                    					<LATE_FEE>{ $late_Fee }</LATE_FEE>
                    				)else()
                		}
            			{
                			for $balance in string($row/ns0:Column[@name='Balance']/text())
              				return
              						if(string($balance)!='')then( 
                    					<BALANCE>{ $balance }</BALANCE>
                    				)else()
                		}
             			{
                			for $account_cicle in string($row/ns0:Column[@name='Ciclo']/text())
                			return
                					if(string($account_cicle)!='')then( 
                    					<ACCOUNT_CICLE>{ $account_cicle }</ACCOUNT_CICLE>
                    				)else()
                		}
              			{
                			for $statement_Url in string($row/ns0:Column[@name='FileLink']/text())
                			return
                				<STATEMENT_URL>{ $statement_Url }</STATEMENT_URL>
            			}
              			{
                			for $statement in string($row/ns0:Column[@name='PdfFile']/text())
                			return
                				<STATEMENT>{ $statement }</STATEMENT>
            			}
            			{
                			for $cycleDue in string($row/ns0:Column[@name='Cycle_Due']/text())
                			return
                				if($cycleDue != '')then(
                					<CYCLE_DUE>{ $cycleDue }</CYCLE_DUE>
                				)else()
            			}
         				</BALANCE_INFORMATION>) 
    				}
    	
        </ns1:consultaSaldosHistEstadoCuentaResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaSaldosHistEstadoCuentaOut($outputParameters)