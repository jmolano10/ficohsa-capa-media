(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/consultaInformacionLaboral/xsd/consultaInformacionLaboralFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInformacionLaboralResponse" location="../xsd/consultaInformacionLaboralTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInformacionLaboralFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInformacionLaboral/xq/consultaInformacionLaboralOut_HNFPC/";

declare function local:format-date-from-FPC($textdate as xs:string) as xs:string
{
	fn:concat(fn:substring($textdate,1,4),fn:substring($textdate,6,2),fn:substring($textdate,9,2),fn:substring($textdate,12,2),fn:substring($textdate,15,2),fn:substring($textdate,18,2))
};

declare function xf:consultaInformacionLaboralOut_HNFPC($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaInformacionLaboralResponse) {
        <ns0:consultaInformacionLaboralResponse>
            <ns0:JOB_INFO_HISTORY>
                {
                    for $PT_HIST_LABORAL_ITEM in $outputParameters1/ns1:PT_HIST_LABORAL/ns1:PT_HIST_LABORAL_ITEM
                    return
                        <ns0:JOB_INFO_HISTORY_ITEM>
                            <ns0:CUSTOMER_ACCOUNT>{ data($PT_HIST_LABORAL_ITEM/ns1:COD_CUENTA_FO) }</ns0:CUSTOMER_ACCOUNT>
                            <ns0:STATUS>{ data($PT_HIST_LABORAL_ITEM/ns1:ESTADO) }</ns0:STATUS>
                            <ns0:START_DATE/>			            
			            {
			            if (fn:empty($PT_HIST_LABORAL_ITEM/ns1:FEC_SALIDA) or fn:empty($PT_HIST_LABORAL_ITEM/ns1:FEC_SALIDA/text())) then
            				<ns0:END_DATE/>
            			else                                        
                            <ns0:END_DATE>{ local:format-date-from-FPC(data($PT_HIST_LABORAL_ITEM/ns1:FEC_SALIDA))} </ns0:END_DATE>
                        }
                            <ns0:PAYMENT_PERIOD>{ data($PT_HIST_LABORAL_ITEM/ns1:NUM_PERIODO) }</ns0:PAYMENT_PERIOD>
                            <ns0:EMPLOYER_CODE>{ data($PT_HIST_LABORAL_ITEM/ns1:COD_PATRONO) }</ns0:EMPLOYER_CODE>
                            <ns0:EMPLOYER_NAME>{ data($PT_HIST_LABORAL_ITEM/ns1:NOM_PATRONO) }</ns0:EMPLOYER_NAME>
                            <ns0:EMPLOYER_RTN>{ data($PT_HIST_LABORAL_ITEM/ns1:RTN_PATRONO) }</ns0:EMPLOYER_RTN>
                            <ns0:BALANCE_TYPE>{ data($PT_HIST_LABORAL_ITEM/ns1:TIP_INGRESO) }</ns0:BALANCE_TYPE>
                            <ns0:PAYMENT_AMOUNT>{ data($PT_HIST_LABORAL_ITEM/ns1:MONTO_PAGADO) }</ns0:PAYMENT_AMOUNT>
                            <ns0:SALARY_CURRENCY/>
                            <ns0:SALARY_AMOUNT>{ data($PT_HIST_LABORAL_ITEM/ns1:SALARIO) }</ns0:SALARY_AMOUNT>
                            <ns0:OCCUPATION_CODE/>
                            <ns0:OCCUPATION_DESC>{ data($PT_HIST_LABORAL_ITEM/ns1:OCUPACION) }</ns0:OCCUPATION_DESC>
                            <ns0:JOB_TITLE_CODE/>
                            <ns0:JOB_TITLE_DESC>{ data($PT_HIST_LABORAL_ITEM/ns1:PUESTO) }</ns0:JOB_TITLE_DESC>
                        </ns0:JOB_INFO_HISTORY_ITEM>
                }
            </ns0:JOB_INFO_HISTORY>
        </ns0:consultaInformacionLaboralResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaInformacionLaboralOut_HNFPC($outputParameters1)