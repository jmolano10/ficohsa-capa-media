(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/eliminarDeudoresDepRef/xsd/eliminarDeudoresDepRef_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarDeudoresDepRef";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/eliminarDeudoresDepRef/xq/eliminarDeudoresDepRefHeaderOut/";

declare function xf:eliminarDeudoresDepRefHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>
            	{
                    if (data($outputParameters1/ns1:PV_CODIGOMENSAJE) = "SUCCESS") then
                        ("Success")
                    else 
                        data($outputParameters1/ns1:PV_CODIGOMENSAJE)
                }
			</successIndicator>
            {
                for $PV_DESCRIPCIONMENSAJE in $outputParameters1/ns1:PV_DESCRIPCIONMENSAJE
                return
                    <messages>{ data($PV_DESCRIPCIONMENSAJE) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:eliminarDeudoresDepRefHeaderOut($outputParameters1)