xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/VinculaDispositivos/xsd/vinculaDispositivos_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:vinculaDispositivosResponse" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/vinculaDispositivos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VinculaDispositivos/xq/vinculaDispositivosOut/";

declare function xf:vinculaDispositivosOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:vinculaDispositivosResponse) {
        <ns1:vinculaDispositivosResponse>
            {
                for $PV_REQUESTID in $outputParameters/ns0:PV_REQUESTID
                return
                    <REQUEST_ID>{ data($PV_REQUESTID) }</REQUEST_ID>
            }
            {
                for $PV_RETURNCODE in $outputParameters/ns0:PV_RETURNCODE
                return
                    <RETURN_CODE>{ data($PV_RETURNCODE) }</RETURN_CODE>
            }

            {
                for $PA_AUTHENTICATIONMETHODS in $outputParameters/ns0:PA_AUTHENTICATIONMETHODS
                return
                	if( empty($PA_AUTHENTICATIONMETHODS/*) )then(
            		
                	)else(
	            			for $PA_AUTHENTICATIONMETHODS_ITEM in $PA_AUTHENTICATIONMETHODS/ns0:PA_AUTHENTICATIONMETHODS_ITEM
	            			return
	                		<AUTHENTICATION_METHODS>
	                			{
	                				for $IDENTIFIER in $PA_AUTHENTICATIONMETHODS_ITEM/ns0:IDENTIFIER
	                				return
	                					if( $IDENTIFIER/text() != "" )then (
	                						<IDENTIFIER>{ data($IDENTIFIER) }</IDENTIFIER>
                						)else()
	                			}
	                			{
	                				for $TYPE in $PA_AUTHENTICATIONMETHODS_ITEM/ns0:TYPE
	                				return
	                					if( $TYPE/text() != "" )then (
	                						<TYPE>{ data($TYPE) }</TYPE>
	                					)else()
	                			}
	                			{
	                				for $MASKEDINFO in $PA_AUTHENTICATIONMETHODS_ITEM/ns0:MASKEDINFO
	                				return
	                					if( $MASKEDINFO/text() != "" )then (
	                						<MASKED_INFO>{ data($MASKEDINFO) }</MASKED_INFO>
	                					)else()
	                			}		                        		                        		                        
		                        {
		                            for $CUSTOMERADDRESS in $PA_AUTHENTICATIONMETHODS_ITEM/ns0:CUSTOMERADDRESS
		                            return
		                            	if( $CUSTOMERADDRESS/text() != "" )then (
		                                	<CUSTOMER_ADDRESS>{ data($CUSTOMERADDRESS) }</CUSTOMER_ADDRESS>
		                                )else()
		                        }
		                        {
		                            for $SOURCEADDRESS in $PA_AUTHENTICATIONMETHODS_ITEM/ns0:SOURCEADDRESS
		                            return
		                            	if( $SOURCEADDRESS/text() != "" )then (
		                                	<SOURCE_ADDRESS>{ data($SOURCEADDRESS) }</SOURCE_ADDRESS>
		                                 )else()
		                        }
		                        {
		                            for $PLATFORM in $PA_AUTHENTICATIONMETHODS_ITEM/ns0:PLATFORM
		                            return
		                            	if( $PLATFORM/text() != "" )then (
		                                	<PLATFORM>{ data($PLATFORM) }</PLATFORM>
		                                )else()
		                        }
		                    </AUTHENTICATION_METHODS>
                	)                    
            }
        </ns1:vinculaDispositivosResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:vinculaDispositivosOut($outputParameters)