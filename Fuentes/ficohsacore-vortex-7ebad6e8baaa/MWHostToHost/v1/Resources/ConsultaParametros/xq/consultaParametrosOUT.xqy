xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$OutputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/PWS/consultaParametros/xsd/consultaParametros_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaParametrosResponse" location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaParametros";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/consultaParametros/xq/consultaParametrosOUT/";

declare function xf:consultaParametrosOUT($OutputParameters as element(ns0:OutputParameters), $customerId as xs:string)
    as element(ns1:consultaParametrosResponse) {
	<ns1:consultaParametrosResponse>
		<CUSTOMER_ID>{ $customerId }</CUSTOMER_ID>
		<PARAMETERS>
			<PARAMETER>
				<NAME>REFERENCE_NAME</NAME>
				<VALUE>{ data($OutputParameters/ns0:PV_NOMBREREFERENCIA) }</VALUE>
			</PARAMETER>
			<PARAMETER>
				<NAME>REFERENCE_LAST_NAME</NAME>
				<VALUE>{ data($OutputParameters/ns0:PV_APELLIDOREFERENCIA) }</VALUE>
			</PARAMETER>
			<PARAMETER>
				<NAME>REFERENCE_PHONE</NAME>
				<VALUE>{ data($OutputParameters/ns0:PV_TELEFONOREFERENCIA) }</VALUE>
			</PARAMETER>
			<PARAMETER>
				<NAME>REFERENCE_RELATIONSHIP</NAME>
				<VALUE>{ data($OutputParameters/ns0:PN_PARENTESCOREFERENCIA) }</VALUE>
			</PARAMETER>
		</PARAMETERS>
	</ns1:consultaParametrosResponse>
};

declare variable $OutputParameters as element(ns0:OutputParameters) external;
declare variable $customerId as xs:string external;

xf:consultaParametrosOUT($OutputParameters, $customerId)