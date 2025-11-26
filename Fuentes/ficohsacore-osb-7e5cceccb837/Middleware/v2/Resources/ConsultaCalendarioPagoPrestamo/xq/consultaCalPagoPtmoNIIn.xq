(:: pragma bea:global-element-parameter parameter="$consultaCalendarioPagoPrestamo1" element="ns2:consultaCalendarioPagoPrestamo" location="../../../../Business_Resources/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamo/consultaCalendarioPagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$opConsultaPrestamoRespuesta1" element="ns5:opConsultaPrestamoRespuesta" location="../../../BusinessServices/CTS/prestamo/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns4:opConsultaCuotaPrestamoSolicitud" location="../../../BusinessServices/CTS/consultaCuotaPagoPrestamo/xsd/services.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaCalendarioPagoPrestamoTypes";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns4 = "http://service.srvaplcobisconsultaprestamo.ecobis.cobiscorp";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns0 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCalendarioPagoPrestamo/xq/consultaCalPagoPtmoNIIn/";

declare variable $stringDate as xs:string external;
declare function xf:consultaCalPagoPtmoNIIn($consultaCalendarioPagoPrestamo1 as element(ns2:consultaCalendarioPagoPrestamo))
    as element(ns4:opConsultaCuotaPrestamoSolicitud) {
        <ns4:opConsultaCuotaPrestamoSolicitud>
            <ns1:consultaCuotaPrestamo>
            	<ns1:canal>1</ns1:canal>
                <ns1:loanNumber>{ data($consultaCalendarioPagoPrestamo1/LOAN_ID) }</ns1:loanNumber>
                { 
	            	if (data($consultaCalendarioPagoPrestamo1/PAGING_INFO/PAGING/text()) = "YES") then
	            		<ns1:paging>S</ns1:paging>
	            	else
	            		""
	            }
	            { 
	            	if (data($consultaCalendarioPagoPrestamo1/PAGING_INFO/PAGING/text()) = "YES") then
	            		<ns1:initialRecord> { xs:int(data($consultaCalendarioPagoPrestamo1/PAGING_INFO/INITIAL_RECORD))}</ns1:initialRecord>	            		
	            	else
	            		""
	            }
	            	            { 
	            	if (data($consultaCalendarioPagoPrestamo1/PAGING_INFO/PAGING/text()) = "YES") then
	            		<ns1:pageSize>{ xs:int(data($consultaCalendarioPagoPrestamo1/PAGING_INFO/RECORD_COUNT))}</ns1:pageSize>            		
	            	else
	            		""
	            }	           
            </ns1:consultaCuotaPrestamo>
        </ns4:opConsultaCuotaPrestamoSolicitud>
};

declare variable $consultaCalendarioPagoPrestamo1 as element(ns2:consultaCalendarioPagoPrestamo) external;

xf:consultaCalPagoPtmoNIIn($consultaCalendarioPagoPrestamo1)