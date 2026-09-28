(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../Business_Resources/Ficopen/Resource/ConsultaFICOPEN/xsd/FICOPEN_OSB_K_CONSULTAFICOPEN_TOPLEVEL-24OSB_CON_FICOPEN.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaProductoOnBaseResponse" location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FICOPEN/OSB_K_CONSULTAFICOPEN/TOPLEVEL-24OSB_CON_FICOPEN/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/consultaProductoOnBaseFPCHNOut/";

declare function xf:consultaProductoOnBaseFPCHNOut($outputParameters as element(ns1:OutputParameters),
    $moneda as xs:string)
    as element(ns0:consultaProductoOnBaseResponse) {
        <ns0:consultaProductoOnBaseResponse>
            <PRODUCT_NAME>{ data($outputParameters/ns1:CUSTOMER_NAME) }</PRODUCT_NAME>
            <CURRENCY>{ $moneda }</CURRENCY>
            <OPENING_DATE>{ data($outputParameters/ns1:START_DATE_RESP) }</OPENING_DATE>
        </ns0:consultaProductoOnBaseResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $moneda as xs:string external;

xf:consultaProductoOnBaseFPCHNOut($outputParameters,
    $moneda)