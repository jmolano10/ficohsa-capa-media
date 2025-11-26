(:: pragma bea:local-element-parameter parameter="$fUNDSTRANSFERType1" type="ns1:VentadeinventariocondbctaResponse/FUNDSTRANSFERType" location="../../../BusinessServices/T24/ventaInventario/xsd/XMLSchema_-2134013027.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeinventarioenagenciaResponse1" element="ns1:ConsultadeinventarioenagenciaResponse" location="../../../BusinessServices/T24/ventaInventario/xsd/XMLSchema_-2134013027.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ventaInventarioResponse" location="../xsd/ventaInventarioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ventaInventarioTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VentaInventario/xq/ventaInventarioOut/";

declare function xf:ventaInventarioOut($fUNDSTRANSFERType1 as element(),
    $consultadeinventarioenagenciaResponse1 as element(ns1:ConsultadeinventarioenagenciaResponse),
    $branchCode as xs:string)
    as element(ns0:ventaInventarioResponse) {
        <ns0:ventaInventarioResponse>
            <STOCK_CODE>{ data($fUNDSTRANSFERType1/gLR.STK.CODE/mLR.STK.CODE[1]/LRSTKCODE) }</STOCK_CODE>
            <DESCRIPTION>{ data($consultadeinventarioenagenciaResponse1/WSSTOCKDETAILType[1]/STOCKDESCRIPTION) }</DESCRIPTION>
            <UNIT_PRICE>{ data($fUNDSTRANSFERType1/gLR.STK.CODE/mLR.STK.CODE[1]/LRUNITPRICE) }</UNIT_PRICE>
            <QUANTITY>{ data($fUNDSTRANSFERType1/gLR.STK.CODE/mLR.STK.CODE[1]/LRPRODQUANT) }</QUANTITY>
            <TOTAL_AMOUNT>{ data($fUNDSTRANSFERType1/LOCAMTDEBITED) }</TOTAL_AMOUNT>
            <PICKUP_BRANCH>{ data($consultadeinventarioenagenciaResponse1/WSSTOCKDETAILType[1]/gWSSTOCKDETAILDetailType/mWSSTOCKDETAILDetailType[BRANCHCODE=$branchCode]/AGENCIANAME) }</PICKUP_BRANCH>
        </ns0:ventaInventarioResponse>
};

declare variable $fUNDSTRANSFERType1 as element() external;
declare variable $consultadeinventarioenagenciaResponse1 as element(ns1:ConsultadeinventarioenagenciaResponse) external;
declare variable $branchCode as xs:string external;

xf:ventaInventarioOut($fUNDSTRANSFERType1,
    $consultadeinventarioenagenciaResponse1,
    $branchCode)