xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/transferenciaInternacional/xsd/transferenciaInternacional_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaInternacionalResponse" location="../../../../Business_Resources/Transferencias/TransferenciaInternacional/transferenciaInternacionalType.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciaInternacional";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalType";
declare namespace xf = "http://tempuri.org/Middleware/transferenciaInternacionalOut/";

declare function xf:transferenciaInternacionalOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:transferenciaInternacionalResponse) {
        <ns1:transferenciaInternacionalResponse>
            <ORDERING_CUSTOMER>{ data($outputParameters1/ns0:ORDERING_CUSTOMER) }</ORDERING_CUSTOMER>
        </ns1:transferenciaInternacionalResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:transferenciaInternacionalOut($outputParameters1)