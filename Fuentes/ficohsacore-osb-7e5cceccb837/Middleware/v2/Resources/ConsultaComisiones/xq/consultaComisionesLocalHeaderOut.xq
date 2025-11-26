xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultadecomisionACH_ValidateResponse" element="ns1:ConsultadecomisionACH_ValidateResponse" location="../../../BusinessServices/ACH/consultaComisionACH/xsd/XMLSchema_-1548829260.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesLocalHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";

declare function xf:consultaComisionesLocalHeaderOut($consultadecomisionACH_ValidateResponse as element(ns1:ConsultadecomisionACH_ValidateResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
        		let $amount := fn:string-join($consultadecomisionACH_ValidateResponse/FICOHNACHONLINEType/COMMISSIONAMOUNT, ' ')
            	let $currency := fn:string-join($consultadecomisionACH_ValidateResponse/FICOHNACHONLINEType/CREDITCCY, ' ')
            	let $successIndicator := fn:upper-case(data($consultadecomisionACH_ValidateResponse/Status/successIndicator))
            	return(
	            	<successIndicator>
	            		{
	                    	if ($successIndicator = "SUCCESS" and $amount != '' and $currency != '') then
	                        	("Success")
	                    	else( 
	                        	if(($amount = '' or $currency = '') and $successIndicator = "SUCCESS") then(
	                        		"Error"
	                        	)else(
	                        		data($consultadecomisionACH_ValidateResponse/Status/successIndicator)
	                        	)
	                        )
	               		}
	    			</successIndicator>,
	            	<messages>
			    		{
		     				if($amount = '' or $currency = '') then(
		     					if(fn:string-join($consultadecomisionACH_ValidateResponse/Status/messages, ' ') != '') then(
		     						fn:string-join($consultadecomisionACH_ValidateResponse/Status/messages, '. ')
		     					)else(
									'No se pudo obtener la informacion solicitada.'		     					
		     					)
		     				)else() 
		            	}
	            	</messages>
	            )
        	}
        </ns0:ResponseHeader>
};

declare variable $consultadecomisionACH_ValidateResponse as element(ns1:ConsultadecomisionACH_ValidateResponse) external;

xf:consultaComisionesLocalHeaderOut($consultadecomisionACH_ValidateResponse)