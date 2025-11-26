xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/GetAccountBS/XMLSchema_374328230.xsd" ::)

declare variable $getDetailAccountResponse as element() (:: schema-element(ns1:ConsultadedetallesdelacuentaResponse) ::) external;

declare function local:func($getDetailAccountResponse as element() (:: schema-element(ns1:ConsultadedetallesdelacuentaResponse) ::)) as xs:string {
    if (fn:string($getDetailAccountResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID/text()) != "") then (
        	fn:string($getDetailAccountResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID/text())
        ) else (
        	fn:string($getDetailAccountResponse/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID/text())
        )
};

local:func($getDetailAccountResponse)