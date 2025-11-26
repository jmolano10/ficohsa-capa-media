(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterData/conDatoAutorizacionesHistorica/xsd/conDatoAutorizacionesHistorica_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaHistoricoAutorizacionesResponse" location="../xsd/consultaHistoricoAutorizacionesTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoAutorizacionesHistorica";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaHistoricoAutorizacionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaHistoricoAutorizaciones/xq/consultaHistoricoAutorizacionesOut/";

declare function xf:consultaHistoricoAutorizacionesOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaHistoricoAutorizacionesResponse) {
        <ns1:consultaHistoricoAutorizacionesResponse>
        {
            <ns1:TRANSACTIONS>
            {
	        	for $row in $outputParameters/ns0:RowSet/ns0:Row
		        return
		        (
	             	<ns1:TRANSACTION>
	                { 
                        for $COD_PAIS in $row/ns0:Column[@name='COD_PAIS']
	   					return
			         	 	<TRANSACTION_COUNTRY>{data($COD_PAIS) }</TRANSACTION_COUNTRY>,
		         	 		
		         	 	for $COD_ACTUAL in $row/ns0:Column[@name='COD_ACTUAL']
   						return
		         			<TRANSACTION_CURRENCY>{data($COD_ACTUAL) }</TRANSACTION_CURRENCY>,
		         			
		         		for $FECHA in $row/ns0:Column[@name='FECHA']
   						return
		         			<TRANSACTION_DATE>{data($FECHA) }</TRANSACTION_DATE>,
		         			
			         	for $HORA in $row/ns0:Column[@name='HORA']
   						return
			         		<TRANSACTION_TIME>{data($HORA) }</TRANSACTION_TIME>,
			         		
                        for $TIPO_REC in $row/ns0:Column[@name='TIPO_REC']
   						return
			         		<TRANSACTION_TYPE>{data($TIPO_REC) }</TRANSACTION_TYPE>,
			         		
                        for $ACQ_ID in $row/ns0:Column[@name='ACQ_ID']
   						return
			         		<COUNTRY_ACQ_ID>{data($ACQ_ID) }</COUNTRY_ACQ_ID>,
			         		
                        for $ORG in $row/ns0:Column[@name='ORG']
   						return
			         		<ORG>{data($ORG) }</ORG>,
			         	
                        for $NUMCUENTA in $row/ns0:Column[@name='NUMCUENTA']
   						return
			         		<ACCOUNT_NUMBER>{data($NUMCUENTA) }</ACCOUNT_NUMBER>,
			         	
                        for $CARDHOLDER_BILL_CURR_CODE in $row/ns0:Column[@name='CARDHOLDER_BILL_CURR_CODE']
   						return
			         		<CARD_HOLDER_BILL_CURRENCY>{data($CARDHOLDER_BILL_CURR_CODE) }</CARD_HOLDER_BILL_CURRENCY>,
			         	
                        for $PROC_TO_ACCT in $row/ns0:Column[@name='PROC_TO_ACCT']
   						return
		    				<CARD_HOLDER_DES_ACCOUNT_TYPE>{data($PROC_TO_ACCT) }</CARD_HOLDER_DES_ACCOUNT_TYPE>,
		    			
                        for $PROC_FRM_ACCT in $row/ns0:Column[@name='PROC_FRM_ACCT']
   						return
		    				<CARD_HOLDER_SRC_ACCOUNT_TYPE>{data($PROC_FRM_ACCT) }</CARD_HOLDER_SRC_ACCOUNT_TYPE>,
		    			
                        for $PROC_TRN_TYPE in $row/ns0:Column[@name='PROC_TRN_TYPE']
   						return
		                	<CARD_HOLDER_TRANSACTION_TYPE>{data($PROC_TRN_TYPE) }</CARD_HOLDER_TRANSACTION_TYPE>,
		                
                        for $NUMERO_TARJETA in $row/ns0:Column[@name='NUMERO_TARJETA']
   						return
		    				<CARD_NUMBER>{data($NUMERO_TARJETA) }</CARD_NUMBER>,
		    			
                        for $SEQ_TARJETA in $row/ns0:Column[@name='SEQ_TARJETA']
   						return
		    				<CARD_SEQUENCE>{data($SEQ_TARJETA) }</CARD_SEQUENCE>,
		    			
                        for $TIPO_TARJETA in $row/ns0:Column[@name='TIPO_TARJETA']
   						return
		    				<CARD_TYPE>{data($TIPO_TARJETA) }</CARD_TYPE>,
		    			
                        for $FECHA_EXPIRA in $row/ns0:Column[@name='FECHA_EXPIRA']
   						return
		    				<CARD_EXP_DATE>{data($FECHA_EXPIRA) }</CARD_EXP_DATE>,
		    			
                        for $PLAN_CREDITO in $row/ns0:Column[@name='PLAN_CREDITO']
   						return
		    				<CASH_PLAN_NUMBER>{data($PLAN_CREDITO) }</CASH_PLAN_NUMBER>,
                        for $CREDITO_DISP in $row/ns0:Column[@name='CREDITO_DISP']
   						return
		    				<AVAILABLE_CREDIT>{data($CREDITO_DISP) }</AVAILABLE_CREDIT>,
		    			
                        for $EFECTIVO_DISP_CREDITO in $row/ns0:Column[@name='EFECTIVO_DISP_CREDITO']
   						return
		    				<AVAILABLE_CASH_CREDIT>{data($EFECTIVO_DISP_CREDITO) }</AVAILABLE_CASH_CREDIT>,
		    			
                        for $BALANCE_ACT in $row/ns0:Column[@name='BALANCE_ACT']
   						return
		    				<BALANCE>{data($BALANCE_ACT) }</BALANCE>,
		    			
                        for $BALANCE_ACT_EFECTIVO in $row/ns0:Column[@name='BALANCE_ACT_EFECTIVO']
   						return
		    				<CASH_BALANCE>{data($BALANCE_ACT_EFECTIVO) }</CASH_BALANCE>,
		    			
                        for $ACCION_FINAL in $row/ns0:Column[@name='ACCION_FINAL']
   						return
		    				<ACTION>{data($ACCION_FINAL) }</ACTION>,
		    			
                        for $RAZON_ACCION in $row/ns0:Column[@name='RAZON_ACCION']
   						return
		    				<ACTION_REASON>{data($RAZON_ACCION) }</ACTION_REASON>,
		    			
                        for $ACCION_REV in $row/ns0:Column[@name='ACCION_REV']
   						return
		    				<REVERSION_REASON>{data($ACCION_REV) }</REVERSION_REASON>,
		    			
                        for $ACCION_SISTEMA in $row/ns0:Column[@name='ACCION_SISTEMA']
   						return
		    				<SYSTEM_ACTION>{data($ACCION_SISTEMA) }</SYSTEM_ACTION>,
		    			
                        for $CARDHOLDER_BILL_AMT in $row/ns0:Column[@name='CARDHOLDER_BILL_AMT']
   						return
		    				<AMOUNT>{data($CARDHOLDER_BILL_AMT) }</AMOUNT>,
		    			
                        for $CANT_TOT_VENTA in $row/ns0:Column[@name='CANT_TOT_VENTA']
   						return
							<SALE_AMOUNT>{data($CANT_TOT_VENTA) }</SALE_AMOUNT>,
						
						for $COD_AUTO in $row/ns0:Column[@name='COD_AUTO']
   						return
							<AUTH_CODE>{data($COD_AUTO) }</AUTH_CODE>,
						
                        for $COD_RESPUESTA in $row/ns0:Column[@name='COD_RESPUESTA']
   						return
							<AUTHORIZATION_RESPONSE_CODE>{data($COD_RESPUESTA) }</AUTHORIZATION_RESPONSE_CODE>,
						
                        for $FORCE_FLAG in $row/ns0:Column[@name='FORCE_FLAG']
   						return
							<FORCE_FLAG>{data($FORCE_FLAG) }</FORCE_FLAG>,
						
						for $FWD_ID in $row/ns0:Column[@name='FWD_ID']
   						return
							<FWD_ID>{data($FWD_ID) }</FWD_ID>,
						
                        for $COMERCIO_ID in $row/ns0:Column[@name='COMERCIO_ID']
   						return
							<BUSINESS_ID>{data($COMERCIO_ID) }</BUSINESS_ID>,
						
                        for $COMERCIO_NOMBRE in $row/ns0:Column[@name='COMERCIO_NOMBRE']
   						return
							<BUSINESS_NAME>{data($COMERCIO_NOMBRE) }</BUSINESS_NAME>,
						
                        for $COMERCIO_CIUDAD in $row/ns0:Column[@name='COMERCIO_CIUDAD']
                        return
							<BUSINESS_CITY>{data($COMERCIO_CIUDAD) }</BUSINESS_CITY>,
						
                        for $COMERCIO_PROV in $row/ns0:Column[@name='COMERCIO_PROV']
   						return
							<BUSINESS_COUNTY>{data($COMERCIO_PROV) }</BUSINESS_COUNTY>,
						
						for $TIPO_PETICION in $row/ns0:Column[@name='TIPO_PETICION']
   						return
							<REQUEST_TYPE>{data($TIPO_PETICION) }</REQUEST_TYPE>,
						
                        for $FAS_TXN_CODE in $row/ns0:Column[@name='FAS_TXN_CODE']
   						return
							<FAS_TRANSACTION_CODE>{data($FAS_TXN_CODE) }</FAS_TRANSACTION_CODE>,
						
                        for $INPUT_SOURCE in $row/ns0:Column[@name='INPUT_SOURCE']
   						return
							<INPUT_SOURCE>{data($INPUT_SOURCE) }</INPUT_SOURCE>,
						
                        for $LOGO in $row/ns0:Column[@name='LOGO']
   						return
							<LOGO>{data($LOGO) }</LOGO>,
						
                        for $NUMERO_REF in $row/ns0:Column[@name='NUMERO_REF']
   						return
							<REFERENCE_NUMBER>{data($NUMERO_REF) }</REFERENCE_NUMBER>,
						
                        for $POS_INT_FLAG in $row/ns0:Column[@name='POS_INT_FLAG']
   						return
							<POS_INT_FLAG>{data($POS_INT_FLAG) }</POS_INT_FLAG>,
						
                        for $POSEM in $row/ns0:Column[@name='POSEM']
   						return
							<POSEM>{data($POSEM) }</POSEM>,
						
                        for $POS_COND_CODE in $row/ns0:Column[@name='POS_COND_CODE']
   						return
							<POS_COND_CODE>{data($POS_COND_CODE) }</POS_COND_CODE>,
						
						for $STIP_RTN_CODE in $row/ns0:Column[@name='STIP_RTN_CODE']
   						return
							<STIP_RTN_CODE>{data($STIP_RTN_CODE) }</STIP_RTN_CODE>,
						
                        for $PROC_LEVEL in $row/ns0:Column[@name='PROC_LEVEL']
   						return
							<PROC_LEVEL>{data($PROC_LEVEL) }</PROC_LEVEL>,
						
                        for $PARM_LEVEL_USED in $row/ns0:Column[@name='PARM_LEVEL_USED']
   						return
							<PARM_LEVEL_USED>{data($PARM_LEVEL_USED) }</PARM_LEVEL_USED>,
						
                        for $CODIGO_TERM in $row/ns0:Column[@name='CODIGO_TERM']
   						return
							<TERMINAL_ID>{data($CODIGO_TERM) }</TERMINAL_ID>,
						
                        for $SOURCE_TERMID in $row/ns0:Column[@name='SOURCE_TERMID']
   						return
							<SOURCE_TERMINAL_ID>{data($SOURCE_TERMID) }</SOURCE_TERMINAL_ID>,
						
                        for $OF01WS_B040_SVC_REST_CODE in $row/ns0:Column[@name='OF01WS_B040_SVC_REST_CODE']
   						return
							<OF01WS_B040_SVC_REST_CODE>{data($OF01WS_B040_SVC_REST_CODE) }</OF01WS_B040_SVC_REST_CODE>,
						
                        for $TIPO_MENSAJE in $row/ns0:Column[@name='TIPO_MENSAJE']
   						return
							<MESAGE_TYPE>{data($TIPO_MENSAJE) }</MESAGE_TYPE>,
						
						for $FECHA_HORA_GMT in $row/ns0:Column[@name='FECHA_HORA_GMT']
   						return  
							<GMT_TIMESTAMP>{data($FECHA_HORA_GMT) }</GMT_TIMESTAMP>,
						
                        for $MER_TYPE in $row/ns0:Column[@name='MER_TYPE']
   						return
							<MER_TYPE>{data($MER_TYPE) }</MER_TYPE>,
						
                        for $HORA_ENVIO in $row/ns0:Column[@name='HORA_ENVIO']
   						return
							<SENT_ABSOLUTE_TIMESTAMP>{data($HORA_ENVIO) }</SENT_ABSOLUTE_TIMESTAMP>,
						
                        for $TIME_SENT in $row/ns0:Column[@name='TIME_SENT']
   						return
							<SENT_TIMESTAMP>{data($TIME_SENT) }</SENT_TIMESTAMP>,
						
                        for $HORA_RECIBIDO in $row/ns0:Column[@name='HORA_RECIBIDO']
   						return
							<RECEIVED_TIMESTAMP>{data($HORA_RECIBIDO) }</RECEIVED_TIMESTAMP>,
						
                        for $HORA_ABS_RECIBIDO in $row/ns0:Column[@name='HORA_ABS_RECIBIDO']
   						return
							<RECEIVED_ABSOLUTE_TIMESTAMP>{data($HORA_ABS_RECIBIDO) }</RECEIVED_ABSOLUTE_TIMESTAMP>	
	                    
	                 }
                	</ns1:TRANSACTION>
                 )
             }
            </ns1:TRANSACTIONS>
          }
        </ns1:consultaHistoricoAutorizacionesResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaHistoricoAutorizacionesOut($outputParameters)