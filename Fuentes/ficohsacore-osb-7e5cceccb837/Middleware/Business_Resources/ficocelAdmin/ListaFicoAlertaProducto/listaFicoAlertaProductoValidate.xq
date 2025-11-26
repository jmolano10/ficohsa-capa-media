(:: pragma bea:global-element-parameter parameter="$listaFicoAlertaProducto" element="ns0:listaFicoAlertaProducto" location="listaFicoAlertaProductoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/listaFicoAlertaProductoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/ListaFicoAlertaProducto/listaFicoAlertaProducto/";

declare function xf:listaFicoAlertaProducto($listaFicoAlertaProducto as element(ns0:listaFicoAlertaProducto))
    as xs:string {
        if (fn:string($listaFicoAlertaProducto/PRODUCT_ID/text()) = "") then (
       		"REQUIRED FIELDS NOT SUPPLIED"
       
       	) else if (not(fn:string($listaFicoAlertaProducto/ACTIVE_ALERTS_YES_NO/text()) = ("YES","NO",""))) then (
       		"ACTIVE_ALERTS_YES_NO NOT SUPPORTED"	
       		
       	) else (
       		""
       	)
};

declare variable $listaFicoAlertaProducto as element(ns0:listaFicoAlertaProducto) external;

xf:listaFicoAlertaProducto($listaFicoAlertaProducto)