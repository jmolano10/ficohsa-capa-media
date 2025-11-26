(:: pragma bea:global-element-parameter parameter="$consultadeinventarioenagenciaResponse1" element="ns1:ConsultadeinventarioenagenciaResponse" location="../../../BusinessServices/T24/ventaInventario/xsd/XMLSchema_-2134013027.xsd" ::)
(:: pragma bea:local-element-return type="ns0:consultaInventarioResponse/consultaInventarioResponseType/consultaInventarioResponseRecordType/STOCK_DETAILS" location="../xsd/consultaInventarioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInventarioTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInventario/xq/consultaDetalleInventarioOut/";

declare function xf:consultaDetalleInventarioOut($consultadeinventarioenagenciaResponse1 as element(ns1:ConsultadeinventarioenagenciaResponse))
    as element() {
        <STOCK_DETAILS>
            {
                for $mWSSTOCKDETAILDetailType in $consultadeinventarioenagenciaResponse1/WSSTOCKDETAILType[1]/gWSSTOCKDETAILDetailType/mWSSTOCKDETAILDetailType
                return
                    <STOCK_DETAIL>
                        {
                            for $BRANCHCODE in $mWSSTOCKDETAILDetailType/BRANCHCODE
                            return
                                <BRANCH_CODE>{ data($BRANCHCODE) }</BRANCH_CODE>
                        }
                        {
                            for $AVAILABLE in $mWSSTOCKDETAILDetailType/AVAILABLE
                            return
                                <STOCK_AMOUNT>{ data($AVAILABLE) }</STOCK_AMOUNT>
                        }
                    </STOCK_DETAIL>
            }
        </STOCK_DETAILS>
};

declare variable $consultadeinventarioenagenciaResponse1 as element(ns1:ConsultadeinventarioenagenciaResponse) external;

xf:consultaDetalleInventarioOut($consultadeinventarioenagenciaResponse1)