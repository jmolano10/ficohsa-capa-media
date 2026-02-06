xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/ingresarDeudoresCliente/xsd/ingresarDeudoresCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ingresarDeudoresCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AfiliacionDeudores/xq/afiliacionDeudoresHNHeaderOut/";

declare function xf:afiliacionDeudoresHNHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	<successIndicator>
            	{
                    if (data($outputParameters/ns0:PV_CODIGOMENSAJE) = "SUCCESS") then
                        ("Success")
                    else 
                        data($outputParameters/ns0:PV_CODIGOMENSAJE)
                }
			</successIndicator>
            {
            	if (fn:string(data($outputParameters/ns0:PV_CODIGOMENSAJE/text())) != 'SUCCESS') then (
            		<messages>{ data($outputParameters/ns0:PV_DESCRIPCIONMENSAJE) }</messages>
            	) else ()
            }			
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:afiliacionDeudoresHNHeaderOut($outputParameters)