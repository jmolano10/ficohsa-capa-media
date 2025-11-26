(:: pragma bea:global-element-parameter parameter="$consultaBancoInternacionalH2HRequest" element="ns1:consultaBancoInternacionalH2HRequest" location="../xsd/consultaBancoInternacionalH2HTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaBancoInternacionalRequest" location="../../../../../Middleware/v2/Resources/ConsultaBancoInternacional/xsd/consultaBancoInternacionalTypes.xsd" ::)

declare namespace ns0 = "http://www.example.org/consultaBancoInternacionalTypes";
declare namespace ns1 = "http://www.example.org/consultaBancoInternacionalH2HTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaBancoInternacionalH2H/xq/consultaBancoInternacionalH2HIn/";

declare function xf:consultaBancoInternacionalH2HIn($consultaBancoInternacionalH2HRequest as element(ns1:consultaBancoInternacionalH2HRequest))
    as element(ns0:consultaBancoInternacionalRequest) {
        <ns0:consultaBancoInternacionalRequest>
            <BANK_CODE_TYPE>{ data($consultaBancoInternacionalH2HRequest/BANK_CODE_TYPE) }</BANK_CODE_TYPE>
            <BANK_CODE>{ data($consultaBancoInternacionalH2HRequest/BANK_CODE) }</BANK_CODE>
        </ns0:consultaBancoInternacionalRequest>
};

declare variable $consultaBancoInternacionalH2HRequest as element(ns1:consultaBancoInternacionalH2HRequest) external;

xf:consultaBancoInternacionalH2HIn($consultaBancoInternacionalH2HRequest)