xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$prestamosResponse" element="ns1:OutputParameters" location="../Resources/ConsultaListaPrestamos/xsd/ORA_BANK_OSB_K_CONSULTALISTAPRESTAMOS_TOPLEVEL-24OSB_CON_LISTA_PRESTA.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$tarjetasCreditoResponse" element="ns0:TarjetasdecreditoporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPasivosClienteHeaderOut/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTALISTAPRESTAMOS/TOPLEVEL-24OSB_CON_LISTA_PRESTA/";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:consultaPasivosClienteHeaderOut($prestamosResponse as element(ns1:OutputParameters),
    $tarjetasCreditoResponse as element(ns0:TarjetasdecreditoporclienteResponse))
    as element(ns2:ResponseHeader) {
        <ns2:ResponseHeader>
            {
                let $successIndicatorPrestamo := $prestamosResponse/ns1:ERROR_CODE,
                    $successIndicatorTC := $tarjetasCreditoResponse/Status/successIndicator
                return
                	if ( data($successIndicatorPrestamo) != "SUCCESS" and data($successIndicatorTC) != "Success") then (
                    	<successIndicator>ERROR</successIndicator>,
                    	for $messages in $tarjetasCreditoResponse/Status/messages union $prestamosResponse/ns1:ERROR_MESSAGE
                    	return
                    		<messages>{data($messages)}</messages> 
                    ) else (
                    	let $prestamos := count($prestamosResponse/ns1:LIABILITY_NUMBER/ns1:ITEM)
                    	let $tcs := count($tarjetasCreditoResponse/FICOLISTCLIENTCARDCPType/gFICOLISTCLIENTCARDCPDetailType/mFICOLISTCLIENTCARDCPDetailType)
                    	return 
		                    if ( (number($prestamos) + number($tcs) ) > 0 ) then (
		                    	<successIndicator>Success</successIndicator>
		                    ) else (
		                    	<successIndicator>NO RECORDS</successIndicator>,
		                    	for $messages in $prestamosResponse/ns1:ERROR_MESSAGE union $tarjetasCreditoResponse/Status/messages
		                    	return
		                    		<messages>{data($messages)}</messages>		                    
		                    )
                    )
            }
        </ns2:ResponseHeader>
};

declare variable $prestamosResponse as element(ns1:OutputParameters) external;
declare variable $tarjetasCreditoResponse as element(ns0:TarjetasdecreditoporclienteResponse) external;

xf:consultaPasivosClienteHeaderOut($prestamosResponse,
    $tarjetasCreditoResponse)