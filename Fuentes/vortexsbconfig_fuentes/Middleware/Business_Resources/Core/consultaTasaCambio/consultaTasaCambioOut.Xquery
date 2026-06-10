<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetasadecambiolcyResponse1" element="ns1:ConsultadetasadecambiolcyResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTasaCambioResponse" location="consultaTasaCambioTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaTasaCambio/consultaTasaCambioOut/";

declare function xf:consultaTasaCambioOut($consultadetasadecambiolcyResponse1 as element(ns1:ConsultadetasadecambiolcyResponse))
    as element(ns0:consultaTasaCambioResponse) {
        <ns0:consultaTasaCambioResponse>
        {
        	if (empty($consultadetasadecambiolcyResponse1/WSLCYEXCHRATEType[1]/ZERORECORDS/text())) then (
	            <ns0:consultaTasaCambioResponseType>
	                <ns0:consultaTasaCambioResponseRecordType>
	                	<BUY_RATE>{ data($consultadetasadecambiolcyResponse1/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/BUYRATE) }</BUY_RATE>
	                    <SELL_RATE>{ data($consultadetasadecambiolcyResponse1/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/SELLRATE) }</SELL_RATE>
	                </ns0:consultaTasaCambioResponseRecordType>
	            </ns0:consultaTasaCambioResponseType>
	    	) else ()
        }
        </ns0:consultaTasaCambioResponse>
};

declare variable $consultadetasadecambiolcyResponse1 as element(ns1:ConsultadetasadecambiolcyResponse) external;

xf:consultaTasaCambioOut($consultadetasadecambiolcyResponse1)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_1632682327.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/Resources/XMLSchema_1632682327"/>
    </con:dependency>
    <con:dependency location="consultaTasaCambioTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes"/>
    </con:dependency>
</con:xqueryEntry>