xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMultipleProductosInterno" element="ns1:consultaMultipleProductosInterno" location="../xsd/consultaMultipleProductosInternoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:sjConsultaMultipleProductosHN" location="../../../BusinessServices/SJS/consultaMultipleProductosHN/xsd/sjConsultaMultipleProductosHN.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMultipleProductosInternoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleProductosInterno/xq/sjConsultaMultipleProductosHNIn/";

declare function xf:sjConsultaMultipleProductosHNIn($consultaMultipleProductosInterno as element(ns1:consultaMultipleProductosInterno),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns2:sjConsultaMultipleProductosHN) {
        <ns2:sjConsultaMultipleProductosHN>
            <ns2:USERNAME>{ data($requestHeader/Authentication/UserName) }</ns2:USERNAME>
            <ns2:PASSWORD>{ data($requestHeader/Authentication/Password) }</ns2:PASSWORD>
            <ns2:PRODUCTS>
                {
                    for $PRODUCT in $consultaMultipleProductosInterno/PRODUCTS/PRODUCT
                    return
                        <ns2:PRODUCT>
                            {
                                for $ID in $PRODUCT/ID
                                return
                                    <ns2:ID>{ data($ID) }</ns2:ID>
                            }
                            {
                                for $TYPE in $PRODUCT/TYPE
                                return
                                    <ns2:TYPE>{ data($TYPE) }</ns2:TYPE>
                            }
                        </ns2:PRODUCT>
                }
            </ns2:PRODUCTS>
        </ns2:sjConsultaMultipleProductosHN>
};

declare variable $consultaMultipleProductosInterno as element(ns1:consultaMultipleProductosInterno) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:sjConsultaMultipleProductosHNIn($consultaMultipleProductosInterno,
    $requestHeader)