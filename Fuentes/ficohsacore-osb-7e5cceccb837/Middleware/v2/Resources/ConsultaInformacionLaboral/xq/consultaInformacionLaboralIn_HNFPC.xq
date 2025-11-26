(:: pragma bea:global-element-parameter parameter="$consultaInformacionLaboralRequest1" element="ns0:consultaInformacionLaboralRequest" location="../xsd/consultaInformacionLaboralTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/FPC/consultaInformacionLaboral/xsd/consultaInformacionLaboralFPC_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInformacionLaboralFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInformacionLaboral/xq/consultaInformacionLaboralIn_HNFPC/";


declare function local:format-date-FPC($textdate as xs:string) as xs:string
{
	fn:concat(fn:substring($textdate,1,4),'-',fn:substring($textdate,5,2),'-',fn:substring($textdate,7,2))
};

declare function xf:consultaInformacionLaboralIn_HNFPC($consultaInformacionLaboralRequest1 as element(ns0:consultaInformacionLaboralRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PC_COD_CTA>{ data($consultaInformacionLaboralRequest1/ns0:CUSTOMER_ACCOUNT) }</ns1:PC_COD_CTA>
            
            {
            if (fn:empty($consultaInformacionLaboralRequest1/ns0:FROM_DATE) or fn:empty($consultaInformacionLaboralRequest1/ns0:FROM_DATE/text())) then
            	<ns1:PD_FECHA_INICIO/>
            else 
            	<ns1:PD_FECHA_INICIO>{ local:format-date-FPC(data($consultaInformacionLaboralRequest1/ns0:FROM_DATE)) }</ns1:PD_FECHA_INICIO>
            }
			{
            if (fn:empty($consultaInformacionLaboralRequest1/ns0:TO_DATE) or fn:empty($consultaInformacionLaboralRequest1/ns0:TO_DATE/text())) then
            	<ns1:PD_FECHA_FIN/>
            else             
            	<ns1:PD_FECHA_FIN>{ local:format-date-FPC(data($consultaInformacionLaboralRequest1/ns0:TO_DATE)) }</ns1:PD_FECHA_FIN>
			}            	
        </ns1:InputParameters>
};

declare variable $consultaInformacionLaboralRequest1 as element(ns0:consultaInformacionLaboralRequest) external;

xf:consultaInformacionLaboralIn_HNFPC($consultaInformacionLaboralRequest1)