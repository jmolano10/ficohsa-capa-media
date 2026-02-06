xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaListasCliente1" element="ns0:consultaListasCliente" location="../xsd/consultaListasClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DataWarehouse/ConsultaListasCliente/xsd/ConsultaListasClienteNI_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaListasClienteNI";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaListasClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/consultaListasClienteNIIn/";

declare function xf:consultaListasClienteNIIn($customerId as xs:string)
    as element(ns1:InputParameters) {
        let $customerId1 := $customerId
        return
			<ns1:InputParameters>
                <ns1:IDENTIDAD>{ data($customerId1) }</ns1:IDENTIDAD>
            </ns1:InputParameters>
};

declare variable $customerId as xs:string external;

xf:consultaListasClienteNIIn($customerId)