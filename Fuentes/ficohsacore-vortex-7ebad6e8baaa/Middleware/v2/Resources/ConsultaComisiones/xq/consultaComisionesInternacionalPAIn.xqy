xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaComisiones" element="ns0:consultaComisiones" location="../xsd/consultaComisionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaComisionSwift" location="../../ConsultaComisionSwift/xsd/consultaComisionSwiftTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionSwiftTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionesInternacionalPAIn/";

declare function xf:consultaComisionesInternacionalPAIn($consultaComisiones as element(ns0:consultaComisiones))
    as element(ns1:consultaComisionSwift) {
        <ns1:consultaComisionSwift>
            <CUSTOMER_ID>{ data($consultaComisiones/CUSTOMER_ID) }</CUSTOMER_ID>
            <DESTINATION_COUNTRY>{ data($consultaComisiones/ADDITIONAL_INFO/INFO[NAME="DESTINATION_COUNTRY"]/VALUE) }</DESTINATION_COUNTRY>
            <TRANSFER_CURRENCY>{ data($consultaComisiones/DESTINATION_CURRENCY) }</TRANSFER_CURRENCY>
        </ns1:consultaComisionSwift>
};

declare variable $consultaComisiones as element(ns0:consultaComisiones) external;

xf:consultaComisionesInternacionalPAIn($consultaComisiones)