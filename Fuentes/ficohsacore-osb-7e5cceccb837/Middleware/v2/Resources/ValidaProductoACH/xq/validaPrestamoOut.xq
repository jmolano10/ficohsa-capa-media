(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamoResponse" element="ns0:consultaGeneralPrestamoResponse" location="../../ConsultaGeneralPrestamo/xsd/consultaGeneralPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validaProductoACH" element="ns1:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validaProductoACHResponse" location="../xsd/validaProductoACHTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/validaPrestamoOut/";

declare function xf:validaPrestamoOut($consultaGeneralPrestamoResponse as element(ns0:consultaGeneralPrestamoResponse),
    $validaProductoACH as element(ns1:validaProductoACH),
    $Type as xs:string)
    as element(ns1:validaProductoACHResponse) {
        <ns1:validaProductoACHResponse>
            {
                for $LOAN_CUSTOMER_NAME in $consultaGeneralPrestamoResponse/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/LOAN_CUSTOMER_NAME
                return
                    <PRODUCT_NAME>
                        {
                            let $First  := (substring(data($LOAN_CUSTOMER_NAME),1,3))  
                            let $Last  := (substring(data($LOAN_CUSTOMER_NAME), string-length(data($LOAN_CUSTOMER_NAME)) - 3 + 1, 3))  
                            return
                                if (data($LOAN_CUSTOMER_NAME) = '') then
                                    ('')
                                else 
                                    string-join(($First,$Last),'**********')
                        }
                    </PRODUCT_NAME>
            }
            {
                for $CURRENCY in $consultaGeneralPrestamoResponse/ns0:consultaGeneralPrestamoResponseType/ns0:consultaGeneralPrestamoResponseRecordType/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            <PRODUCT_STATUS>true</PRODUCT_STATUS>
            <UUID>{ data($validaProductoACH/UUID) }</UUID>
            {
                for $KV_PAIRS in $validaProductoACH/KV_PAIRS
                return
                    <KV_PAIRS>
                    { 
                    $KV_PAIRS/@* , $KV_PAIRS/node() 
                    }
                    </KV_PAIRS>
            }
        </ns1:validaProductoACHResponse>
};

declare variable $consultaGeneralPrestamoResponse as element(ns0:consultaGeneralPrestamoResponse) external;
declare variable $validaProductoACH as element(ns1:validaProductoACH) external;
declare variable $Type as xs:string external;

xf:validaPrestamoOut($consultaGeneralPrestamoResponse,
    $validaProductoACH,
    $Type)
