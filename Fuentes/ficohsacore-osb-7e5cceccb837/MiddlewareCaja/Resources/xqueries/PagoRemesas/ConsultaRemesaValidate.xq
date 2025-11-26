(:: pragma bea:global-element-parameter parameter="$consultaderemesaResponse" element="ns0:ConsultaderemesaResponse" location="../../xsds/Remesas/XMLSchema_-1855765488.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRemesas/ConsultaRemesaValidate/";

declare function xf:ConsultaRemesaValidate($consultaderemesaResponse as element(ns0:ConsultaderemesaResponse))
    as xs:string {
        if (fn:string($consultaderemesaResponse/Status/successIndicator/text()) != "Success") then (
        	fn:string-join($consultaderemesaResponse/Status/messages/text()," ")
        
        ) else if (fn:string($consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/ZERORECORDS/text()) != "") then (
        	fn:string($consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/ZERORECORDS/text())
        	
        ) else if (fn:string($consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/gWSLATAMAGREMITTANCEINFODetailType/mWSLATAMAGREMITTANCEINFODetailType[1]/STATUS/text()) != "PENDING") then (
        	concat("Remesa en estado: ", $consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]/gWSLATAMAGREMITTANCEINFODetailType/mWSLATAMAGREMITTANCEINFODetailType[1]/STATUS)
        
        ) else ( 
			""
			
		)
};

declare variable $consultaderemesaResponse as element(ns0:ConsultaderemesaResponse) external;

xf:ConsultaRemesaValidate($consultaderemesaResponse)