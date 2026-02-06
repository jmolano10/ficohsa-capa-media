xquery version "2004-draft";
(:: pragma  parameter="$resultGroup" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaListasClienteResponse" location="../xsd/sjConsultaListasClienteGT.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaListasClienteGT/xq/sjConsultaListasClienteGTOut/";

declare function xf:sjConsultaListasClienteGTOut($resultGroup as element(*))
    as element(ns0:sjConsultaListasClienteResponse) {
        <ns0:sjConsultaListasClienteResponse>
        {
        	for $listItem in $resultGroup/ITEM
        	return(
        		<ns0:consultaListaClienteResponse>
                	<ns0:successIndicator>{ fn:data($listItem/STATUS) }</ns0:successIndicator>
                	{
                		for $messages in $listItem/MESSAGE
                		return
                		<ns0:messages>{ fn:data($messages) }</ns0:messages>
                	}
                	<ns0:ASSOCIATION_NAME>{ fn:data($listItem/ASSOCIATION_NAME) }</ns0:ASSOCIATION_NAME>
            	</ns0:consultaListaClienteResponse>
        	)
        }
        </ns0:sjConsultaListasClienteResponse>
};

declare variable $resultGroup as element(*) external;

xf:sjConsultaListasClienteGTOut($resultGroup)