(:: pragma bea:global-element-parameter parameter="$getPassBookDetailsResponse" element="ns0:getPassBookDetailsResponse" location="../../xsds/BkFicCustRtn/XMLSchema_-517352168.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ActualizacionLibretaAhorro/ActualizacionLibretaAhorroHeaderOut/";

declare function xf:ActualizacionLibretaAhorroHeaderOut($getPassBookDetailsResponse as element(ns0:getPassBookDetailsResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $getPassBookDetailsResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $PBOOKSTATUS in $getPassBookDetailsResponse/PassBookRspType/PBOOKSTATUS
                return
                    <messages>{ data($PBOOKSTATUS) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $getPassBookDetailsResponse as element(ns0:getPassBookDetailsResponse) external;

xf:ActualizacionLibretaAhorroHeaderOut($getPassBookDetailsResponse)