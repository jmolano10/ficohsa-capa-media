(:: pragma bea:global-element-parameter parameter="$consultaComisionesH2HRequest" element="ns1:consultaComisionesH2HRequest" location="../xsd/consultaComisionesH2HTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaComisiones" location="../../../../../Middleware/v2/Resources/ConsultaComisiones/xsd/consultaComisionesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesH2HTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaComisionesH2H/xq/consultaComisionesGTIn/";

declare function xf:consultaComisionesH2HIN($consultaComisionesH2HRequest as element(ns1:consultaComisionesH2HRequest))
    as element(ns0:consultaComisiones) {
        <ns0:consultaComisiones>
            <TRANSACTION_TYPE>{ data($consultaComisionesH2HRequest/TRANSACTION_TYPE) }</TRANSACTION_TYPE>
            <CUSTOMER_ID>{ data($consultaComisionesH2HRequest/CUSTOMER_ID) }</CUSTOMER_ID>
            <SOURCE_CURRENCY>{ data($consultaComisionesH2HRequest/SOURCE_CURRENCY) }</SOURCE_CURRENCY>
            <DESTINATION_CURRENCY>{ data($consultaComisionesH2HRequest/DESTINATION_CURRENCY) }</DESTINATION_CURRENCY>
            <ADDITIONAL_INFO>
                {
                    for $INFO in $consultaComisionesH2HRequest/ADDITIONAL_INFO/INFO
                    return
                        <INFO>
                            <NAME>{ data($INFO/NAME) }</NAME>
                            <VALUE>{ data($INFO/VALUE) }</VALUE>
                        </INFO>
                }
            </ADDITIONAL_INFO>
        </ns0:consultaComisiones>
};

declare variable $consultaComisionesH2HRequest as element(ns1:consultaComisionesH2HRequest) external;

xf:consultaComisionesH2HIN($consultaComisionesH2HRequest)