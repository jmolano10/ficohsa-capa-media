xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMultiplesProductosRequest" element="ns2:consultaMultiplesProductosRequest" location="../xsd/consultaMultiplesProductosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaMultipleProductos" location="../../../BusinessServices/SJS/consultaMultiplesProductos/xsd/sjConsultaMultipleProductos.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaMultiplesProductosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultiplesProductos/xq/sjConsultaMultiplesProductosIn/";

declare function xf:sjConsultaMultiplesProductosIn($consultaMultiplesProductosRequest as element(ns2:consultaMultiplesProductosRequest),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns1:sjConsultaMultipleProductos) {
        <ns1:sjConsultaMultipleProductos>
            <ns1:USERNAME>{ data($requestHeader/Authentication/UserName) }</ns1:USERNAME>
            <ns1:PASSWORD>{ data($requestHeader/Authentication/Password) }</ns1:PASSWORD>
            <ns1:SOURCE_BANK>{ data($requestHeader/Region/SourceBank) }</ns1:SOURCE_BANK>
            {
                for $DestinationBank in $requestHeader/Region/DestinationBank
                return
                    <ns1:DESTINATION_BANK>{ data($DestinationBank) }</ns1:DESTINATION_BANK>
            }
            {
                let $PRODUCTS := $consultaMultiplesProductosRequest/PRODUCTS
                return
                    <ns1:PRODUCTS>
                        {
                            for $PRODUCT in $PRODUCTS/PRODUCT
                            return
                                <ns1:PRODUCT>
                                    <ns1:TYPE>{ data($PRODUCT/TYPE) }</ns1:TYPE>
                                    <ns1:ID>{ normalize-space(data($PRODUCT/PRODUCT_ID)) }</ns1:ID>
                                    <ns1:REGION>{ data($PRODUCT/PRODUCT_REGION) }</ns1:REGION>
                                </ns1:PRODUCT>
                        }
                    </ns1:PRODUCTS>
            }
        </ns1:sjConsultaMultipleProductos>
};

declare variable $consultaMultiplesProductosRequest as element(ns2:consultaMultiplesProductosRequest) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:sjConsultaMultiplesProductosIn($consultaMultiplesProductosRequest,
    $requestHeader)