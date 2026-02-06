xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/ventaMenorHeaderOut/";

declare function xf:ventaMenorHeaderOut($codigoVenta as xs:string,
    $mensaje as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
        		if ($codigoVenta != '0') then
                	(
                    	<successIndicator>SUCCESS</successIndicator>
                    )
                    else
                    ( <successIndicator>ERROR</successIndicator> )
        	}
        	<messages>{ fn:string($mensaje) }</messages>
        </ns0:ResponseHeader>
};

declare variable $codigoVenta as xs:string external;
declare variable $mensaje as xs:string external;

xf:ventaMenorHeaderOut($codigoVenta,
    $mensaje)