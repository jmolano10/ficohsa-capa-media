(:: pragma bea:global-element-parameter parameter="$pagoderecaudolocalylineadbctaResponse1" element="ns0:PagoderecaudolocalylineadbctaResponse" location="../../pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoCitiHeaderOut/";

declare function xf:pagoTarjetaCreditoCitiHeaderOut($pagoderecaudolocalylineadbctaResponse1 as element(ns0:PagoderecaudolocalylineadbctaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $pagoderecaudolocalylineadbctaResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $pagoderecaudolocalylineadbctaResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            <messages>{ fn:string-join($pagoderecaudolocalylineadbctaResponse1/Status/messages,";") }</messages>
            {
                for $CREDITVALUEDATE in $pagoderecaudolocalylineadbctaResponse1/FUNDSTRANSFERType/CREDITVALUEDATE
                return
                    <valueDate>{ data($CREDITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $pagoderecaudolocalylineadbctaResponse1 as element(ns0:PagoderecaudolocalylineadbctaResponse) external;

xf:pagoTarjetaCreditoCitiHeaderOut($pagoderecaudolocalylineadbctaResponse1)