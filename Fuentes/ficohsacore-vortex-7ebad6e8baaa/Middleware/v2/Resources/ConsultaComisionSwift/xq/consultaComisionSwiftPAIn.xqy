xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaComisionSwift" element="ns1:consultaComisionSwift" location="../xsd/consultaComisionSwiftTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaComsionSwift/xsd/consultaComisionSwift_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisionSwift";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionSwiftTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisionSwift/xq/consultaComisionSwiftPAIn/";

declare function xf:consultaComisionSwiftPAIn($consultaComisionSwift as element(ns1:consultaComisionSwift))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CUSTOMER_ID>{ data($consultaComisionSwift/CUSTOMER_ID) }</ns0:CUSTOMER_ID>
            <ns0:DESTINATION_COUNTRY>{ data($consultaComisionSwift/DESTINATION_COUNTRY) }</ns0:DESTINATION_COUNTRY>
            <ns0:TRANSFER_CURRENCY>{ data($consultaComisionSwift/TRANSFER_CURRENCY) }</ns0:TRANSFER_CURRENCY>
        </ns0:InputParameters>
};

declare variable $consultaComisionSwift as element(ns1:consultaComisionSwift) external;

xf:consultaComisionSwiftPAIn($consultaComisionSwift)