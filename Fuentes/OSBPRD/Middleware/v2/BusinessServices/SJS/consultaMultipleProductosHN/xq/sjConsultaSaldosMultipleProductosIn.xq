(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosHN" element="ns1:sjConsultaMultipleProductosHN" location="../xsd/sjConsultaMultipleProductosHN.xsd" ::)
(:: pragma  parameter="$productosxTipo" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaSaldosMultipleProductos" location="../../consultaSaldosMultipleProductos/xsd/sjConsultaSaldosMultipleProductos.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosMultipleProductos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/sjConsultaSaldosMultipleProductosIn/";

declare function xf:sjConsultaSaldosMultipleProductosIn($sjConsultaMultipleProductosHN as element(ns1:sjConsultaMultipleProductosHN),
    $productosxTipo as element(*),$TYPE as xs:string)
    as element(ns0:sjConsultaSaldosMultipleProductos) {
        <ns0:sjConsultaSaldosMultipleProductos>
            {
                for $USERNAME in $sjConsultaMultipleProductosHN/ns1:USERNAME
                return
                    <ns0:USERNAME>{ data($USERNAME) }</ns0:USERNAME>
            }
            {
                for $PASSWORD in $sjConsultaMultipleProductosHN/ns1:PASSWORD
                return
                    <ns0:PASSWORD>{ data($PASSWORD) }</ns0:PASSWORD>
            }
            <ns0:TYPE>{ $TYPE }</ns0:TYPE>
            <ns0:PRODUCTS>
            	{
            		let $ids := $productosxTipo/ID
            		for $i in 1 to count($ids)
            		return
                		<ns0:ID>{string($ids[$i]/text())}</ns0:ID>
                }
            </ns0:PRODUCTS>
        </ns0:sjConsultaSaldosMultipleProductos>
};

declare variable $sjConsultaMultipleProductosHN as element(ns1:sjConsultaMultipleProductosHN) external;
declare variable $productosxTipo as element(*) external;
declare variable $TYPE as xs:string external;

xf:sjConsultaSaldosMultipleProductosIn($sjConsultaMultipleProductosHN,
    $productosxTipo,$TYPE)