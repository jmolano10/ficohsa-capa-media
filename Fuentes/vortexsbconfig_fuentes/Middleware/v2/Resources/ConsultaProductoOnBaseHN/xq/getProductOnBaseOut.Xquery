<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaProductoOnBaseResponse" element="ns0:consultaProductoOnBaseResponse" location="../../../BusinessServices/FPC/getProductOnbase12c/xsd/GetProductOnbaseTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaProductoOnBaseResponse" location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/getProductOnBaseOut/";

declare function xf:getProductOnBaseOut($consultaProductoOnBaseResponse as element(ns0:consultaProductoOnBaseResponse))
    as element(ns0:consultaProductoOnBaseResponse) {
        <ns0:consultaProductoOnBaseResponse>
            {
                for $PRODUCT_NAME in $consultaProductoOnBaseResponse/PRODUCT_NAME
                return
                    <PRODUCT_NAME>{ data($PRODUCT_NAME) }</PRODUCT_NAME>
            }
            {
                for $CURRENCY in $consultaProductoOnBaseResponse/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $OPENING_DATE in $consultaProductoOnBaseResponse/OPENING_DATE
                return
                    <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
            }
        </ns0:consultaProductoOnBaseResponse>
};

declare variable $consultaProductoOnBaseResponse as element(ns0:consultaProductoOnBaseResponse) external;

xf:getProductOnBaseOut($consultaProductoOnBaseResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/FPC/getProductOnbase12c/xsd/GetProductOnbaseTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/FPC/getProductOnbase12c/xsd/GetProductOnbaseTypes"/>
    </con:dependency>
    <con:dependency location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes"/>
    </con:dependency>
</con:xqueryEntry>