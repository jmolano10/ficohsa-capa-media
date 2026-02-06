xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosPagoPrestamo1" element="ns1:consultaMovimientosPagoPrestamo" location="../xsd/consultaMovimientosPagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opConsultaPagoPrestamoSolicitud" location="../../../BusinessServices/CTS/consultaCuotaPagoPrestamo/xsd/services.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosPagoPrestamo/xq/consultaMovPagoPrestamoNIIn/";
declare namespace ns2 = "http://service.srvaplcobisconsultaprestamo.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosPagoPrestamoTypes";
declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";

declare function xf:consultaMovPagoPrestamoNIIn($consultaMovimientosPagoPrestamo1 as element(ns1:consultaMovimientosPagoPrestamo))
    as element(ns2:opConsultaPagoPrestamoSolicitud) {
        <ns2:opConsultaPagoPrestamoSolicitud>     	
            <ns0:consultaPagoPrestamo>
            <ns0:canal>1</ns0:canal>
            <ns0:loanNumber>{ data($consultaMovimientosPagoPrestamo1/ns1:LOAN_ID) }</ns0:loanNumber>
                { 
	            	if (data($consultaMovimientosPagoPrestamo1/ns1:PAGING_INFO/ns1:PAGING/text()) = "YES") then
	            		<ns0:paging>S</ns0:paging>
	            	else
	            		""
	            }
	            { 
	            	if (data($consultaMovimientosPagoPrestamo1/ns1:PAGING_INFO/ns1:PAGING/text()) = "YES") then
	            		<ns0:initialRecord> { xs:int(data($consultaMovimientosPagoPrestamo1/ns1:PAGING_INFO/ns1:INITIAL_RECORD))}</ns0:initialRecord>	            		
	            	else
	            		""
	            }
	            	            { 
	            	if (data($consultaMovimientosPagoPrestamo1/ns1:PAGING_INFO/ns1:PAGING/text()) = "YES") then
	            		<ns0:pageSize>{ xs:int(data($consultaMovimientosPagoPrestamo1/ns1:PAGING_INFO/ns1:RECORD_COUNT))}</ns0:pageSize>            		
	            	else
	            		""
	            }
          </ns0:consultaPagoPrestamo>
         </ns2:opConsultaPagoPrestamoSolicitud>     
};

declare variable $consultaMovimientosPagoPrestamo1 as element(ns1:consultaMovimientosPagoPrestamo) external;

xf:consultaMovPagoPrestamoNIIn($consultaMovimientosPagoPrestamo1)