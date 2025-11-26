(:: pragma bea:local-element-parameter parameter="$status1" type="ns1:VentadeinventariocondbctaResponse/Status" location="../../../BusinessServices/T24/ventaInventario/xsd/XMLSchema_-2134013027.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$fUNDSTRANSFERType1" type="ns1:VentadeinventariocondbctaResponse/FUNDSTRANSFERType" location="../../../BusinessServices/T24/ventaInventario/xsd/XMLSchema_-2134013027.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VentaInventario/xq/ventaInventarioHeaderOut/";

declare function xf:ventaInventarioHeaderOut($status1 as element(),
    $fUNDSTRANSFERType1 as element())
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $status1/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $status1/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $DEBITVALUEDATE in $fUNDSTRANSFERType1/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $status1 as element() external;
declare variable $fUNDSTRANSFERType1 as element() external;

xf:ventaInventarioHeaderOut($status1,
    $fUNDSTRANSFERType1)