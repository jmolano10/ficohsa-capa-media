(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaDetalleCuenta/consultaDetalleCuentaHeaderOut/";

declare function xf:consultaDetalleCuentaHeaderOut($consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse))
    as element(ns1:ResponseHeader) {
    	if (fn:string($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType/ZERORECORDS/text()) = "") then
    	(
	        <ns1:ResponseHeader>
	            {
	                for $successIndicator in $consultadedetallesdelacuentaResponse1/Status/successIndicator
	                return
	                    <successIndicator>{ data($successIndicator) }</successIndicator>
	            }
	            {
	                for $messages in $consultadedetallesdelacuentaResponse1/Status/messages
	                return
	                    <messages>{ data($messages) }</messages>
	            }
	        </ns1:ResponseHeader>
	    ) else (
	        <ns1:ResponseHeader>
	            {
	                for $successIndicator in $consultadedetallesdelacuentaResponse1/Status/successIndicator
	                return
	                    <successIndicator>NORECORDS</successIndicator>
	            }
	            {
	                for $messages in $consultadedetallesdelacuentaResponse1/Status/messages
	                return
	                    <messages>{ data($messages) }</messages>
	            }
	        </ns1:ResponseHeader>
	    
	    )
};

declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:consultaDetalleCuentaHeaderOut($consultadedetallesdelacuentaResponse1)