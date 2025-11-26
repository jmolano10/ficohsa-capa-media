(:: pragma bea:global-element-parameter parameter="$consultaBancoInternacionalResponse" element="ns0:consultaBancoInternacionalResponse" location="../../../../../Middleware/v2/Resources/ConsultaBancoInternacional/xsd/consultaBancoInternacionalTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaBancoInternacionalH2HResponse" location="../xsd/consultaBancoInternacionalH2HTypes.xsd" ::)

declare namespace ns0 = "http://www.example.org/consultaBancoInternacionalTypes";
declare namespace ns1 = "http://www.example.org/consultaBancoInternacionalH2HTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaBancoInternacionalH2H/xq/consultaBancoInternacionalH2HOut/";

declare function xf:consultaBancoInternacionalH2HOut($consultaBancoInternacionalResponse as element(ns0:consultaBancoInternacionalResponse))
    as element(ns1:consultaBancoInternacionalH2HResponse) {
        <ns1:consultaBancoInternacionalH2HResponse>
            <BANK_CODE>{ data($consultaBancoInternacionalResponse/BANK_CODE) }</BANK_CODE>
            <BANK_CODE_TYPE>{ data($consultaBancoInternacionalResponse/BANK_CODE_TYPE) }</BANK_CODE_TYPE>
            <BANK_NAME>{ data($consultaBancoInternacionalResponse/BANK_NAME) }</BANK_NAME>
            <COUNTRY_CODE>{ data($consultaBancoInternacionalResponse/COUNTRY_CODE) }</COUNTRY_CODE>
            <COUNTRY_NAME>{ data($consultaBancoInternacionalResponse/COUNTRY_NAME) }</COUNTRY_NAME>
            <OFFICE>{ data($consultaBancoInternacionalResponse/OFFICE) }</OFFICE>
            <STATE>{ data($consultaBancoInternacionalResponse/STATE) }</STATE>
            <CITY>{ data($consultaBancoInternacionalResponse/CITY) }</CITY>
        </ns1:consultaBancoInternacionalH2HResponse>
};

declare variable $consultaBancoInternacionalResponse as element(ns0:consultaBancoInternacionalResponse) external;

xf:consultaBancoInternacionalH2HOut($consultaBancoInternacionalResponse)