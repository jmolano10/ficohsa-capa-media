(:: pragma bea:global-element-parameter parameter="$consultaBancoInternacionalRequest" element="ns0:consultaBancoInternacionalRequest" location="../xsd/consultaBancoInternacionalTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/INTFC/consultaBancoInternacional/xsd/consultaBancoInternacional_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaBancoInternacionalResponse" location="../xsd/consultaBancoInternacionalTypes.xsd" ::)

declare namespace ns0 = "http://www.example.org/consultaBancoInternacionalTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaBancoInternacional";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBancoInternacional/xq/consultaBancoInternacionalOut/";

declare function xf:consultaBancoInternacionalOut($consultaBancoInternacionalRequest as element(ns0:consultaBancoInternacionalRequest),
    $outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaBancoInternacionalResponse) {
        <ns0:consultaBancoInternacionalResponse>
            <BANK_CODE>{ data($consultaBancoInternacionalRequest/BANK_CODE) }</BANK_CODE>
            <BANK_CODE_TYPE>{ data($consultaBancoInternacionalRequest/BANK_CODE_TYPE) }</BANK_CODE_TYPE>
            {
                for $PV_NOMBREBANCO in $outputParameters/ns1:PV_NOMBREBANCO
                return
                    <BANK_NAME>{ data($PV_NOMBREBANCO) }</BANK_NAME>
            }
            {
                for $PV_CODIGOPAIS in $outputParameters/ns1:PV_CODIGOPAIS
                return
                    <COUNTRY_CODE>{ data($PV_CODIGOPAIS) }</COUNTRY_CODE>
            }
            {
                for $PV_NOMBREPAIS in $outputParameters/ns1:PV_NOMBREPAIS
                return
                    <COUNTRY_NAME>{ data($PV_NOMBREPAIS) }</COUNTRY_NAME>
            }
            {
                for $PV_INSTITUCION in $outputParameters/ns1:PV_INSTITUCION
                return
                    <OFFICE>{ data($PV_INSTITUCION) }</OFFICE>
            }
            {
                for $PV_ESTADO in $outputParameters/ns1:PV_ESTADO
                return
                    <STATE>{ data($PV_ESTADO) }</STATE>
            }
            {
                for $PV_CIUDAD in $outputParameters/ns1:PV_CIUDAD
                return
                    <CITY>{ data($PV_CIUDAD) }</CITY>
            }
        </ns0:consultaBancoInternacionalResponse>
};

declare variable $consultaBancoInternacionalRequest as element(ns0:consultaBancoInternacionalRequest) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaBancoInternacionalOut($consultaBancoInternacionalRequest,
    $outputParameters)