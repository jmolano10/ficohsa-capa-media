(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaCuentaOCategoria/ConsultaDeDetallesDeLaCuentaHeaderOut/";

declare function xf:ConsultaDeDetallesDeLaCuentaHeaderOut($consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadedetallesdelacuentaResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadedetallesdelacuentaResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadedetallesdelacuentaResponse/WSACCOUNTLISTType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadedetallesdelacuentaResponse as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:ConsultaDeDetallesDeLaCuentaHeaderOut($consultadedetallesdelacuentaResponse)