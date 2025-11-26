(:: pragma bea:global-element-parameter parameter="$actualizardatosdeclienteResponse1" element="ns0:ActualizardatosdeclienteResponse" location="../../../BusinessServices/actualizaDatosCliente/xsd/XMLSchema_1014999265.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaDatosCliente/xq/actualizaDatosClienteHeaderOut/";

declare function xf:actualizaDatosClienteHeaderOut($actualizardatosdeclienteResponse1 as element(ns0:ActualizardatosdeclienteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $actualizardatosdeclienteResponse1/Status/successIndicator
                return
                    if ($actualizardatosdeclienteResponse1/Status/messages != "LIVE RECORD NOT CHANGED") then (
                    	<successIndicator>{ data($successIndicator) }</successIndicator>
                    )
                    else (
                    	<successIndicator>Success</successIndicator>
                    )
            }
            {
                for $messages in $actualizardatosdeclienteResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $actualizardatosdeclienteResponse1 as element(ns0:ActualizardatosdeclienteResponse) external;

xf:actualizaDatosClienteHeaderOut($actualizardatosdeclienteResponse1)