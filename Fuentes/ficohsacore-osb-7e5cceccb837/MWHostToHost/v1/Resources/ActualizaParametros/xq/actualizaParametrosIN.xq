(:: pragma bea:global-element-parameter parameter="$actualizaParametrosRequest" element="ns0:actualizaParametrosRequest" location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PWS/actualizaParametros/xsd/actualizaParametros_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaParametros";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ActualizaParametros/xq/actualizaParametrosIN/";

declare function xf:actualizaParametrosIN($actualizaParametrosRequest as element(ns0:actualizaParametrosRequest))
    as element(ns1:InputParameters) {
	<ns1:InputParameters>
		<ns1:PV_CODIGOCLIENTE>{ data($actualizaParametrosRequest/CUSTOMER_ID/text()) }</ns1:PV_CODIGOCLIENTE>
		<ns1:PV_NOMBREREFERENCIA>{ data($actualizaParametrosRequest/PARAMETERS/PARAMETER[NAME="REFERENCE_NAME"]/VALUE/text()) }</ns1:PV_NOMBREREFERENCIA>
		<ns1:PV_APELLIDOREFERENCIA>{ data($actualizaParametrosRequest/PARAMETERS/PARAMETER[NAME="REFERENCE_LAST_NAME"]/VALUE/text()) }</ns1:PV_APELLIDOREFERENCIA>
		<ns1:PV_TELEFONOREFERENCIA>{ data($actualizaParametrosRequest/PARAMETERS/PARAMETER[NAME="REFERENCE_PHONE"]/VALUE/text()) }</ns1:PV_TELEFONOREFERENCIA>
		<ns1:PN_PARENTESCOREFERENCIA>{ data($actualizaParametrosRequest/PARAMETERS/PARAMETER[NAME="REFERENCE_RELATIONSHIP"]/VALUE/text()) }</ns1:PN_PARENTESCOREFERENCIA>
	</ns1:InputParameters>
};

declare variable $actualizaParametrosRequest as element(ns0:actualizaParametrosRequest) external;

xf:actualizaParametrosIN($actualizaParametrosRequest)