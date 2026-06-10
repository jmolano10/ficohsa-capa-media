<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetasadecambiolcyResponse1" element="ns1:ConsultadetasadecambiolcyResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTasaCambioResponse" location="consultaTasaCambioTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaTasaCambio/consultaTasaCambioOut2/";

declare function xf:consultaTasaCambioOut2($consultadetasadecambiolcyResponse1 as element(ns1:ConsultadetasadecambiolcyResponse))
    as element(ns0:consultaTasaCambioResponse) {
        <ns0:consultaTasaCambioResponse>
        {
        	if (empty($consultadetasadecambiolcyResponse1/WSLCYEXCHRATEType[1]/ZERORECORDS/text())) then (
	            <ns0:consultaTasaCambioResponseType>
	                <ns0:consultaTasaCambioResponseRecordType>
	                	{
	                	
	                		if ( $consultadetasadecambiolcyResponse1/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/BUYRATE = "" ) then (
		        				<BUY_RATE></BUY_RATE>
		        			) 
		        			else if ( number( $consultadetasadecambiolcyResponse1/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/BUYRATE ) = 0 ) then
		        			(
		        				<BUY_RATE>0</BUY_RATE>
		        			)
		        			else (
		        				<BUY_RATE>{ fn-bea:fail-over(round-half-to-even(1 div data($consultadetasadecambiolcyResponse1/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/BUYRATE), 4), 0) }</BUY_RATE>
		        			)
		        		}
		        		{
			        		if ($consultadetasadecambiolcyResponse1/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/SELLRATE = "" ) then (
			        			<SELL_RATE></SELL_RATE>
			        		)
			        		else if ( number( $consultadetasadecambiolcyResponse1/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/SELLRATE ) = 0 ) then
			        		(
			        			<SELL_RATE>0</SELL_RATE>
			        		)
			        		else (
			        			<SELL_RATE>{ fn-bea:fail-over(round-half-to-even(1 div data($consultadetasadecambiolcyResponse1/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/SELLRATE), 4), 0) }</SELL_RATE>
			        		)
		        		}
	                </ns0:consultaTasaCambioResponseRecordType>
	            </ns0:consultaTasaCambioResponseType>
	    	) else()
	    }
        </ns0:consultaTasaCambioResponse>
};

declare variable $consultadetasadecambiolcyResponse1 as element(ns1:ConsultadetasadecambiolcyResponse) external;

xf:consultaTasaCambioOut2($consultadetasadecambiolcyResponse1)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_1632682327.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/Resources/XMLSchema_1632682327"/>
    </con:dependency>
    <con:dependency location="consultaTasaCambioTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes"/>
    </con:dependency>
</con:xqueryEntry>