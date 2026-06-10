<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaInformacionSolicitudes" element="ns0:consultaInformacionSolicitudes" location="../../DesembolsoLineaCredito/xsd/desembolsoLineaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DesembolsoLineaCredito/consultaInformacionSolicitudes/xsd/consultaInformacionSolicitud_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInformacionSolicitudes/xq/consultaInformacionSolicitudesHNIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/desembolsoLineaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInformacionSolicitud";



declare function xf:consultaInformacionSolicitudesHNIn($consultaInformacionSolicitudes as element(ns0:consultaInformacionSolicitudes))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	<ns1:P_CUSTOMER_ID>{ data($consultaInformacionSolicitudes/CUSTOMER_ID) }</ns1:P_CUSTOMER_ID>
            {
            	let $requestRepetitive := $consultaInformacionSolicitudes/REQUEST_DETAILS/REQUEST
            	return(            		            	
	            		<ns1:P_REQUEST_ID>
	            			{
	            				for $request in $requestRepetitive
	            				return
	            					<ns1:P_REQUEST_ID_ITEM>{ data($request/ID) }</ns1:P_REQUEST_ID_ITEM>
	            			}	            			                				            			            			
	            		</ns1:P_REQUEST_ID>,	            		
						<ns1:P_INCOME_DATE>
							{
								for $request in $requestRepetitive,	    		
			    				$incomeDate in $request/INCOME_DATE            	
								return
									if( $incomeDate/text() != "" )then(
			        					<ns1:P_INCOME_DATE_ITEM>{adjust-date-to-timezone(xs:date($incomeDate),()) }</ns1:P_INCOME_DATE_ITEM>
		        					)else()	
							}						
						</ns1:P_INCOME_DATE>   		    				 	          		        			
	             )     
			}
           	
        </ns1:InputParameters>
};

declare variable $consultaInformacionSolicitudes as element(ns0:consultaInformacionSolicitudes) external;

xf:consultaInformacionSolicitudesHNIn($consultaInformacionSolicitudes)]]></con:xquery>
    <con:dependency location="../../DesembolsoLineaCredito/xsd/desembolsoLineaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/DesembolsoLineaCredito/xsd/desembolsoLineaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/DesembolsoLineaCredito/consultaInformacionSolicitudes/xsd/consultaInformacionSolicitud_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DesembolsoLineaCredito/consultaInformacionSolicitudes/xsd/consultaInformacionSolicitud_sp"/>
    </con:dependency>
</con:xqueryEntry>