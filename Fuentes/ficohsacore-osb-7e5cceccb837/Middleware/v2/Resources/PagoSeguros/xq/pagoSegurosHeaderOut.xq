(:: pragma bea:global-element-parameter parameter="$transfmodelbankentrecuentasResponse1" element="ns0:TransfmodelbankentrecuentasResponse" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoSeguros/xq/pagoSegurosHeaderOut/";

declare function xf:pagoSegurosHeaderOut($transfmodelbankentrecuentasResponse1 as element(ns0:TransfmodelbankentrecuentasResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $transfmodelbankentrecuentasResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $transfmodelbankentrecuentasResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
        </ns1:ResponseHeader>
};

declare variable $transfmodelbankentrecuentasResponse1 as element(ns0:TransfmodelbankentrecuentasResponse) external;

xf:pagoSegurosHeaderOut($transfmodelbankentrecuentasResponse1)