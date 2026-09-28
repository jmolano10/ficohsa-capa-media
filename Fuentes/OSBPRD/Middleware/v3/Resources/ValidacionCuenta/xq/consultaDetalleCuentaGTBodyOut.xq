(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../../v2/BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuentaResponse" location="../../../../Business_Resources/validacionCuenta/ValidacionCuenta/validacionCuentaType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionCuenta/xq/consultaDetalleCuentaGTBodyOut/";


declare function xf:consultaDetalleCuentaGTBodyOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:validacionCuentaResponse)    {
    
    if (fn:string($outputParameters1/ns0:ERROR_CODE/text()) = "SUCCESS") then (
        <ns1:validacionCuentaResponse>            
                    <ACCOUNT_NUMBER>{ data($outputParameters1/ns0:ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
                    <ACCOUNT_NAME>{ data($outputParameters1/ns0:ACCOUNT_NAME) }</ACCOUNT_NAME>
                    <CURRENCY>{ data($outputParameters1/ns0:CURRENCY) }</CURRENCY>                    
                    <ACCOUNT_STATUS>
                    {
                    if (fn:string($outputParameters1/ns0:RESTRICTIONS/text())= '' and fn:string($outputParameters1/ns0:INACTIVE_MARKER/text()) = '0') then
                    ("ACTIVE")
                    else if (fn:string($outputParameters1/ns0:RESTRICTIONS/text()) = '' and fn:string($outputParameters1/ns0:INACTIVE_MARKER/text()) != '0' )then
                    ("INACTIVE")
                   else if (fn:string($outputParameters1/ns0:RESTRICTIONS/text()) = 'ALL') then
                   ("INACTIVE")
                   else ("INACTIVE")
                     }
                    </ACCOUNT_STATUS>
        </ns1:validacionCuentaResponse>
        
         ) else (	    	
	    	<ns1:validacionCuentaResponse/>
         )   
	};
 
declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaDetalleCuentaGTBodyOut($outputParameters1)