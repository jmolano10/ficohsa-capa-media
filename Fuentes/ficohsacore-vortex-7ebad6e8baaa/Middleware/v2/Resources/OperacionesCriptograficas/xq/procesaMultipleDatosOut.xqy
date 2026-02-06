xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-parameter parameter="$processDataResponse" element="ns0:processDataResponse" location="../../../BusinessServices/operacionesCriptograficas/wsdl/cryptographicOperations.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:procesaMultipleDatosResponse" location="../xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/cryptographicOperationsTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/procesaMultipleDatosOut/";

declare function xf:procesaMultipleDatosOut($processDataResponse as element(ns0:processDataResponse))
    as element(ns1:procesaMultipleDatosResponse) {
        <ns1:procesaMultipleDatosResponse>
            <ns1:DATA_ITEMS>
                {
                    for $fieldItem in $processDataResponse/dataItems/fieldItem
                    return
                        <ns1:FIELD_ITEM>
                            <ns1:NAME>{ data($fieldItem/name) }</ns1:NAME>
                            <ns1:VALUE>{ data($fieldItem/value) }</ns1:VALUE>
                        </ns1:FIELD_ITEM>
                }
            </ns1:DATA_ITEMS>
        </ns1:procesaMultipleDatosResponse>
};

declare variable $processDataResponse as element(ns0:processDataResponse) external;

xf:procesaMultipleDatosOut($processDataResponse)