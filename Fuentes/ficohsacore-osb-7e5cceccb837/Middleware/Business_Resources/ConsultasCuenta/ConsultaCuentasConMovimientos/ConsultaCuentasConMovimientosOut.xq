xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../Resources/ConsultaCuentasConMovimientos/xsd/ConsultaCuentasConMovimientos_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCuentasConMovimientos1" element="ns0:consultaCuentasConMovimientos" location="consultaCuentasConMovimientosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCuentasConMovimientosResponse" location="consultaCuentasConMovimientosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaCuentasConMovimientos/ConsultaCuentasConMovimientosOut2/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaCuentasConMovimientos";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentasConMovimientosTypes";

declare function xf:ConsultaCuentasConMovimientosOut2($outputParameters1 as element(ns1:OutputParameters),
    $consultaCuentasConMovimientos1 as element(ns0:consultaCuentasConMovimientos))
    as element(ns0:consultaCuentasConMovimientosResponse) {
        <ns0:consultaCuentasConMovimientosResponse>
        	{
                for $PV_TOTAL_CUENTAS in $outputParameters1/ns1:PV_TOTAL_CUENTAS
                return
                    <TOTAL_ACCOUNTS_FOUND>{ xs:string(data($PV_TOTAL_CUENTAS)) }</TOTAL_ACCOUNTS_FOUND>
            }            
            {
            	let $TotalRow := fn:count($outputParameters1/ns1:PC_CUENTAS/ns1:Row)            	            	
                return                    
                	<TOTAL_ACCOUNTS_RETURNED>{ xs:string(data($TotalRow)) }</TOTAL_ACCOUNTS_RETURNED>                	                	
            }
            {
				let $initialPos := data($consultaCuentasConMovimientos1/INITIAL_POSITION)				
				return											
            		<INITIAL_POSITION_RETURNED>{ data($initialPos) }</INITIAL_POSITION_RETURNED>					            		            		            		
            }
            {
            	let $initialPos := data($consultaCuentasConMovimientos1/INITIAL_POSITION)
				let $TotalRow := fn:count($outputParameters1/ns1:PC_CUENTAS/ns1:Row)
				return
								
				let $lastPos := fn-bea:format-number($initialPos + $TotalRow - 1,'0')
				return 				
            		<LAST_POSITION_RETURNED>{ xs:string(data($lastPos)) }</LAST_POSITION_RETURNED>
            }
            <ACCOUNTS>
            {
                for $Row in $outputParameters1/ns1:PC_CUENTAS/ns1:Row
                return                    
                        <ACCOUNT>{ data($Row/ns1:Column[2]) }</ACCOUNT>                    
            }
            </ACCOUNTS>
         </ns0:consultaCuentasConMovimientosResponse> 
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $consultaCuentasConMovimientos1 as element(ns0:consultaCuentasConMovimientos) external;

xf:ConsultaCuentasConMovimientosOut2($outputParameters1,
    $consultaCuentasConMovimientos1)