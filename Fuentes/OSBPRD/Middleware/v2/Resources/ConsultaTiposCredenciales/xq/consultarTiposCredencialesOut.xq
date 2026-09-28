(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DIGITARCLI/consultaTiposCredenciales/xsd/consultarTiposCredencialesStepUp_db.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTiposCredencialesResponse" location="../../AutenticacionClienteTarjeta/xsd/autenticacionClienteTarjetaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autenticacionClienteTarjetaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/DIGITARCLI/OSB_K_VCAS/STEP_UP/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposCredenciales/xq/consultarTiposCredencialesOut/";

declare function xf:consultarTiposCredencialesStepUpOut($outputParameters as element(ns1:OutputParameters),
	$status as xs:string,
	$uuid as xs:string)
    as element(ns0:consultaTiposCredencialesResponse) {
        <ns0:consultaTiposCredencialesResponse>{
        
        	if($status = 'SUCCESS' or $status = 'FAILWITHFEEDBACK' or $status = 'ERROR')then(
        	
        	
                for $PV_PROCESSORIDOUT in $outputParameters/ns1:PV_PROCESSORIDOUT
                return
                    <PROCESSORID>{ data($PV_PROCESSORIDOUT) }</PROCESSORID>,
            
            
                for $PV_ISSUERIDOUT in $outputParameters/ns1:PV_ISSUERIDOUT
                return
                    <ISSUERID>{ data($PV_ISSUERIDOUT) }</ISSUERID>,
            
            
                for $PV_TRANSACTIONIDOUT in $outputParameters/ns1:PV_TRANSACTIONIDOUT
                return
                    <TRANSACTIONID>{ data($PV_TRANSACTIONIDOUT) }</TRANSACTIONID>,
            
            
                for $PV_STEPUPREQUESTIDOUT in $outputParameters/ns1:PV_STEPUPREQUESTIDOUT
                return
                    <STEPUPREQUESTID>{ data($PV_STEPUPREQUESTIDOUT) }</STEPUPREQUESTID>,
            
            
                for $PV_STEPUPTYPE in $outputParameters/ns1:PV_STEPUPTYPE
                return
                    <STEPUPTYPE>{ data($PV_STEPUPTYPE) }</STEPUPTYPE>,
            
            
                for $PV_LANGUAGE in $outputParameters/ns1:PV_LANGUAGE
                return
                    <LANGUAGE>{ data($PV_LANGUAGE) }</LANGUAGE>,
            
            
                for $PV_STATUS in $outputParameters/ns1:PV_STATUS
                return
                    <STATUS>{ data($PV_STATUS) }</STATUS>,
            
            
                for $PV_RISKINDICATOR in $outputParameters/ns1:PV_RISKINDICATOR
                return
                    <RISKINDICATOR>{ data($PV_RISKINDICATOR) }</RISKINDICATOR>,
            
            <CREDENTIALS>{
            	for $PT_CREDENTIALS in $outputParameters/ns1:PT_CREDENTIALS/ns1:PT_CREDENTIALS_ITEM/ns1:CREDENTIAL
            	return
                <CREDENTIAL>
                    <ID>{ data($PT_CREDENTIALS/ns1:ID) }</ID>
                    <TYPE>{ data($PT_CREDENTIALS/ns1:TYPE) }</TYPE>
                    <TEXT>{ data($PT_CREDENTIALS/ns1:TEXT) }</TEXT>
                </CREDENTIAL>
            }
            </CREDENTIALS>,
            <REASON>
                <REASONCODE>{ data($outputParameters/ns1:PT_REASON/ns1:PT_REASON_ITEM[1]/ns1:REASONCODE) }</REASONCODE>
                <REASONDESCRIPTION>{ data($outputParameters/ns1:PT_REASON/ns1:PT_REASON_ITEM[1]/ns1:REASONDESCRIPTION) }</REASONDESCRIPTION>
            </REASON>,
                for $PT_ERROR in $outputParameters/ns1:PT_ERROR
                let $REFERENCENUMBER := $PT_ERROR/ns1:PT_ERROR_ITEM[1]/ns1:REFERENCENUMBER
                let $DESCRIPTION := $PT_ERROR/ns1:PT_ERROR_ITEM[1]/ns1:DESCRIPTION
                let $MESSAGE := $PT_ERROR/ns1:PT_ERROR_ITEM[1]/ns1:MESSAGE
                
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
            
                for $PT_WHYINFO in $outputParameters/ns1:PT_WHYINFO
                let $LABEL := $PT_WHYINFO/ns1:PT_WHYINFO_ITEM[1]/ns1:LABEL
                let $TEXT := $PT_WHYINFO/ns1:PT_WHYINFO_ITEM[1]/ns1:TEXT
                
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
        	
        	
                for $PV_PROCESSORIDOUT in $outputParameters/ns1:PV_PROCESSORIDOUT
                return
                    <PROCESSORID>{ data($PV_PROCESSORIDOUT) }</PROCESSORID>,
            
            
                for $PV_ISSUERIDOUT in $outputParameters/ns1:PV_ISSUERIDOUT
                return
                    <ISSUERID>{ data($PV_ISSUERIDOUT) }</ISSUERID>,
            
            
                for $PV_TRANSACTIONIDOUT in $outputParameters/ns1:PV_TRANSACTIONIDOUT
                return
                    <TRANSACTIONID>{ data($PV_TRANSACTIONIDOUT) }</TRANSACTIONID>,
            
            
                for $PV_STEPUPREQUESTIDOUT in $outputParameters/ns1:PV_STEPUPREQUESTIDOUT
                return
                    <STEPUPREQUESTID>{ data($PV_STEPUPREQUESTIDOUT) }</STEPUPREQUESTID>,
                    
                for $PV_STEPUPTYPE in $outputParameters/ns1:PV_STEPUPTYPE
                return
                    <STEPUPTYPE>{ data($PV_STEPUPTYPE) }</STEPUPTYPE>,
            	
            	<STATUS>ERROR</STATUS>,
            	
            	<CREDENTIALS>                  			     
                        <CREDENTIAL>
                            <ID>{ data(fn:substring($uuid, 5)) }</ID>
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
        </ns0:consultaTiposCredencialesResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $status as xs:string external;
declare variable $uuid as xs:string external;

xf:consultarTiposCredencialesStepUpOut($outputParameters, $status, $uuid)