xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultarXmlAutorizacionesResponse1" element="ns0:ConsultarXmlAutorizacionesResponse" location="../../../BusinessServices/VASA/consultarFlotantesTC/wsdl/WSConsultas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosFlotantesTC/xq/consultaMovsFlotantesTCHeader/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://tempuri.org/";

declare function xf:consultaMovsFlotantesTCHeader($consultarXmlAutorizacionesResponse1 as element(ns0:ConsultarXmlAutorizacionesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
                	{
        		if (fn:empty(data($consultarXmlAutorizacionesResponse1//error))) then (
        		     <successIndicator>SUCCESS</successIndicator>,
        			 <messageId></messageId>,
        			 <messages></messages>
        		)
        		else (
        			 <successIndicator>ERROR</successIndicator>,
        			 <messageId>{ data($consultarXmlAutorizacionesResponse1//codigo)}</messageId>,
        			 <messages>{data($consultarXmlAutorizacionesResponse1//error)}</messages>
        		)
        	}
       </ns1:ResponseHeader>
};

declare variable $consultarXmlAutorizacionesResponse1 as element(ns0:ConsultarXmlAutorizacionesResponse) external;

xf:consultaMovsFlotantesTCHeader($consultarXmlAutorizacionesResponse1)