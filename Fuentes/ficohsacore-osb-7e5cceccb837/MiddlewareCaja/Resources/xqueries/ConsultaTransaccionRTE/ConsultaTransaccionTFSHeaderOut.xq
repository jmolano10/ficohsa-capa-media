(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTFSResponse" element="ns0:ConsultadetransaccionTFSResponse" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaTransaccionRTE/ConsultaTransaccionTFSHeaderOut/";

declare function xf:ConsultaTransaccionTFSHeaderOut($consultadetransaccionTFSResponse as element(ns0:ConsultadetransaccionTFSResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadetransaccionTFSResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadetransaccionTFSResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadetransaccionTFSResponse/WSTFSTRANSACTIONType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetransaccionTFSResponse as element(ns0:ConsultadetransaccionTFSResponse) external;

xf:ConsultaTransaccionTFSHeaderOut($consultadetransaccionTFSResponse)