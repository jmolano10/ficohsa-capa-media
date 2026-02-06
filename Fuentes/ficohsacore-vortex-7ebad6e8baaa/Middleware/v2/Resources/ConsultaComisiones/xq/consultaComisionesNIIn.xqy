xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaComisiones" element="ns0:consultaComisiones" location="../xsd/consultaComisionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:opConsultaComisionesSolicitud" location="../../../BusinessServices/CTS/cuenta/xsd/services.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://service.srvaplcobiscuenta.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesNIIn/";

declare function xf:consultaComisionesNIIn($consultaComisiones as element(ns0:consultaComisiones),
$tipoAchValue as xs:string)
    as element(ns1:opConsultaComisionesSolicitud) {
        <ns1:opConsultaComisionesSolicitud>
            <ns2:contextoTransaccional>
                <ns2:codCanalOriginador>1</ns2:codCanalOriginador>
            </ns2:contextoTransaccional>
            <ns2:monedaOrigen>
                <ns2:valSimboloMoneda>{ data($consultaComisiones/SOURCE_CURRENCY) }</ns2:valSimboloMoneda>
            </ns2:monedaOrigen>
            <ns2:monedaDestino>
                {
                    for $DESTINATION_CURRENCY in $consultaComisiones/DESTINATION_CURRENCY
                    return
                        <ns2:valSimboloMoneda>{ data($DESTINATION_CURRENCY) }</ns2:valSimboloMoneda>
                }
            </ns2:monedaDestino>
            
            <ns2:cliente>
            	{
	            	for $CUSTOMER_ID in data($consultaComisiones/CUSTOMER_ID)
	            	return
	            		<ns2:codCliente>{ $CUSTOMER_ID }</ns2:codCliente>
           		 }                
            </ns2:cliente>
            {
	            for $VALUE in $consultaComisiones/ADDITIONAL_INFO/INFO[NAME="DEBIT_ACCOUNT"]/VALUE
	            return
	            	<ns2:cuenta>
	        			<ns2:codCuentaHabiente>{ data($VALUE) }</ns2:codCuentaHabiente>
	    			</ns2:cuenta>
            }
            {
	            for $VALUE in $consultaComisiones/ADDITIONAL_INFO/INFO[NAME="DEBIT_AMOUNT"]/VALUE
	            return
	            	<ns2:montoADebitar>{ data($VALUE) }</ns2:montoADebitar>
	               
	        }
            <ns2:tipoTransaccion>{ data($consultaComisiones/TRANSACTION_TYPE) }</ns2:tipoTransaccion>            
            <ns2:tipoACH>
            	{ 
        			let $transactionType := fn:string($consultaComisiones/TRANSACTION_TYPE/text())
        			return(
	        				if($transactionType = "INTERGRUPAL")then(
	        					$tipoAchValue
	        				)else if($transactionType = "LOCAL")then(
	        					fn:string($consultaComisiones/ADDITIONAL_INFO/INFO[NAME = 'ACH_ACCT_TYPE']/VALUE)
	        				)else("")            				            			
        			)
             	}
             </ns2:tipoACH>                               
            {
	            for $VALUE in $consultaComisiones/ADDITIONAL_INFO/INFO[NAME="CREDIT_CURRENCY"]/VALUE
	            return
	            	 <ns2:monedaCredito>
			         	<ns2:valSimboloMoneda>{ data($VALUE) }</ns2:valSimboloMoneda>
			         </ns2:monedaCredito>
            }
            {
                for $VALUE in $consultaComisiones/ADDITIONAL_INFO/INFO[NAME="DEST_BANK_CODE"]/VALUE
                return
                    <ns2:bancoDestino>
               			<ns2:codSABanco>{ data($VALUE) }</ns2:codSABanco>
            		</ns2:bancoDestino>
            }
            {
	             for $VALUE in $consultaComisiones/ADDITIONAL_INFO/INFO[NAME="DEBIT_ACCOUNT"]/VALUE
	             return
			         <ns2:cuentaDestino>
			        	 <ns2:codCuentaHabiente>{ data($VALUE) }</ns2:codCuentaHabiente>
			         </ns2:cuentaDestino>
	     	}
            {
	             for $VALUE in $consultaComisiones/ADDITIONAL_INFO/INFO[NAME="DESTINATION_COUNTRY"]/VALUE
	             return
			        <ns2:paisDestino>
	        			<ns2:valPais>{ data($VALUE) }</ns2:valPais>
	   				</ns2:paisDestino>
    	 	}
            {
	             for $VALUE in $consultaComisiones/ADDITIONAL_INFO/INFO[NAME="ADDEND"]/VALUE
	             return
			       <ns2:informacionAdicional>{ data($VALUE) }</ns2:informacionAdicional>
	     	}
            
        </ns1:opConsultaComisionesSolicitud>
};

declare variable $consultaComisiones as element(ns0:consultaComisiones) external;
declare variable $tipoAchValue as xs:string external;

xf:consultaComisionesNIIn($consultaComisiones, $tipoAchValue)