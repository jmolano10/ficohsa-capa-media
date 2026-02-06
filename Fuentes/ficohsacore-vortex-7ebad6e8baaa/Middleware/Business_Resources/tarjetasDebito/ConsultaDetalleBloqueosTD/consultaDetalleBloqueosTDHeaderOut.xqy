xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadebloqueosporTDResponse1" element="ns0:ConsultadebloqueosporTDResponse" location="../Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/ConsultaDetalleBloqueosTD/consultaDetalleBloqueosTDHeaderOut/";

declare function xf:consultaDetalleBloqueosTDHeaderOut($consultadebloqueosporTDResponse1 as element(ns0:ConsultadebloqueosporTDResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <successIndicator>{ data($consultadebloqueosporTDResponse1/Status/successIndicator) }</successIndicator>
            {
            	if (empty($consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/ZERORECORDS/text())) then (
            		<messages>{ data($consultadebloqueosporTDResponse1/Status/messages) }</messages>
            	) else (
            		<messages>{ data($consultadebloqueosporTDResponse1/WSFICOECUSTPOSVISATXNSType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadebloqueosporTDResponse1 as element(ns0:ConsultadebloqueosporTDResponse) external;

xf:consultaDetalleBloqueosTDHeaderOut($consultadebloqueosporTDResponse1)