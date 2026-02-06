xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaPasivosClienteResponse1" element="ns0:sjConsultaPasivosClienteResponse" location="../../../BusinessServices/SJS/consultaPasivosCliente/xsd/sjConsultaPasivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteHeaderOut/";

declare function xf:consultaPasivosClienteHeaderOut($sjConsultaPasivosClienteResponse1 as element(ns0:sjConsultaPasivosClienteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	<successIndicator>
            {

                let $SUCCESSIND_PRESTAMOS := fn:string($sjConsultaPasivosClienteResponse1/ns0:consultaPrestamosResponse/ns0:successIndicator/text())
                let $SUCCESSIND_TARJETAS := fn:string($sjConsultaPasivosClienteResponse1/ns0:consultaTarjetaCreditoResponse/ns0:successIndicator/text())
                let $SUCCESSIND_LCR := fn:string($sjConsultaPasivosClienteResponse1/ns0:consultaLCRResponse/ns0:successIndicator/text())
                return
                if (fn:upper-case($SUCCESSIND_PRESTAMOS) = "NO RECORDS" and
                fn:upper-case($SUCCESSIND_TARJETAS) = "-2" and fn:upper-case($SUCCESSIND_LCR) = "NO_RECORDS" ) then (
					"NO RECORDS"
				) else if (fn:upper-case($SUCCESSIND_PRESTAMOS)!= "SUCCESS" and
						fn:upper-case($SUCCESSIND_TARJETAS) != "-1" and fn:upper-case($SUCCESSIND_LCR) != "SUCCESS") then (
					"ERROR"
				) else (
					"Success" 
				)
            }
            </successIndicator>
        </ns1:ResponseHeader>
};

declare variable $sjConsultaPasivosClienteResponse1 as element(ns0:sjConsultaPasivosClienteResponse) external;

xf:consultaPasivosClienteHeaderOut($sjConsultaPasivosClienteResponse1)