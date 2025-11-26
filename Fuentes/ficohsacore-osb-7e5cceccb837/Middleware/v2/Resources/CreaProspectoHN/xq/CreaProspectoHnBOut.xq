(:: pragma bea:global-element-parameter parameter="$creaciondeclienteprospectoResponse1" element="ns0:NewProspectResponse" location="../../../BusinessServices/T24/CreaProspecto/xsd/XMLSchema_435747315.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creaProspectoResponse" location="../../CreaProspecto/xsd/creaProspectoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creaProspectoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaProspectoHN/xq/creaProspectoHnBOut/";

declare function xf:creaProspectoHnBOut($creaciondeclienteprospectoResponse1 as element(ns0:NewProspectResponse))
    as element(ns1:creaProspectoResponse) {
        <ns1:creaProspectoResponse>
            <ns1:CUSTOMER_ID>{ data($creaciondeclienteprospectoResponse1/CUSTOMERType/@id) }</ns1:CUSTOMER_ID>
            <ns1:CUSTOMER_NAME>{ concat($creaciondeclienteprospectoResponse1/CUSTOMERType/gSHORTNAME/SHORTNAME[1]) }</ns1:CUSTOMER_NAME>
        </ns1:creaProspectoResponse>
};

declare variable $creaciondeclienteprospectoResponse1 as element(ns0:NewProspectResponse) external;

xf:creaProspectoHnBOut($creaciondeclienteprospectoResponse1)