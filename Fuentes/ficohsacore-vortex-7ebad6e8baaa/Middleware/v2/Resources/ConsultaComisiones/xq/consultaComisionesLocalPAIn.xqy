xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaComisiones" element="ns0:consultaComisiones" location="../xsd/consultaComisionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/consultaComisiones/xsd/consultaComisiones_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesLocalPAIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisiones";

declare function xf:consultaComisionesLocalPAIn($consultaComisiones as element(ns0:consultaComisiones))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	<ns1:ACCOUNT_NUMBER>{ data($consultaComisiones/ADDITIONAL_INFO/INFO[NAME="ACCOUNT_NUMBER"]/VALUE) }</ns1:ACCOUNT_NUMBER>
        </ns1:InputParameters>
};

declare variable $consultaComisiones as element(ns0:consultaComisiones) external;

xf:consultaComisionesLocalPAIn($consultaComisiones)