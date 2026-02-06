xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/consultaCuentasAfiliadasTarjetaDebito/consultaDetalleCuentaOut/";

declare function xf:consultaDetalleCuentaOut($consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse))
    as xs:string {
    	if (fn:string($consultadedetallesdelacuentaResponse/Status/successIndicator/text()) = "Success" and
    		fn:string($consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/ZERORECORDS/text()) = "" ) then (
			if (fn:string($consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID/text()) != "") then (
				data($consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID)
			) else (
				data($consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID)
			)
    	) else (
    		""
    	)    
};

declare variable $consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:consultaDetalleCuentaOut($consultadedetallesdelacuentaResponse)