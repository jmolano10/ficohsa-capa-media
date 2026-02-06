xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaFinanciamientosCliente" element="ns0:consultaFinanciamientosCliente" location="../xsd/consultaFinanciamientosClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/MasterDataHN/conListadoPrestamos/xsd/conListadoPrestamos_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFinanciamientosClienteTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conListadoPrestamos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinanciamientosCliente/xq/conListadoPrestamosHN/";

declare function xf:conListadoPrestamosHN($consultaFinanciamientosCliente as element(ns0:consultaFinanciamientosCliente),
    $COUNTRY as xs:string,
    $TYPE as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:Pais>{ $COUNTRY }</ns2:Pais>
            <ns2:NumeroB>{ data($consultaFinanciamientosCliente/SEARCH_VALUE) }</ns2:NumeroB>
            {
            	 for $LOGO in $consultaFinanciamientosCliente/LOGO
            	 return
                	<ns2:Logo>{ data($LOGO) }</ns2:Logo>
            }    
            <ns2:Tipo>{ data($TYPE) }</ns2:Tipo>
            <ns2:TipoProducto>{ data($consultaFinanciamientosCliente/PRODUCT_TYPE) }</ns2:TipoProducto>
            <ns2:Orden>
            	{
	            	if(data($consultaFinanciamientosCliente/KV_PAIRS/KV_PAIR[fn:upper-case(KEY) = "ORDER_RECORDS"]/VALUE) = "A")then(
	            		"A"
	            	)else if(data($consultaFinanciamientosCliente/KV_PAIRS/KV_PAIR[fn:upper-case(KEY) = "ORDER_RECORDS"]/VALUE) = "D")then(
	            		"D"
	            	)else("")
            	}
            </ns2:Orden>
        </ns2:InputParameters>
};

declare variable $consultaFinanciamientosCliente as element(ns0:consultaFinanciamientosCliente) external;
declare variable $COUNTRY as xs:string external;
declare variable $TYPE as xs:string external;

xf:conListadoPrestamosHN($consultaFinanciamientosCliente,
    $COUNTRY,
    $TYPE)