(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DIGITARCLI/envioVerificacionToken/xsd/enviarVerificacionTokenInitiateAction_db.xsd" ::)
(:: pragma bea:global-element-return element="ns1:envioVerificacionTokenResponse" location="../../AutenticacionClienteTarjeta/xsd/autenticacionClienteTarjetaTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/DIGITARCLI/OSB_K_VCAS/INITIATE_ACTION/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autenticacionClienteTarjetaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnvioVerificacionToken/xq/enviarVerificacionTokenOut/";

declare function xf:envioVerificacionTokenOut($outputParameters as element(ns0:OutputParameters),
	$status as xs:string,
	$id as xs:string)
    as element(ns1:envioVerificacionTokenResponse) {
        <ns1:envioVerificacionTokenResponse>
        {        
            if($status = 'SUCCESS' or $status = 'FAILWITHFEEDBACK' or $status = 'ERROR')then(
        
        		            
                for $PV_PROCESSORIDOUT in $outputParameters/ns0:PV_PROCESSORIDOUT
                return
                    <PROCESSORID>{ data($PV_PROCESSORIDOUT) }</PROCESSORID>,
            
                for $PV_ISSUERIDOUT in $outputParameters/ns0:PV_ISSUERIDOUT
                return
                    <ISSUERID>{ data($PV_ISSUERIDOUT) }</ISSUERID>,
            
                for $PV_TRANSACTIONIDOUT in $outputParameters/ns0:PV_TRANSACTIONIDOUT
                return
                    <TRANSACTIONID>{ data($PV_TRANSACTIONIDOUT) }</TRANSACTIONID>,
            
                for $PV_STEPUPREQUESTIDOUT in $outputParameters/ns0:PV_STEPUPREQUESTIDOUT
                return
                    <STEPUPREQUESTID>{ data($PV_STEPUPREQUESTIDOUT) }</STEPUPREQUESTID>,
            
                for $PV_LANGUAGE in $outputParameters/ns0:PV_LANGUAGE
                return
                    <LANGUAGE>{ data($PV_LANGUAGE) }</LANGUAGE>,
            
                for $PV_STATUS in $outputParameters/ns0:PV_STATUS
                return
                    <STATUS>{ data($PV_STATUS) }</STATUS>,
            
                for $PV_RISKINDICATOR in $outputParameters/ns0:PV_RISKINDICATOR
                return
                    <RISKINDICATOR>{ data($PV_RISKINDICATOR) }</RISKINDICATOR>,
            
            <CREDENTIALS>
                {
                    for $PT_CREDENTIALS_ITEM in $outputParameters/ns0:PT_CREDENTIALSOUT/ns0:PT_CREDENTIALS_ITEM
                    return
                        <CREDENTIAL>
                            <ID>{ data($PT_CREDENTIALS_ITEM/ns0:CREDENTIAL/ns0:ID) }</ID>
                            <TYPE>{ data($PT_CREDENTIALS_ITEM/ns0:CREDENTIAL/ns0:TYPE) }</TYPE>
                            <TEXT>{ data($PT_CREDENTIALS_ITEM/ns0:CREDENTIAL/ns0:TEXT) }</TEXT>
                        </CREDENTIAL>
                }
            </CREDENTIALS>,
            <REASON>
                <REASONCODE>{ data($outputParameters/ns0:PT_REASON/ns0:PT_REASON_ITEM[1]/ns0:REASONCODE) }</REASONCODE>
                <REASONDESCRIPTION>{ data($outputParameters/ns0:PT_REASON/ns0:PT_REASON_ITEM[1]/ns0:REASONDESCRIPTION) }</REASONDESCRIPTION>
            </REASON>,
                for $PT_ERROR in $outputParameters/ns0:PT_ERROR
                let $REFERENCENUMBER := $PT_ERROR/ns0:PT_ERROR_ITEM[1]/ns0:REFERENCENUMBER
                let $DESCRIPTION := $PT_ERROR/ns0:PT_ERROR_ITEM[1]/ns0:DESCRIPTION
                let $MESSAGE := $PT_ERROR/ns0:PT_ERROR_ITEM[1]/ns0:MESSAGE
                
                return
               
                	if($REFERENCENUMBER = '' and $DESCRIPTION = '' and $MESSAGE = '')then(
                	
                	)else(
                	
                		<ERROR>
                        {
                            if($REFERENCENUMBER != '')then(
                            
                            	<REFERENCENUMBER>{ data($REFERENCENUMBER) }</REFERENCENUMBER>
                            	
                            )else()
                                
                        }
                        {
                            if($DESCRIPTION != '')then(
                            	
                            	<DESCRIPTION>{ data($DESCRIPTION) }</DESCRIPTION>
                            
                            )else()
                                
                        }
                        {
                            if($MESSAGE != '')then(
                            
                            	<MESSAGE>{ data($MESSAGE) }</MESSAGE>
                            
                            )else()
                                
                        }
                    </ERROR>
                      	),                 
            
                for $PT_WHYINFO in $outputParameters/ns0:PT_WHYINFO
                let $LABEL := $PT_WHYINFO/ns0:PT_WHYINFO_ITEM[1]/ns0:LABEL
                let $TEXT := $PT_WHYINFO/ns0:PT_WHYINFO_ITEM[1]/ns0:TEXT
                
                return
                
                	if($LABEL = '' and $TEXT = '')then(
                	
                	)else(
                	
                		<WHYINFO>
                        {
                        	if($LABEL != '')then(
                            
                            	<LABEL>{ data($LABEL) }</LABEL>
                            	
                            )else()
                        }
                        {
                            if($TEXT != '')then(
                            
                            	<TEXT>{ data($TEXT) }</TEXT>
                            	
                            )else()
                                
                        }
                    </WHYINFO>
                    
                    )
        	
        	)else(
            	
            	for $PV_PROCESSORIDOUT in $outputParameters/ns0:PV_PROCESSORIDOUT
                return
                    <PROCESSORID>{ data($PV_PROCESSORIDOUT) }</PROCESSORID>,
            
            
                for $PV_ISSUERIDOUT in $outputParameters/ns0:PV_ISSUERIDOUT
                return
                    <ISSUERID>{ data($PV_ISSUERIDOUT) }</ISSUERID>,
            
            
                for $PV_TRANSACTIONIDOUT in $outputParameters/ns0:PV_TRANSACTIONIDOUT
                return
                    <TRANSACTIONID>{ data($PV_TRANSACTIONIDOUT) }</TRANSACTIONID>,
            
            
                for $PV_STEPUPREQUESTIDOUT in $outputParameters/ns0:PV_STEPUPREQUESTIDOUT
                return
                    <STEPUPREQUESTID>{ data($PV_STEPUPREQUESTIDOUT) }</STEPUPREQUESTID>,
                    
            	<STATUS>ERROR</STATUS>,            	
            	<CREDENTIALS>                  			     
                        <CREDENTIAL>
                            <ID>{ data($id) }</ID>
                            <TYPE>OTPSMS</TYPE>
                        </CREDENTIAL>
		        </CREDENTIALS>,
            	
            	<REASON>
                	<REASONCODE>02</REASONCODE>
                	<REASONDESCRIPTION>Error en el backed</REASONDESCRIPTION>
           		</REASON>,
            	<ERROR>
                	<REFERENCENUMBER>2001</REFERENCENUMBER>
                	<DESCRIPTION>Error en mapeo respuesta del backend</DESCRIPTION>
                	<MESSAGE>No se pudo procesar correctamente la respuesta</MESSAGE>
            	</ERROR>
        	)
        }
        </ns1:envioVerificacionTokenResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $status as xs:string external;
declare variable $id as xs:string external;

xf:envioVerificacionTokenOut($outputParameters,$status, $id)