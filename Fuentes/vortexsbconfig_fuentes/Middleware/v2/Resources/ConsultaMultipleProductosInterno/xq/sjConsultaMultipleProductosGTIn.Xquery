<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMultipleProductosInterno" element="ns1:consultaMultipleProductosInterno" location="../xsd/consultaMultipleProductosInternoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:sjConsultaMultipleProductosGT" location="../../../BusinessServices/SJS/consultaMultipleProductosGT/xsd/sjConsultaMultipleProductosGT.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosGT";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMultipleProductosInternoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleProductosInterno/xq/sjConsultaMultipleProductosGTIn/";

declare function xf:sjConsultaMultipleProductosGTIn($consultaMultipleProductosInterno as element(ns1:consultaMultipleProductosInterno),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns2:sjConsultaMultipleProductosGT) {
        <ns2:sjConsultaMultipleProductosGT>
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
        </ns2:sjConsultaMultipleProductosGT>
};

declare variable $consultaMultipleProductosInterno as element(ns1:consultaMultipleProductosInterno) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:sjConsultaMultipleProductosGTIn($consultaMultipleProductosInterno,
    $requestHeader)]]></con:xquery>
    <con:dependency location="../xsd/consultaMultipleProductosInternoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaMultipleProductosInterno/xsd/consultaMultipleProductosInternoTypes"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/SJS/consultaMultipleProductosGT/xsd/sjConsultaMultipleProductosGT.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaMultipleProductosGT/xsd/sjConsultaMultipleProductosGT"/>
    </con:dependency>
</con:xqueryEntry>