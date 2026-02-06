xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$updateProspectResponse1" element="ns0:UpdateProspectResponse" location="../../../BusinessServices/T24/ActualizaProspecto/xsd/svcUpdateProspect_1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:actualizaProspectoResponse" location="../../ActualizaProspecto/xsd/actualizaProspectoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaProspectoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaProspectoHN/xq/actualizaProspectoHnBOut/";

declare function xf:actualizaProspectoHnBOut($updateProspectResponse1 as element(ns0:UpdateProspectResponse))
    as element(ns1:actualizaProspectoResponse) {
        <ns1:actualizaProspectoResponse>
            <ns1:CUSTOMER_ID>{ data($updateProspectResponse1/CUSTOMERType/@id) }</ns1:CUSTOMER_ID>
            <ns1:CUSTOMER_NAME>{ concat($updateProspectResponse1/CUSTOMERType/gSHORTNAME/SHORTNAME[1]) }</ns1:CUSTOMER_NAME>
        </ns1:actualizaProspectoResponse>
};

declare variable $updateProspectResponse1 as element(ns0:UpdateProspectResponse) external;

xf:actualizaProspectoHnBOut($updateProspectResponse1)