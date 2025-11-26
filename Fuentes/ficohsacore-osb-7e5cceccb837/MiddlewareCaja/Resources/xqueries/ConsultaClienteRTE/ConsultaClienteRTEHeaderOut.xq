(:: pragma bea:global-element-parameter parameter="$consultaperfildeclienteResponse" element="ns0:ConsultaperfildeclienteResponse" location="../../xsds/PerfilCliente/XMLSchema_-994245660.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaClienteRTE/ConsultaClienteRTEHeaderOut/";

declare function xf:ConsultaClienteRTEHeaderOut($consultaperfildeclienteResponse as element(ns0:ConsultaperfildeclienteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultaperfildeclienteResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultaperfildeclienteResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultaperfildeclienteResponse/WSCUSTOMERFULLType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultaperfildeclienteResponse as element(ns0:ConsultaperfildeclienteResponse) external;

xf:ConsultaClienteRTEHeaderOut($consultaperfildeclienteResponse)