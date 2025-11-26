(:: pragma bea:global-element-parameter parameter="$consultaInformacionLaboralResponse" element="ns0:consultaInformacionLaboralResponse" location="../../../BusinessServices/FPC/getEmploymentInformation12c/xsd/GetEmploymentInformation.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInformacionLaboralResponse" location="../xsd/consultaInformacionLaboralTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInformacionLaboral/xq/getEmploymentInformationHNOut/";

declare function xf:getEmploymentInformationHNOut($consultaInformacionLaboralResponse as element(ns0:consultaInformacionLaboralResponse))
    as element(ns0:consultaInformacionLaboralResponse) {
        <ns0:consultaInformacionLaboralResponse>
            <ns0:JOB_INFO_HISTORY>
           {
                for $item in $consultaInformacionLaboralResponse/ns0:JOB_INFO_HISTORY/ns0:JOB_INFO_HISTORY_ITEM
                return
                <ns0:JOB_INFO_HISTORY_ITEM>
                    <ns0:CUSTOMER_ACCOUNT>{ data($item/ns0:CUSTOMER_ACCOUNT) }</ns0:CUSTOMER_ACCOUNT>
                    <ns0:STATUS>{data($item/ns0:STATUS)}</ns0:STATUS>
                    <ns0:START_DATE/>
                    {
                     element ns0:END_DATE{ data($item/ns0:END_DATE) }
                    }
                    <ns0:PAYMENT_PERIOD>{ data($item/ns0:PAYMENT_PERIOD) }</ns0:PAYMENT_PERIOD>
                    <ns0:EMPLOYER_CODE>{ data($item/ns0:EMPLOYER_CODE) }</ns0:EMPLOYER_CODE>
                    <ns0:EMPLOYER_NAME>{ data($item/ns0:EMPLOYER_NAME) }</ns0:EMPLOYER_NAME>
                    <ns0:EMPLOYER_RTN>{ data($item/ns0:EMPLOYER_RTN) }</ns0:EMPLOYER_RTN>
                    <ns0:BALANCE_TYPE>{ data($item/ns0:BALANCE_TYPE) }</ns0:BALANCE_TYPE>
                    <ns0:PAYMENT_AMOUNT>{ data($item/ns0:PAYMENT_AMOUNT) }</ns0:PAYMENT_AMOUNT>
                    <ns0:SALARY_CURRENCY/>
                    <ns0:SALARY_AMOUNT>{ data($item/ns0:SALARY_AMOUNT) }</ns0:SALARY_AMOUNT>
                    <ns0:OCCUPATION_CODE/>
                    <ns0:OCCUPATION_DESC>{ data($item/ns0:OCCUPATION_DESC) }</ns0:OCCUPATION_DESC>
                    <ns0:JOB_TITLE_CODE/>
                    <ns0:JOB_TITLE_DESC>{ data($item/ns0:JOB_TITLE_DESC) }</ns0:JOB_TITLE_DESC>
                </ns0:JOB_INFO_HISTORY_ITEM>
           }
            </ns0:JOB_INFO_HISTORY>
        </ns0:consultaInformacionLaboralResponse>
};

declare variable $consultaInformacionLaboralResponse as element(ns0:consultaInformacionLaboralResponse) external;

xf:getEmploymentInformationHNOut($consultaInformacionLaboralResponse)