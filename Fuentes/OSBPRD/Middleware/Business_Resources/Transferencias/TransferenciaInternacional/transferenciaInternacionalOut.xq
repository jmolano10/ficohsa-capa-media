(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalResponse" element="ns1:TransferenciaInternacionalResponse" location="../Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns0:transferenciaInternacionalResponse" location="transferenciaInternacionalType.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciaInternacional/transferenciaInternacionalOut/";

declare function xf:transferenciaInternacionalOut($transferenciaInternacionalResponse as element(ns1:TransferenciaInternacionalResponse))
    as element(ns0:transferenciaInternacionalResponse) {
        <ns0:transferenciaInternacionalResponse>
        {
        	if (fn:string($transferenciaInternacionalResponse/Status/successIndicator/text()) = "Success") then (
                <ORDERING_CUSTOMER>{ data($transferenciaInternacionalResponse/FUNDSTRANSFERType/gORDERINGCUST/ORDERINGCUST) }</ORDERING_CUSTOMER>
            
        	) else ()
        }
        </ns0:transferenciaInternacionalResponse>
};

declare variable $transferenciaInternacionalResponse as element(ns1:TransferenciaInternacionalResponse) external;

xf:transferenciaInternacionalOut($transferenciaInternacionalResponse)