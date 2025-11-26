(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaBuroInterno/xsd/ConsultaBuroInterno_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaBuroInternoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaBuroInterno";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBuroInterno/xq/consultaBuroInternoPAIn/";

declare function xf:consultaBuroInternoPAIn($customerId as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_CLIENTE>{ data($customerId) }</ns1:PV_CODIGO_CLIENTE>
        </ns1:InputParameters>
};

declare variable $customerId as xs:string external;

xf:consultaBuroInternoPAIn($customerId)