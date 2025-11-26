(:: pragma bea:global-element-parameter parameter="$tellerPassbookEnquiryResponse" element="ns0:TellerPassbookEnquiryResponse" location="../../xsds/BkFicPBookEnq/XMLSchema_-1374990530.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ActualizacionLibretaAhorro/ObtenerCantidadRegistrosPorImprimir/";

declare function xf:ObtenerCantidadRegistrosPorImprimir($tellerPassbookEnquiryResponse as element(ns0:TellerPassbookEnquiryResponse))
    as xs:string {
        fn:string(count($tellerPassbookEnquiryResponse/NOFILETTTWSEXPType[1]/gNOFILETTTWSEXPDetailType/mNOFILETTTWSEXPDetailType[fn:string(./TXNAMOUNT/text())!= ""]))
};

declare variable $tellerPassbookEnquiryResponse as element(ns0:TellerPassbookEnquiryResponse) external;

xf:ObtenerCantidadRegistrosPorImprimir($tellerPassbookEnquiryResponse)