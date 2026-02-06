xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-parameter parameter="$procesaMultipleDatos" element="ns1:procesaMultipleDatos" location="../xsd/operacionesCriptograficasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:processDataRequest" location="../../../BusinessServices/operacionesCriptograficas/wsdl/cryptographicOperations.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/cryptographicOperationsTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/processDataMultipleIn/";

declare function xf:processDataMultipleIn($procesaMultipleDatos as element(ns1:procesaMultipleDatos))
    as element(ns0:processDataRequest) {
        <ns0:processDataRequest>
            <operationType>{ data($procesaMultipleDatos/ns1:OPERATION_TYPE) }</operationType>
            <cipher>{ data($procesaMultipleDatos/ns1:CIPHER) }</cipher>
            <keyAlias>{ fn:lower-case(data($procesaMultipleDatos/ns1:CRYPTOKEY_ALIAS)) }</keyAlias>
            <dataItems>
                {
                    for $FIELD_ITEM in $procesaMultipleDatos/ns1:DATA_ITEMS/ns1:FIELD_ITEM
                    return
                        <fieldItem>
                            <name>{ data($FIELD_ITEM/ns1:NAME) }</name>
                            <value>{ data($FIELD_ITEM/ns1:VALUE) }</value>
                        </fieldItem>
                }
            </dataItems>
        </ns0:processDataRequest>
};

declare variable $procesaMultipleDatos as element(ns1:procesaMultipleDatos) external;

xf:processDataMultipleIn($procesaMultipleDatos)