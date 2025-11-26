(:: pragma bea:global-element-parameter parameter="$registraVentaMenor" element="ns1:registraVentaMenor" location="../xsd/registraVentaMenorTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DCP/registrarVentaMenor/xsd/registraVentaMenor_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraVentaMenor";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registraVentaMenorTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraVentaMenor/xq/registraVentaMenorIn/";

declare function xf:registraVentaMenorIn($registraVentaMenor as element(ns1:registraVentaMenor))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PVDD>{ data($registraVentaMenor/DESTINATION_CURRENCY) }</ns0:PVDD>
            <ns0:PVMT>{ data($registraVentaMenor/FOREIGN_AMOUNT) }</ns0:PVMT>
            <ns0:PVIC>{ data($registraVentaMenor/LEGAL_ID) }</ns0:PVIC>
            <ns0:PVCC>{ data($registraVentaMenor/CUSTOMER_ID) }</ns0:PVCC>
            <ns0:PVFC>{ data($registraVentaMenor/TRANSACTION_DATE) }</ns0:PVFC>
            <ns0:PTCM>{ data($registraVentaMenor/EXCHANGE_RATE) }</ns0:PTCM>
            <ns0:PVMN>{ data($registraVentaMenor/LOCAL_AMOUNT) }</ns0:PVMN>
            <ns0:PVUB>{ data($registraVentaMenor/USER_ID) }</ns0:PVUB>
            <ns0:PVAB>{ data($registraVentaMenor/BRANCH) }</ns0:PVAB>
            <ns0:PTRX>{ data($registraVentaMenor/TRANSACTION_ID) }</ns0:PTRX>
            <ns0:PRODUCT_NUMBER>{ data($registraVentaMenor/PRODUCT_NUMBER) }</ns0:PRODUCT_NUMBER>
        </ns0:InputParameters>
};

declare variable $registraVentaMenor as element(ns1:registraVentaMenor) external;

xf:registraVentaMenorIn($registraVentaMenor)