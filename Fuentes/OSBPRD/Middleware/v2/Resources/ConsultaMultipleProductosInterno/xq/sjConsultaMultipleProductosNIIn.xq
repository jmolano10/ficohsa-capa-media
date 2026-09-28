(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaMultipleProductosInterno" element="ns1:consultaMultipleProductosInterno" location="../xsd/consultaMultipleProductosInternoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaMultipleProductosNI" location="../../../BusinessServices/SJS/consultaMultipleProductosNI/xsd/sjConsultaMultipleProductosNI.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMultipleProductosInternoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultipleProductosInterno/xq/sjConsultaMultipleProductosNIIn/";

declare function xf:sjConsultaMultipleProductosNIIn($requestHeader as element(ns2:RequestHeader),
    $consultaMultipleProductosInterno as element(ns1:consultaMultipleProductosInterno))
    as element(ns0:sjConsultaMultipleProductosNI) {
        <ns0:sjConsultaMultipleProductosNI>
            <ns0:USERNAME>{ data($requestHeader/Authentication/UserName) }</ns0:USERNAME>
            <ns0:PASSWORD>{ data($requestHeader/Authentication/Password) }</ns0:PASSWORD>
            {
                for $PRODUCTS in $consultaMultipleProductosInterno/PRODUCTS
                return
                    <ns0:PRODUCTS>
                        {
                            for $PRODUCT in $PRODUCTS/PRODUCT
                            return
                                <ns0:PRODUCT>
                                    {
                                        for $ID in $PRODUCT/ID
                                        return
                                            <ns0:ID>{ data($ID) }</ns0:ID>
                                    }
                                    {
                                        for $TYPE in $PRODUCT/TYPE
                                        return
                                            <ns0:TYPE>{ data($TYPE) }</ns0:TYPE>
                                    }
                                </ns0:PRODUCT>
                        }
                    </ns0:PRODUCTS>
            }
        </ns0:sjConsultaMultipleProductosNI>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaMultipleProductosInterno as element(ns1:consultaMultipleProductosInterno) external;

xf:sjConsultaMultipleProductosNIIn($requestHeader,
    $consultaMultipleProductosInterno)