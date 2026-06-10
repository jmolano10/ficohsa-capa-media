<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMultipleProductosInterno" element="ns2:consultaMultipleProductosInterno" location="../xsd/consultaMultipleProductosInternoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaMultiplesProductosPA" location="../../../BusinessServices/SJS/consultaMultipleProductosPA/xsd/sjConsultaMultipleProductosPA.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaMultipleProductosInternoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultiplesProductosPA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleProductosInterno/xq/sjConsultaMultipleProductosPAIn/";

declare function xf:sjConsultaMultipleProductosPAIn($requestHeader as element(ns0:RequestHeader),
    $consultaMultipleProductosInterno as element(ns2:consultaMultipleProductosInterno))
    as element(ns1:sjConsultaMultiplesProductosPA) {
        <ns1:sjConsultaMultiplesProductosPA>
            <ns1:USERNAME>{ data($requestHeader/Authentication/UserName) }</ns1:USERNAME>
            <ns1:PASSWORD>{ data($requestHeader/Authentication/Password) }</ns1:PASSWORD>
            {
                for $PRODUCTS in $consultaMultipleProductosInterno/PRODUCTS
                return
                    <ns1:PRODUCTS>
                        {
                            for $PRODUCT in $PRODUCTS/PRODUCT
                            return
                                <ns1:PRODUCT>
                                    {
                                        for $ID in $PRODUCT/ID
                                        return
                                            <ns1:ID>{ data($ID) }</ns1:ID>
                                    }
                                    {
                                        for $TYPE in $PRODUCT/TYPE
                                        return
                                            <ns1:TYPE>{ data($TYPE) }</ns1:TYPE>
                                    }
                                </ns1:PRODUCT>
                        }
                    </ns1:PRODUCTS>
            }
        </ns1:sjConsultaMultiplesProductosPA>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaMultipleProductosInterno as element(ns2:consultaMultipleProductosInterno) external;

xf:sjConsultaMultipleProductosPAIn($requestHeader,
    $consultaMultipleProductosInterno)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaMultipleProductosInternoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaMultipleProductosInterno/xsd/consultaMultipleProductosInternoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/SJS/consultaMultipleProductosPA/xsd/sjConsultaMultipleProductosPA.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xsd/sjConsultaMultipleProductosPA"/>
    </con:dependency>
</con:xqueryEntry>