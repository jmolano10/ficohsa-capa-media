xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaBancoInternacionalRequest" element="ns0:consultaBancoInternacionalRequest" location="../xsd/consultaBancoInternacionalTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/INTFC/consultaBancoInternacional/xsd/consultaBancoInternacional_sp.xsd" ::)

declare namespace ns0 = "http://www.example.org/consultaBancoInternacionalTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaBancoInternacional";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBancoInternacional/xq/consultaBancoInternacionalIn/";

declare function xf:consultaBancoInternacionalIn($consultaBancoInternacionalRequest as element(ns0:consultaBancoInternacionalRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGOBANCO>{ data($consultaBancoInternacionalRequest/BANK_CODE) }</ns1:PV_CODIGOBANCO>
            <ns1:PV_CODIGOTIPOBANCO>{ data($consultaBancoInternacionalRequest/BANK_CODE_TYPE) }</ns1:PV_CODIGOTIPOBANCO>
        </ns1:InputParameters>
};

declare variable $consultaBancoInternacionalRequest as element(ns0:consultaBancoInternacionalRequest) external;

xf:consultaBancoInternacionalIn($consultaBancoInternacionalRequest)