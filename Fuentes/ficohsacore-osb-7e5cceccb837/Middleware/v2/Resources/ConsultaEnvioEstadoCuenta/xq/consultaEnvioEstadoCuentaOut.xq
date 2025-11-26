xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterData/obtenerBitacoraEC/xsd/obtenerBitacoraEC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaEnvioEstadoCuentaResponse" location="../xsd/consultaEnvioEstadoCuentaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEnvioEstadoCuenta/xq/consultaEnvioEstadoCuentaOut/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerBitacoraEC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEnvioEstadoCuentaTypes";

declare function xf:consultaEnvioEstadoCuentaOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaEnvioEstadoCuentaResponse) {
        <ns0:consultaEnvioEstadoCuentaResponse>
         {
			for $row in $outputParameters/ns1:RowSet/ns1:Row
			return(
				<BALANCE_INFORMATION>
   				{
   					for $ACCOUNT_NUMBER in string($row/ns1:Column[@name='NUMUSU']/text())
   					return
   						<ACCOUNT_NUMBER>{$ACCOUNT_NUMBER }</ACCOUNT_NUMBER>
   				}
   				{
   					for $FULL_NAME in string($row/ns1:Column[@name='NOMBRE_COMPLETO']/text())
   					return
   						<FULL_NAME>{ $FULL_NAME }</FULL_NAME>
   				}
   				{
   					for $LEGAL_ID in string($row/ns1:Column[@name='IDENTIDAD']/text())
   					return
   					<LEGAL_ID>{ $LEGAL_ID }</LEGAL_ID>
   				}
   				{
   					for $EMAIL in string($row/ns1:Column[@name='EMAIL']/text())
   					return
   						<EMAIL>{ $EMAIL }</EMAIL>
   				}	
   				{
   					for $PHONE_NUMBER in string($row/ns1:Column[@name='TELEFONO1_CELULAR']/text())
   					return
   						<PHONE_NUMBER>{ $PHONE_NUMBER }</PHONE_NUMBER>
   				}
   				{
   					for $PRODUCT_NAME in string($row/ns1:Column[@name='NOMBRE_DE_PRODUCTOS']/text())
   					return
   						<PRODUCT_NAME>{ $PRODUCT_NAME }</PRODUCT_NAME>
   				}
   				{
   					for $CUT_OF in string($row/ns1:Column[@name='CORTE']/text())
   					return
   						<CUT_OF>{ $CUT_OF }</CUT_OF>
   				}
   				{
   					for $CHAIN in string($row/ns1:Column[@name='CADENA']/text())
   					return
   						<CHAIN>{ $CHAIN }</CHAIN>
   				}
   				{
   					for $SNO in string($row/ns1:Column[@name='SNO']/text())
   					return
   						<SNO>{ $SNO }</SNO>
   				}
   				{
   					for $EMAIL_ID in string($row/ns1:Column[@name='MAILINGID']/text())
   					return
   						<EMAIL_ID>{ $EMAIL_ID }</EMAIL_ID>
   				}
   				{
   					for $DB_ID in string($row/ns1:Column[@name='DBID']/text())
   					return
   						<DB_ID>{ $DB_ID }</DB_ID>
   				}
   				{
   					for $TEMPLATE_ID in string($row/ns1:Column[@name='MESSAGEID']/text())
   					return
   						<TEMPLATE_ID>{ $TEMPLATE_ID }</TEMPLATE_ID>
   				}
   				{
   					for $PROCESS_DATE in $row/ns1:Column[@name='FECHA_PROCESO']
   					return
   						if(string($PROCESS_DATE/text())!='')then( 
                    		<PROCESS_DATE>{ adjust-dateTime-to-timezone(data($PROCESS_DATE),()) }</PROCESS_DATE>
                    	)else()
   				}
   				{
   					for $STATUS in string($row/ns1:Column[@name='ESTADO']/text())
   					return
   						<STATUS>{ $STATUS }</STATUS>
   				}
   				{
   					for $SUB_STATUS in string($row/ns1:Column[@name='SUBESTADO']/text())
   					return
   						<SUB_STATUS>{ $SUB_STATUS }</SUB_STATUS>
   				}
   				{
   					for $LAST_ACTION_DATE in $row/ns1:Column[@name='FECHA_ULTIMA_ACCION']
   					return
   						if(string($LAST_ACTION_DATE/text())!='')then( 
                    		<LAST_ACTION_DATE>{adjust-dateTime-to-timezone(data($LAST_ACTION_DATE), ()) }</LAST_ACTION_DATE>
                    	)else()
                    	
                    					
   				}
   				{
   					for $COMMENTS in string($row/ns1:Column[@name='comentario']/text())
   					return
   						<COMMENTS>{ $COMMENTS }</COMMENTS>
   				}
				</BALANCE_INFORMATION>
			) 
		}
		</ns0:consultaEnvioEstadoCuentaResponse>        
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaEnvioEstadoCuentaOut($outputParameters)