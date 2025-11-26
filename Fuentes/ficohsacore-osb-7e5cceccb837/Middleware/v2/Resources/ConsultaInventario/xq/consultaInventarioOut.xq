(:: pragma bea:global-element-parameter parameter="$consultadetalleinventarioResponse1" element="ns1:ConsultadetalleinventarioResponse" location="../../../BusinessServices/T24/ventaInventario/xsd/XMLSchema_-2134013027.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInventarioResponse" location="../xsd/consultaInventarioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInventarioTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInventario/xq/consultaInventarioOut/";

declare function xf:consultaInventarioOut($consultadetalleinventarioResponse1 as element(ns1:ConsultadetalleinventarioResponse))
    as element(ns0:consultaInventarioResponse) {
    	if (fn:string($consultadetalleinventarioResponse1/Status/successIndicator/text()) = "Success" and 
    		fn:string($consultadetalleinventarioResponse1/WSINVENTORYType[1]/ZERORECORDS/text()) = "") then (
	        <ns0:consultaInventarioResponse>
	            <consultaInventarioResponseType>
	                {
	                        for $mWSINVENTORYDetailType in $consultadetalleinventarioResponse1/WSINVENTORYType[1]/gWSINVENTORYDetailType/mWSINVENTORYDetailType
	                        return
	                            <consultaInventarioResponseRecordType>
	                                {
	                                    for $ID in $mWSINVENTORYDetailType/ID
	                                    return
	                                        <STOCK_CODE>{ data($ID) }</STOCK_CODE>
	                                }
	                                {
	                                    for $DESCRIPTION in $mWSINVENTORYDetailType/DESCRIPTION
	                                    return
	                                        <DESCRIPTION>{ data($DESCRIPTION) }</DESCRIPTION>
	                                }
	                                {
	                                    for $SALEPRICE in $mWSINVENTORYDetailType/SALEPRICE
	                                    return
	                                        <UNIT_PRICE>{ data($SALEPRICE) }</UNIT_PRICE>
	                                }
	                            </consultaInventarioResponseRecordType>
	                }
	            </consultaInventarioResponseType>
	        </ns0:consultaInventarioResponse>
	    ) else (
	    	<ns0:consultaInventarioResponse/>
	    )
};

declare variable $consultadetalleinventarioResponse1 as element(ns1:ConsultadetalleinventarioResponse) external;

xf:consultaInventarioOut($consultadetalleinventarioResponse1)