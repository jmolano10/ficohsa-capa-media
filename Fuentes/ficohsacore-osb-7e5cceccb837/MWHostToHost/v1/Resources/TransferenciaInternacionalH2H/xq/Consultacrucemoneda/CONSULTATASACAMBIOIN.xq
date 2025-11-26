(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalH2HRequest" element="ns0:transferenciaInternacionalH2HRequest" location="../../xsd/transferenciaInternacionalH2HTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTasaCambio" location="../../../../../../Middleware/Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalH2HType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/TransferenciaInternacionalH2H/xq/Consultacrucemoneda/CONSULTATASACAMBIOIN/";

declare function xf:CONSULTATASACAMBIOIN($transferenciaInternacionalH2HRequest as element(ns0:transferenciaInternacionalH2HRequest))
    as element(ns1:consultaTasaCambio) {
        <ns1:consultaTasaCambio>
            <SOURCE_CURRENCY>{ data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT[1]/DEBIT_CURRENCY) }</SOURCE_CURRENCY>
            <TARGET_CURRENCY>{ data($transferenciaInternacionalH2HRequest/TRANSFERS_INT/TRANSFER_INT[1]/DESTINATION_CURRENCY) }</TARGET_CURRENCY>
        </ns1:consultaTasaCambio>
};

declare variable $transferenciaInternacionalH2HRequest as element(ns0:transferenciaInternacionalH2HRequest) external;

xf:CONSULTATASACAMBIOIN($transferenciaInternacionalH2HRequest)