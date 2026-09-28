(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TENGO/ConsultaDatosCuponATM/xsd/consultaCuponTengoATM_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCuponTengoATM";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaCuponATM/xq/consultarCuponTengodbIn/";

declare function xf:consultarCuponTengodbIn($retrievalReference as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_RETRIEVAL_REF>{ $retrievalReference }</ns0:PV_RETRIEVAL_REF>
        </ns0:InputParameters>
};

declare variable $retrievalReference as xs:string external;

xf:consultarCuponTengodbIn($retrievalReference)