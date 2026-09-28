(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetallesCuenta/consultaDetallesCuentaHeaderOut/";

declare function xf:consultaDetallesCuentaHeaderOut($consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $successIndicator := fn:string($consultadedetallesdelacuentaResponse1/Status/successIndicator/text()) 
                return
                if ( $successIndicator = "Success") then (
                	if (fn:string($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType/ZERORECORDS/text()) != "") then (
                		<successIndicator>NO RECORDS</successIndicator>,
                		<messages>{ fn:string($consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/ZERORECORDS/text()) }</messages>
                	) else (
                		<successIndicator>Success</successIndicator>
                	)
                ) else (
                	<successIndicator>{ $successIndicator }</successIndicator>,
            		for $messages in $consultadedetallesdelacuentaResponse1/Status/messages
            		return
                	<messages>{ data($messages) }</messages>
                )
            }
        </ns1:ResponseHeader>
};

declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:consultaDetallesCuentaHeaderOut($consultadedetallesdelacuentaResponse1)