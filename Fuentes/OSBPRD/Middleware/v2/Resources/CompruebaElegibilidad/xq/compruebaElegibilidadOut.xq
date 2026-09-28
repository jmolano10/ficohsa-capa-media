(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/CompruebaElegibilidad/xsd/compruebaElegibilidad_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:compruebaElegibilidadResponse" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/compruebaElegibilidad";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompruebaElegibilidad/xq/compruebaElegibilidadOut/";

declare function xf:compruebaElegibilidadOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:compruebaElegibilidadResponse) {
        <ns0:compruebaElegibilidadResponse>
            {
                for $PV_REQUESTIDOUT in $outputParameters/ns1:PV_REQUESTIDOUT
                return
                	if( $PV_REQUESTIDOUT/text() != "" )then (
                    	<REQUEST_ID>{ data($PV_REQUESTIDOUT) }</REQUEST_ID>
                	 )else()
            }
            {
                for $PV_PROCESSIDOUT in $outputParameters/ns1:PV_PROCESSIDOUT
                return
                	if( $PV_PROCESSIDOUT/text() != "" )then (
                    	<PROCESS_ID>{ data($PV_PROCESSIDOUT) }</PROCESS_ID>
                	)else()
            }
            {
                for $PV_RETURNCODE in $outputParameters/ns1:PV_RETURNCODE
                return
                	if( $PV_RETURNCODE/text() != "" )then (
                    	<RETURN_CODE>{ data($PV_RETURNCODE) }</RETURN_CODE>
                	)else()
            }
            {
                for $PV_ERRORDESCRIPTION in $outputParameters/ns1:PV_ERRORDESCRIPTION
                return
                	if( $PV_ERRORDESCRIPTION/text() != "" )then (
                    	<ERROR_DESCRIPTION>{ data($PV_ERRORDESCRIPTION) }</ERROR_DESCRIPTION>
                    )else()
            }
            {
            	for $PT_CARDMETADATA in $outputParameters/ns1:PT_CARDMETADATA
            	return
            		if( empty($PT_CARDMETADATA/*) )then(
            		
                	)else(
	                		<CARD_META_DATA>
	                			{
	                				for $FOREGROUNDCOLOR in $PT_CARDMETADATA/ns1:FOREGROUNDCOLOR
	                				return
	                					if( $FOREGROUNDCOLOR/text() != "" )then (
	                						<FOREGROUNDCOLOR>{ data($FOREGROUNDCOLOR) }</FOREGROUNDCOLOR>
                						)else()
	                			}
	                			{
	                				for $BACKGROUNDCOLOR in $PT_CARDMETADATA/ns1:BACKGROUNDCOLOR
	                				return
	                					if( $BACKGROUNDCOLOR/text() != "" )then (
	                						<BACKGROUNDCOLOR>{ data($BACKGROUNDCOLOR) }</BACKGROUNDCOLOR>
                						)else()
	                			}	                							                
	                			{
	                				for $LABELCOLOR in $PT_CARDMETADATA/ns1:LABELCOLOR
	                				return
	                					if( $LABELCOLOR/text() != "" )then (
	                						<LABELCOLOR>{ data($LABELCOLOR) }</LABELCOLOR>
                						)else()
	                			}
	                			{
	                				for $SHORTDESCRIPTION in $PT_CARDMETADATA/ns1:SHORTDESCRIPTION
	                				return
	                					if( $SHORTDESCRIPTION/text() != "" )then (
	                						<SHORTDESCRIPTION>{ data($SHORTDESCRIPTION) }</SHORTDESCRIPTION>
                						)else()
	                			}
	                			{
	                				for $LONGDESCRIPTION in $PT_CARDMETADATA/ns1:LONGDESCRIPTION
	                				return
	                					if( $LONGDESCRIPTION/text() != "" )then (
	                						<LONGDESCRIPTION>{ data($LONGDESCRIPTION) }</LONGDESCRIPTION>
                						)else()
	                			}
	                			{
	                				for $CONTACTEMAIL in $PT_CARDMETADATA/ns1:CONTACTEMAIL
	                				return
	                					if( $CONTACTEMAIL/text() != "" )then (
	                						<CONTACTEMAIL>{ data($CONTACTEMAIL) }</CONTACTEMAIL>
                						)else()
	                			}
	                			{
	                				for $CONTACTPHONE in $PT_CARDMETADATA/ns1:CONTACTPHONE
	                				return
	                					if( $CONTACTPHONE/text() != "" )then (
	                						<CONTACTPHONE>{ data($CONTACTPHONE) }</CONTACTPHONE>
                						)else()
	                			}
	                			{
	                				for $CONTACTNAME in $PT_CARDMETADATA/ns1:CONTACTNAME
	                				return
	                					if( $CONTACTNAME/text() != "" )then (
	                						<CONTACTNAME>{ data($CONTACTNAME) }</CONTACTNAME>
                						)else()
	                			}
	                			
	                			{
	                				for $TERMSANDCONDITIONSID in $PT_CARDMETADATA/ns1:TERMSANDCONDITIONSID
	                				return
	                					if( $TERMSANDCONDITIONSID/text() != "" )then (
	                						<TERMSANDCONDITIONSID>{ data($TERMSANDCONDITIONSID) }</TERMSANDCONDITIONSID>
                						)else()
	                			}
	                			{
	                				for $CARDARTID in $PT_CARDMETADATA/ns1:CARDARTID
	                				return
	                					if( $CARDARTID/text() != "" )then (
	                						<CARDARTID>{ data($CARDARTID) }</CARDARTID>
                						)else()
	                			}
	                			{
	                				for $PRODUCTID in $PT_CARDMETADATA/ns1:PRODUCTID
	                				return
	                					if( $PRODUCTID/text() != "" )then (
	                						<PRODUCTID>{ data($PRODUCTID) }</PRODUCTID>
                						)else()
	                			}
	                			{
	                				for $PRODUCTNAME in $PT_CARDMETADATA/ns1:PRODUCTNAME
	                				return
	                					if( $PRODUCTNAME/text() != "" )then (
	                						<PRODUCTNAME>{ data($PRODUCTNAME) }</PRODUCTNAME>
                						)else()
	                			}
	                			{
	                				for $PRODUCTTYPE in $PT_CARDMETADATA/ns1:PRODUCTTYPE
	                				return
	                					if( $PRODUCTTYPE/text() != "" )then (
	                						<PRODUCTTYPE>{ data($PRODUCTTYPE) }</PRODUCTTYPE>
                						)else()
	                			}		                					                				                				                							                			                
		            		</CARD_META_DATA>
                	)        			      
            }                        
            {
                for $PA_AUTHENTICATIONELEMENT1 in $outputParameters/ns1:PA_AUTHENTICATIONELEMENT1
                return
                	if( empty($PA_AUTHENTICATIONELEMENT1/*) )then(
            		
                	)else(
	            			for $PA_AUTHENTICATIONELEMENT1_ITEM in $PA_AUTHENTICATIONELEMENT1/ns1:PA_AUTHENTICATIONELEMENT1_ITEM
	            			return
	            			<AUTHENTICATION_METHODS>
	            				{
	            					for $IDENTIFIER in $PA_AUTHENTICATIONELEMENT1_ITEM/ns1:IDENTIFIER
	            					return
	            						if( $IDENTIFIER/text() != "" )then (
	            							<IDENTIFIER>{ data($IDENTIFIER) }</IDENTIFIER>	
	            						)else()
	            				}
	            				{
	            					for $TYPE in $PA_AUTHENTICATIONELEMENT1_ITEM/ns1:TYPE
	            					return
	            						if( $TYPE/text() != "" )then (
	            							<TYPE>{ data($TYPE) }</TYPE>	
            							)else()
	            				}
	            				{
	            					for $MASKEDINFO in $PA_AUTHENTICATIONELEMENT1_ITEM/ns1:MASKEDINFO
	            					return
	            						if( $MASKEDINFO/text() != "" )then (
	            							<MASKED_INFO>{ data($MASKEDINFO) }</MASKED_INFO>
	            						)else()
	            				}		                        		                        		                        
		                        {
		                            for $CUSTOMERADDRESS in $PA_AUTHENTICATIONELEMENT1_ITEM/ns1:CUSTOMERADDRESS
		                            return
		                            	if( $CUSTOMERADDRESS/text() != "" )then (
		                                	<CUSTOMER_ADDRESS>{ data($CUSTOMERADDRESS) }</CUSTOMER_ADDRESS>
		                                )else()
		                        }
		                        {
		                            for $SOURCEADDRESS in $PA_AUTHENTICATIONELEMENT1_ITEM/ns1:SOURCEADDRESS
		                            return
		                            	if( $SOURCEADDRESS/text() != "" )then (
		                                	<SOURCE_ADDRESS>{ data($SOURCEADDRESS) }</SOURCE_ADDRESS>
		                                 )else()
		                        }
		                        {
		                            for $PLATFORM in $PA_AUTHENTICATIONELEMENT1_ITEM/ns1:PLATFORM
		                            return
		                            	if( $PLATFORM/text() != "" )then (
		                                	<PLATFORM>{ data($PLATFORM) }</PLATFORM>
		                                )else()
		                        }
		                    </AUTHENTICATION_METHODS>
                	)                    
            }
            {
                for $PV_USERID in $outputParameters/ns1:PV_USERID
                return
                	if( $PV_USERID/text() != "" )then (
                    	<USER_ID>{ data($PV_USERID) }</USER_ID>
                    )else()
            }
			{
            	for $PT_MARKET in $outputParameters/ns1:PT_MARKET
            	return
            		if( empty($PT_MARKET/*) )then(
            		
                	)else(

	                		<MARKET>
	                			{
	                				for $COUNTRYCODE in $PT_MARKET/ns1:COUNTRYCODE
	                				return
	                					if( $COUNTRYCODE/text() != "" )then (
	                						<COUNTRYCODE>{ data($COUNTRYCODE) }</COUNTRYCODE>
                						)else()
	                			}
	                			{
	                				for $REGIONNAME in $PT_MARKET/ns1:REGIONNAME
	                				return
	                					if( $REGIONNAME/text() != "" )then (
	                						<REGIONNAME>{ data($REGIONNAME) }</REGIONNAME>
                						)else()
	                			}
	                			{
	                				for $LOCALE in $PT_MARKET/ns1:LOCALE
	                				return
	                					if( $LOCALE/text() != "" )then (
	                						<LOCALE>{ data($LOCALE) }</LOCALE>
                						)else()
	                			}	                				                			
	                					                					                				                				                							                			                
		            		</MARKET>
                	)        			      
            }   
            
			{
            	for $PT_EXPIRATIONDATE in $outputParameters/ns1:PT_EXPIRATIONDATE
            	return
            		if( empty($PT_EXPIRATIONDATE/*) )then(
            		
                	)else(
						
	                		<EXPIRATION_DATE>
	                			{
	                				for $MONTH in $PT_EXPIRATIONDATE/ns1:MONTH
	                				return
	                					if( $MONTH/text() != "" )then (
	                						<MONTH>{ data($MONTH) }</MONTH>
                						)else()
	                			}
	                			{
	                				for $YEAR in $PT_EXPIRATIONDATE/ns1:YEAR
	                				return
	                					if( $YEAR/text() != "" )then (
	                						<YEAR>{ data($YEAR) }</YEAR>
                						)else()
	                			}	                				                				                			
	                					                					                				                				                							                			                
		            		</EXPIRATION_DATE>
              )  	        			      
            }
            {
                for $PV_PANSECUENCE in $outputParameters/ns1:PV_PANSECUENCE
                return
                	if( $PV_PANSECUENCE/text() != "" )then (
                    	<PAN_SEQUENCE>{ data($PV_PANSECUENCE) }</PAN_SEQUENCE>
                    )else()
            }                                  
        </ns0:compruebaElegibilidadResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:compruebaElegibilidadOut($outputParameters)