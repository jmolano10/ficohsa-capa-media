xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/consultaInfoUsuarioAD/xsd/consultarInfoUsuarioAD_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarInfoUsuarioAD";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUsuarioLdap/xq/consultaUsuarioLdapHeaderOut/";

declare function xf:consultaUsuarioLdapHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
	if ((fn:string($outputParameters1/ns0:COD_ERROR/text())) = 'SUCCESS') then 
	(
		<ns1:ResponseHeader>
			<successIndicator>Success</successIndicator>
		</ns1:ResponseHeader>
	)
	else 
	(
		<ns1:ResponseHeader>
			<successIndicator>{$outputParameters1/ns0:COD_ERROR/text()}</successIndicator>
			<messages>{$outputParameters1/ns0:MSG_ERROR/text()}</messages>
		</ns1:ResponseHeader>
	)
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaUsuarioLdapHeaderOut($outputParameters1)